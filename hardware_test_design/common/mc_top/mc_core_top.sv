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
///////////////////////////////////////////////////////////////////////

//`include "cxl_type3ddr_define.svh.iv"

module mc_core_top
#(
   parameter MC_CHANNEL               = 2, // valid options are 1 and 2

   parameter MC_HA_DDR4_ADDR_WIDTH    = 17,
   parameter MC_HA_DDR4_BA_WIDTH      = 2,
   parameter MC_HA_DDR4_BG_WIDTH      = 2,
   parameter MC_HA_DDR4_CK_WIDTH      = 1,
   parameter MC_HA_DDR4_CKE_WIDTH     = 1,
   parameter MC_HA_DDR4_CS_WIDTH      = 1,
   parameter MC_HA_DDR4_ODT_WIDTH     = 1,
   parameter MC_HA_DDR4_DQ_WIDTH      = 72,
// `ifdef ENABLE_DDR_DBI_PINS
   parameter MC_HA_DDR4_DQS_WIDTH      = 9,
   parameter MC_HA_DDR4_DBI_WIDTH      = 9,
 //`else 
 //  parameter MC_HA_DDR4_DQS_WIDTH      = 18,
 //`endif 

   parameter EMIF_AMM_ADDR_WIDTH      = 27,
   parameter EMIF_AMM_DATA_WIDTH      = 576,
   parameter EMIF_AMM_BURST_WIDTH     = 7,
   parameter EMIF_AMM_BE_WIDTH        = 72,
   parameter REG_ON_REQFIFO_INPUT_EN  = 0, // 0 - OFF; 1 - ON; (1 - adds latency of 1 eclk)
   parameter REG_ON_REQFIFO_OUTPUT_EN = 0, // 0 - OFF; 1 - ON; (1 - adds latency of 1 emif_usr_clk)
   parameter REG_ON_RSPFIFO_OUTPUT_EN = 0, // 0 - OFF; 1 - ON; (1 - adds latency of 1 eclk)

   parameter MC_HA_DP_ADDR_WIDTH      = 46,
   parameter MC_HA_DP_DATA_WIDTH      = 512,
   parameter MC_ECC_EN                = 1, // 0 - OFF; 1 - ON
   parameter MC_ECC_ENC_LATENCY       = 0, // supported option 0 and 1; (latency in emif_usr_clk cycles)
   parameter MC_ECC_DEC_LATENCY       = 1, // supported option 1 and 2; (latency in emif_usr_clk cycles)
   parameter MC_RAM_INIT_W_ZERO_EN    = 1, // 0 - OFF; 1 - ON
   parameter MEMSIZE_WIDTH            = 64,

   // == localparam ==
   localparam MC_MDATA_WIDTH          = 14, // increase of value requires change of rspfifo width in mc_channel_adapter
   localparam MC_SR_STAT_WIDTH        = 5,
   localparam MC_HA_DP_SYMBOL_WIDTH   = 8,
   localparam MC_HA_DP_BE_WIDTH       = MC_HA_DP_DATA_WIDTH / MC_HA_DP_SYMBOL_WIDTH,
   localparam REQFIFO_DEPTH_WIDTH     = 6,
   localparam RSPFIFO_DEPTH_WIDTH     = 6,

   // ==== ALTECC ====
   localparam ALTECC_DATAWORD_WIDTH   = 64,
   localparam ALTECC_WIDTH_CODEWORD   = 72,
   localparam ALTECC_INST_NUMBER      = MC_HA_DP_DATA_WIDTH / ALTECC_DATAWORD_WIDTH,

   //   March 2022 - bringing up from mc_channel_adapter.sv
   localparam RST_REG_NUM             = 2,

   //   March 2022 - brining upt from mc_ecc.sv
   localparam ALTECC_CODEWORD_WIDTH   = 72,
   localparam AVMM_S_DATA_WIDTH       = 512,
   localparam AVMM_M_DATA_WIDTH       = ALTECC_INST_NUMBER * ALTECC_CODEWORD_WIDTH
)
(
  
   input  logic           eclk                            ,   //   input,    width = 1,               mc_clk.clk
     input  logic          reset_n_eclk                    ,   //  output,    width = 1,         reset_n_eclk.reset_n
     input   logic          emif_usr_clk_0                  ,             //   input,    width = 1,       emif_usr_clk_0.clk
     input   logic          emif_usr_clk_1                  ,             //   input,    width = 1,       emif_usr_clk_1.clk
     input   logic          emif_usr_reset_n_0              ,             //   input,    width = 1,   emif_usr_reset_n_0.reset
     input   logic          emif_usr_reset_n_1              ,  
   
     input   logic          pll_locked_0                    ,   //   input,    width = 1,         pll_locked_0.pll_locked
     input   logic          pll_locked_1                    ,   //   input,    width = 1,         pll_locked_1.pll_locked
     input   logic          local_cal_fail_0                ,   //   input,    width = 1,        emif_status_0.local_cal_fail
     input   logic          local_cal_success_0             ,   //   input,    width = 1,        emif_status_1.local_cal_success
     input   logic          local_cal_success_1             ,   //   input,    width = 1,        emif_status_1.local_cal_success
     input   logic          local_cal_fail_1                ,   //   input,    width = 1,                     .local_cal_fail
     input   logic          local_reset_done_0                ,   //   input,    width = 1,                     .local_cal_fail
     input   logic          local_reset_done_1                ,   //   input,    width = 1,                     .local_cal_fail


     output   logic         local_reset_req_0              ,
     output   logic         local_reset_req_1              ,
     output   logic         emif_usr_clk_out0_0              ,
     output   logic         emif_usr_clk_out0_1              ,
     output   logic         emif_usr_clk_out0_2              ,
     output   logic         emif_usr_clk_out0_3              ,
     output   logic         emif_usr_clk_out0_4              ,
     output   logic         emif_usr_clk_out0_5              ,
     output   logic         emif_usr_clk_out0_6              ,
     output   logic         emif_usr_clk_out0_7              ,
     output   logic         emif_usr_clk_out1_0              ,
     output   logic         emif_usr_clk_out1_1              ,
     output   logic         emif_usr_clk_out1_2              ,
     output   logic         emif_usr_clk_out1_3              ,
     output   logic         emif_usr_clk_out1_4              ,
     output   logic         emif_usr_clk_out1_5              ,
     output   logic         emif_usr_clk_out1_6              ,
     output   logic         emif_usr_clk_out1_7              ,
      
     output  logic  [639:0] reqfifo_data_in_eclk_0          ,   //  output,  width = 640,        reqfifo_out_0.datain
     output  logic          reqfifo_wen_eclk_0              ,   //  output,    width = 1,                     .wrreq
     output  logic          reqfifo_eclk_0                  ,   //  output,    width = 1,                     .wrclk
     output  logic          reqfifo_ren_mclk_0              ,   //  output,    width = 1,                     .rdreq
     output  logic          reqfifo_emif_usr_clk_0          ,   //  output,    width = 1,                     .rdclk
     output  logic          reqfifo_aclr_0                  ,   //  output,    width = 1,                     .aclr
     input  logic  [639:0]  reqfifo_data_out_mclk_0         ,   //   input,  width = 640,         reqfifo_in_0.dataout
     input  logic  [5:0]    reqfifo_wrusedw_eclk_0          ,   //   input,    width = 6,                     .wrusedw
     input  logic           reqfifo_empty_mclk_0            ,   //   input,    width = 1,                     .rdempty
     input  logic           reqfifo_full_eclk_0             ,   //   input,    width = 1,                     .wrfull
     input  logic           reqfifo_empty_eclk_0            ,   //   input,    width = 1,                     .wrempty
  
     output  logic  [639:0] reqfifo_data_in_eclk_1          ,   //  output,  width = 640,        reqfifo_out_1.datain
     output  logic          reqfifo_wen_eclk_1              ,   //  output,    width = 1,                     .wrreq
     output  logic          reqfifo_eclk_1                  ,   //  output,    width = 1,                     .wrclk
     output  logic          reqfifo_ren_mclk_1              ,   //  output,    width = 1,                     .rdreq
     output  logic          reqfifo_emif_usr_clk_1          ,   //  output,    width = 1,                     .rdclk
     output  logic          reqfifo_aclr_1                  ,   //  output,    width = 1,                     .aclr
     input  logic  [639:0]  reqfifo_data_out_mclk_1         ,   //   input,  width = 640,         reqfifo_in_1.dataout
     input  logic  [5:0]    reqfifo_wrusedw_eclk_1          ,   //   input,    width = 6,                     .wrusedw
     input  logic           reqfifo_empty_mclk_1            ,   //   input,    width = 1,                     .rdempty
     input  logic           reqfifo_full_eclk_1             ,   //   input,    width = 1,                     .wrfull
     input  logic           reqfifo_empty_eclk_1            ,   //   input,    width = 1,                     .wrempty  
     
     output  logic  [559:0] rspfifo_data_in_mclk_0          ,   //  output,  width = 560,        
     output  logic          rspfifo_wen_mclk_0              ,   //  output,    width = 1,        
     output  logic          rspfifo_emif_usr_clk_0          ,   //  output,    width = 1,        
     output  logic          rspfifo_ren_eclk_0              ,   //  output,    width = 1,        
     output  logic          rspfifo_eclk_0                  ,   //  output,    width = 1,        
     output  logic          rspfifo_aclr_0                  ,   //  output,    width = 1,        
     input  logic  [559:0]  rspfifo_data_out_eclk_0         ,   //   input,  width = 560,        
     input  logic           rspfifo_empty_eclk_0            ,   //   input,    width = 1,        
     input  logic           rspfifo_full_eclk_0             ,   //   input,    width = 1,        
     input  logic           rspfifo_full_mclk_0             ,   //   input,    width = 1,        
     input  logic  [5:0]    rspfifo_fill_level_eclk_0             ,   //   input,    width = 1,  
     
	 output  logic  [559:0] rspfifo_data_in_mclk_1          ,   //  output,  width = 560,        
     output  logic          rspfifo_wen_mclk_1              ,   //  output,    width = 1,        
     output  logic          rspfifo_emif_usr_clk_1                  ,   //  output,    width = 1,
     output  logic          rspfifo_ren_eclk_1              ,   //  output,    width = 1,        
     output  logic          rspfifo_eclk_1                  ,   //  output,    width = 1,        
     output  logic          rspfifo_aclr_1                  ,   //  output,    width = 1,        
     input  logic  [560:0]  rspfifo_data_out_eclk_1         ,   //   input,  width = 560,        
     input  logic           rspfifo_empty_eclk_1            ,   //   input,    width = 1,        
     input  logic           rspfifo_full_eclk_1             ,   //   input,    width = 1,        
     input  logic           rspfifo_full_mclk_1             ,   //   input,    width = 1,        
     input  logic  [5:0]    rspfifo_fill_level_eclk_1             ,   //   input,    width = 1,  
   
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_0_0,
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_0_1,
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_0_2,
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_0_3,
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_0_4,
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_0_5,
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_0_6,
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_0_7,
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_1_0,
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_1_1,
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_1_2,
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_1_3,
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_1_4,
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_1_5,
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_1_6,
    input   logic [71:0]  ecc_in_avmm_s_writedata_w_ecc_1_7,

   output logic [63:0]    mem_writedata_rmw_mclk_0_0       ,
   output logic [63:0]    mem_writedata_rmw_mclk_0_1      , 
   output logic [63:0]    mem_writedata_rmw_mclk_0_2       ,
   output logic [63:0]    mem_writedata_rmw_mclk_0_3       ,
   output logic [63:0]    mem_writedata_rmw_mclk_0_4       ,
   output logic [63:0]    mem_writedata_rmw_mclk_0_5       ,
   output logic [63:0]    mem_writedata_rmw_mclk_0_6       ,
   output logic [63:0]    mem_writedata_rmw_mclk_0_7       ,
   output logic [63:0]    mem_writedata_rmw_mclk_1_0       ,
   output logic [63:0]    mem_writedata_rmw_mclk_1_1      , 
   output logic [63:0]    mem_writedata_rmw_mclk_1_2       ,
   output logic [63:0]    mem_writedata_rmw_mclk_1_3       ,
   output logic [63:0]    mem_writedata_rmw_mclk_1_4       ,
   output logic [63:0]    mem_writedata_rmw_mclk_1_5       ,
   output logic [63:0]    mem_writedata_rmw_mclk_1_6       ,
   output logic [63:0]    mem_writedata_rmw_mclk_1_7       ,

    input logic    mem_ecc_err_corrected_rmw_mclk_0_0, 
    input logic    mem_ecc_err_corrected_rmw_mclk_0_1, 
    input logic    mem_ecc_err_corrected_rmw_mclk_0_2, 
    input logic    mem_ecc_err_corrected_rmw_mclk_0_3, 
    input logic    mem_ecc_err_corrected_rmw_mclk_0_4, 
    input logic    mem_ecc_err_corrected_rmw_mclk_0_5, 
    input logic    mem_ecc_err_corrected_rmw_mclk_0_6, 
    input logic    mem_ecc_err_corrected_rmw_mclk_0_7, 
    input logic    mem_ecc_err_corrected_rmw_mclk_1_0, 
    input logic    mem_ecc_err_corrected_rmw_mclk_1_1, 
    input logic    mem_ecc_err_corrected_rmw_mclk_1_2, 
    input logic    mem_ecc_err_corrected_rmw_mclk_1_3, 
    input logic    mem_ecc_err_corrected_rmw_mclk_1_4, 
    input logic    mem_ecc_err_corrected_rmw_mclk_1_5, 
    input logic    mem_ecc_err_corrected_rmw_mclk_1_6, 
    input logic    mem_ecc_err_corrected_rmw_mclk_1_7, 
    input logic    mem_ecc_err_detected_rmw_mclk_0_0, 
    input logic    mem_ecc_err_detected_rmw_mclk_0_1, 
    input logic    mem_ecc_err_detected_rmw_mclk_0_2, 
    input logic    mem_ecc_err_detected_rmw_mclk_0_3, 
    input logic    mem_ecc_err_detected_rmw_mclk_0_4, 
    input logic    mem_ecc_err_detected_rmw_mclk_0_5, 
    input logic    mem_ecc_err_detected_rmw_mclk_0_6, 
    input logic    mem_ecc_err_detected_rmw_mclk_0_7, 
    input logic    mem_ecc_err_detected_rmw_mclk_1_0, 
    input logic    mem_ecc_err_detected_rmw_mclk_1_1, 
    input logic    mem_ecc_err_detected_rmw_mclk_1_2, 
    input logic    mem_ecc_err_detected_rmw_mclk_1_3, 
    input logic    mem_ecc_err_detected_rmw_mclk_1_4, 
    input logic    mem_ecc_err_detected_rmw_mclk_1_5, 
    input logic    mem_ecc_err_detected_rmw_mclk_1_6, 
    input logic    mem_ecc_err_detected_rmw_mclk_1_7, 
    input logic    mem_ecc_err_fatal_rmw_mclk_0_0   , 
    input logic    mem_ecc_err_fatal_rmw_mclk_0_1   , 
    input logic    mem_ecc_err_fatal_rmw_mclk_0_2   , 
    input logic    mem_ecc_err_fatal_rmw_mclk_0_3   , 
    input logic    mem_ecc_err_fatal_rmw_mclk_0_4   , 
    input logic    mem_ecc_err_fatal_rmw_mclk_0_5   , 
    input logic    mem_ecc_err_fatal_rmw_mclk_0_6   , 
    input logic    mem_ecc_err_fatal_rmw_mclk_0_7   , 
    input logic    mem_ecc_err_fatal_rmw_mclk_1_0   , 
    input logic    mem_ecc_err_fatal_rmw_mclk_1_1   , 
    input logic    mem_ecc_err_fatal_rmw_mclk_1_2   , 
    input logic    mem_ecc_err_fatal_rmw_mclk_1_3   , 
    input logic    mem_ecc_err_fatal_rmw_mclk_1_4   , 
    input logic    mem_ecc_err_fatal_rmw_mclk_1_5   , 
    input logic    mem_ecc_err_fatal_rmw_mclk_1_6   , 
    input logic    mem_ecc_err_fatal_rmw_mclk_1_7   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_0_0   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_0_1   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_0_2   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_0_3   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_0_4   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_0_5   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_0_6   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_0_7   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_1_0   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_1_1   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_1_2   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_1_3   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_1_4   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_1_5   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_1_6   , 
    input logic    mem_ecc_err_syn_e_rmw_mclk_1_7   , 


    output  logic [71:0]    emif_amm_readdata_0_0,   //  width = 576
    output  logic [71:0]    emif_amm_readdata_0_1,   //  width = 576
    output  logic [71:0]    emif_amm_readdata_0_2,   //  width = 576
    output  logic [71:0]    emif_amm_readdata_0_3,   //  width = 576
    output  logic [71:0]    emif_amm_readdata_0_4,   //  width = 576
    output  logic [71:0]    emif_amm_readdata_0_5,   //  width = 576
    output  logic [71:0]    emif_amm_readdata_0_6,   //  width = 576
    output  logic [71:0]    emif_amm_readdata_0_7,   //  width = 576
    output  logic [71:0]    emif_amm_readdata_1_0,   //  width = 576
    output  logic [71:0]    emif_amm_readdata_1_1,   //  width = 576
    output  logic [71:0]    emif_amm_readdata_1_2,   //  width = 576
    output  logic [71:0]    emif_amm_readdata_1_3,   //  width = 576
    output  logic [71:0]    emif_amm_readdata_1_4,   //  width = 576
    output  logic [71:0]    emif_amm_readdata_1_5,   //  width = 576
    output  logic [71:0]    emif_amm_readdata_1_6,   //  width = 576
    output  logic [71:0]    emif_amm_readdata_1_7,   //  width = 576
    
    input logic [63:0]  ecc_in_avmm_s_readdata_0_0,        
    input logic [63:0]  ecc_in_avmm_s_readdata_0_1,        
    input logic [63:0]  ecc_in_avmm_s_readdata_0_2,        
    input logic [63:0]  ecc_in_avmm_s_readdata_0_3,        
    input logic [63:0]  ecc_in_avmm_s_readdata_0_4,        
    input logic [63:0]  ecc_in_avmm_s_readdata_0_5,        
    input logic [63:0]  ecc_in_avmm_s_readdata_0_6,        
    input logic [63:0]  ecc_in_avmm_s_readdata_0_7,        
    input logic [63:0]  ecc_in_avmm_s_readdata_1_0,         
    input logic [63:0]  ecc_in_avmm_s_readdata_1_1,         
    input logic [63:0]  ecc_in_avmm_s_readdata_1_2,         
    input logic [63:0]  ecc_in_avmm_s_readdata_1_3,         
    input logic [63:0]  ecc_in_avmm_s_readdata_1_4,         
    input logic [63:0]  ecc_in_avmm_s_readdata_1_5,         
    input logic [63:0]  ecc_in_avmm_s_readdata_1_6,         
    input logic [63:0]  ecc_in_avmm_s_readdata_1_7,

     output  logic [1:0]   mc2iafu_ready_eclk                  ,   //  output,    width = 2,              mc2iafu.ready_eclk
     output  logic [1:0]   mc2iafu_read_poison_eclk            ,   //  output,    width = 2,                     .read_poison_eclk
     output  logic [1:0]   mc2iafu_readdatavalid_eclk          ,   //  output,    width = 2,                     .readdatavalid_eclk
     output  logic [7:0]   mc2iafu_ecc_err_corrected_eclk_0    ,   //  output,    width = 8,                     .ecc_err_corrected_eclk_0
     output  logic [7:0]   mc2iafu_ecc_err_corrected_eclk_1    ,   //  output,    width = 8,                     .ecc_err_corrected_eclk_1
     output  logic [7:0]   mc2iafu_ecc_err_detected_eclk_0     ,   //  output,    width = 8,                     .ecc_err_detected_eclk_0
     output  logic [7:0]   mc2iafu_ecc_err_detected_eclk_1     ,   //  output,    width = 8,                     .ecc_err_detected_eclk_1
     output  logic [7:0]   mc2iafu_ecc_err_fatal_eclk_0        ,   //  output,    width = 8,                     .ecc_err_fatal_eclk_0
     output  logic [7:0]   mc2iafu_ecc_err_fatal_eclk_1        ,   //  output,    width = 8,                     .ecc_err_fatal_eclk_1
     output  logic [7:0]   mc2iafu_ecc_err_syn_e_eclk_0        ,   //  output,    width = 8,                     .ecc_err_syn_e_eclk_0
     output  logic [7:0]   mc2iafu_ecc_err_syn_e_eclk_1        ,   //  output,    width = 8,                     .ecc_err_syn_e_eclk_1
     output  logic [1:0]   mc2iafu_ecc_err_valid_eclk          ,   //  output,    width = 2,                     .ecc_err_valid_eclk
     output  logic [1:0]   cxlmem_ready                        ,   //  output,    width = 2,                     .cxlmem_ready
     output  logic [511:0] mc2iafu_readdata_eclk_0         ,       //  output,  width = 512,                     .readdata_eclk_0
     output  logic [511:0] mc2iafu_readdata_eclk_1         ,       //  output,  width = 512,                     .readdata_eclk_1
     output  logic [13:0]  mc2iafu_rsp_mdata_eclk_0            ,   //  output,   width = 14,                     .rsp_mdata_eclk_0
     output  logic [13:0]  mc2iafu_rsp_mdata_eclk_1            ,   //  output,   width = 14,                     .rsp_mdata_eclk_1
     input  logic  [511:0] iafu2mc_writedata_eclk_0        ,       //   input,  width = 512,              iafu2mc.writedata_eclk_0
     input  logic  [511:0] iafu2mc_writedata_eclk_1        ,       //   input,  width = 512,                     .writedata_eclk_1
     input  logic  [63:0]  iafu2mc_byteenable_eclk_0           ,   //   input,   width = 64,                     .byteenable_eclk_0
     input  logic  [63:0]  iafu2mc_byteenable_eclk_1           ,   //   input,   width = 64,                     .byteenable_eclk_1
     input  logic  [1:0]   iafu2mc_read_eclk                   ,   //   input,    width = 2,                     .read_eclk
     input  logic  [1:0]   iafu2mc_write_eclk                  ,   //   input,    width = 2,                     .write_eclk
     input  logic  [1:0]   iafu2mc_write_poison_eclk           ,   //   input,    width = 2,                     .write_poison_eclk
     input  logic  [1:0]   iafu2mc_write_ras_sbe_eclk          ,   //   input,    width = 2,                     .write_ras_sbe_eclk
     input  logic  [1:0]   iafu2mc_write_ras_dbe_eclk          ,   //   input,    width = 2,                     .write_ras_dbe_eclk
     input  logic  [45:0]  iafu2mc_address_eclk_0              ,   //   input,   width = 46,                     .address_eclk_0
     input  logic  [45:0]  iafu2mc_address_eclk_1              ,   //   input,   width = 46,                     .address_eclk_1
     input  logic  [13:0]  iafu2mc_req_mdata_eclk_0            ,   //   input,   width = 14,                     .req_mdata_eclk_0
     input  logic  [13:0]  iafu2mc_req_mdata_eclk_1            ,   //   input,   width = 14,                     .req_mdata_eclk_1
     output  logic [63:0]  mc2ha_memsize                       ,   //  output,   width = 64,               mc2sip.memsize
     output  logic [4:0]   mc_sr_status_eclk_0                 ,   //  output,    width = 5,                     .mc_sr_status_eclk_0
     output  logic [4:0]   mc_sr_status_eclk_1                 ,   //  output,    width = 5,                     .mc_sr_status_eclk_1
     output  logic [1:0]   mc2sip_reqfifo_full_eclk                   ,   //  output,    width = 2,                     .reqfifo_full_eclk
     output  logic [1:0]   mc2sip_reqfifo_empty_eclk                  ,   //  output,    width = 2,                     .reqfifo_empty_eclk
     output  logic [5:0]   mc2sip_reqfifo_fill_level_eclk_0           ,   //  output,    width = 6,                     .reqfifo_fill_level_eclk_0
     output  logic [5:0]   mc2sip_reqfifo_fill_level_eclk_1           ,   //  output,    width = 6,                     .reqfifo_fill_level_eclk_1
     output  logic [1:0]   mc2sip_rspfifo_full_eclk                   ,   //  output,    width = 2,                     .rspfifo_full_eclk
     output  logic [1:0]   mc2sip_rspfifo_empty_eclk                  ,   //  output,    width = 2,                     .rspfifo_empty_eclk
     output  logic [5:0]   mc2sip_rspfifo_fill_level_eclk_0           ,   //  output,    width = 6,                     .rspfifo_fill_level_eclk_0
     output  logic [5:0]   mc2sip_rspfifo_fill_level_eclk_1          ,  //  output,    width = 6,                     .rspfifo_fill_level_eclk_1
 

     output  logic [575:0]  emif_amm_0_writedata        , 
     output  logic          emif_amm_0_read             , 
     output  logic          emif_amm_0_write            , 
     output  logic [71:0]   emif_amm_0_byteenable       , 
     output  logic [34:0]   emif_amm_0_address          , 
     output  logic [6:0]    emif_amm_0_burstcount     , 
     input   logic [575:0]  emif_amm_0_readdata         , 
     input   logic          emif_amm_0_readdatavalid    , 
     input   logic          emif_amm_0_waitrequest      , 


     output  logic [575:0]  emif_amm_1_writedata        , 
     output  logic          emif_amm_1_read             , 
     output  logic          emif_amm_1_write            , 
     output  logic [71:0]   emif_amm_1_byteenable       , 
     output  logic [34:0]   emif_amm_1_address          , 
     output  logic [6:0]    emif_amm_1_burstcount     , 
     input   logic [575:0]  emif_amm_1_readdata         , 
     input   logic          emif_amm_1_readdatavalid    , 
     input   logic          emif_amm_1_waitrequest       


  
);

  /*  March 2022 -> signals added when moving Quartus IP modules up from mc_emif.sv
  */
  logic [4095:0]         calbus_seq_param_tbl [MC_CHANNEL-1:0]; // emif_fm_0:calbus_seq_param_tbl -> emif_cal_0:calbus_seq_param_tbl_0
  logic [31:0]           calbus_rdata [MC_CHANNEL-1:0];         // emif_fm_0:calbus_rdata -> emif_cal_0:calbus_rdata_0
  logic [31:0]           calbus_wdata   [MC_CHANNEL-1:0];       // emif_cal_0:calbus_wdata_0 -> emif_fm_0:calbus_wdata
  logic [19:0]           calbus_address [MC_CHANNEL-1:0];       // emif_cal_0:calbus_address_0 -> emif_fm_0:calbus_address
  logic [MC_CHANNEL-1:0] calbus_read;                           // emif_cal_0:calbus_read_0 -> emif_fm_0:calbus_read
  logic [MC_CHANNEL-1:0] calbus_write;                          // emif_cal_0:calbus_write_0 -> emif_fm_0:calbus_write
  logic 		 calbus_clk;                            // emif_cal_0:calbus_clk -> [emif_fm_0:calbus_clk, emif_fm_1:calbus_clk]

  logic [MEMSIZE_WIDTH-1:0]          mc_chan_memsize      [MC_CHANNEL-1:0];
  logic [MC_HA_DP_ADDR_WIDTH-1:0]    mc_baseaddr_cl;
  logic                              mc_baseaddr_cl_vld;

  logic [MC_CHANNEL-1:0]             emif_amm_read;                        //  width = 1,
  logic [MC_CHANNEL-1:0]             emif_amm_write;                       //  width = 1,
  logic [EMIF_AMM_ADDR_WIDTH-1:0]    emif_amm_address    [MC_CHANNEL-1:0]; //  width = 27,
  logic [EMIF_AMM_DATA_WIDTH-1:0]    emif_amm_writedata  [MC_CHANNEL-1:0]; //  width = 576,
  logic [EMIF_AMM_BURST_WIDTH-1:0]   emif_amm_burstcount [MC_CHANNEL-1:0]; //  width = 7,
  logic [EMIF_AMM_BE_WIDTH-1:0]      emif_amm_byteenable [MC_CHANNEL-1:0]; //  width = 72,
  logic [MC_CHANNEL-1:0]             emif_amm_readdatavalid;               //  width = 1,
  logic [MC_CHANNEL-1:0]             emif_amm_ready;                       //  width = 1,
  logic [EMIF_AMM_DATA_WIDTH-1:0]    emif_amm_readdata [MC_CHANNEL-1:0];   //  width = 576

  logic [MC_CHANNEL-1:0]  emif_usr_clk;
  logic [MC_CHANNEL-1:0]  emif_usr_reset_n;
  logic [MC_CHANNEL-1:0]  local_cal_success;
  logic [MC_CHANNEL-1:0]  local_cal_fail;
  logic [MC_CHANNEL-1:0]  local_reset_done;
  logic [MC_CHANNEL-1:0]  pll_ref_clk_out;
  logic [MC_CHANNEL-1:0]  pll_locked;

  /*  March 2022 -> signals added when moving Quartus IP modules up from mc_channel_adapter.sv
  */
  logic [ALTECC_INST_NUMBER-1:0]     mem_ecc_err_corrected_rmw_mclk [MC_CHANNEL-1:0];
  logic [ALTECC_INST_NUMBER-1:0]     mem_ecc_err_detected_rmw_mclk  [MC_CHANNEL-1:0];
  logic [ALTECC_INST_NUMBER-1:0]     mem_ecc_err_fatal_rmw_mclk     [MC_CHANNEL-1:0];
  logic [ALTECC_INST_NUMBER-1:0]     mem_ecc_err_syn_e_rmw_mclk     [MC_CHANNEL-1:0];
  logic [MC_HA_DP_DATA_WIDTH-1:0]    mem_readdata_rmw_mclk          [MC_CHANNEL-1:0];
  logic [MC_HA_DP_DATA_WIDTH-1:0]    mem_writedata_rmw_mclk         [MC_CHANNEL-1:0];
  logic [MC_HA_DP_BE_WIDTH-1:0]      mem_byteenable_rmw_mclk        [MC_CHANNEL-1:0];
  logic [EMIF_AMM_ADDR_WIDTH-1:0]    mem_address_rmw_mclk           [MC_CHANNEL-1:0];

  logic [MC_CHANNEL-1:0]             mem_read_poison_rmw_mclk  ;
  logic [MC_CHANNEL-1:0]             mem_readdatavalid_rmw_mclk;
  logic [MC_CHANNEL-1:0]             mem_ready_rmw_mclk        ;
  logic [MC_CHANNEL-1:0]             mem_write_ras_sbe_mclk    ;
  logic [MC_CHANNEL-1:0]             mem_write_ras_dbe_mclk    ;
  logic [MC_CHANNEL-1:0]             mem_read_rmw_mclk         ;
  logic [MC_CHANNEL-1:0]             mem_write_rmw_mclk        ;
  logic [MC_CHANNEL-1:0]             mem_write_poison_rmw_mclk ;

  // reqfifo
  localparam REQFIFO_DATA_WIDTH = 640;
  logic [REQFIFO_DATA_WIDTH-1:0]    reqfifo_data_in_eclk    [MC_CHANNEL-1:0];
  logic [REQFIFO_DATA_WIDTH-1:0]    reqfifo_data_out_mclk   [MC_CHANNEL-1:0];
  logic [REQFIFO_DEPTH_WIDTH-1:0]   reqfifo_wrusedw_eclk    [MC_CHANNEL-1:0];

  logic [MC_CHANNEL-1:0]            reqfifo_wen_eclk;
  logic [MC_CHANNEL-1:0]            reqfifo_ren_mclk;
  logic [MC_CHANNEL-1:0]            reqfifo_empty_mclk;
  
   logic [MC_CHANNEL-1:0]            reqfifo_full_eclk;
	logic [MC_CHANNEL-1:0]            reqfifo_empty_eclk; 
	logic [MC_CHANNEL-1:0]            rspfifo_empty_eclk;
   logic [MC_CHANNEL-1:0]            rspfifo_full_eclk;

  // rspfifo
  localparam RSPFIFO_DATA_WIDTH = 560;
  logic [RSPFIFO_DATA_WIDTH-1:0]    rspfifo_data_in_mclk  [MC_CHANNEL-1:0];
  logic [RSPFIFO_DATA_WIDTH-1:0]    rspfifo_data_out_eclk [MC_CHANNEL-1:0];

  logic [MC_CHANNEL-1:0]            rspfifo_wen_mclk;
  logic [MC_CHANNEL-1:0]            rspfifo_ren_eclk;
  logic [MC_CHANNEL-1:0]            rspfifo_full_mclk;

  logic [RST_REG_NUM-1:0]           emif_usr_reset_n_reg [MC_CHANNEL-1:0];

  /*  March 2022 -> signals added when moving Quartus IP modules up from mc_ecc.sv
  */
  logic [AVMM_M_DATA_WIDTH-1:0]  ecc_in_avmm_s_writedata_w_ecc [MC_CHANNEL-1:0];
  logic [AVMM_S_DATA_WIDTH-1:0]  ecc_in_avmm_s_readdata        [MC_CHANNEL-1:0];

  wire [MC_SR_STAT_WIDTH-1:0] 	  mc_sr_status_eclk [MC_CHANNEL-1:0]; // Memory Controller Status
  wire [MC_HA_DP_ADDR_WIDTH-1:0]  iafu2mc_address_eclk [MC_CHANNEL-1:0]; // AVMM address from iAFU
  wire [MC_MDATA_WIDTH-1:0] 	  iafu2mc_req_mdata_eclk [MC_CHANNEL-1:0]; // AVMM reqeust MDATA  from iAFU
  wire [MC_HA_DP_DATA_WIDTH-1:0]  iafu2mc_writedata_eclk [MC_CHANNEL-1:0]; // AVMM write data from iAFU
  wire [MC_HA_DP_BE_WIDTH-1:0] 	  iafu2mc_byteenable_eclk [MC_CHANNEL-1:0]; // AVMM byte enable from iAFU
  wire [MC_HA_DP_DATA_WIDTH-1:0]  mc2iafu_readdata_eclk [MC_CHANNEL-1:0]; // AVMM read data to iAFU
  wire [MC_MDATA_WIDTH-1:0] 	  mc2iafu_rsp_mdata_eclk [MC_CHANNEL-1:0]; // AVMM response MDATA to iAFU
  wire [ALTECC_INST_NUMBER-1:0]    mc2iafu_ecc_err_corrected_eclk [MC_CHANNEL-1:0];
  wire [ALTECC_INST_NUMBER-1:0]    mc2iafu_ecc_err_detected_eclk [MC_CHANNEL-1:0];
  wire [ALTECC_INST_NUMBER-1:0]    mc2iafu_ecc_err_fatal_eclk [MC_CHANNEL-1:0];
  wire [ALTECC_INST_NUMBER-1:0]    mc2iafu_ecc_err_syn_e_eclk [MC_CHANNEL-1:0];
  wire [REQFIFO_DEPTH_WIDTH-1:0]   reqfifo_fill_level_eclk [MC_CHANNEL-1:0];
  wire [RSPFIFO_DEPTH_WIDTH-1:0]   rspfifo_fill_level_eclk [MC_CHANNEL-1:0];   



   assign mc_sr_status_eclk_0 = mc_sr_status_eclk[0];
   assign mc_sr_status_eclk_1 = mc_sr_status_eclk[1];

