
module neoprof_avmm_slave #(
   // Sketch Params
   parameter int unsigned ARRAY_DEPTH = 2,
   parameter int unsigned KEY_WIDTH   = 32,
   parameter int unsigned HASH_WIDTH  = 16,
   parameter int unsigned CNT_WIDTH   = 16,
   parameter int unsigned HOT_FIFO_DEPTH = 1<<12, // 4096 hot pages
   parameter int unsigned CNT_PIPELINE_DEPTH = 16, // 1024 stages
   parameter int unsigned HB_PIPELINE_DEPTH = 8
)(
   // AVMM Slave Interface
   input               clk, // slow clock
   input               reset_n, 
   /* verilator lint_off UNUSED */
   input  logic [31:0] writedata,
   input  logic        read,
   input  logic        write,
   input  logic [3:0]  byteenable,
   output logic [31:0] readdata,
   output logic        readdatavalid,
   input  logic [31:0] address,
   output logic        waitrequest,

   // CDC FIFO 
   input afu_clk,  // fast clock
   input afu_rstn,
   input logic [KEY_WIDTH-1: 0] cdc_fifo_push_data,
   input cdc_fifo_push_en,

   // State monitor
   input ddr_rd_valid,
   input ddr_wr_valid
);

// state monitor
logic [31:0] state_sample_interval = 100;
logic [31:0] page_sample_interval = 0;
logic state_monitor_reset_n = 1'b1;

// state monitor registers
logic [31:0] sample_count = 0;
logic [31:0] rd_valid_count = 0;
logic [31:0] wr_valid_count = 0;
logic [31:0] total_sample_count = 0;

localparam MAX_CNT = 32'hffffffff;

always_ff @(posedge afu_clk) begin // todo: cross domain?
   if (!state_monitor_reset_n) begin
      sample_count <= 0;
      rd_valid_count <= 0;
      wr_valid_count <= 0;
      total_sample_count <= 0;
   end else begin
      if (sample_count == state_sample_interval) begin
         if(total_sample_count != MAX_CNT) begin
            total_sample_count <= total_sample_count + 1;
         end
         if (ddr_rd_valid && (rd_valid_count != MAX_CNT)) begin
            rd_valid_count <= rd_valid_count + 1;
         end
         if (ddr_wr_valid && (wr_valid_count != MAX_CNT)) begin
            wr_valid_count <= wr_valid_count + 1;
         end
         sample_count <= 0;
      end else begin
         sample_count <= sample_count + 1;
      end
   end 
end

// Sketch signals
logic [KEY_WIDTH-1:0] sketch_page_addr_in;
logic [KEY_WIDTH-1:0] sketch_page_addr_out;
logic sketch_page_addr_in_valid;
logic page_sample_valid = 1;
logic sketch_page_addr_in_valid_w_sample;
assign sketch_page_addr_in_valid_w_sample = sketch_page_addr_in_valid && page_sample_valid;

// Histogram signals
logic [31:0] hist_rd_data_out;
logic [31:0] hist_fifo_data_out;
logic hist_valid_o;
logic hist_fifo_rd_en;
logic hist_sample_en;

// sample the page address
logic [31:0] page_sample_count = 0;
always_ff @(posedge clk) begin
   if (page_sample_count == page_sample_interval) begin
         page_sample_count <= 0;
         page_sample_valid <= 1;
   end else begin
      page_sample_count <= page_sample_count + 1;
      page_sample_valid <= 0;
   end
end

// hotness threshold 
logic [CNT_WIDTH-1:0] hotness_threshold = 0;
logic hot_valid_o;

// read out sketch info
logic [CNT_WIDTH-1:0] sketch_rd_data_out;
logic sketch_rd_en_in;
logic sketch_rd_valid_out;

// CDC FIFO signals
logic cdc_fifo_empty;
logic cdc_fifo_rd_en;
logic cdc_fifo_ready_o;

