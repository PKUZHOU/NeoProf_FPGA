module pipeline_mem_component #(
    parameter ADDR_WIDTH_FULL = 12,
    parameter DATA_WIDTH = 32,
    parameter PIPELINE_DEPTH = 4,
    parameter MODE = "CNT"
)(
    input  clk,
    input  rst_n,
    input  rd_en_in,
    input  rd_cnt_en,
    input  [ADDR_WIDTH_FULL-1:0] addr_in,
    output [DATA_WIDTH-1:0] rd_data_out,
    output [ADDR_WIDTH_FULL-1:0] rd_addr_out,
    output rd_data_valid,
    output rd_cnt_valid
);

localparam ADDR_WIDTH = ADDR_WIDTH_FULL - $clog2(PIPELINE_DEPTH);

logic rd_en_signals  [PIPELINE_DEPTH:0];
logic rd_cnt_signals [PIPELINE_DEPTH:0];
logic rd_data_valid_signals [PIPELINE_DEPTH:0];
logic rd_cnt_valid_signals [PIPELINE_DEPTH:0];
logic [DATA_WIDTH-1:0] rd_data_in_signals [PIPELINE_DEPTH:0];
logic [ADDR_WIDTH_FULL-1:0] addr_in_signals [PIPELINE_DEPTH:0];
logic [ADDR_WIDTH_FULL-1:0] rd_addr_signals [PIPELINE_DEPTH:0];
logic [$clog2(PIPELINE_DEPTH)-1:0] dst_id_in_signals [PIPELINE_DEPTH:0];

genvar i;
generate 
    for (i = 0; i < PIPELINE_DEPTH; i = i + 1) begin : pipeline
        pipeline_mem_segment #(
            .ADDR_WIDTH_FULL(ADDR_WIDTH_FULL),
            .DATA_WIDTH(DATA_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH),
            .PIPELINE_DEPTH(PIPELINE_DEPTH),
            .MEM_ID(i),
            .MODE(MODE)
        ) mem_segment (
            .clk(clk),
            .rst_n(rst_n),
            .dst_id_in(dst_id_in_signals[i]),
            .dst_id_out(dst_id_in_signals[i+1]),
            .addr_in(addr_in_signals[i]),
            .addr_out(addr_in_signals[i+1]),
            .rd_data_in(rd_data_in_signals[i]),
            .rd_data_out(rd_data_in_signals[i+1]),
            .rd_en_in(rd_en_signals[i]),
            .rd_en_out(rd_en_signals[i+1]),
            .rd_data_valid_in(rd_data_valid_signals[i]),
            .rd_data_valid_out(rd_data_valid_signals[i+1]),
            .rd_addr_in(rd_addr_signals[i]),
            .rd_addr_out(rd_addr_signals[i+1]),
            .rd_cnt_in(rd_cnt_signals[i]),
            .rd_cnt_out(rd_cnt_signals[i+1]),
            .rd_cnt_valid_in(rd_cnt_valid_signals[i]),
            .rd_cnt_valid_out(rd_cnt_valid_signals[i+1])
        );
    end
endgenerate

logic [$clog2(PIPELINE_DEPTH)-1:0] dst_id;
/* verilator lint_off WIDTH */
assign dst_id = (addr_in >> ADDR_WIDTH);

/*Input Buffer*/
pipeline_mem_buffer #(
    .ADDR_WIDTH_FULL(ADDR_WIDTH_FULL),
    .DATA_WIDTH(DATA_WIDTH),
    .PIPELINE_DEPTH(PIPELINE_DEPTH)
) pipeline_buffer(
    .clk(clk),
    .addr_in(addr_in),
    .dst_id_in(dst_id),
    .dst_id_out(dst_id_in_signals[0]),
    .rd_en_in(rd_en_in),
    .rd_data_in(0),
    .rd_data_out(rd_data_in_signals[0]),
    .rd_en_out(rd_en_signals[0]),
    .addr_out(addr_in_signals[0]),
    .rd_cnt_in(rd_cnt_en),
    .rd_cnt_out(rd_cnt_signals[0])
);

/*Outout signals*/
assign rd_data_out = rd_data_in_signals[PIPELINE_DEPTH];
assign rd_addr_out = rd_addr_signals[PIPELINE_DEPTH];
assign rd_data_valid = rd_data_valid_signals[PIPELINE_DEPTH];
assign rd_cnt_valid = rd_cnt_valid_signals[PIPELINE_DEPTH];
endmodule