////

  //logic [1:0] emif_usr_clk;
  assign emif_usr_clk = {emif_usr_clk_1,emif_usr_clk_0};  
  //logic [1:0] emif_usr_reset_n;
  assign emif_usr_reset_n = {emif_usr_reset_n_1,emif_usr_reset_n_0};
  //logic [1:0] pll_locked;
  assign pll_locked = {pll_locked_1,pll_locked_0};  
  //logic [1:0] local_reset_done;
  assign local_reset_done = {local_reset_done_1,local_reset_done_0};
  //logic [1:0] local_cal_success;
  assign local_cal_success = {local_cal_success_1,local_cal_success_0};
  //logic [1:0] local_cal_fail;
  assign local_cal_fail = {local_cal_fail_1,local_cal_fail_0};
  
  assign local_reset_req_0 ='0;
  assign local_reset_req_1 ='0;


//-----------------------------width=512---------------------------//
  assign mem_writedata_rmw_mclk_0_0 = mem_writedata_rmw_mclk[0][63:0];
  assign mem_writedata_rmw_mclk_0_1 = mem_writedata_rmw_mclk[0][127:64];
  assign mem_writedata_rmw_mclk_0_2 = mem_writedata_rmw_mclk[0][191:128];
  assign mem_writedata_rmw_mclk_0_3 = mem_writedata_rmw_mclk[0][255:192];
  assign mem_writedata_rmw_mclk_0_4 = mem_writedata_rmw_mclk[0][319:256];
  assign mem_writedata_rmw_mclk_0_5 = mem_writedata_rmw_mclk[0][383:320];
  assign mem_writedata_rmw_mclk_0_6 = mem_writedata_rmw_mclk[0][447:384];
  assign mem_writedata_rmw_mclk_0_7 = mem_writedata_rmw_mclk[0][511:448];
  assign mem_writedata_rmw_mclk_1_0 = mem_writedata_rmw_mclk[1][63:0];
  assign mem_writedata_rmw_mclk_1_1 = mem_writedata_rmw_mclk[1][127:64];
  assign mem_writedata_rmw_mclk_1_2 = mem_writedata_rmw_mclk[1][191:128];
  assign mem_writedata_rmw_mclk_1_3 = mem_writedata_rmw_mclk[1][255:192];
  assign mem_writedata_rmw_mclk_1_4 = mem_writedata_rmw_mclk[1][319:256];
  assign mem_writedata_rmw_mclk_1_5 = mem_writedata_rmw_mclk[1][383:320];
  assign mem_writedata_rmw_mclk_1_6 = mem_writedata_rmw_mclk[1][447:384];
  assign mem_writedata_rmw_mclk_1_7 = mem_writedata_rmw_mclk[1][511:448];