cdc_fifo_gray #(
   .WIDTH (KEY_WIDTH),
   .LOG_DEPTH (6), // num of entries
   .T(logic [KEY_WIDTH-1:0]),
   .SYNC_STAGES(2)
) afu_neoprof_cdc_fifo(
   .src_rst_ni (afu_rstn),
   .src_clk_i  (afu_clk),
   .src_data_i (cdc_fifo_push_data),
   .src_valid_i(cdc_fifo_push_en),
   .src_ready_o(cdc_fifo_ready_o),

   .dst_rst_ni (reset_n),
   .dst_clk_i  (clk),
   .dst_data_o (sketch_page_addr_in),
   .dst_valid_o(sketch_page_addr_in_valid),
   .dst_ready_i(1'b1)
);

// just for debugging
logic [31:0] page_in_cnt = 0;
logic page_in_cnt_reset_n = 1'b1;
always @(posedge clk) begin
   if(page_in_cnt_reset_n && sketch_page_addr_in_valid && (page_in_cnt != MAX_CNT)) begin
      page_in_cnt <= page_in_cnt + 1;
   end 
   else if (!page_in_cnt_reset_n) begin 
      page_in_cnt <= 0;
   end
end

// sketch instantiation
logic cmsketch_rst_n = 1;
cmsketch #(
   .ARRAY_DEPTH(ARRAY_DEPTH),
   .KEY_WIDTH(KEY_WIDTH),
   .HASH_WIDTH(HASH_WIDTH),
   .CNT_WIDTH(CNT_WIDTH),
   .CNT_PIPELINE_DEPTH(CNT_PIPELINE_DEPTH),
   .HB_PIPELINE_DEPTH(HB_PIPELINE_DEPTH)
) cmsketch_unit (
   .clk(clk),
   .rst_n(cmsketch_rst_n),
   .valid_i(sketch_page_addr_in_valid_w_sample),
   .valid_o(sketch_rd_valid_out),
   .key_i(sketch_page_addr_in),
   .min_cnt_o(sketch_rd_data_out),
   // for hotness profiling
   .threshold_i(hotness_threshold),
   .key_o(sketch_page_addr_out),
   .hot_valid_o(hot_valid_o),
   // for histogram reading
   .hist_sample_en_i(hist_sample_en),
   .hist_rd_data_out(hist_rd_data_out),
   .hist_valid_o(hist_valid_o)
);

// hot page fifo
parameter int unsigned ADDR_DEPTH = (HOT_FIFO_DEPTH > 1) ? $clog2(HOT_FIFO_DEPTH) : 1;

logic hot_fifo_flush;
logic hot_fifo_full;
logic hot_fifo_empty;
logic [ADDR_DEPTH:0] hot_fifo_usage;

// readout hot pages
logic [KEY_WIDTH-1:0] hot_fifo_data_out;
logic hot_fifo_rd_en;

logic hot_fifo_push_en;
assign hot_fifo_push_en = hot_valid_o;

fifo_v3 #(
   .FALL_THROUGH(0),
   .DATA_WIDTH(KEY_WIDTH),
   .DEPTH(HOT_FIFO_DEPTH),
   .dtype(logic [KEY_WIDTH-1:0]),
   .ADDR_DEPTH (ADDR_DEPTH)
) fifo_inst(
   .clk_i(clk),
   .rst_ni(reset_n),
   .flush_i(hot_fifo_flush),

   .full_o(hot_fifo_full),
   .empty_o(hot_fifo_empty),
   .usage_o(hot_fifo_usage),

   .data_i(sketch_page_addr_out),
   .push_i(hot_fifo_push_en),
   .data_o(hot_fifo_data_out),
   .pop_i(hot_fifo_rd_en)
);

logic hist_fifo_flush;
logic hist_fifo_full;
logic hist_fifo_empty;
logic [8:0] hist_fifo_usage;

fifo_v3 #(
   .FALL_THROUGH(0),
   .DATA_WIDTH(32),
   .DEPTH(256),
   .dtype(logic [31:0]),
   .ADDR_DEPTH (8)
) hist_fifo_inst(
   .clk_i(clk),
   .rst_ni(reset_n),
   .flush_i(hist_fifo_flush),

   .full_o(hist_fifo_full),
   .empty_o(hist_fifo_empty),
   .usage_o(hist_fifo_usage),

   .data_i(hist_rd_data_out),
   .push_i(hist_valid_o),
   .data_o(hist_fifo_data_out),
   .pop_i(hist_fifo_rd_en)
);



