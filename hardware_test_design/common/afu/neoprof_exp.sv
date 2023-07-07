module neoprof_exp #(
   parameter KEY_WIDTH   = 32
) (
    input csr_avmm_clk,
    /* verilator lint_off SYNCASYNCNET */
    input csr_avmm_rstn,
    input csr_avmm_read,
    input csr_avmm_write,
    input [3:0] csr_avmm_byteenable,
    input [KEY_WIDTH-1:0] csr_avmm_writedata,
    input [31:0] csr_avmm_address,
    output logic [KEY_WIDTH-1:0] csr_avmm_readdata,
    output logic csr_avmm_readdatavalid,
    output logic csr_avmm_waitrequest,

    input afu_clk,
    input afu_rstn,
    input cxlip2iafu_read_eclk,
    input ddr_read_valid,
    input ddr_write_valid,
    input [51:6] cxlip2iafu_address_eclk
);
  // Parameters
    logic [31:0] cdc_fifo_wr_data;
    logic cdc_fifo_wr_en;

    always@(posedge afu_clk) begin
        if (cxlip2iafu_read_eclk) 
        begin
            cdc_fifo_wr_en <= 1'b1;
            /* verilator lint_off WIDTH */
            cdc_fifo_wr_data <= (cxlip2iafu_address_eclk >> 6); // get the page address
        end 
        else
        begin
            cdc_fifo_wr_en <= 1'b0;
            /* verilator lint_off WIDTH */
            cdc_fifo_wr_data <= (cxlip2iafu_address_eclk >> 6); // get the page address
        end
    end

    neoprof_avmm_slave#(
        .ARRAY_DEPTH (2),
        .KEY_WIDTH (32),
        .HASH_WIDTH(10), // hashed index 
        .CNT_WIDTH (16),   // counter width
        .CNT_PIPELINE_DEPTH(2),
        .HB_PIPELINE_DEPTH(2)
    )
      neoprof_avmm_slave_inst(
        .clk          (csr_avmm_clk),
        .reset_n      (csr_avmm_rstn),
        .writedata    (csr_avmm_writedata),
        .read         (csr_avmm_read),
        .write        (csr_avmm_write),
        .byteenable   (csr_avmm_byteenable),
        .readdata     (csr_avmm_readdata),
        .readdatavalid(csr_avmm_readdatavalid),
        .address      (csr_avmm_address),
        .waitrequest  (csr_avmm_waitrequest),

        // connect to cdc_fifo
        .afu_clk (afu_clk),
        .afu_rstn (afu_rstn),
        .cdc_fifo_push_en (cdc_fifo_wr_en),
        .cdc_fifo_push_data (cdc_fifo_wr_data),

        // state monitor
        .ddr_rd_valid (ddr_read_valid),
        .ddr_wr_valid (ddr_write_valid)
    );

endmodule