
module hash_block #(
  parameter  KEY_WIDTH,
  parameter  HASH_WIDTH,
  parameter  NSUB_STAGE
) (
  // is purely combinational
  input  clk,
  input  valid_i,
  input  [KEY_WIDTH-1:0]     data_i,
  input  [KEY_WIDTH * HASH_WIDTH-1:0]     seed_i,
  output reg [HASH_WIDTH-1:0]    hash_o,
  output valid_o 
);
  // for each round


integer valid_stage_i;
parameter n_pipe_stage = 2;
reg [n_pipe_stage-1:0] valid_signals = 0;

always @(posedge clk) begin
  if (valid_i) begin
    valid_signals[0] <= 1'b1;
  end 
  else begin 
    valid_signals[0] <= 1'b0;
  end  
  for (valid_stage_i = 1; valid_stage_i < n_pipe_stage; valid_stage_i = valid_stage_i+1 ) begin
    valid_signals[valid_stage_i] <= valid_signals[valid_stage_i-1];
  end
end


assign valid_o = valid_signals[n_pipe_stage-1];


// Currently we only use two-stage pipeline for hash unit
parameter SUB_KEY_WIDTH = KEY_WIDTH / NSUB_STAGE;

reg  [HASH_WIDTH-1:0] sub_hash [NSUB_STAGE-1:0];
reg  [HASH_WIDTH-1:0] sub_hash_pipe_reg [NSUB_STAGE-1:0];

// integer stage_i;
genvar stage_i;
generate
for (stage_i = 0; stage_i < NSUB_STAGE; stage_i=stage_i+1 ) begin : sub_stage
  integer j;
  always_comb begin
    sub_hash[stage_i] = 0;
    for (j = 0; j < SUB_KEY_WIDTH; j=j+1 ) begin : sub_hash_func
        sub_hash[stage_i] = sub_hash[stage_i] ^ ({HASH_WIDTH{data_i[stage_i * SUB_KEY_WIDTH + j]}} & seed_i[(stage_i * SUB_KEY_WIDTH + j) * HASH_WIDTH +: HASH_WIDTH]);
    end
  end 
  always_ff @(posedge clk) begin
    sub_hash_pipe_reg[stage_i] <= sub_hash[stage_i];
  end
end
endgenerate


// merge all sub_hash
reg  [HASH_WIDTH-1:0] final_hash;
integer i;
always_comb  begin
    final_hash = 0;
    for (i = 0; i < NSUB_STAGE; i=i+1) begin : merge
        /* verilator lint_off BLKSEQ */
        final_hash = final_hash ^ sub_hash_pipe_reg[i];
    end
end 

always_ff @(posedge clk) begin
  hash_o <= final_hash;
end

endmodule