//-----------------------------width=576-----------------------------//
  assign  ecc_in_avmm_s_writedata_w_ecc[0][71:0]     = ecc_in_avmm_s_writedata_w_ecc_0_0   ;
  assign  ecc_in_avmm_s_writedata_w_ecc[0][143:72]   = ecc_in_avmm_s_writedata_w_ecc_0_1   ;
  assign  ecc_in_avmm_s_writedata_w_ecc[0][215:144]  = ecc_in_avmm_s_writedata_w_ecc_0_2   ;
  assign  ecc_in_avmm_s_writedata_w_ecc[0][287:216]  = ecc_in_avmm_s_writedata_w_ecc_0_3   ;
  assign  ecc_in_avmm_s_writedata_w_ecc[0][359:288]  = ecc_in_avmm_s_writedata_w_ecc_0_4   ;
  assign  ecc_in_avmm_s_writedata_w_ecc[0][431:360]  = ecc_in_avmm_s_writedata_w_ecc_0_5   ;
  assign  ecc_in_avmm_s_writedata_w_ecc[0][503:432]  = ecc_in_avmm_s_writedata_w_ecc_0_6   ;
  assign  ecc_in_avmm_s_writedata_w_ecc[0][575:504]  = ecc_in_avmm_s_writedata_w_ecc_0_7   ;
  assign  ecc_in_avmm_s_writedata_w_ecc[1][71:0]     = ecc_in_avmm_s_writedata_w_ecc_1_0   ;
  assign  ecc_in_avmm_s_writedata_w_ecc[1][143:72]   = ecc_in_avmm_s_writedata_w_ecc_1_1   ;
  assign  ecc_in_avmm_s_writedata_w_ecc[1][215:144]  = ecc_in_avmm_s_writedata_w_ecc_1_2   ;
  assign  ecc_in_avmm_s_writedata_w_ecc[1][287:216]  = ecc_in_avmm_s_writedata_w_ecc_1_3   ;
  assign  ecc_in_avmm_s_writedata_w_ecc[1][359:288]  = ecc_in_avmm_s_writedata_w_ecc_1_4   ;
  assign  ecc_in_avmm_s_writedata_w_ecc[1][431:360]  = ecc_in_avmm_s_writedata_w_ecc_1_5   ;
  assign  ecc_in_avmm_s_writedata_w_ecc[1][503:432]  = ecc_in_avmm_s_writedata_w_ecc_1_6   ;
  assign  ecc_in_avmm_s_writedata_w_ecc[1][575:504]  = ecc_in_avmm_s_writedata_w_ecc_1_7   ;



