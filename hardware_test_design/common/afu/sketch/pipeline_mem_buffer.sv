module pipeline_mem_buffer#(
    parameter ADDR_WIDTH_FULL = 0,
    parameter DATA_WIDTH = 0,
    parameter PIPELINE_DEPTH = 1
)(
    input  clk,
    input  [ADDR_WIDTH_FULL-1:0] addr_in,
    output reg [ADDR_WIDTH_FULL-1:0] addr_out,
    input  rd_en_in,
    output reg rd_en_out,
    input  [$clog2(PIPELINE_DEPTH)-1:0] dst_id_in,
    output reg [$clog2(PIPELINE_DEPTH)-1:0] dst_id_out,
    input  [DATA_WIDTH-1:0] rd_data_in,
    output reg [DATA_WIDTH-1:0] rd_data_out,
    input rd_cnt_in,
    output reg rd_cnt_out
);

always @(posedge clk) begin
    addr_out    <= addr_in;
    rd_en_out   <= rd_en_in;
    rd_data_out <= rd_data_in;
    dst_id_out  <= dst_id_in;  
    rd_cnt_out  <= rd_cnt_in;
end

endmodule