module cmsketch#(
  parameter   int unsigned ARRAY_DEPTH = 2,
  parameter   int unsigned KEY_WIDTH   = 32,
  parameter   int unsigned HASH_WIDTH  = 16, // hashed index 
  parameter   int unsigned CNT_WIDTH   = 16,   // counter width
  parameter   int unsigned CNT_PIPELINE_DEPTH = 16,
  parameter   int unsigned HB_PIPELINE_DEPTH = 8
)(
  input   clk,
  input   rst_n,                           
  input   valid_i,
  output  reg valid_o,
  input   [KEY_WIDTH-1:0] key_i,
  output  reg [CNT_WIDTH-1:0] min_cnt_o, // counter output

  // for hotness profiling
  input   [CNT_WIDTH-1:0] threshold_i,
  output  reg [KEY_WIDTH-1:0] key_o,
  output  reg hot_valid_o,               // indicate if key_o is hot

  // for histgram profiling
  input   hist_sample_en_i,
  output  reg [31:0] hist_rd_data_out,
  output  reg hist_valid_o
);

`include "seeds_table.hv"  // should generate seeds table using seed_gen.py first

/* generate processing lanes. Each row is a lane */
logic [CNT_WIDTH-1 : 0] all_cnt [ARRAY_DEPTH-1 : 0]; // counters in each lane
logic lane_out_valid [ARRAY_DEPTH-1 : 0]; // valid signals in each lane
logic [KEY_WIDTH-1:0] all_keys [ARRAY_DEPTH-1 : 0]; // carried keys in each lane
// logic new_hot_found;
logic [HASH_WIDTH-1:0] hash_index [ARRAY_DEPTH-1 : 0]; // hashed index in each lane

// histogram sampling 
logic [31:0] hist_gram_out [ARRAY_DEPTH-1 : 0]; 
logic hist_gram_valid_out [ARRAY_DEPTH-1 : 0]; 

assign hist_rd_data_out = hist_gram_out[0];
assign hist_valid_o = hist_gram_valid_out[0];

// generate lanes
genvar i;
generate
  for (i = 0; i < ARRAY_DEPTH; i = i + 1) begin : lane
    // hash unit
    sketch_lane #(
      .KEY_WIDTH(KEY_WIDTH),
      .HASH_WIDTH(HASH_WIDTH),
      .CNT_WIDTH(CNT_WIDTH),
      .MEM_PIPELINE_DEPTH(CNT_PIPELINE_DEPTH)
    ) lane (
      .clk(clk),
      .rst_n(rst_n),
      .valid_i(valid_i),
      .key_i(key_i),
      .seed_i(HASH_SEED_TABLE[i * KEY_WIDTH * HASH_WIDTH +: KEY_WIDTH * HASH_WIDTH]),

      .cnt_o(all_cnt[i]),
      .valid_o(lane_out_valid[i]),
      .key_o(all_keys[i]),
      // for hotness profiling
      .hash_index_o(hash_index[i]),
      // for reading out counters
      // for histogram sampling
      .hist_sample_en_i(hist_sample_en_i),
      .hist_rd_out_o(hist_gram_out[i]),
      .hist_valid_o(hist_gram_valid_out[i])
    );
  end
endgenerate

// count-min sketch output
reg [CNT_WIDTH-1 : 0] min_cnt = 0;
integer j;
always_comb begin
    min_cnt = all_cnt[0];
    for (j = 0; j < ARRAY_DEPTH; j = j + 1) begin
      if (all_cnt[j] < min_cnt) begin
        min_cnt = all_cnt[j];
      end
    end
end

// Determine if the page is hot
// logic [HASH_WIDTH-1:0] hash_index_tmp[ARRAY_DEPTH-1:0];

logic hot_candidate_valid;
assign hot_candidate_valid = lane_out_valid[0] && (min_cnt > threshold_i);

logic hotbits[ARRAY_DEPTH-1:0];
// logic [HASH_WIDTH-1:0] hb_rd_addr[ARRAY_DEPTH-1:0];
logic hb_valid[ARRAY_DEPTH-1:0];
// hotness bits querying
// generate lanes
genvar k;
generate
  for (k = 0; k < ARRAY_DEPTH; k = k + 1) begin : hotbits_pipelines
    /* verilator lint_off PINMISSING */
    pipeline_mem_component #(
      .MODE("HB"),
      .ADDR_WIDTH_FULL(HASH_WIDTH),
      .DATA_WIDTH(1),
      .PIPELINE_DEPTH(HB_PIPELINE_DEPTH)
    ) pipeline_mem_inst(
      .clk(clk),
      .rst_n(rst_n),
      .rd_en_in(hot_candidate_valid),
      .addr_in(hash_index[k]),
      .rd_data_out(hotbits[k]),
      // .rd_addr_out(hb_rd_addr[k]),
      .rd_data_valid(hb_valid[k])
    );
  end
endgenerate

integer hb_j;
reg new_hb = 0;

// new hot page detector
always_comb begin
    new_hb = ~hotbits[0];
    for (hb_j = 0; hb_j < ARRAY_DEPTH; hb_j = hb_j + 1) begin
        new_hb = new_hb | (~hotbits[hb_j]);
    end
end

localparam HB_PASSING_CYCLES = HB_PIPELINE_DEPTH + 2;
/* Pipeline for passing min_cnt and key */
reg [KEY_WIDTH-1:0] key_pipe_reg [HB_PASSING_CYCLES-1:0];
reg [CNT_WIDTH-1:0] cnt_pipe_reg [HB_PASSING_CYCLES-1:0];
reg valid_pipe_reg [HB_PASSING_CYCLES-1:0];

// valid signal pipeline
integer valid_stage_i;
always @(posedge clk) begin
  if (lane_out_valid[0] && rst_n) begin
    key_pipe_reg[0] <= all_keys[0];
    cnt_pipe_reg[0] <= min_cnt;
    valid_pipe_reg[0] <= 1;
  end 
  else begin 
    key_pipe_reg[0] <= 0;
    cnt_pipe_reg[0] <= 0;
    valid_pipe_reg[0] <= 0;
  end  
  for (valid_stage_i = 1; valid_stage_i < HB_PASSING_CYCLES; valid_stage_i = valid_stage_i+1 ) begin
    // valid_signals[valid_stage_i] <= valid_signals[valid_stage_i-1];
    key_pipe_reg[valid_stage_i] <= key_pipe_reg[valid_stage_i-1];
    cnt_pipe_reg[valid_stage_i] <= cnt_pipe_reg[valid_stage_i-1];
    valid_pipe_reg[valid_stage_i] <= valid_pipe_reg[valid_stage_i-1];
  end
end

always@(posedge clk) begin
  key_o <= key_pipe_reg[HB_PASSING_CYCLES-1];
  min_cnt_o <= cnt_pipe_reg[HB_PASSING_CYCLES-1]; 
  valid_o <= valid_pipe_reg[HB_PASSING_CYCLES-1];
  hot_valid_o <= new_hb & hb_valid[0];
end

endmodule 