/////////////////////////////////LOGIC FOR QPDS/////////////////////////////////////////////////////////////////////////
//

//---------------------------------width = 1----------------------------------//
  generate     // generate for mc_ecc inst
  if (MC_ECC_EN == 1) 
  begin : GEN_ECC_EN_SIG_1

  assign mem_ecc_err_corrected_rmw_mclk[0][0] = mem_ecc_err_corrected_rmw_mclk_0_0; 
  assign mem_ecc_err_corrected_rmw_mclk[0][1] = mem_ecc_err_corrected_rmw_mclk_0_1; 
  assign mem_ecc_err_corrected_rmw_mclk[0][2] = mem_ecc_err_corrected_rmw_mclk_0_2; 
  assign mem_ecc_err_corrected_rmw_mclk[0][3] = mem_ecc_err_corrected_rmw_mclk_0_3; 
  assign mem_ecc_err_corrected_rmw_mclk[0][4] = mem_ecc_err_corrected_rmw_mclk_0_4; 
  assign mem_ecc_err_corrected_rmw_mclk[0][5] = mem_ecc_err_corrected_rmw_mclk_0_5; 
  assign mem_ecc_err_corrected_rmw_mclk[0][6] = mem_ecc_err_corrected_rmw_mclk_0_6; 
  assign mem_ecc_err_corrected_rmw_mclk[0][7] = mem_ecc_err_corrected_rmw_mclk_0_7; 
  assign mem_ecc_err_corrected_rmw_mclk[1][0] = mem_ecc_err_corrected_rmw_mclk_1_0; 
  assign mem_ecc_err_corrected_rmw_mclk[1][1] = mem_ecc_err_corrected_rmw_mclk_1_1; 
  assign mem_ecc_err_corrected_rmw_mclk[1][2] = mem_ecc_err_corrected_rmw_mclk_1_2; 
  assign mem_ecc_err_corrected_rmw_mclk[1][3] = mem_ecc_err_corrected_rmw_mclk_1_3; 
  assign mem_ecc_err_corrected_rmw_mclk[1][4] = mem_ecc_err_corrected_rmw_mclk_1_4; 
  assign mem_ecc_err_corrected_rmw_mclk[1][5] = mem_ecc_err_corrected_rmw_mclk_1_5; 
  assign mem_ecc_err_corrected_rmw_mclk[1][6] = mem_ecc_err_corrected_rmw_mclk_1_6; 
  assign mem_ecc_err_corrected_rmw_mclk[1][7] = mem_ecc_err_corrected_rmw_mclk_1_7; 

