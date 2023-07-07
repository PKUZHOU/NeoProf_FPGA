// (C) 2001-2022 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// Copyright 2022 Intel Corporation.
//
// THIS SOFTWARE MAY CONTAIN PREPRODUCTION CODE AND IS PROVIDED BY THE
// COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
// WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
// OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
// EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import cxlip_top_pkg::*;

module afu_top(
    input  logic        csr_avmm_clk,
    input  logic        csr_avmm_rstn,  
    output logic        csr_avmm_waitrequest,            
    output logic [31:0] csr_avmm_readdata,               
    output logic        csr_avmm_readdatavalid,          
    input  logic [31:0] csr_avmm_writedata,              
    input  logic [21:0] csr_avmm_address,                
    input  logic        csr_avmm_write,                  
    input  logic        csr_avmm_read,                   
    input  logic [3:0]  csr_avmm_byteenable,
    
    input  logic                                             afu_clk,
    input  logic                                             afu_rstn,
    input  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc2iafu_ready_eclk,
    input  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc2iafu_read_poison_eclk,
    input  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc2iafu_readdatavalid_eclk,
    // Error Correction Code (ECC)
    // Note *ecc_err_* are valid when mc2iafu_readdatavalid_eclk is active
    input  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     mc2iafu_ecc_err_corrected_eclk  [cxlip_top_pkg::MC_CHANNEL-1:0],
    input  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     mc2iafu_ecc_err_detected_eclk   [cxlip_top_pkg::MC_CHANNEL-1:0],
    input  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     mc2iafu_ecc_err_fatal_eclk      [cxlip_top_pkg::MC_CHANNEL-1:0],
    input  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     mc2iafu_ecc_err_syn_e_eclk      [cxlip_top_pkg::MC_CHANNEL-1:0],
    input  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc2iafu_ecc_err_valid_eclk,
    input  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc2iafu_cxlmem_ready,
    input  logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    mc2iafu_readdata_eclk           [cxlip_top_pkg::MC_CHANNEL-1:0],
    input  logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         mc2iafu_rsp_mdata_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0],
    
    
    output logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    iafu2mc_writedata_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0],
    output logic [cxlip_top_pkg::MC_HA_DP_BE_WIDTH-1:0]      iafu2mc_byteenable_eclk         [cxlip_top_pkg::MC_CHANNEL-1:0],
    output logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2mc_read_eclk,
    output logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2mc_write_eclk,
    output logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2mc_write_poison_eclk,
    output logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2mc_write_ras_sbe_eclk,    
    output logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2mc_write_ras_dbe_eclk,    
    output logic  [(cxlip_top_pkg::CXLIP_FULL_ADDR_MSB):(cxlip_top_pkg::CXLIP_FULL_ADDR_LSB)]   iafu2mc_address_eclk            [cxlip_top_pkg::MC_CHANNEL-1:0],
    output logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         iafu2mc_req_mdata_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0],

                //CXL_IP to AFU to MC TOP Passthrough signals
    output  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2cxlip_ready_eclk,
    output  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2cxlip_read_poison_eclk,
    output  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2cxlip_readdatavalid_eclk,
    // Error Correction Code (ECC)
    // Note *ecc_err_* are valid when mc2iafu_readdatavalid_eclk is active
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     iafu2cxlip_ecc_err_corrected_eclk  [cxlip_top_pkg::MC_CHANNEL-1:0],
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     iafu2cxlip_ecc_err_detected_eclk   [cxlip_top_pkg::MC_CHANNEL-1:0],
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     iafu2cxlip_ecc_err_fatal_eclk      [cxlip_top_pkg::MC_CHANNEL-1:0],
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     iafu2cxlip_ecc_err_syn_e_eclk      [cxlip_top_pkg::MC_CHANNEL-1:0],
    output  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2cxlip_ecc_err_valid_eclk,
    output  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2cxlip_cxlmem_ready,
    output  logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    iafu2cxlip_readdata_eclk           [cxlip_top_pkg::MC_CHANNEL-1:0],
    output  logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         iafu2cxlip_rsp_mdata_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0],
    
    input logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]      cxlip2iafu_writedata_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0],
    input logic [cxlip_top_pkg::MC_HA_DP_BE_WIDTH-1:0]        cxlip2iafu_byteenable_eclk         [cxlip_top_pkg::MC_CHANNEL-1:0],
    input logic [cxlip_top_pkg::MC_CHANNEL-1:0]               cxlip2iafu_read_eclk,
    input logic [cxlip_top_pkg::MC_CHANNEL-1:0]               cxlip2iafu_write_eclk,
    input logic [cxlip_top_pkg::MC_CHANNEL-1:0]               cxlip2iafu_write_poison_eclk,
    input logic [cxlip_top_pkg::MC_CHANNEL-1:0]               cxlip2iafu_write_ras_sbe_eclk,    
    input logic [cxlip_top_pkg::MC_CHANNEL-1:0]               cxlip2iafu_write_ras_dbe_eclk,    
    input logic  [(cxlip_top_pkg::CXLIP_FULL_ADDR_MSB):(cxlip_top_pkg::CXLIP_FULL_ADDR_LSB)]      cxlip2iafu_address_eclk            [cxlip_top_pkg::MC_CHANNEL-1:0],
    input logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]           cxlip2iafu_req_mdata_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0]
    
    
);