logic [31:0] mask ;

logic config_access; 
assign mask[7:0]   = byteenable[0]? 8'hFF:8'h0; 
assign mask[15:8]  = byteenable[1]? 8'hFF:8'h0; 
assign mask[23:16] = byteenable[2]? 8'hFF:8'h0; 
assign mask[31:24] = byteenable[3]? 8'hFF:8'h0; 
assign config_access = address[21];  

//Terminating extented capability header
// localparam EX_CAP_HEADER  = 32'h00010023;
localparam EX_CAP_HEADER  = 32'h00000000;
// localparam EX_CAP_HEADER1 = 32'h00801E98;

//Control Logic
enum int unsigned { IDLE = 0, WRITE = 2, READ = 4 } state, next_state;

logic [31:0] test_reg;

/* Write logic */
localparam RESET = 21'h200;
localparam WR_TEST_REG = 21'h100;
localparam SET_THRESHOLD = 21'h300;
localparam SET_STATE_SAMPLE_INTERVAL = 21'h400;
localparam SET_PAGE_SAMPLE_INTERVAL = 21'h500;
localparam HIST_SAMPLE_EN = 21'h600;
// Config Parameters Sent by CPU
always @(posedge clk) begin
   // Clear states
   if (write && (address[20:0] == RESET)) begin 
      cmsketch_rst_n <= 0;
      state_monitor_reset_n <= 0;
      hot_fifo_flush <= 1;
      hist_fifo_flush <= 1;
      page_in_cnt_reset_n <= 0;
      hotness_threshold <= hotness_threshold;
      test_reg <= test_reg;
      hist_sample_en <= 0;
   end
   // set threshold
   else if(write && (address[20:0] == SET_THRESHOLD)) begin
      /* verilator lint_off WIDTH */
      hotness_threshold <= writedata[31:0] & mask; 
      cmsketch_rst_n <= 0;
      state_monitor_reset_n <= 1; // no need to reset state monitor
      page_in_cnt_reset_n <= 1;
      hot_fifo_flush <= 1;
      hist_fifo_flush <= 1;
      test_reg <= test_reg;
      hist_sample_en <= 0;
   end
   // write test reg
   else if(write && (address[20:0] == WR_TEST_REG)) begin
      test_reg <= writedata[31:0] & mask;
      cmsketch_rst_n <= 1;
      state_monitor_reset_n <= 1;
      page_in_cnt_reset_n <= 1;
      hot_fifo_flush <= 0;
      hist_fifo_flush <= 0;
      hist_sample_en <= 0;
   end 
   // set state sample interval
   else if(write && (address[20:0] == SET_STATE_SAMPLE_INTERVAL)) begin
      state_sample_interval <= writedata[31:0] & mask;
      cmsketch_rst_n <= 1;
      state_monitor_reset_n <= 0;  // reset state monitor
      page_in_cnt_reset_n <= 1;
      hot_fifo_flush <= 0;
      hist_fifo_flush <= 0;
      test_reg <= test_reg;
      hist_sample_en <= 0;
   end
   // set page sample interval
   else if(write && (address[20:0] == SET_PAGE_SAMPLE_INTERVAL)) begin
      page_sample_interval <= writedata[31:0] & mask;
      cmsketch_rst_n <= 1;
      state_monitor_reset_n <= 1;  // reset state monitor
      page_in_cnt_reset_n <= 1;
      hot_fifo_flush <= 0;
      hist_fifo_flush <= 0;
      test_reg <= test_reg;
      hist_sample_en <= 0;
   end

   else if(write && (address[20:0] == HIST_SAMPLE_EN)) begin 
      cmsketch_rst_n <= 1;
      state_monitor_reset_n <= 1;
      page_in_cnt_reset_n <= 1;
      hot_fifo_flush <= 0;
      hist_fifo_flush <= 0;
      test_reg <= test_reg;
      hist_sample_en <= 1;
   end 

   else begin
      // no action 
      hotness_threshold <= hotness_threshold;
      cmsketch_rst_n <= 1;
      state_monitor_reset_n <= 1;
      page_in_cnt_reset_n <= 1;
      hot_fifo_flush <= 0;
      hist_fifo_flush <= 0;
      test_reg <= test_reg;
      hist_sample_en <= 0;
   end