//---------------------------------width=1 ---------------------------------// 
  assign mem_ecc_err_detected_rmw_mclk[0][0] = mem_ecc_err_detected_rmw_mclk_0_0;
  assign mem_ecc_err_detected_rmw_mclk[0][1] = mem_ecc_err_detected_rmw_mclk_0_1;
  assign mem_ecc_err_detected_rmw_mclk[0][2] = mem_ecc_err_detected_rmw_mclk_0_2;
  assign mem_ecc_err_detected_rmw_mclk[0][3] = mem_ecc_err_detected_rmw_mclk_0_3;
  assign mem_ecc_err_detected_rmw_mclk[0][4] = mem_ecc_err_detected_rmw_mclk_0_4;
  assign mem_ecc_err_detected_rmw_mclk[0][5] = mem_ecc_err_detected_rmw_mclk_0_5;
  assign mem_ecc_err_detected_rmw_mclk[0][6] = mem_ecc_err_detected_rmw_mclk_0_6;
  assign mem_ecc_err_detected_rmw_mclk[0][7] = mem_ecc_err_detected_rmw_mclk_0_7;
  assign mem_ecc_err_detected_rmw_mclk[1][0] = mem_ecc_err_detected_rmw_mclk_1_0;
  assign mem_ecc_err_detected_rmw_mclk[1][1] = mem_ecc_err_detected_rmw_mclk_1_1;
  assign mem_ecc_err_detected_rmw_mclk[1][2] = mem_ecc_err_detected_rmw_mclk_1_2;
  assign mem_ecc_err_detected_rmw_mclk[1][3] = mem_ecc_err_detected_rmw_mclk_1_3;
  assign mem_ecc_err_detected_rmw_mclk[1][4] = mem_ecc_err_detected_rmw_mclk_1_4;
  assign mem_ecc_err_detected_rmw_mclk[1][5] = mem_ecc_err_detected_rmw_mclk_1_5;
  assign mem_ecc_err_detected_rmw_mclk[1][6] = mem_ecc_err_detected_rmw_mclk_1_6;
  assign mem_ecc_err_detected_rmw_mclk[1][7] = mem_ecc_err_detected_rmw_mclk_1_7;

//---------------------------------width = 1 ------------------------------------------//
  assign mem_ecc_err_fatal_rmw_mclk[0][0] = mem_ecc_err_fatal_rmw_mclk_0_0; 
  assign mem_ecc_err_fatal_rmw_mclk[0][1] = mem_ecc_err_fatal_rmw_mclk_0_1; 
  assign mem_ecc_err_fatal_rmw_mclk[0][2] = mem_ecc_err_fatal_rmw_mclk_0_2; 
  assign mem_ecc_err_fatal_rmw_mclk[0][3] = mem_ecc_err_fatal_rmw_mclk_0_3; 
  assign mem_ecc_err_fatal_rmw_mclk[0][4] = mem_ecc_err_fatal_rmw_mclk_0_4; 
  assign mem_ecc_err_fatal_rmw_mclk[0][5] = mem_ecc_err_fatal_rmw_mclk_0_5; 
  assign mem_ecc_err_fatal_rmw_mclk[0][6] = mem_ecc_err_fatal_rmw_mclk_0_6; 
  assign mem_ecc_err_fatal_rmw_mclk[0][7] = mem_ecc_err_fatal_rmw_mclk_0_7; 
  assign mem_ecc_err_fatal_rmw_mclk[1][0] = mem_ecc_err_fatal_rmw_mclk_1_0; 
  assign mem_ecc_err_fatal_rmw_mclk[1][1] = mem_ecc_err_fatal_rmw_mclk_1_1; 
  assign mem_ecc_err_fatal_rmw_mclk[1][2] = mem_ecc_err_fatal_rmw_mclk_1_2; 
  assign mem_ecc_err_fatal_rmw_mclk[1][3] = mem_ecc_err_fatal_rmw_mclk_1_3; 
  assign mem_ecc_err_fatal_rmw_mclk[1][4] = mem_ecc_err_fatal_rmw_mclk_1_4; 
  assign mem_ecc_err_fatal_rmw_mclk[1][5] = mem_ecc_err_fatal_rmw_mclk_1_5; 
  assign mem_ecc_err_fatal_rmw_mclk[1][6] = mem_ecc_err_fatal_rmw_mclk_1_6; 
  assign mem_ecc_err_fatal_rmw_mclk[1][7] = mem_ecc_err_fatal_rmw_mclk_1_7; 

//---------------------------------------width=1 --------------------------------
  assign mem_ecc_err_syn_e_rmw_mclk[0][0] = mem_ecc_err_syn_e_rmw_mclk_0_0; 
  assign mem_ecc_err_syn_e_rmw_mclk[0][1] = mem_ecc_err_syn_e_rmw_mclk_0_1; 
  assign mem_ecc_err_syn_e_rmw_mclk[0][2] = mem_ecc_err_syn_e_rmw_mclk_0_2; 
  assign mem_ecc_err_syn_e_rmw_mclk[0][3] = mem_ecc_err_syn_e_rmw_mclk_0_3; 
  assign mem_ecc_err_syn_e_rmw_mclk[0][4] = mem_ecc_err_syn_e_rmw_mclk_0_4; 
  assign mem_ecc_err_syn_e_rmw_mclk[0][5] = mem_ecc_err_syn_e_rmw_mclk_0_5; 
  assign mem_ecc_err_syn_e_rmw_mclk[0][6] = mem_ecc_err_syn_e_rmw_mclk_0_6; 
  assign mem_ecc_err_syn_e_rmw_mclk[0][7] = mem_ecc_err_syn_e_rmw_mclk_0_7; 
  assign mem_ecc_err_syn_e_rmw_mclk[1][0] = mem_ecc_err_syn_e_rmw_mclk_1_0; 
  assign mem_ecc_err_syn_e_rmw_mclk[1][1] = mem_ecc_err_syn_e_rmw_mclk_1_1; 
  assign mem_ecc_err_syn_e_rmw_mclk[1][2] = mem_ecc_err_syn_e_rmw_mclk_1_2; 
  assign mem_ecc_err_syn_e_rmw_mclk[1][3] = mem_ecc_err_syn_e_rmw_mclk_1_3; 
  assign mem_ecc_err_syn_e_rmw_mclk[1][4] = mem_ecc_err_syn_e_rmw_mclk_1_4; 
  assign mem_ecc_err_syn_e_rmw_mclk[1][5] = mem_ecc_err_syn_e_rmw_mclk_1_5; 
  assign mem_ecc_err_syn_e_rmw_mclk[1][6] = mem_ecc_err_syn_e_rmw_mclk_1_6; 
  assign mem_ecc_err_syn_e_rmw_mclk[1][7] = mem_ecc_err_syn_e_rmw_mclk_1_7; 

end   // if (MC_ECC_EN == 1) 
endgenerate   // generate for mc_ecc inst 

//----------------------------width=512-----------------------------------------//
  assign ecc_in_avmm_s_readdata[0][63:0]    =  ecc_in_avmm_s_readdata_0_0;
  assign ecc_in_avmm_s_readdata[0][127:64]  =  ecc_in_avmm_s_readdata_0_1;
  assign ecc_in_avmm_s_readdata[0][191:128] =  ecc_in_avmm_s_readdata_0_2;
  assign ecc_in_avmm_s_readdata[0][255:192] =  ecc_in_avmm_s_readdata_0_3;
  assign ecc_in_avmm_s_readdata[0][319:256] =  ecc_in_avmm_s_readdata_0_4;
  assign ecc_in_avmm_s_readdata[0][383:320] =  ecc_in_avmm_s_readdata_0_5;
  assign ecc_in_avmm_s_readdata[0][447:384] =  ecc_in_avmm_s_readdata_0_6;
  assign ecc_in_avmm_s_readdata[0][511:448] =  ecc_in_avmm_s_readdata_0_7;
  assign ecc_in_avmm_s_readdata[1][63:0]    =  ecc_in_avmm_s_readdata_1_0;
  assign ecc_in_avmm_s_readdata[1][127:64]  =  ecc_in_avmm_s_readdata_1_1;
  assign ecc_in_avmm_s_readdata[1][191:128] =  ecc_in_avmm_s_readdata_1_2;
  assign ecc_in_avmm_s_readdata[1][255:192] =  ecc_in_avmm_s_readdata_1_3;
  assign ecc_in_avmm_s_readdata[1][319:256] =  ecc_in_avmm_s_readdata_1_4;
  assign ecc_in_avmm_s_readdata[1][383:320] =  ecc_in_avmm_s_readdata_1_5;
  assign ecc_in_avmm_s_readdata[1][447:384] =  ecc_in_avmm_s_readdata_1_6;
  assign ecc_in_avmm_s_readdata[1][511:448] =  ecc_in_avmm_s_readdata_1_7;