logic [31:0] old_pg_addr [1:0]; // ensure that each address enqueues only once
logic [31:0] cdc_fifo_wr_data;
logic [31:0] pg_addr[1:0];

assign pg_addr[0] = (cxlip2iafu_address_eclk[0] >> 5); //  cxlip2iafu_address_eclk : [51:7]
assign pg_addr[1] = (cxlip2iafu_address_eclk[1] >> 5);

logic cdc_fifo_wr_en;

always@(posedge afu_clk) begin
    if (cxlip2iafu_read_eclk[0] && (old_pg_addr[0] != pg_addr[0])) 
    begin
        cdc_fifo_wr_en <= 1'b1;
        old_pg_addr[0] <= pg_addr[0];
        cdc_fifo_wr_data <= pg_addr[0]; // get the page address
    end 
    else if (cxlip2iafu_read_eclk[1] && (old_pg_addr[1] != pg_addr[1])) // another channel
    begin
        cdc_fifo_wr_en <= 1'b1;
        old_pg_addr[1] <= pg_addr[1];
        cdc_fifo_wr_data <= pg_addr[1]; // get the page address
    end
    else
    begin
        cdc_fifo_wr_en <= 1'b0;
        cdc_fifo_wr_data <= 0;
    end 
end

// Read/write state sample 

logic ddr_read_valid;
logic ddr_write_valid;

assign ddr_read_valid = iafu2cxlip_readdatavalid_eclk[0] || iafu2cxlip_readdatavalid_eclk[1];
assign ddr_write_valid = cxlip2iafu_write_eclk[0] || cxlip2iafu_write_eclk[1];

neoprof_avmm_slave #(
    .ARRAY_DEPTH (2),
    .KEY_WIDTH (32),
    .HASH_WIDTH(19), // 2 ** 19 = 512K entries 
    .CNT_WIDTH (16),   // counter width
    .CNT_PIPELINE_DEPTH(128),
    .HB_PIPELINE_DEPTH(128),
    .HOT_FIFO_DEPTH(1<<14) // 16K
) neoprof_avmm_slave_inst(
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



assign iafu2cxlip_ready_eclk                = mc2iafu_ready_eclk             ;
assign iafu2cxlip_read_poison_eclk          = mc2iafu_read_poison_eclk       ;
assign iafu2cxlip_readdatavalid_eclk        = mc2iafu_readdatavalid_eclk     ;
assign iafu2cxlip_ecc_err_corrected_eclk    = mc2iafu_ecc_err_corrected_eclk ;
assign iafu2cxlip_ecc_err_detected_eclk     = mc2iafu_ecc_err_detected_eclk  ;
assign iafu2cxlip_ecc_err_fatal_eclk        = mc2iafu_ecc_err_fatal_eclk     ;
assign iafu2cxlip_ecc_err_syn_e_eclk        = mc2iafu_ecc_err_syn_e_eclk     ;
assign iafu2cxlip_ecc_err_valid_eclk        = mc2iafu_ecc_err_valid_eclk     ;
assign iafu2cxlip_cxlmem_ready              = mc2iafu_cxlmem_ready           ;
assign iafu2cxlip_readdata_eclk             = mc2iafu_readdata_eclk          ;
assign iafu2cxlip_rsp_mdata_eclk            = mc2iafu_rsp_mdata_eclk         ;  


assign iafu2mc_writedata_eclk               = cxlip2iafu_writedata_eclk     ;
assign iafu2mc_byteenable_eclk              = cxlip2iafu_byteenable_eclk    ;
assign iafu2mc_read_eclk                    = cxlip2iafu_read_eclk          ;
assign iafu2mc_write_eclk                   = cxlip2iafu_write_eclk         ;
assign iafu2mc_write_poison_eclk            = cxlip2iafu_write_poison_eclk  ;
assign iafu2mc_write_ras_sbe_eclk           = cxlip2iafu_write_ras_sbe_eclk ;
assign iafu2mc_write_ras_dbe_eclk           = cxlip2iafu_write_ras_dbe_eclk ;
assign iafu2mc_address_eclk                 = cxlip2iafu_address_eclk       ;
assign iafu2mc_req_mdata_eclk               = cxlip2iafu_req_mdata_eclk     ;


endmodule
