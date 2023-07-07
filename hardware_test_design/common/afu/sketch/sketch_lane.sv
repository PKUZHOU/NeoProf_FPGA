module sketch_lane#(
  parameter  int unsigned KEY_WIDTH,
  parameter  int unsigned HASH_WIDTH,
  parameter  int unsigned CNT_WIDTH,
  parameter  int unsigned MEM_PIPELINE_DEPTH = 16
)(
  input   clk,
  input   rst_n,
  input   valid_i,
  input   [KEY_WIDTH-1:0] key_i,
  input   [KEY_WIDTH * HASH_WIDTH - 1:0] seed_i,
  output  reg [CNT_WIDTH-1:0] cnt_o,
  output  reg valid_o,
  output  reg [KEY_WIDTH-1:0] key_o,
  // for hotness profiling
  output  reg [HASH_WIDTH-1:0] hash_index_o,
  // for reading out counters
  input   hist_sample_en_i,
  output  reg [31:0] hist_rd_out_o,
  output  reg hist_valid_o
);

enum int unsigned { RUN = 0, RD_CNT = 2} state;

localparam OTHER_PIPELINE_DEPTH  = 5;
localparam LANE_PIPELINE_DEPTH = MEM_PIPELINE_DEPTH + OTHER_PIPELINE_DEPTH;

logic mem_rd_en;
logic [HASH_WIDTH-1:0] mem_rd_addr;
logic [CNT_WIDTH-1:0] mem_rd_data;
logic [HASH_WIDTH-1:0] mem_rd_addr_out;
logic mem_rd_data_valid;

// for reading out counters
logic [HASH_WIDTH:0] rd_cnt_idx; 
logic rd_cnt_en;
logic rd_cnt_out_valid;

wire [HASH_WIDTH-1:0] update_index;
wire index_valid;

// Compute the hashed index address
hash_block #(
  .KEY_WIDTH(KEY_WIDTH),
  .HASH_WIDTH(HASH_WIDTH),
  .NSUB_STAGE(8)
) hash_block_inst (
  .clk(clk),
  .data_i(key_i),
  .valid_i(valid_i),
  .seed_i(seed_i),
  .hash_o(update_index),
  .valid_o(index_valid)
);

pipeline_mem_component #(
  .MODE ("CNT"),
  .ADDR_WIDTH_FULL(HASH_WIDTH),
  .DATA_WIDTH(CNT_WIDTH),
  .PIPELINE_DEPTH(MEM_PIPELINE_DEPTH)
) pipeline_mem_inst(
  .clk(clk),
  .rst_n(rst_n),
  .rd_en_in(mem_rd_en),
  .rd_cnt_en(rd_cnt_en),
  .addr_in(mem_rd_addr),
  .rd_data_out(mem_rd_data),
  .rd_addr_out(mem_rd_addr_out),
  .rd_data_valid(mem_rd_data_valid),
  .rd_cnt_valid(rd_cnt_out_valid) // for histgram sampling
);

assign cnt_o = mem_rd_data;
assign valid_o = mem_rd_data_valid;
assign hash_index_o = mem_rd_addr_out;

logic [31:0] cnt_out_counter; // how many cnt values have been readout from pipeline mem
logic cnt_finish_reading = 0; 

histogram #(
  .N_BINs(64),
  .INTERVAL(1),
  .INPUT_BITS(CNT_WIDTH),
  .OUTPUT_BITS(32)
) histogram_inst (
  .clk(clk),
  .rst_n(rst_n),
  .rd_out_en(cnt_finish_reading),
  .data_i(mem_rd_data),
  .valid_i(rd_cnt_out_valid), // cnt_out_valid
  .data_o(hist_rd_out_o),
  .valid_o(hist_valid_o)
);

// control the sketch data reading
always @(posedge clk) begin
  if (!rst_n) begin
    state <= RUN;
    cnt_finish_reading <= 0;
    cnt_out_counter <= 0;
  end 
  else if(hist_sample_en_i) begin
    state <= RD_CNT;
    cnt_finish_reading <= 0;
    cnt_out_counter <= 0;
  end

  if (state == RUN) begin 
    if(cnt_finish_reading) begin
      cnt_finish_reading <= 0;
    end 

    if (index_valid) begin
      mem_rd_en <= 1;
      mem_rd_addr <= update_index;
    end
    else begin
      mem_rd_en <= 0;
      mem_rd_addr <= 0;
    end
  end 
  else if (state == RD_CNT) begin
    if (rd_cnt_out_valid) begin 
      cnt_out_counter <= cnt_out_counter + 1;
    end 
    if(cnt_out_counter == (2**HASH_WIDTH)) begin 
      cnt_finish_reading <= 1;
      cnt_out_counter <= 0; 
      state <= RUN;
      rd_cnt_idx <= 0;
    end else begin 
      cnt_finish_reading <= 0;
    end   
    if(rd_cnt_idx == (2**HASH_WIDTH)) begin
      mem_rd_addr <= 0;
      // rd_cnt_idx <= 0;
      mem_rd_en <= 0;
      rd_cnt_en <= 0;
      // state <= RUN;
    end
    else begin
      mem_rd_addr <= rd_cnt_idx[HASH_WIDTH-1:0];
      mem_rd_en <= 1;
      rd_cnt_en <= 1;
      rd_cnt_idx <= rd_cnt_idx + 1;
    end
  end
end

/* Pipeline */
// reg valid_signals [LANE_PIPELINE_DEPTH-1:0];
reg [KEY_WIDTH-1:0] key_pipe_reg [LANE_PIPELINE_DEPTH-1:0];

// valid signal pipeline
integer valid_stage_i;
always @(posedge clk) begin
  // valid_signals[0] <= valid_i;
  if (valid_i && rst_n) begin
    key_pipe_reg[0] <= key_i;
  end 
  else begin 
    key_pipe_reg[0] <= 0;
  end  
  for (valid_stage_i = 1; valid_stage_i < LANE_PIPELINE_DEPTH; valid_stage_i = valid_stage_i+1 ) begin
    key_pipe_reg[valid_stage_i] <= key_pipe_reg[valid_stage_i-1];
  end
end

// assign valid_o = valid_signals[LANE_PIPELINE_DEPTH-1];
assign key_o = key_pipe_reg[LANE_PIPELINE_DEPTH-1];

endmodule