//------------------width = 576-------------------------//
    assign emif_amm_readdata_0_0 = emif_amm_readdata[0][71:0]; 
    assign emif_amm_readdata_0_1 = emif_amm_readdata[0][143:72];
    assign emif_amm_readdata_0_2 = emif_amm_readdata[0][215:144];
    assign emif_amm_readdata_0_3 = emif_amm_readdata[0][287:216];
    assign emif_amm_readdata_0_4 = emif_amm_readdata[0][359:288];
    assign emif_amm_readdata_0_5 = emif_amm_readdata[0][431:360];
    assign emif_amm_readdata_0_6 = emif_amm_readdata[0][503:432];
    assign emif_amm_readdata_0_7 = emif_amm_readdata[0][575:504];
    assign emif_amm_readdata_1_0 = emif_amm_readdata[1][71:0];
    assign emif_amm_readdata_1_1 = emif_amm_readdata[1][143:72];
    assign emif_amm_readdata_1_2 = emif_amm_readdata[1][215:144];
    assign emif_amm_readdata_1_3 = emif_amm_readdata[1][287:216];
    assign emif_amm_readdata_1_4 = emif_amm_readdata[1][359:288];
    assign emif_amm_readdata_1_5 = emif_amm_readdata[1][431:360];
    assign emif_amm_readdata_1_6 = emif_amm_readdata[1][503:432];
    assign emif_amm_readdata_1_7 = emif_amm_readdata[1][575:504];


    assign reqfifo_data_in_eclk_0 = reqfifo_data_in_eclk[0];
    assign reqfifo_data_in_eclk_1 = reqfifo_data_in_eclk[1];
    assign reqfifo_wen_eclk_0   	= reqfifo_wen_eclk[0]    ;
    assign reqfifo_wen_eclk_1   	= reqfifo_wen_eclk[1]    ;
    assign reqfifo_eclk_0      	= eclk                ;
    assign reqfifo_eclk_1      	= eclk                ;
    assign reqfifo_ren_mclk_0     = reqfifo_ren_mclk[0]    ;
    assign reqfifo_ren_mclk_1     = reqfifo_ren_mclk[1]    ;
    assign reqfifo_emif_usr_clk_0 = emif_usr_clk_0        ;
    assign reqfifo_emif_usr_clk_1 = emif_usr_clk_1        ;
    assign reqfifo_aclr_0         = ~reset_n_eclk;   
    assign reqfifo_aclr_1         = ~reset_n_eclk;   

    assign  reqfifo_data_out_mclk[0]  =  reqfifo_data_out_mclk_0  ; 
    assign  reqfifo_data_out_mclk[1]  =  reqfifo_data_out_mclk_1  ; 
    assign  reqfifo_wrusedw_eclk[0]   =  reqfifo_wrusedw_eclk_0   ; 
    assign  reqfifo_wrusedw_eclk[1]   =  reqfifo_wrusedw_eclk_1   ; 
    assign  reqfifo_empty_mclk[0]     =  reqfifo_empty_mclk_0     ; 
    assign  reqfifo_empty_mclk[1]     =  reqfifo_empty_mclk_1     ; 
    assign  reqfifo_full_eclk[0]      =  reqfifo_full_eclk_0      ; 
    assign  reqfifo_full_eclk[1]      =  reqfifo_full_eclk_1      ; 
    assign  reqfifo_empty_eclk[0]     =  reqfifo_empty_eclk_0     ; 
    assign  reqfifo_empty_eclk[1]     =  reqfifo_empty_eclk_1     ; 
  

	
     assign   rspfifo_data_in_mclk_0    		= 	rspfifo_data_in_mclk[0]      ;
     assign   rspfifo_data_in_mclk_1    		= 	rspfifo_data_in_mclk[1]      ;
     assign   rspfifo_wen_mclk_0        		= 	 rspfifo_wen_mclk[0]  ;
     assign   rspfifo_wen_mclk_1        		= 	 rspfifo_wen_mclk[1]  ;
     assign   rspfifo_emif_usr_clk_0    		= 	emif_usr_clk_0  ;
     assign   rspfifo_emif_usr_clk_1    		= 	emif_usr_clk_1  ;
     assign   rspfifo_ren_eclk_0        		= 	 rspfifo_ren_eclk [0] ; 
     assign   rspfifo_ren_eclk_1        		= 	 rspfifo_ren_eclk [1] ; 
     assign   rspfifo_eclk_0            		= 	eclk  ;
     assign   rspfifo_eclk_1            		= 	eclk  ;
     assign   rspfifo_aclr_0            		= 	~reset_n_eclk;
     assign   rspfifo_aclr_1            		= 	~reset_n_eclk;
	   
    assign   rspfifo_data_out_eclk[0] 	= rspfifo_data_out_eclk_0   		; 
    assign   rspfifo_data_out_eclk[1] 	= rspfifo_data_out_eclk_1   		; 
    assign   rspfifo_empty_eclk[0] 		= rspfifo_empty_eclk_0      		;
    assign   rspfifo_empty_eclk[1] 		= rspfifo_empty_eclk_1      		;
    assign   rspfifo_full_eclk[0]		= rspfifo_full_eclk_0       		;
    assign   rspfifo_full_eclk[1]		= rspfifo_full_eclk_1       		;
	 
    assign   mc2sip_rspfifo_full_eclk[0]		= rspfifo_full_eclk_0       		;
    assign   mc2sip_rspfifo_full_eclk[1]		= rspfifo_full_eclk_1       		;

    assign  mc2sip_reqfifo_full_eclk[0]    =  reqfifo_full_eclk_0   ;
    assign  mc2sip_reqfifo_full_eclk[1]    =  reqfifo_full_eclk_1   ; 
    assign  mc2sip_reqfifo_empty_eclk[0]   =  reqfifo_empty_eclk_0  ;  	 	 
    assign  mc2sip_reqfifo_empty_eclk[1]   =  reqfifo_empty_eclk_1  ;  	 	 
    assign  mc2sip_rspfifo_empty_eclk[0]   =  rspfifo_empty_eclk_0  ;  	 	
    assign  mc2sip_rspfifo_empty_eclk[1]   =  rspfifo_empty_eclk_1  ;  	 	

 
    assign   rspfifo_fill_level_eclk[0]	= rspfifo_fill_level_eclk_0 			;
    assign   rspfifo_fill_level_eclk[1]	= rspfifo_fill_level_eclk_1 			;
    assign   rspfifo_full_mclk[0]		= rspfifo_full_mclk_0     			;
    assign   rspfifo_full_mclk[1]		= rspfifo_full_mclk_1     			;


    //assign   reqfifo_data_in_eclk_0  =  reqfifo_data_in_eclk[0] ;
    //assign   reqfifo_data_in_eclk_1  =  reqfifo_data_in_eclk[1] ;
    //assign   reqfifo_wen_eclk_0      =  reqfifo_wen_eclk[0]     ;
    //assign   reqfifo_wen_eclk_1      =  reqfifo_wen_eclk[1]     ;
    //assign   reqfifo_eclk_0          =  reqfifo_eclk[0]         ;
    //assign   reqfifo_eclk_1          =  reqfifo_eclk[1]         ;
    //assign   reqfifo_ren_mclk_0      =  reqfifo_ren_mclk[0]     ;
    //assign   reqfifo_ren_mclk_1      =  reqfifo_ren_mclk[1]     ;
    //assign   reqfifo_emif_usr_clk_0  =  emif_usr_clk_0 ;
    //assign   reqfifo_emif_usr_clk_1  =  emif_usr_clk_1 ;
    //assign   reqfifo_aclr_0          =  ~reset_n_eclk   ;
    //assign   reqfifo_aclr_1          =  ~reset_n_eclk   ;
	
    //assign    reqfifo_data_out_mclk[0]  =    reqfifo_data_out_mclk_0 ;
    //assign    reqfifo_data_out_mclk[1]  =    reqfifo_data_out_mclk_1 ;
    //assign    reqfifo_wrusedw_eclk[0]   =    reqfifo_wrusedw_eclk_0  ;
    //assign    reqfifo_wrusedw_eclk[1]   =    reqfifo_wrusedw_eclk_1  ;
    //assign    reqfifo_empty_mclk[0]     =    reqfifo_empty_mclk_0    ;
    //assign    reqfifo_empty_mclk[1]     =    reqfifo_empty_mclk_1    ;
    //assign    reqfifo_full_eclk[0]      =    reqfifo_full_eclk_0     ;
    //assign    reqfifo_full_eclk[1]      =    reqfifo_full_eclk_1     ;
    //assign    reqfifo_empty_eclk[0]     =    reqfifo_empty_eclk_0    ;
    //assign    reqfifo_empty_eclk[1]     =    reqfifo_empty_eclk_1    ;

  generate     // generate for mc_ecc inst
  if (MC_ECC_EN == 1) 
  begin : GEN_ECC_ON_DEC_IN_CLK
   assign   emif_usr_clk_out0_0    = emif_usr_clk_0  ;
   assign   emif_usr_clk_out0_1    = emif_usr_clk_0  ;
   assign   emif_usr_clk_out0_2    = emif_usr_clk_0  ;
   assign   emif_usr_clk_out0_3    = emif_usr_clk_0  ;
   assign   emif_usr_clk_out0_4    = emif_usr_clk_0  ;
   assign   emif_usr_clk_out0_5    = emif_usr_clk_0  ;
   assign   emif_usr_clk_out0_6    = emif_usr_clk_0  ;
   assign   emif_usr_clk_out0_7    = emif_usr_clk_0  ;
   assign   emif_usr_clk_out1_0    = emif_usr_clk_1 ;
   assign   emif_usr_clk_out1_1    = emif_usr_clk_1 ;
   assign   emif_usr_clk_out1_2    = emif_usr_clk_1 ;
   assign   emif_usr_clk_out1_3    = emif_usr_clk_1 ;
   assign   emif_usr_clk_out1_4    = emif_usr_clk_1 ;
   assign   emif_usr_clk_out1_5    = emif_usr_clk_1 ;
   assign   emif_usr_clk_out1_6    = emif_usr_clk_1 ;
   assign   emif_usr_clk_out1_7    = emif_usr_clk_1 ;

end   // if (MC_ECC_EN == 1) 
  else begin : GEN_ECC_OFF_DEC_IN_CLK
   assign   emif_usr_clk_out0_0    = 1'b0  ;
   assign   emif_usr_clk_out0_1    = 1'b0  ;
   assign   emif_usr_clk_out0_2    = 1'b0  ;
   assign   emif_usr_clk_out0_3    = 1'b0  ;
   assign   emif_usr_clk_out0_4    = 1'b0  ;
   assign   emif_usr_clk_out0_5    = 1'b0  ;
   assign   emif_usr_clk_out0_6    = 1'b0  ;
   assign   emif_usr_clk_out0_7    = 1'b0  ;
   assign   emif_usr_clk_out1_0    = 1'b0 ;
   assign   emif_usr_clk_out1_1    = 1'b0 ;
   assign   emif_usr_clk_out1_2    = 1'b0 ;
   assign   emif_usr_clk_out1_3    = 1'b0 ;
   assign   emif_usr_clk_out1_4    = 1'b0 ;
   assign   emif_usr_clk_out1_5    = 1'b0 ;
   assign   emif_usr_clk_out1_6    = 1'b0 ;
   assign   emif_usr_clk_out1_7    = 1'b0 ;
end   // if (MC_ECC_EN != 1) 