end 


// Read logic 

localparam RD_TEST_REG  = 21'h100;
localparam RD_NR_HP = 21'h200;
localparam RD_HP = 21'h300;
localparam RD_PG_CNT = 21'h400;
localparam RD_STATE_SAMPLE_CNT = 21'h500;
localparam RD_STATE_RD_CNT = 21'h600;
localparam RD_STATE_WR_CNT = 21'h700;
localparam RD_HIST = 21'h800;
localparam RD_NR_HIST = 21'h900;
//Read Out Hotpages
always @(posedge clk) begin
   if (!reset_n) begin
      readdata  <= 32'h0;
   end
   else begin
      if (read && (address[20:0] == RD_HP)) begin 
         if (state == IDLE) begin 
            hot_fifo_rd_en <= 1; // avoid double reading
         end 
         else begin  
            hot_fifo_rd_en <= 0;
         end
         readdata <= hot_fifo_data_out & mask; // Do we need the mask?
      end
      else if (read && (address[20:0] == RD_NR_HP)) begin
         hot_fifo_rd_en <= 0;
         /* verilator lint_off WIDTH */
         readdata <= hot_fifo_usage & mask;
      end
      else if (read && (address[20:0] == RD_NR_HIST)) begin 
         hist_fifo_rd_en <= 0;
         /* verilator lint_off WIDTH */
         readdata <= hist_fifo_usage & mask;
      end 
      else if (read && (address[20:0] == RD_TEST_REG)) begin
         hot_fifo_rd_en <= 0;
         readdata <= test_reg & mask;
      end
      else if (read && (address[20:0] == RD_PG_CNT)) begin 
         readdata <= page_in_cnt & mask;
      end 
      else if (read && (address[20:0] == RD_STATE_SAMPLE_CNT)) begin 
         readdata <= total_sample_count & mask;
      end 
      else if (read && (address[20:0] == RD_STATE_RD_CNT)) begin 
         readdata <= rd_valid_count & mask;
      end 
      else if (read && (address[20:0] == RD_STATE_WR_CNT)) begin
         readdata <= wr_valid_count & mask;
      end
      else if (read && (address[20:0] == RD_HIST)) begin 
         if (state == IDLE) begin 
            hist_fifo_rd_en <= 1; // avoid double reading
         end 
         else begin  
            hist_fifo_rd_en <= 0;
         end
         readdata <= hist_fifo_data_out & mask; // Do we need the mask?
      end 
      else begin
         hot_fifo_rd_en <= 0;
         hist_fifo_rd_en <= 0;
         readdata  <= 32'h0;
      end        
   end    
end 

// State Machine

always_comb begin : next_state_logic
   next_state = IDLE;
      case(state)
      IDLE  :  begin 
                  if( write ) begin
                     next_state = WRITE;
                  end
                  else begin
                  if (read) begin  
                     next_state = READ;
                  end
                  else begin
                     next_state = IDLE;
                  end
                  end 
               end
      WRITE :  begin
                  next_state = IDLE;
               end
      READ  :  begin
                  next_state = IDLE;  // TODO: Why only read for one cycle?
               end
      default : next_state = IDLE;
   endcase
end


always_comb begin
   case(state)
   IDLE    : begin
               waitrequest  = 1'b1;
               readdatavalid= 1'b0;
             end
   WRITE     : begin 
               waitrequest  = 1'b0;
               readdatavalid= 1'b0;
             end
   READ     : begin 
               waitrequest  = 1'b0;
               readdatavalid= 1'b1;
             end
   default : begin 
               waitrequest  = 1'b1;
               readdatavalid= 1'b0;
             end
   endcase
end

always_ff@(posedge clk) begin
   if(~reset_n)
      state <= IDLE;
   else
      state <= next_state;
end

endmodule