endgenerate   // generate for mc_ecc inst 
///////


  assign   iafu2mc_address_eclk[0]    = iafu2mc_address_eclk_0   ;
  assign   iafu2mc_address_eclk[1]    = iafu2mc_address_eclk_1   ;
  assign   iafu2mc_req_mdata_eclk[0]  = iafu2mc_req_mdata_eclk_0 ;
  assign   iafu2mc_req_mdata_eclk[1]  = iafu2mc_req_mdata_eclk_1 ;
  assign   iafu2mc_writedata_eclk[0]  = iafu2mc_writedata_eclk_0 ;
  assign   iafu2mc_writedata_eclk[1]  = iafu2mc_writedata_eclk_1 ;
  assign   iafu2mc_byteenable_eclk[0] = iafu2mc_byteenable_eclk_0; 
  assign   iafu2mc_byteenable_eclk[1] = iafu2mc_byteenable_eclk_1;  
  assign   mc2iafu_readdata_eclk_0  = mc2iafu_readdata_eclk[0] ;
  assign   mc2iafu_readdata_eclk_1  = mc2iafu_readdata_eclk[1] ;  
  assign   mc2iafu_rsp_mdata_eclk_0 = mc2iafu_rsp_mdata_eclk[0];  
  assign   mc2iafu_rsp_mdata_eclk_1 = mc2iafu_rsp_mdata_eclk[1];  
  
  assign   mc2iafu_ecc_err_corrected_eclk_0 =  mc2iafu_ecc_err_corrected_eclk[0];
  assign   mc2iafu_ecc_err_corrected_eclk_1 =  mc2iafu_ecc_err_corrected_eclk[1];
  assign   mc2iafu_ecc_err_detected_eclk_0  = mc2iafu_ecc_err_detected_eclk[0]  ;
  assign   mc2iafu_ecc_err_detected_eclk_1  = mc2iafu_ecc_err_detected_eclk[1]  ;
  assign   mc2iafu_ecc_err_fatal_eclk_0  = mc2iafu_ecc_err_fatal_eclk[0]       ;
  assign   mc2iafu_ecc_err_fatal_eclk_1  = mc2iafu_ecc_err_fatal_eclk[1]       ;
  assign   mc2iafu_ecc_err_syn_e_eclk_0  = mc2iafu_ecc_err_syn_e_eclk[0]       ;
  assign   mc2iafu_ecc_err_syn_e_eclk_1  =  mc2iafu_ecc_err_syn_e_eclk[1]       ;
  assign   mc2sip_reqfifo_fill_level_eclk_0 =   reqfifo_fill_level_eclk[0]              ;
  assign   mc2sip_reqfifo_fill_level_eclk_1  =  reqfifo_fill_level_eclk[1]              ;
  assign   mc2sip_rspfifo_fill_level_eclk_0  =  rspfifo_fill_level_eclk[0]             ;
  assign   mc2sip_rspfifo_fill_level_eclk_1  =  rspfifo_fill_level_eclk[1]             ;   
  
  
  
// avmm

  assign   emif_amm_0_writedata      = emif_amm_writedata[0]   ;
  assign   emif_amm_0_read           = emif_amm_read[0]        ;
  assign   emif_amm_0_write          = emif_amm_write[0]       ;
  assign   emif_amm_0_byteenable     = emif_amm_byteenable[0]  ;
//  assign   emif_amm_0_address        = {8'b0,emif_amm_address[0]} ;
  assign   emif_amm_0_address        = {1'b0,emif_amm_address[0],7'b0} ;
  assign   emif_amm_0_burstcount     = emif_amm_burstcount[0]  ;
  assign   emif_amm_readdata[0]      = emif_amm_0_readdata       ;
  assign   emif_amm_readdatavalid[0] = emif_amm_0_readdatavalid  ;
  assign   emif_amm_ready[0]         = emif_amm_0_waitrequest    ;  //.amm_ready_0  (emif_amm_ready[chanCount] ),    //  output,     width = 1,    ctrl_amm_0.waitrequest_n


  assign   emif_amm_1_writedata      = emif_amm_writedata[1]   ;
  assign   emif_amm_1_read           = emif_amm_read[1]        ;
  assign   emif_amm_1_write          = emif_amm_write[1]       ;
  assign   emif_amm_1_byteenable     = emif_amm_byteenable[1]  ;
//  assign   emif_amm_1_address        = {8'b0,emif_amm_address[1]} ;
  assign   emif_amm_1_address        = {1'b0,emif_amm_address[1],7'b0} ;
  assign   emif_amm_1_burstcount     = emif_amm_burstcount[1]  ;
  assign   emif_amm_readdata[1]      = emif_amm_1_readdata       ;
  assign   emif_amm_readdatavalid[1] = emif_amm_1_readdatavalid  ;
  assign   emif_amm_ready[1]         = emif_amm_1_waitrequest    ;  //.amm_ready_0  (emif_amm_ready[chanCount] ),    //  output,     width = 1,    ctrl_amm_0.waitrequest_n





    	

////

  assign mc_baseaddr_cl = '0;
  assign mc_baseaddr_cl_vld = 1'b1;

  always_comb 
  begin
    mc2ha_memsize = 0;
    for (int i=0; i<MC_CHANNEL; i=i+1)
    begin
      mc2ha_memsize = mc2ha_memsize + mc_chan_memsize[i];
    end
  end


  generate   // generate for channel adapter
  for( genvar chanCount = 0; chanCount < MC_CHANNEL; chanCount=chanCount+1 )
  begin : GEN_CHAN_COUNT_CHAN_ADAPT

   // `ifdef INCLUDE_CXLMEM_READY
        mc_cxlmem_ready_control     mc_cxlmem_ready_control_inst       // "interface" logic handling the ready flag to the bbs
        (
            .clk                                     ( eclk                               ),
            .reset_al                                ( reset_n_eclk                       ),
            .from_mc_ch_adpt_mc2iafu_ready_eclk      ( mc2iafu_ready_eclk[chanCount]      ),
            .from_mc_ch_adpt_reqfifo_full_eclk       ( reqfifo_full_eclk[chanCount]       ),
            .from_mc_ch_adpt_reqfifo_empty_eclk      ( reqfifo_empty_eclk[chanCount]      ),
            .from_mc_ch_adpt_reqfifo_fill_level_eclk ( reqfifo_fill_level_eclk[chanCount] ),
            .to_bbs_cxlmem_ready                     ( cxlmem_ready[chanCount]            )
        );
    // `endif

    mc_channel_adapter 
    #(
      .MC_HA_DP_ADDR_WIDTH      (MC_HA_DP_ADDR_WIDTH     ),
      .MC_HA_DP_DATA_WIDTH      (MC_HA_DP_DATA_WIDTH     ),
      .MC_ECC_EN                (MC_ECC_EN               ),
      .MC_ECC_ENC_LATENCY       (MC_ECC_ENC_LATENCY      ),
      .MC_ECC_DEC_LATENCY       (MC_ECC_DEC_LATENCY      ),
      .MC_RAM_INIT_W_ZERO_EN    (MC_RAM_INIT_W_ZERO_EN   ),
      .EMIF_AMM_ADDR_WIDTH      (EMIF_AMM_ADDR_WIDTH     ),
      .EMIF_AMM_DATA_WIDTH      (EMIF_AMM_DATA_WIDTH     ),
      .EMIF_AMM_BURST_WIDTH     (EMIF_AMM_BURST_WIDTH    ),
      .EMIF_AMM_BE_WIDTH        (EMIF_AMM_BE_WIDTH       ),
      .REG_ON_REQFIFO_INPUT_EN  (REG_ON_REQFIFO_INPUT_EN ),
      .REG_ON_REQFIFO_OUTPUT_EN (REG_ON_REQFIFO_OUTPUT_EN),
      .REG_ON_RSPFIFO_OUTPUT_EN (REG_ON_RSPFIFO_OUTPUT_EN)
    )
    mc_channel_adapter_inst 
    (
      .eclk                         (eclk                          ), // input,    width = 1,
      .reset_n_eclk                 (reset_n_eclk                  ), // input,    width = 1,

      .mc_baseaddr_cl               (mc_baseaddr_cl                ), 
      .mc_baseaddr_cl_vld           (mc_baseaddr_cl_vld            ), //                      mc_ha     : Base address registers have been set

      // iAFU signals
      .mc2iafu_ready_eclk         ( mc2iafu_ready_eclk[chanCount]          ), //  input,   width = 1,
      .iafu2mc_read_eclk          ( iafu2mc_read_eclk[chanCount]           ), // output,   width = 1,
      .iafu2mc_write_eclk         ( iafu2mc_write_eclk[chanCount]          ), // output,   width = 1,
      .iafu2mc_write_poison_eclk  ( iafu2mc_write_poison_eclk[chanCount]   ), // output,   width = 1,
      .iafu2mc_write_ras_sbe_eclk ( iafu2mc_write_ras_sbe_eclk[chanCount]  ), // output,   width = 1,
      .iafu2mc_write_ras_dbe_eclk ( iafu2mc_write_ras_dbe_eclk[chanCount]  ), // output,   width = 1,
      .iafu2mc_address_eclk       ( iafu2mc_address_eclk[chanCount]        ), // output,   width = 46,
      .iafu2mc_req_mdata_eclk     ( iafu2mc_req_mdata_eclk[chanCount]      ), // output,   width = 46,
      .mc2iafu_readdata_eclk      ( mc2iafu_readdata_eclk[chanCount]       ), //  input,   width = 512,
      .mc2iafu_rsp_mdata_eclk     ( mc2iafu_rsp_mdata_eclk[chanCount]      ), //  input,   width = 512,
      .iafu2mc_writedata_eclk     ( iafu2mc_writedata_eclk[chanCount]      ), // output,   width = 512,
      .iafu2mc_byteenable_eclk    ( iafu2mc_byteenable_eclk[chanCount]     ), // output,   width = 64,
      .mc2iafu_read_poison_eclk   ( mc2iafu_read_poison_eclk[chanCount]    ), // output,   width = 1,
      .mc2iafu_readdatavalid_eclk ( mc2iafu_readdatavalid_eclk[chanCount]  ), //  input,   width = 1,

      // Error Correction Code (ECC)
      .mc2iafu_ecc_err_corrected_eclk( mc2iafu_ecc_err_corrected_eclk[chanCount] ),
      .mc2iafu_ecc_err_detected_eclk ( mc2iafu_ecc_err_detected_eclk[chanCount]  ),
      .mc2iafu_ecc_err_fatal_eclk    ( mc2iafu_ecc_err_fatal_eclk[chanCount]     ),
      .mc2iafu_ecc_err_syn_e_eclk    ( mc2iafu_ecc_err_syn_e_eclk[chanCount]     ),
      .mc2iafu_ecc_err_valid_eclk    ( mc2iafu_ecc_err_valid_eclk[chanCount]     ),

      .emif_usr_clk                  (emif_usr_clk[chanCount]                 ),
      .emif_usr_reset_n              (emif_usr_reset_n[chanCount]             ),
      .emif_pll_locked               (pll_locked[chanCount]              ),
      .emif_reset_done               (local_reset_done[chanCount]              ),
      .emif_cal_success              (local_cal_success[chanCount]             ),
      .emif_cal_fail                 (local_cal_fail[chanCount]                ),

      .mc_sr_status_eclk             (mc_sr_status_eclk[chanCount]            ), // output,

      .mem_ecc_err_corrected_rmw_mclk ( mem_ecc_err_corrected_rmw_mclk[chanCount] ),
      .mem_ecc_err_detected_rmw_mclk  ( mem_ecc_err_detected_rmw_mclk[chanCount]  ),
      .mem_ecc_err_fatal_rmw_mclk     ( mem_ecc_err_fatal_rmw_mclk[chanCount]     ),
      .mem_ecc_err_syn_e_rmw_mclk     ( mem_ecc_err_syn_e_rmw_mclk[chanCount]     ),
      .mem_read_poison_rmw_mclk       ( mem_read_poison_rmw_mclk[chanCount]       ),
      .mem_readdatavalid_rmw_mclk     ( mem_readdatavalid_rmw_mclk[chanCount]     ),
      .mem_readdata_rmw_mclk          ( mem_readdata_rmw_mclk[chanCount]          ),
      .mem_ready_rmw_mclk             ( mem_ready_rmw_mclk[chanCount]             ),
      .mem_writedata_rmw_mclk         ( mem_writedata_rmw_mclk[chanCount]         ),
      .mem_byteenable_rmw_mclk        ( mem_byteenable_rmw_mclk[chanCount]        ),
      .mem_write_ras_sbe_mclk         ( mem_write_ras_sbe_mclk[chanCount]         ),
      .mem_write_ras_dbe_mclk         ( mem_write_ras_dbe_mclk[chanCount]         ),
      .mem_address_rmw_mclk           ( mem_address_rmw_mclk[chanCount]           ),
      .mem_read_rmw_mclk              ( mem_read_rmw_mclk[chanCount]              ),
      .mem_write_rmw_mclk             ( mem_write_rmw_mclk[chanCount]             ),
      .mem_write_poison_rmw_mclk      ( mem_write_poison_rmw_mclk[chanCount]      ),

      .reqfifo_data_in_eclk    ( reqfifo_data_in_eclk[chanCount]    ),
      .reqfifo_data_out_mclk   ( reqfifo_data_out_mclk[chanCount]   ),
      .reqfifo_wen_eclk        ( reqfifo_wen_eclk[chanCount]        ),
      .reqfifo_ren_mclk        ( reqfifo_ren_mclk[chanCount]        ),
      .reqfifo_empty_mclk      ( reqfifo_empty_mclk[chanCount]      ),
      .reqfifo_wrusedw_eclk    ( reqfifo_wrusedw_eclk[chanCount]    ),
      .reqfifo_full_eclk       ( reqfifo_full_eclk[chanCount]       ),
      .reqfifo_empty_eclk      ( reqfifo_empty_eclk[chanCount]      ),
      .reqfifo_fill_level_eclk ( reqfifo_fill_level_eclk[chanCount] ),

      .rspfifo_data_in_mclk    ( rspfifo_data_in_mclk[chanCount]  ),
      .rspfifo_data_out_eclk   ( rspfifo_data_out_eclk[chanCount] ),
      .rspfifo_wen_mclk        ( rspfifo_wen_mclk[chanCount]      ),
      .rspfifo_ren_eclk        ( rspfifo_ren_eclk[chanCount]      ),
      .rspfifo_full_mclk       ( rspfifo_full_mclk[chanCount]     ),
      .rspfifo_empty_eclk      ( rspfifo_empty_eclk[chanCount]    ),

      .emif_usr_reset_n_reg    ( emif_usr_reset_n_reg[chanCount] )
    );

  end   // for( genvar chanCount = 0; chanCount < MC_CHANNEL; chanCount=chanCount+1 )
  endgenerate   // generate for channel adapter


  generate     // generate for mc_ecc inst
  if (MC_ECC_EN == 1) 
  begin : GEN_ECC_ON

    for( genvar chanCount = 0; chanCount < MC_CHANNEL; chanCount=chanCount+1 )
    begin : GEN_CHAN_COUNT_ECC_ON

      mc_ecc #(
         .MC_ECC_EN          (MC_ECC_EN           ),
         .MC_ECC_ENC_LATENCY (MC_ECC_ENC_LATENCY  ),
         .MC_ECC_DEC_LATENCY (MC_ECC_DEC_LATENCY  ),
         .AVMM_ADDR_WIDTH    (EMIF_AMM_ADDR_WIDTH ),
         .AVMM_S_DATA_WIDTH  (MC_HA_DP_DATA_WIDTH )
      )
      mc_ecc_inst
      (
          .clk                     (emif_usr_clk[chanCount]                        ), // input  logic
          .reset_n                 (emif_usr_reset_n_reg[chanCount][RST_REG_NUM-1] ), // input  logic

          .avmm_s_ready            (mem_ready_rmw_mclk[chanCount]             ), // output logic
          .avmm_s_read             (mem_read_rmw_mclk[chanCount]              ), // input  logic
          .avmm_s_write            (mem_write_rmw_mclk[chanCount]             ), // input  logic
          .avmm_s_write_poison     (mem_write_poison_rmw_mclk[chanCount]      ), // input  logic
          .avmm_s_write_ras_sbe    (mem_write_ras_sbe_mclk[chanCount]         ), // input  logic
          .avmm_s_write_ras_dbe    (mem_write_ras_dbe_mclk[chanCount]         ), // input  logic
          .avmm_s_address          (mem_address_rmw_mclk[chanCount]           ), // input  logic [AVMM_S_ADDR_WIDTH-1:0]
          .avmm_s_readdata         (mem_readdata_rmw_mclk[chanCount]          ), // output logic [AVMM_S_DATA_WIDTH-1:0]
          .avmm_s_writedata        (mem_writedata_rmw_mclk[chanCount]         ), // input  logic [AVMM_S_DATA_WIDTH-1:0]
          .avmm_s_byteenable       (mem_byteenable_rmw_mclk[chanCount]        ), // input  logic [AVMM_S_BE_WIDTH-1:0]
          .avmm_s_read_poison      (mem_read_poison_rmw_mclk[chanCount]       ), // output logic
          .avmm_s_readdatavalid    (mem_readdatavalid_rmw_mclk[chanCount]     ), // output logic

//          .avmm_s_ecc_err_corrected(mem_ecc_err_corrected_rmw_mclk[chanCount] ), // output logic [ALTECC_INST_NUMBER-1:0]
//          .avmm_s_ecc_err_detected (mem_ecc_err_detected_rmw_mclk[chanCount]  ), // output logic [ALTECC_INST_NUMBER-1:0]
          .avmm_s_ecc_err_fatal    (mem_ecc_err_fatal_rmw_mclk[chanCount]     ), // output logic [ALTECC_INST_NUMBER-1:0]
//          .avmm_s_ecc_err_syn_e    (mem_ecc_err_syn_e_rmw_mclk[chanCount]     ), // output logic [ALTECC_INST_NUMBER-1:0]

          .avmm_m_ready            (emif_amm_ready[chanCount]         ), // input  logic
          .avmm_m_read             (emif_amm_read[chanCount]          ), // output logic
          .avmm_m_write            (emif_amm_write[chanCount]         ), // output logic
          .avmm_m_address          (emif_amm_address[chanCount]       ), // output logic [AVMM_M_ADDR_WIDTH-1:0]
          .avmm_m_writedata        (emif_amm_writedata[chanCount]     ), // output logic [AVMM_M_DATA_WIDTH-1:0]
          .avmm_m_byteenable       (emif_amm_byteenable[chanCount]    ), // output logic [AVMM_M_BE_WIDTH-1:0]
          .avmm_m_readdata         (emif_amm_readdata[chanCount]      ), // input  logic [AVMM_M_DATA_WIDTH-1:0]
          .avmm_m_readdatavalid    (emif_amm_readdatavalid[chanCount] ), // input  logic

          .in_avmm_s_writedata_w_ecc ( ecc_in_avmm_s_writedata_w_ecc[chanCount] ),
          .in_avmm_s_readdata        ( ecc_in_avmm_s_readdata[chanCount]        )
      );

    end   // for( genvar chanCount = 0; chanCount < MC_CHANNEL; chanCount=chanCount+1 ) 
  end   // if (MC_ECC_EN == 1) 
  else begin : GEN_ECC_OFF

    for( genvar chanCount = 0; chanCount < MC_CHANNEL; chanCount=chanCount+1 )
    begin : GEN_CHAN_COUNT_ECC_OFF

        always_comb 
        begin
          // == to emif ==
            emif_amm_read[ chanCount ]       = mem_read_rmw_mclk[    chanCount ];
            emif_amm_write[ chanCount ]      = mem_write_rmw_mclk[   chanCount ];
            emif_amm_address[ chanCount ]    = mem_address_rmw_mclk[ chanCount ];
            emif_amm_byteenable[ chanCount ] = '1;

            emif_amm_writedata[ chanCount ][MC_HA_DP_DATA_WIDTH-1:0]                     = mem_writedata_rmw_mclk[    chanCount ];
            emif_amm_writedata[ chanCount ][MC_HA_DP_DATA_WIDTH]                         = mem_write_poison_rmw_mclk[ chanCount ];
            emif_amm_writedata[ chanCount ][EMIF_AMM_DATA_WIDTH-1:MC_HA_DP_DATA_WIDTH+1] = '0;

          // == from emif ==
            mem_ready_rmw_mclk[chanCount]              = emif_amm_ready[chanCount] ;

          // ==== releaded to read response ====
            mem_readdata_rmw_mclk[ chanCount ]       = emif_amm_readdata[ chanCount ][MC_HA_DP_DATA_WIDTH-1:0];
            mem_read_poison_rmw_mclk[ chanCount ]    = emif_amm_readdata[ chanCount ][MC_HA_DP_DATA_WIDTH];
            mem_readdatavalid_rmw_mclk[ chanCount ]  = emif_amm_readdatavalid[ chanCount ] ;
        end

        always_comb 
        begin
            mem_ecc_err_corrected_rmw_mclk[ chanCount ] = '0;
            mem_ecc_err_detected_rmw_mclk[ chanCount ]  = '0;
            mem_ecc_err_fatal_rmw_mclk[ chanCount ]     = '0;
            mem_ecc_err_syn_e_rmw_mclk[ chanCount ]     = '0;
        end

    end   // for( genvar chanCount = 0; chanCount < MC_CHANNEL; chanCount=chanCount+1 ) 
  end   // if (MC_ECC_EN != 1) 
  endgenerate   // generate for mc_ecc inst 

  generate   // generate emif_amm_burstcount
    for( genvar chanCount = 0; chanCount < MC_CHANNEL; chanCount=chanCount+1 )
    begin : GEN_CHAN_COUNT_BURSTCOUNT

      assign emif_amm_burstcount[ chanCount ] = {{EMIF_AMM_BURST_WIDTH-1{1'b0}},1'b1};

    end
  endgenerate   // generate emif_amm_burstcount





endmodule                      
