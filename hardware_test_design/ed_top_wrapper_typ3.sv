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


//---------------------------------------------
//   ed_top_wrapper_typ2
//---------------------------------------------
`include "cxl_type3ddr_define.svh.iv"

import cxlip_top_pkg::*;
//import afu_axi_if_pkg::*;
import intel_cxl_pio_parameters :: *;

module ed_top_wrapper_typ3 (

    // Clocks
     input logic                ip2hdm_clk,             // SIP clk
     input logic                ip2csr_avmm_clk,             // SBR clk


    // Resets
     input logic                ip2hdm_reset_n,           // bbs_rst_n
     input logic                ip2csr_avmm_rstn,           // sbr_rst_n

// PIO IOs
//<<<

     input [2:0]                ed_rx_st0_bar_i,      // 
     input [2:0]                ed_rx_st1_bar_i,      //
     input [2:0]                ed_rx_st2_bar_i,      //
     input [2:0]                ed_rx_st3_bar_i,      //
     input 			ed_rx_st0_eop_i,      // 
     input                      ed_rx_st1_eop_i,      //
     input                      ed_rx_st2_eop_i,      //
     input                      ed_rx_st3_eop_i,      //
     input [127:0]              ed_rx_st0_header_i,   // 
     input [127:0]              ed_rx_st1_header_i,   //
     input [127:0]              ed_rx_st2_header_i,   //
     input [127:0]              ed_rx_st3_header_i,   //
     input [255:0]              ed_rx_st0_payload_i,  // 
     input [255:0]          	ed_rx_st1_payload_i,  //
     input [255:0]          	ed_rx_st2_payload_i,  //
     input [255:0]          	ed_rx_st3_payload_i,  //

     input  		        ed_rx_st0_sop_i,      // 
     input                      ed_rx_st1_sop_i,      //
     input                      ed_rx_st2_sop_i,      //
     input                      ed_rx_st3_sop_i,      //
     input 			ed_rx_st0_hvalid_i,    //
     input                      ed_rx_st1_hvalid_i,    //
     input                      ed_rx_st2_hvalid_i,    //
     input                      ed_rx_st3_hvalid_i,    //
     input                      ed_rx_st0_dvalid_i,    //
     input                      ed_rx_st1_dvalid_i,    //
     input                      ed_rx_st2_dvalid_i,    //
     input                      ed_rx_st3_dvalid_i,    //
     input                      ed_rx_st0_pvalid_i,    //
     input                      ed_rx_st1_pvalid_i,    //
     input                      ed_rx_st2_pvalid_i,    //
     input                      ed_rx_st3_pvalid_i,    //

     input [2:0]	        ed_rx_st0_empty_i,    // 
     input [2:0]                ed_rx_st1_empty_i,    //
     input [2:0]                ed_rx_st2_empty_i,    //
     input [2:0]                ed_rx_st3_empty_i,    //
     
     input [PFNUM_WIDTH-1:0]    ed_rx_st0_pfnum_i,    //added PF number for all channels 
     input [PFNUM_WIDTH-1:0]    ed_rx_st1_pfnum_i,    // 
     input [PFNUM_WIDTH-1:0]    ed_rx_st2_pfnum_i,    // 
     input [PFNUM_WIDTH-1:0]    ed_rx_st3_pfnum_i,    // 
     input [31:0]               ed_rx_st0_tlp_prfx_i, // 
     input [31:0]               ed_rx_st1_tlp_prfx_i, //
     input [31:0]               ed_rx_st2_tlp_prfx_i, //
     input [31:0]               ed_rx_st3_tlp_prfx_i, //
//-- unused in PIO
  
     input [7:0]		ed_rx_st0_data_parity_i,
     input [3:0]		ed_rx_st0_hdr_parity_i,
     input 			ed_rx_st0_tlp_prfx_parity_i,
     input [11:0] 		ed_rx_st0_rssai_prefix_i,
     input 			ed_rx_st0_rssai_prefix_parity_i,
     input 			ed_rx_st0_vfactive_i,
     input [10:0] 		ed_rx_st0_vfnum_i,
     input [2:0]  		ed_rx_st0_chnum_i,
     input 			ed_rx_st0_misc_parity_i,

     input [7:0]		ed_rx_st1_data_parity_i,
     input [3:0]		ed_rx_st1_hdr_parity_i,
     input 			ed_rx_st1_tlp_prfx_parity_i,
     input [11:0] 		ed_rx_st1_rssai_prefix_i,
     input 			ed_rx_st1_rssai_prefix_parity_i,
     input 			ed_rx_st1_vfactive_i,
     input [10:0] 		ed_rx_st1_vfnum_i,
     input [2:0]  		ed_rx_st1_chnum_i,
     input 			ed_rx_st1_misc_parity_i,

     input [7:0]		ed_rx_st2_data_parity_i,
     input [3:0]		ed_rx_st2_hdr_parity_i,
     input 			ed_rx_st2_tlp_prfx_parity_i,
     input [11:0] 		ed_rx_st2_rssai_prefix_i,
     input 			ed_rx_st2_rssai_prefix_parity_i,
     input 			ed_rx_st2_vfactive_i,
     input [10:0] 		ed_rx_st2_vfnum_i,
     input [2:0]  		ed_rx_st2_chnum_i,
     input 			ed_rx_st2_misc_parity_i,
     
     input [7:0]		ed_rx_st3_data_parity_i,
     input [3:0]		ed_rx_st3_hdr_parity_i,
     input 			ed_rx_st3_tlp_prfx_parity_i,
     input [11:0] 		ed_rx_st3_rssai_prefix_i,
     input 			ed_rx_st3_rssai_prefix_parity_i,
     input 			ed_rx_st3_vfactive_i,
     input [10:0] 		ed_rx_st3_vfnum_i,
     input [2:0]  		ed_rx_st3_chnum_i,
     input 			ed_rx_st3_misc_parity_i,
     input [7:0]		ed_rx_bus_number,
     input [4:0]		ed_rx_device_number,
     input [2:0]		ed_rx_function_number,
//-- 
     output logic               ed_rx_st_ready_o,


     output logic            	ed_clk,
     output logic            	ed_rst_n,

     output logic               ed_tx_st0_eop_o,
     output logic               ed_tx_st1_eop_o,
     output logic               ed_tx_st2_eop_o,
     output logic               ed_tx_st3_eop_o,
     output logic [127:0]       ed_tx_st0_header_o,
     output logic [127:0]       ed_tx_st1_header_o,
     output logic [127:0]       ed_tx_st2_header_o,
     output logic [127:0]       ed_tx_st3_header_o,

     output logic [31:0]        ed_tx_st0_prefix_o,
     output logic [31:0]        ed_tx_st1_prefix_o,
     output logic [31:0]        ed_tx_st2_prefix_o,
     output logic [31:0]        ed_tx_st3_prefix_o,
     
     output logic [255:0]   	ed_tx_st0_payload_o,
     output logic [255:0]   	ed_tx_st1_payload_o,
     output logic [255:0]   	ed_tx_st2_payload_o,
     output logic [255:0]   	ed_tx_st3_payload_o,

     output logic               ed_tx_st0_sop_o,
     output logic               ed_tx_st1_sop_o,
     output logic               ed_tx_st2_sop_o,
     output logic               ed_tx_st3_sop_o,

     output logic               ed_tx_st0_dvalid_o,
     output logic               ed_tx_st1_dvalid_o,
     output logic               ed_tx_st2_dvalid_o,
     output logic               ed_tx_st3_dvalid_o,
     output logic               ed_tx_st0_pvalid_o,
     output logic               ed_tx_st1_pvalid_o,
     output logic               ed_tx_st2_pvalid_o,
     output logic               ed_tx_st3_pvalid_o,
     output logic               ed_tx_st0_hvalid_o,
     output logic               ed_tx_st1_hvalid_o,
     output logic               ed_tx_st2_hvalid_o,
     output logic               ed_tx_st3_hvalid_o,

     //--unused
     
    output   logic [7:0]   	ed_tx_st0_data_parity,
    output   logic [3:0]        ed_tx_st0_hdr_parity,
    output   logic    		ed_tx_st0_prefix_parity,
    output   logic [11:0]       ed_tx_st0_RSSAI_prefix,
    output   logic              ed_tx_st0_RSSAI_prefix_parity,
    output   logic              ed_tx_st0_vfactive,
    output   logic [10:0]       ed_tx_st0_vfnum ,
    output   logic [2:0]        ed_tx_st0_pfnum,
    output   logic              ed_tx_st0_chnum,
    output   logic [2:0]        ed_tx_st0_empty, 
    output   logic              ed_tx_st0_misc_parity,

    output   logic [7:0]   	ed_tx_st1_data_parity,
    output   logic [3:0]        ed_tx_st1_hdr_parity,
    output   logic    		ed_tx_st1_prefix_parity,
    output   logic [11:0]       ed_tx_st1_RSSAI_prefix,
    output   logic              ed_tx_st1_RSSAI_prefix_parity,
    output   logic              ed_tx_st1_vfactive,
    output   logic [10:0]       ed_tx_st1_vfnum ,
    output   logic [2:0]        ed_tx_st1_pfnum,
    output   logic              ed_tx_st1_chnum,
    output   logic [2:0]        ed_tx_st1_empty, 
    output   logic              ed_tx_st1_misc_parity,


    output   logic [7:0]   	ed_tx_st2_data_parity,
    output   logic [3:0]        ed_tx_st2_hdr_parity,
    output   logic    		ed_tx_st2_prefix_parity,
    output   logic [11:0]       ed_tx_st2_RSSAI_prefix,
    output   logic              ed_tx_st2_RSSAI_prefix_parity,
    output   logic              ed_tx_st2_vfactive,
    output   logic [10:0]       ed_tx_st2_vfnum ,
    output   logic [2:0]        ed_tx_st2_pfnum,
    output   logic              ed_tx_st2_chnum,
    output   logic [2:0]        ed_tx_st2_empty, 
    output   logic              ed_tx_st2_misc_parity,


    output   logic [7:0]   	ed_tx_st3_data_parity,
    output   logic [3:0]        ed_tx_st3_hdr_parity,
    output   logic    		ed_tx_st3_prefix_parity,
    output   logic [11:0]       ed_tx_st3_RSSAI_prefix,
    output   logic              ed_tx_st3_RSSAI_prefix_parity,
    output   logic              ed_tx_st3_vfactive,
    output   logic [10:0]       ed_tx_st3_vfnum ,
    output   logic [2:0]        ed_tx_st3_pfnum,
    output   logic              ed_tx_st3_chnum,
    output   logic [2:0]        ed_tx_st3_empty, 
    output   logic              ed_tx_st3_misc_parity,

     //--
     input                      ed_tx_st_ready_i,        

     //rx hcrdt
     output logic [2:0]         rx_st_hcrdt_update_o,
     output logic [5:0]         rx_st_hcrdt_update_cnt_o,
     output logic [2:0]         rx_st_hcrdt_init_o,
     input  logic [2:0]         rx_st_hcrdt_init_ack_i,

     //rx dcrdt
     output logic [2:0]         rx_st_dcrdt_update_o,
     output logic [11:0]        rx_st_dcrdt_update_cnt_o,
     output logic [2:0]         rx_st_dcrdt_init_o,
     input  logic [2:0]         rx_st_dcrdt_init_ack_i,

     //tx hcrdt
     input logic [2:0]          tx_st_hcrdt_update_i,
     input logic [5:0]          tx_st_hcrdt_update_cnt_i,
     input logic [2:0]          tx_st_hcrdt_init_i,
    output logic [2:0]          tx_st_hcrdt_init_ack_o,

     //tx dcrdt
     input logic [2:0]          tx_st_dcrdt_update_i,
     input logic [11:0]         tx_st_dcrdt_update_cnt_i,
     input logic [2:0]          tx_st_dcrdt_init_i,
    output logic [2:0]          tx_st_dcrdt_init_ack_o,

     //ed specific signals
     output logic  	        ed_tx_st0_passthrough_o,
     output logic  	        ed_tx_st1_passthrough_o,
     output logic  	        ed_tx_st2_passthrough_o,
     output logic  	        ed_tx_st3_passthrough_o,
     input 		        ed_rx_st0_passthrough_i,
     input 		        ed_rx_st1_passthrough_i,
     input 		        ed_rx_st2_passthrough_i,
     input 		        ed_rx_st3_passthrough_i,


//>>>
// MC IOs
//<<<
// DDRMC <--> BBS Slice
 // DDRMC <--> BBS Slice
  output  logic [35:0]                                      hdm_size_256mb , // Brought out to top from 22ww18a
  output  logic [63:0]                                      mc2ip_memsize,

`ifndef ENABLE_4_BBS_SLICE   // MC_CHANNEL=2

//Channel-0
    
   // output  logic [63:0]                                      mc2ip_0_memsize,
	
    output  logic [cxlip_top_pkg::MC_SR_STAT_WIDTH-1:0]       mc2ip_0_sr_status                ,    
    output  logic                                             mc2ip_0_rspfifo_full,
    output  logic                                             mc2ip_0_rspfifo_empty,
    output  logic [cxlip_top_pkg::RSPFIFO_DEPTH_WIDTH-1:0]    mc2ip_0_rspfifo_fill_level  ,
    output  logic                                             mc2ip_0_reqfifo_full,
    output  logic                                             mc2ip_0_reqfifo_empty,
    output  logic [cxlip_top_pkg::REQFIFO_DEPTH_WIDTH-1:0]    mc2ip_0_reqfifo_fill_level  ,
    
    output  logic                                             hdm2ip_avmm0_cxlmem_ready,	
    output  logic                                             hdm2ip_avmm0_ready,
    output  logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    hdm2ip_avmm0_readdata            ,
    output  logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         hdm2ip_avmm0_rsp_mdata           ,
    output  logic                                             hdm2ip_avmm0_read_poison,
    output  logic                                             hdm2ip_avmm0_readdatavalid,
 // Error Correction Code (ECC)
    // Note *ecc_err_* are valid when hdm2ip_avmm0_readdatavalid is active
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm0_ecc_err_corrected   ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm0_ecc_err_detected    ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm0_ecc_err_fatal       ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm0_ecc_err_syn_e       ,
    output  logic                                             hdm2ip_avmm0_ecc_err_valid,	
	
    input logic                                             ip2hdm_avmm0_read,
    input logic                                             ip2hdm_avmm0_write,
    input logic                                             ip2hdm_avmm0_write_poison,
    input logic                                             ip2hdm_avmm0_write_ras_sbe,    
    input logic                                             ip2hdm_avmm0_write_ras_dbe,    
    input logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    ip2hdm_avmm0_writedata           ,
    input logic [cxlip_top_pkg::MC_HA_DP_BE_WIDTH-1:0]      ip2hdm_avmm0_byteenable          ,
    input   logic [(cxlip_top_pkg::CXLIP_FULL_ADDR_MSB):(cxlip_top_pkg::CXLIP_FULL_ADDR_LSB)]    ip2hdm_avmm0_address            ,  //added from 22ww18a
    input logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         ip2hdm_avmm0_req_mdata           ,

//Channel 1
   // output  logic [63:0]                                      mc2ip_1_memsize,
	
    output  logic [cxlip_top_pkg::MC_SR_STAT_WIDTH-1:0]       mc2ip_1_sr_status                ,    
    output  logic                                             mc2ip_1_rspfifo_full,
    output  logic                                             mc2ip_1_rspfifo_empty,
    output  logic [cxlip_top_pkg::RSPFIFO_DEPTH_WIDTH-1:0]    mc2ip_1_rspfifo_fill_level  ,
    output  logic                                             mc2ip_1_reqfifo_full,
    output  logic                                             mc2ip_1_reqfifo_empty,
    output  logic [cxlip_top_pkg::REQFIFO_DEPTH_WIDTH-1:0]    mc2ip_1_reqfifo_fill_level  ,
    
    output  logic                                             hdm2ip_avmm1_cxlmem_ready,	
    output  logic                                             hdm2ip_avmm1_ready,
    output  logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    hdm2ip_avmm1_readdata            ,
    output  logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         hdm2ip_avmm1_rsp_mdata           ,
    output  logic                                             hdm2ip_avmm1_read_poison,
    output  logic                                             hdm2ip_avmm1_readdatavalid,
 // Error Correction Code (ECC)
    // Note *ecc_err_* are valid when hdm2ip_avmm1_readdatavalid is active
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm1_ecc_err_corrected   ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm1_ecc_err_detected    ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm1_ecc_err_fatal       ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm1_ecc_err_syn_e       ,
    output  logic                                             hdm2ip_avmm1_ecc_err_valid,	
	
    input logic                                             ip2hdm_avmm1_read,
    input logic                                             ip2hdm_avmm1_write,
    input logic                                             ip2hdm_avmm1_write_poison,
    input logic                                             ip2hdm_avmm1_write_ras_sbe,    
    input logic                                             ip2hdm_avmm1_write_ras_dbe,    
    input logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    ip2hdm_avmm1_writedata           ,
    input logic [cxlip_top_pkg::MC_HA_DP_BE_WIDTH-1:0]      ip2hdm_avmm1_byteenable          ,
    input   logic [(cxlip_top_pkg::CXLIP_FULL_ADDR_MSB):(cxlip_top_pkg::CXLIP_FULL_ADDR_LSB)]    ip2hdm_avmm1_address            ,  //added from 22ww18a
    input logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         ip2hdm_avmm1_req_mdata           ,


`else   // MC_CHANNEL=4
   // DDRMC <--> BBS Slice

//Channel-0
    
   // output  logic [63:0]                                      mc2ip_0_memsize,
	
    output  logic [cxlip_top_pkg::MC_SR_STAT_WIDTH-1:0]       mc2ip_0_sr_status                ,    
    output  logic                                             mc2ip_0_rspfifo_full,
    output  logic                                             mc2ip_0_rspfifo_empty,
    output  logic [cxlip_top_pkg::RSPFIFO_DEPTH_WIDTH-1:0]    mc2ip_0_rspfifo_fill_level  ,
    output  logic                                             mc2ip_0_reqfifo_full,
    output  logic                                             mc2ip_0_reqfifo_empty,
    output  logic [cxlip_top_pkg::REQFIFO_DEPTH_WIDTH-1:0]    mc2ip_0_reqfifo_fill_level  ,
    
    output  logic                                             hdm2ip_avmm0_cxlmem_ready,	
    output  logic                                             hdm2ip_avmm0_ready,
    output  logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    hdm2ip_avmm0_readdata            ,
    output  logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         hdm2ip_avmm0_rsp_mdata           ,
    output  logic                                             hdm2ip_avmm0_read_poison,
    output  logic                                             hdm2ip_avmm0_readdatavalid,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm0_ecc_err_corrected   ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm0_ecc_err_detected    ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm0_ecc_err_fatal       ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm0_ecc_err_syn_e       ,
    output  logic                                             hdm2ip_avmm0_ecc_err_valid,	
	
    input logic                                             ip2hdm_avmm0_read,
    input logic                                             ip2hdm_avmm0_write,
    input logic                                             ip2hdm_avmm0_write_poison,
    input logic                                             ip2hdm_avmm0_write_ras_sbe,    
    input logic                                             ip2hdm_avmm0_write_ras_dbe,    
    input logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    ip2hdm_avmm0_writedata           ,
    input logic [cxlip_top_pkg::MC_HA_DP_BE_WIDTH-1:0]      ip2hdm_avmm0_byteenable          ,
    input   logic [(cxlip_top_pkg::CXLIP_FULL_ADDR_MSB):(cxlip_top_pkg::CXLIP_FULL_ADDR_LSB)]    ip2hdm_avmm0_address            ,  //added from 22ww18a
    input logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         ip2hdm_avmm0_req_mdata           ,

//Channel 1
   // output  logic [63:0]                                      mc2ip_1_memsize,
	
    output  logic [cxlip_top_pkg::MC_SR_STAT_WIDTH-1:0]       mc2ip_1_sr_status                ,    
    output  logic                                             mc2ip_1_rspfifo_full,
    output  logic                                             mc2ip_1_rspfifo_empty,
    output  logic [cxlip_top_pkg::RSPFIFO_DEPTH_WIDTH-1:0]    mc2ip_1_rspfifo_fill_level  ,
    output  logic                                             mc2ip_1_reqfifo_full,
    output  logic                                             mc2ip_1_reqfifo_empty,
    output  logic [cxlip_top_pkg::REQFIFO_DEPTH_WIDTH-1:0]    mc2ip_1_reqfifo_fill_level  ,
    
    output  logic                                             hdm2ip_avmm1_cxlmem_ready,	
    output  logic                                             hdm2ip_avmm1_ready,
    output  logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    hdm2ip_avmm1_readdata            ,
    output  logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         hdm2ip_avmm1_rsp_mdata           ,
    output  logic                                             hdm2ip_avmm1_read_poison,
    output  logic                                             hdm2ip_avmm1_readdatavalid,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm1_ecc_err_corrected   ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm1_ecc_err_detected    ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm1_ecc_err_fatal       ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm1_ecc_err_syn_e       ,
    output  logic                                             hdm2ip_avmm1_ecc_err_valid,	
	
    input logic                                             ip2hdm_avmm1_read,
    input logic                                             ip2hdm_avmm1_write,
    input logic                                             ip2hdm_avmm1_write_poison,
    input logic                                             ip2hdm_avmm1_write_ras_sbe,    
    input logic                                             ip2hdm_avmm1_write_ras_dbe,    
    input logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    ip2hdm_avmm1_writedata           ,
    input logic [cxlip_top_pkg::MC_HA_DP_BE_WIDTH-1:0]      ip2hdm_avmm1_byteenable          ,
    input   logic [(cxlip_top_pkg::CXLIP_FULL_ADDR_MSB):(cxlip_top_pkg::CXLIP_FULL_ADDR_LSB)]    ip2hdm_avmm1_address            ,  //added from 22ww18a
    input logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         ip2hdm_avmm1_req_mdata           ,
	
//Channel 2
    
    //output  logic [63:0]                                      mc2ip_2_memsize,
	
    output  logic [cxlip_top_pkg::MC_SR_STAT_WIDTH-1:0]       mc2ip_2_sr_status                ,    
    output  logic                                             mc2ip_2_rspfifo_full,
    output  logic                                             mc2ip_2_rspfifo_empty,
    output  logic [cxlip_top_pkg::RSPFIFO_DEPTH_WIDTH-1:0]    mc2ip_2_rspfifo_fill_level  ,
    output  logic                                             mc2ip_2_reqfifo_full,
    output  logic                                             mc2ip_2_reqfifo_empty,
    output  logic [cxlip_top_pkg::REQFIFO_DEPTH_WIDTH-1:0]    mc2ip_2_reqfifo_fill_level  ,
    
    output  logic                                             hdm2ip_avmm2_cxlmem_ready,	
    output  logic                                             hdm2ip_avmm2_ready,
    output  logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    hdm2ip_avmm2_readdata            ,
    output  logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         hdm2ip_avmm2_rsp_mdata           ,
    output  logic                                             hdm2ip_avmm2_read_poison,
    output  logic                                             hdm2ip_avmm2_readdatavalid,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm2_ecc_err_corrected   ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm2_ecc_err_detected    ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm2_ecc_err_fatal       ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm2_ecc_err_syn_e       ,
    output  logic                                             hdm2ip_avmm2_ecc_err_valid,	
	
    input logic                                               ip2hdm_avmm2_read,
    input logic                                               ip2hdm_avmm2_write,
    input logic                                               ip2hdm_avmm2_write_poison,
    input logic                                               ip2hdm_avmm2_write_ras_sbe,    
    input logic                                               ip2hdm_avmm2_write_ras_dbe,    
    input logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]      ip2hdm_avmm2_writedata           ,
    input logic [cxlip_top_pkg::MC_HA_DP_BE_WIDTH-1:0]        ip2hdm_avmm2_byteenable          ,
    input   logic [(cxlip_top_pkg::CXLIP_FULL_ADDR_MSB):(cxlip_top_pkg::CXLIP_FULL_ADDR_LSB)]    ip2hdm_avmm2_address            ,  //added from 22ww18a
    input logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]           ip2hdm_avmm2_req_mdata           ,

//Channel 3
    //output  logic [63:0]                                      mc2ip_3_memsize,
	
    output  logic [cxlip_top_pkg::MC_SR_STAT_WIDTH-1:0]       mc2ip_3_sr_status                ,    
    output  logic                                             mc2ip_3_rspfifo_full,
    output  logic                                             mc2ip_3_rspfifo_empty,
    output  logic [cxlip_top_pkg::RSPFIFO_DEPTH_WIDTH-1:0]    mc2ip_3_rspfifo_fill_level  ,
    output  logic                                             mc2ip_3_reqfifo_full,
    output  logic                                             mc2ip_3_reqfifo_empty,
    output  logic [cxlip_top_pkg::REQFIFO_DEPTH_WIDTH-1:0]    mc2ip_3_reqfifo_fill_level  ,
    
    output  logic                                             hdm2ip_avmm3_cxlmem_ready,	
    output  logic                                             hdm2ip_avmm3_ready,
    output  logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    hdm2ip_avmm3_readdata            ,
    output  logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         hdm2ip_avmm3_rsp_mdata           ,
    output  logic                                             hdm2ip_avmm3_read_poison,
    output  logic                                             hdm2ip_avmm3_readdatavalid,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm3_ecc_err_corrected   ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm3_ecc_err_detected    ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm3_ecc_err_fatal       ,
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     hdm2ip_avmm3_ecc_err_syn_e       ,
    output  logic                                             hdm2ip_avmm3_ecc_err_valid,	
	
    input logic                                               ip2hdm_avmm3_read,
    input logic                                               ip2hdm_avmm3_write,
    input logic                                               ip2hdm_avmm3_write_poison,
    input logic                                               ip2hdm_avmm3_write_ras_sbe,    
    input logic                                               ip2hdm_avmm3_write_ras_dbe,    
    input logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]      ip2hdm_avmm3_writedata           ,
    input logic [cxlip_top_pkg::MC_HA_DP_BE_WIDTH-1:0]        ip2hdm_avmm3_byteenable          ,
    input   logic [(cxlip_top_pkg::CXLIP_FULL_ADDR_MSB):(cxlip_top_pkg::CXLIP_FULL_ADDR_LSB)]    ip2hdm_avmm3_address            ,  //added from 22ww18a
    input logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]           ip2hdm_avmm3_req_mdata           ,

`endif	
 



//>>>

// ex_default_csr_top
//<<<
//AFU inline CSR avmm access
 
  output  logic                             csr2ip_avmm_waitrequest,  
  output  logic [31:0]                      csr2ip_avmm_readdata,     
  output  logic                             csr2ip_avmm_readdatavalid,
  input   logic [31:0]                      ip2csr_avmm_writedata,
  input   logic [21:0]                      ip2csr_avmm_address,
  input   logic                             ip2csr_avmm_write,
  input   logic                             ip2csr_avmm_read, 
  input   logic [3:0]                       ip2csr_avmm_byteenable,


//>>>

//-----------------------NOTE---------------------------------------
// DDR Memory Interface (2 Channel)
//------------------------------------------------------------------
`ifndef ENABLE_4_BBS_SLICE   // MC Channel=2
  input  [1:0]   mem_refclk,                                    // EMIF PLL reference clock
  output [0:0]   mem_ck         [1:0],  // DDR4 interface signals
  output [0:0]   mem_ck_n       [1:0],  //
  output [16:0]  mem_a          [1:0],  //
  output [1:0]   mem_act_n,                                     //
  output [1:0]   mem_ba         [1:0],  //
  output [1:0]   mem_bg         [1:0],  //
`ifdef HDM_64G
  output [1:0]   mem_cke        [1:0],  //
  output [1:0]   mem_cs_n       [1:0],  //
  output [1:0]   mem_odt        [1:0],  //
`else
  output [0:0]   mem_cke        [1:0],  //
  output [0:0]   mem_cs_n       [1:0],  //
  output [0:0]   mem_odt        [1:0],  //
`endif
  output [1:0]   mem_reset_n,                                   //
  output [1:0]   mem_par,                                       //
  input  [1:0]   mem_oct_rzqin,                                 //
  input  [1:0]   mem_alert_n, 
`ifdef ENABLE_DDR_DBI_PINS                                  //Micron DIMM
  inout  [8:0]   mem_dqs        [1:0],  //
  inout  [8:0]   mem_dqs_n      [1:0],  //
  inout  [8:0]   mem_dbi_n      [1:0],  //
`else
  inout  [17:0]   mem_dqs        [1:0],  //
  inout  [17:0]   mem_dqs_n      [1:0],  //
`endif  
  inout  [71:0]  mem_dq         [1:0]    //
//-----------------------NOTE---------------------------------------
// DDR Memory Interface (4 Channel)
//------------------------------------------------------------------
`else  // MC CHANNEL =4

  input  [3:0]   mem_refclk,                                    // EMIF PLL reference clock
  output [0:0]   mem_ck         [3:0],  // DDR4 interface signals
  output [0:0]   mem_ck_n       [3:0],  //
  output [16:0]  mem_a          [3:0],  //
  output [3:0]   mem_act_n,                                     //
  output [1:0]   mem_ba         [3:0],  //
  output [1:0]   mem_bg         [3:0],  //
`ifdef HDM_64G
  output [1:0]   mem_cke        [3:0],  //
  output [1:0]   mem_cs_n       [3:0],  //
  output [1:0]   mem_odt        [3:0],  //
`else
  output [0:0]   mem_cke        [3:0],  //
  output [0:0]   mem_cs_n       [3:0],  //
  output [0:0]   mem_odt        [3:0],  //
`endif
  output [3:0]   mem_reset_n,                                   //
  output [3:0]   mem_par,                                       //
  input  [3:0]   mem_oct_rzqin,                                 //
  input  [3:0]   mem_alert_n, 
`ifdef ENABLE_DDR_DBI_PINS                                  //Micron DIMM
  inout  [8:0]   mem_dqs        [3:0],  //
  inout  [8:0]   mem_dqs_n      [3:0],  //
  inout  [8:0]   mem_dbi_n      [3:0],  //
`else
  inout  [17:0]   mem_dqs        [3:0],  //
  inout  [17:0]   mem_dqs_n      [3:0],  //
`endif  
  inout  [71:0]  mem_dq         [3:0]    //

`endif



);

  //-------------------------------------------------------
  // Signals & Settings                                  --
  //-------------------------------------------------------





   //CXLIP <---> iAFU
   
  // Error Correction Code (ECC)
  // Note *ecc_err_* are valid when mc2iafu_readdatavalid_eclk is active
  

  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc2iafu_ready_eclk;
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc2iafu_read_poison_eclk;
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc2iafu_readdatavalid_eclk;
  // Error Correction Code (ECC)
  // Note *ecc_err_* are valid when mc2iafu_readdatavalid_eclk is active
  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     mc2iafu_ecc_err_corrected_eclk  [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     mc2iafu_ecc_err_detected_eclk   [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     mc2iafu_ecc_err_fatal_eclk      [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     mc2iafu_ecc_err_syn_e_eclk      [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc2iafu_ecc_err_valid_eclk;
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc_rspfifo_full_eclk;
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc_rspfifo_empty_eclk;
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc2iafu_cxlmem_ready;
  logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    mc2iafu_readdata_eclk           [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         mc2iafu_rsp_mdata_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0];
  
  
  logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    iafu2mc_writedata_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::MC_HA_DP_BE_WIDTH-1:0]      iafu2mc_byteenable_eclk         [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2mc_read_eclk;
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2mc_write_eclk;
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2mc_write_poison_eclk;
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2mc_write_ras_sbe_eclk;    
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2mc_write_ras_dbe_eclk;    
  logic [cxlip_top_pkg::MC_HA_DP_ADDR_WIDTH-1:0]    iafu2mc_address_eclk            [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         iafu2mc_req_mdata_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0];
  


  //logic [63:0]                                      mc2ip_memsize  ;
  logic [cxlip_top_pkg::MC_SR_STAT_WIDTH-1:0]       mc_sr_status_eclk                   [cxlip_top_pkg::MC_CHANNEL-1:0];

  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2cxlip_ready_eclk;
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             cxlip2iafu_read_eclk;
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             cxlip2iafu_write_eclk;
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             cxlip2iafu_write_poison_eclk;
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             cxlip2iafu_write_ras_sbe_eclk;    
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             cxlip2iafu_write_ras_dbe_eclk;    
  
  //   logic [cxlip_top_pkg::MC_HA_DP_ADDR_WIDTH-1:0]    cxlip2iafu_address_eclk             [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [(cxlip_top_pkg::CXLIP_FULL_ADDR_MSB):(cxlip_top_pkg::CXLIP_FULL_ADDR_LSB)]    cxlip2iafu_chan_address_eclk            [cxlip_top_pkg::MC_CHANNEL-1:0];  //added from 22ww18a
  logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         cxlip2iafu_req_mdata_eclk           [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    iafu2cxlip_readdata_eclk            [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         iafu2cxlip_rsp_mdata_eclk           [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    cxlip2iafu_writedata_eclk           [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::MC_HA_DP_BE_WIDTH-1:0]      cxlip2iafu_byteenable_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0];

  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2cxlip_read_poison_eclk;
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2cxlip_readdatavalid_eclk;
  // Error Correction Code (ECC)
  // Note *ecc_err_* are valid when iafu2cxlip_readdatavalid_eclk is active
  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     iafu2cxlip_ecc_err_corrected_eclk   [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     iafu2cxlip_ecc_err_detected_eclk    [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     iafu2cxlip_ecc_err_fatal_eclk       [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     iafu2cxlip_ecc_err_syn_e_eclk       [cxlip_top_pkg::MC_CHANNEL-1:0];
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2cxlip_ecc_err_valid_eclk;
  
 // logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc_rspfifo_full_eclk;
 // logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc_rspfifo_empty_eclk;
  logic [cxlip_top_pkg::RSPFIFO_DEPTH_WIDTH-1:0]    mc_rspfifo_fill_level_eclk  [cxlip_top_pkg::MC_CHANNEL-1:0];
    
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc_reqfifo_full_eclk;
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc_reqfifo_empty_eclk;
  logic [cxlip_top_pkg::REQFIFO_DEPTH_WIDTH-1:0]    mc_reqfifo_fill_level_eclk  [cxlip_top_pkg::MC_CHANNEL-1:0];
  
  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2cxlip_cxlmem_ready;


  //-------------------------------------------------------
  // Example design Modules                  
  //-------------------------------------------------------


  //-------------------------------------------------------
  // CXL PIO                                  
  //-------------------------------------------------------
intel_cxl_pio_ed_top intel_cxl_pio_ed_top_inst (
    .ed_rx_st0_bar_i                   ,                                 
    .ed_rx_st1_bar_i                   ,                                 
    .ed_rx_st2_bar_i                   ,                                 
    .ed_rx_st3_bar_i                   ,                                 
    .ed_rx_st0_eop_i                   ,                                 
    .ed_rx_st1_eop_i                   ,                                 
    .ed_rx_st2_eop_i                   ,                                 
    .ed_rx_st3_eop_i                   ,                                 
    .ed_rx_st0_header_i                ,                                 
    .ed_rx_st1_header_i                ,                                 
    .ed_rx_st2_header_i                ,                                 
    .ed_rx_st3_header_i                ,                                 
    .ed_rx_st0_payload_i               ,                                 
    .ed_rx_st1_payload_i               ,                                 
    .ed_rx_st2_payload_i               ,                                 
    .ed_rx_st3_payload_i               ,                                 
    .ed_rx_st0_sop_i                   ,                                 
    .ed_rx_st1_sop_i                   ,                                 
    .ed_rx_st2_sop_i                   ,                                 
    .ed_rx_st3_sop_i                   ,                                 
    .ed_rx_st0_hvalid_i                ,                                 
    .ed_rx_st1_hvalid_i                ,                                 
    .ed_rx_st2_hvalid_i                ,                                 
    .ed_rx_st3_hvalid_i                ,                                 
    .ed_rx_st0_dvalid_i                ,                                 
    .ed_rx_st1_dvalid_i                ,                                 
    .ed_rx_st2_dvalid_i                ,                                 
    .ed_rx_st3_dvalid_i                ,                                 
    .ed_rx_st0_pvalid_i                ,                                 
    .ed_rx_st1_pvalid_i                ,                                 
    .ed_rx_st2_pvalid_i                ,                                 
    .ed_rx_st3_pvalid_i                ,                                 
    .ed_rx_st0_empty_i                 ,                                 
    .ed_rx_st1_empty_i                 ,                                 
    .ed_rx_st2_empty_i                 ,                                 
    .ed_rx_st3_empty_i                 ,                                 
    .ed_rx_st0_pfnum_i                 ,    
    .ed_rx_st1_pfnum_i                 ,                                 
    .ed_rx_st2_pfnum_i                 ,                                 
    .ed_rx_st3_pfnum_i                 ,                                 
    .ed_rx_st0_tlp_prfx_i              ,                                 
    .ed_rx_st1_tlp_prfx_i              ,                                 
    .ed_rx_st2_tlp_prfx_i              ,                                 
    .ed_rx_st3_tlp_prfx_i              ,                                 
    .ed_rx_st0_data_parity_i           ,                                 
    .ed_rx_st0_hdr_parity_i            ,                                   
    .ed_rx_st0_tlp_prfx_parity_i       ,                                   
    .ed_rx_st0_rssai_prefix_i          ,                                   
    .ed_rx_st0_rssai_prefix_parity_i   ,                                   
    .ed_rx_st0_vfactive_i              ,                                   
    .ed_rx_st0_vfnum_i                 ,                                   
    .ed_rx_st0_chnum_i                 ,                                   
    .ed_rx_st0_misc_parity_i           ,                                   
    .ed_rx_st1_data_parity_i           ,                                   
    .ed_rx_st1_hdr_parity_i            ,                                   
    .ed_rx_st1_tlp_prfx_parity_i       ,                                   
    .ed_rx_st1_rssai_prefix_i          ,                                   
    .ed_rx_st1_rssai_prefix_parity_i   ,                                   
    .ed_rx_st1_vfactive_i              ,                                   
    .ed_rx_st1_vfnum_i                 ,                                   
    .ed_rx_st1_chnum_i                 ,                                   
    .ed_rx_st1_misc_parity_i           ,                                   
    .ed_rx_st2_data_parity_i           ,                                
    .ed_rx_st2_hdr_parity_i            ,                                
    .ed_rx_st2_tlp_prfx_parity_i       ,                                
    .ed_rx_st2_rssai_prefix_i          ,                                
    .ed_rx_st2_rssai_prefix_parity_i   ,                                
    .ed_rx_st2_vfactive_i              ,                                
    .ed_rx_st2_vfnum_i                 ,                                
    .ed_rx_st2_chnum_i                 ,                                
    .ed_rx_st2_misc_parity_i           ,                                
    .ed_rx_st3_data_parity_i           ,                                
    .ed_rx_st3_hdr_parity_i            ,                                
    .ed_rx_st3_tlp_prfx_parity_i       ,                                
    .ed_rx_st3_rssai_prefix_i          ,                                
    .ed_rx_st3_rssai_prefix_parity_i   ,                                
    .ed_rx_st3_vfactive_i              ,                                
    .ed_rx_st3_vfnum_i                 ,                                
    .ed_rx_st3_chnum_i                 ,                                
    .ed_rx_st3_misc_parity_i           ,                                
    .ed_rx_bus_number                  ,
    .ed_rx_device_number               ,
    .ed_rx_function_number             ,
    
    .ed_rx_st_ready_o                  ,                             
    .Clk_i            (ip2hdm_clk   )  ,                             
    .Rstn_i           (ip2hdm_reset_n ),                              
    .ed_clk                            ,                             
    .ed_rst_n                          ,                             
    .ed_tx_st0_eop_o                   ,                             
    .ed_tx_st1_eop_o                   ,                             
    .ed_tx_st2_eop_o                   ,                             
    .ed_tx_st3_eop_o                   ,                             
    .ed_tx_st0_header_o                ,                             
    .ed_tx_st1_header_o                ,                             
    .ed_tx_st2_header_o                ,                             
    .ed_tx_st3_header_o                ,                             
    .ed_tx_st0_prefix_o                ,                             
    .ed_tx_st1_prefix_o                ,                             
    .ed_tx_st2_prefix_o                ,                             
    .ed_tx_st3_prefix_o                ,                             
    .ed_tx_st0_payload_o               ,                             
    .ed_tx_st1_payload_o               ,                             
    .ed_tx_st2_payload_o               ,                             
    .ed_tx_st3_payload_o               ,                             
    .ed_tx_st0_sop_o                   ,                             
    .ed_tx_st1_sop_o                   ,                             
    .ed_tx_st2_sop_o                   ,                             
    .ed_tx_st3_sop_o                   ,                             
    .ed_tx_st0_dvalid_o                ,                             
    .ed_tx_st1_dvalid_o                ,                             
    .ed_tx_st2_dvalid_o                ,                             
    .ed_tx_st3_dvalid_o                ,                             
    .ed_tx_st0_pvalid_o                ,                             
    .ed_tx_st1_pvalid_o                ,                             
    .ed_tx_st2_pvalid_o                ,                             
    .ed_tx_st3_pvalid_o                ,                             
    .ed_tx_st0_hvalid_o                ,                             
    .ed_tx_st1_hvalid_o                ,                             
    .ed_tx_st2_hvalid_o                ,                             
    .ed_tx_st3_hvalid_o                ,                             
    .ed_tx_st0_data_parity             ,                               
    .ed_tx_st0_hdr_parity              ,                               
    .ed_tx_st0_prefix_parity           ,                               
    .ed_tx_st0_RSSAI_prefix            ,                               
    .ed_tx_st0_RSSAI_prefix_parity     ,                               
    .ed_tx_st0_vfactive                ,                               
    .ed_tx_st0_vfnum                   ,                               
    .ed_tx_st0_pfnum                   ,                               
    .ed_tx_st0_chnum                   ,                               
    .ed_tx_st0_empty                   ,                               
    .ed_tx_st0_misc_parity             ,                               
    .ed_tx_st1_data_parity             ,                               
    .ed_tx_st1_hdr_parity              ,                               
    .ed_tx_st1_prefix_parity           ,                               
    .ed_tx_st1_RSSAI_prefix            ,                               
    .ed_tx_st1_RSSAI_prefix_parity     ,                               
    .ed_tx_st1_vfactive                ,                               
    .ed_tx_st1_vfnum                   ,                               
    .ed_tx_st1_pfnum                   ,                               
    .ed_tx_st1_chnum                   ,                               
    .ed_tx_st1_empty                   ,                               
    .ed_tx_st1_misc_parity             ,                               
    .ed_tx_st2_data_parity             ,                               
    .ed_tx_st2_hdr_parity              ,                               
    .ed_tx_st2_prefix_parity           ,                               
    .ed_tx_st2_RSSAI_prefix            ,                               
    .ed_tx_st2_RSSAI_prefix_parity     ,                               
    .ed_tx_st2_vfactive                ,                               
    .ed_tx_st2_vfnum                   ,                               
    .ed_tx_st2_pfnum                   ,                               
    .ed_tx_st2_chnum                   ,                               
    .ed_tx_st2_empty                   ,                               
    .ed_tx_st2_misc_parity             ,                               
    .ed_tx_st3_data_parity             ,                               
    .ed_tx_st3_hdr_parity              ,                               
    .ed_tx_st3_prefix_parity           ,                               
    .ed_tx_st3_RSSAI_prefix            ,                               
    .ed_tx_st3_RSSAI_prefix_parity     ,                               
    .ed_tx_st3_vfactive                ,                               
    .ed_tx_st3_vfnum                   ,                               
    .ed_tx_st3_pfnum                   ,                               
    .ed_tx_st3_chnum                   ,                               
    .ed_tx_st3_empty                   ,                               
    .ed_tx_st3_misc_parity             ,                               
    .ed_tx_st_ready_i                  ,                             
    .rx_st_hcrdt_update_o              ,                               
    .rx_st_hcrdt_update_cnt_o          ,                               
    .rx_st_hcrdt_init_o                ,                               
    .rx_st_hcrdt_init_ack_i            ,                               
    .rx_st_dcrdt_update_o              ,                               
    .rx_st_dcrdt_update_cnt_o          ,                               
    .rx_st_dcrdt_init_o                ,                               
    .rx_st_dcrdt_init_ack_i            ,                               
    .tx_st_hcrdt_update_i              ,                               
    .tx_st_hcrdt_update_cnt_i          ,                               
    .tx_st_hcrdt_init_i                ,                               
    .tx_st_hcrdt_init_ack_o            ,                               
    .tx_st_dcrdt_update_i              ,                               
    .tx_st_dcrdt_update_cnt_i          ,                               
    .tx_st_dcrdt_init_i                ,                               
    .tx_st_dcrdt_init_ack_o            ,                               
    .ed_tx_st0_passthrough_o           ,                               
    .ed_tx_st1_passthrough_o           ,                               
    .ed_tx_st2_passthrough_o           ,                               
    .ed_tx_st3_passthrough_o           ,                               
    .ed_rx_st0_passthrough_i           ,                               
    .ed_rx_st1_passthrough_i           ,                               
    .ed_rx_st2_passthrough_i           ,                               
    .ed_rx_st3_passthrough_i                                          
); 





//Passthrough User can implement the AFU logic here 

  //-------------------------------------------------------
  // PF1 BAR2 example CSR                                --
  //-------------------------------------------------------

//  ex_default_csr_top ex_default_csr_top_inst(
//     .csr_avmm_clk                        ( ip2csr_avmm_clk                   ),
//     .csr_avmm_rstn                       ( ip2csr_avmm_rstn                  ),
//     .csr_avmm_waitrequest                ( csr2ip_avmm_waitrequest           ),
//     .csr_avmm_readdata                   ( csr2ip_avmm_readdata              ),
//     .csr_avmm_readdatavalid              ( csr2ip_avmm_readdatavalid         ),
//     .csr_avmm_writedata                  ( ip2csr_avmm_writedata             ),
//     .csr_avmm_address                    ( ip2csr_avmm_address               ),
//     .csr_avmm_write                      ( ip2csr_avmm_write                 ),
//     .csr_avmm_read                       ( ip2csr_avmm_read                  ),
//     .csr_avmm_byteenable                 ( ip2csr_avmm_byteenable            )
//  );


//HDM SIZE
// Total amount of HDM expressed as a multiple of 256MB.
// This is a CXL-IP input and is used to advertise HDM size via CXL-IP DVSEC registers.
//
// HDM Size  hdm_size_256mb
// --------  --------------
//  256MB       36'h001
//  512MB       36'h002
//    1GB       36'h004
//    2GB       36'h008
//    4GB       36'h010
//    8GB       36'h020
//   16GB       36'h040
//   32GB       36'h080
//   64GB       36'h100
//  128GB       36'h200
//  256GB       36'h400
//  512GB       36'h800
//  (etc.)      (etc.)

`ifdef HDM_64G
   `ifndef ENABLE_4_BBS_SLICE   // MC_CHANNEL=2
      assign hdm_size_256mb = 36'h100;// HDM_64G
   `else   // MC_CHANNEL=4
      assign hdm_size_256mb = 36'h200;// HDM_128G
   `endif
`else
   `ifndef ENABLE_4_BBS_SLICE   // MC_CHANNEL=2
       assign hdm_size_256mb = 36'h40;// HDM_16G
   `else   // MC_CHANNEL=4
       assign hdm_size_256mb = 36'h80;// HDM_32G
   `endif
`endif


`ifndef ENABLE_4_BBS_SLICE   // MC_CHANNEL=2

 assign   mc2ip_0_sr_status                    =  mc_sr_status_eclk[0]                   ;
 assign   mc2ip_0_rspfifo_full                 =  mc_rspfifo_full_eclk[0]                ;
 assign   mc2ip_0_rspfifo_empty                =  mc_rspfifo_empty_eclk[0]               ;
 assign   mc2ip_0_rspfifo_fill_level           =  mc_rspfifo_fill_level_eclk[0]          ;
 assign   mc2ip_0_reqfifo_full                 =  mc_reqfifo_full_eclk[0]                ;
 assign   mc2ip_0_reqfifo_empty                =  mc_reqfifo_empty_eclk[0]               ;
 assign   mc2ip_0_reqfifo_fill_level           =  mc_reqfifo_fill_level_eclk[0]          ;
 assign   cxlip2iafu_read_eclk[0]              =  ip2hdm_avmm0_read                      ;
 assign   cxlip2iafu_write_eclk[0]             =  ip2hdm_avmm0_write                     ;
 assign   cxlip2iafu_write_poison_eclk[0]      =  ip2hdm_avmm0_write_poison              ;
 assign   cxlip2iafu_write_ras_sbe_eclk[0]     =  ip2hdm_avmm0_write_ras_sbe             ; 
 assign   cxlip2iafu_write_ras_dbe_eclk[0]     =  ip2hdm_avmm0_write_ras_dbe             ; 
 assign   cxlip2iafu_chan_address_eclk[0]      =  ip2hdm_avmm0_address                   ;
 assign   cxlip2iafu_req_mdata_eclk[0]         =  ip2hdm_avmm0_req_mdata                 ;
 assign   cxlip2iafu_writedata_eclk[0]         =  ip2hdm_avmm0_writedata                 ;
 assign   cxlip2iafu_byteenable_eclk[0]        =  ip2hdm_avmm0_byteenable                ;
 assign   hdm2ip_avmm0_ready                   =  iafu2cxlip_ready_eclk[0]               ; 
 assign   hdm2ip_avmm0_readdata                =  iafu2cxlip_readdata_eclk[0]            ;
 assign   hdm2ip_avmm0_rsp_mdata               =  iafu2cxlip_rsp_mdata_eclk[0]           ;
 assign   hdm2ip_avmm0_cxlmem_ready            =  iafu2cxlip_cxlmem_ready[0]   	         ;
 assign   hdm2ip_avmm0_read_poison             =  iafu2cxlip_read_poison_eclk[0]         ;
 assign   hdm2ip_avmm0_readdatavalid           =  iafu2cxlip_readdatavalid_eclk[0]       ;
 assign   hdm2ip_avmm0_ecc_err_corrected       =  iafu2cxlip_ecc_err_corrected_eclk[0]   ;
 assign   hdm2ip_avmm0_ecc_err_detected        =  iafu2cxlip_ecc_err_detected_eclk[0]    ;
 assign   hdm2ip_avmm0_ecc_err_fatal           =  iafu2cxlip_ecc_err_fatal_eclk[0]       ;
 assign   hdm2ip_avmm0_ecc_err_syn_e           =  iafu2cxlip_ecc_err_syn_e_eclk[0]       ;
 assign   hdm2ip_avmm0_ecc_err_valid           =  iafu2cxlip_ecc_err_valid_eclk[0]       ;
 assign   mc2ip_1_sr_status                    =  mc_sr_status_eclk[1]                   ;
 assign   mc2ip_1_rspfifo_full                 =  mc_rspfifo_full_eclk[1]                ;
 assign   mc2ip_1_rspfifo_empty                =  mc_rspfifo_empty_eclk[1]               ;
 assign   mc2ip_1_rspfifo_fill_level           =  mc_rspfifo_fill_level_eclk[1]          ;
 assign   mc2ip_1_reqfifo_full                 =  mc_reqfifo_full_eclk[1]                ;
 assign   mc2ip_1_reqfifo_empty                =  mc_reqfifo_empty_eclk[1]               ;
 assign   mc2ip_1_reqfifo_fill_level           =  mc_reqfifo_fill_level_eclk[1]          ;
 assign   cxlip2iafu_read_eclk[1]              =  ip2hdm_avmm1_read                      ;
 assign   cxlip2iafu_write_eclk[1]             =  ip2hdm_avmm1_write                     ;
 assign   cxlip2iafu_write_poison_eclk[1]      =  ip2hdm_avmm1_write_poison              ;
 assign   cxlip2iafu_write_ras_sbe_eclk[1]     =  ip2hdm_avmm1_write_ras_sbe             ; 
 assign   cxlip2iafu_write_ras_dbe_eclk[1]     =  ip2hdm_avmm1_write_ras_dbe             ; 
 assign   cxlip2iafu_chan_address_eclk[1]      =  ip2hdm_avmm1_address                   ;
 assign   cxlip2iafu_req_mdata_eclk[1]         =  ip2hdm_avmm1_req_mdata                 ;
 assign   cxlip2iafu_writedata_eclk[1]         =  ip2hdm_avmm1_writedata                 ;
 assign   cxlip2iafu_byteenable_eclk[1]        =  ip2hdm_avmm1_byteenable                ;
 assign   hdm2ip_avmm1_ready                   =  iafu2cxlip_ready_eclk[1]               ; 
 assign   hdm2ip_avmm1_readdata                =  iafu2cxlip_readdata_eclk[1]            ;
 assign   hdm2ip_avmm1_rsp_mdata               =  iafu2cxlip_rsp_mdata_eclk[1]           ;
 assign   hdm2ip_avmm1_cxlmem_ready            =  iafu2cxlip_cxlmem_ready[1]   	         ;
 assign   hdm2ip_avmm1_read_poison             =  iafu2cxlip_read_poison_eclk[1]         ;
 assign   hdm2ip_avmm1_readdatavalid           =  iafu2cxlip_readdatavalid_eclk[1]       ;
 assign   hdm2ip_avmm1_ecc_err_corrected       =  iafu2cxlip_ecc_err_corrected_eclk[1]   ;
 assign   hdm2ip_avmm1_ecc_err_detected        =  iafu2cxlip_ecc_err_detected_eclk[1]    ;
 assign   hdm2ip_avmm1_ecc_err_fatal           =  iafu2cxlip_ecc_err_fatal_eclk[1]       ;
 assign   hdm2ip_avmm1_ecc_err_syn_e           =  iafu2cxlip_ecc_err_syn_e_eclk[1]       ;
 assign   hdm2ip_avmm1_ecc_err_valid           =  iafu2cxlip_ecc_err_valid_eclk[1]       ;


`else   // MC_CHANNEL=4

 assign   mc2ip_0_sr_status                    =  mc_sr_status_eclk[0]                   ;
 assign   mc2ip_0_rspfifo_full                 =  mc_rspfifo_full_eclk[0]                ;
 assign   mc2ip_0_rspfifo_empty                =  mc_rspfifo_empty_eclk[0]               ;
 assign   mc2ip_0_rspfifo_fill_level           =  mc_rspfifo_fill_level_eclk[0]          ;
 assign   mc2ip_0_reqfifo_full                 =  mc_reqfifo_full_eclk[0]                ;
 assign   mc2ip_0_reqfifo_empty                =  mc_reqfifo_empty_eclk[0]               ;
 assign   mc2ip_0_reqfifo_fill_level           =  mc_reqfifo_fill_level_eclk[0]          ;
 assign   cxlip2iafu_read_eclk[0]              =  ip2hdm_avmm0_read                      ;
 assign   cxlip2iafu_write_eclk[0]             =  ip2hdm_avmm0_write                     ;
 assign   cxlip2iafu_write_poison_eclk[0]      =  ip2hdm_avmm0_write_poison              ;
 assign   cxlip2iafu_write_ras_sbe_eclk[0]     =  ip2hdm_avmm0_write_ras_sbe             ; 
 assign   cxlip2iafu_write_ras_dbe_eclk[0]     =  ip2hdm_avmm0_write_ras_dbe             ; 
 assign   cxlip2iafu_chan_address_eclk[0]      =  ip2hdm_avmm0_address                   ;
 assign   cxlip2iafu_req_mdata_eclk[0]         =  ip2hdm_avmm0_req_mdata                 ;
 assign   cxlip2iafu_writedata_eclk[0]         =  ip2hdm_avmm0_writedata                 ;
 assign   cxlip2iafu_byteenable_eclk[0]        =  ip2hdm_avmm0_byteenable                ;
 assign   hdm2ip_avmm0_ready                   =  iafu2cxlip_ready_eclk[0]               ; 
 assign   hdm2ip_avmm0_readdata                =  iafu2cxlip_readdata_eclk[0]            ;
 assign   hdm2ip_avmm0_rsp_mdata               =  iafu2cxlip_rsp_mdata_eclk[0]           ;
 assign   hdm2ip_avmm0_cxlmem_ready            =  iafu2cxlip_cxlmem_ready[0]   	         ;
 assign   hdm2ip_avmm0_read_poison             =  iafu2cxlip_read_poison_eclk[0]         ;
 assign   hdm2ip_avmm0_readdatavalid           =  iafu2cxlip_readdatavalid_eclk[0]       ;
 assign   hdm2ip_avmm0_ecc_err_corrected       =  iafu2cxlip_ecc_err_corrected_eclk[0]   ;
 assign   hdm2ip_avmm0_ecc_err_detected        =  iafu2cxlip_ecc_err_detected_eclk[0]    ;
 assign   hdm2ip_avmm0_ecc_err_fatal           =  iafu2cxlip_ecc_err_fatal_eclk[0]       ;
 assign   hdm2ip_avmm0_ecc_err_syn_e           =  iafu2cxlip_ecc_err_syn_e_eclk[0]       ;
 assign   hdm2ip_avmm0_ecc_err_valid           =  iafu2cxlip_ecc_err_valid_eclk[0]       ;
 assign   mc2ip_1_sr_status                    =  mc_sr_status_eclk[1]                   ;
 assign   mc2ip_1_rspfifo_full                 =  mc_rspfifo_full_eclk[1]                ;
 assign   mc2ip_1_rspfifo_empty                =  mc_rspfifo_empty_eclk[1]               ;
 assign   mc2ip_1_rspfifo_fill_level           =  mc_rspfifo_fill_level_eclk[1]          ;
 assign   mc2ip_1_reqfifo_full                 =  mc_reqfifo_full_eclk[1]                ;
 assign   mc2ip_1_reqfifo_empty                =  mc_reqfifo_empty_eclk[1]               ;
 assign   mc2ip_1_reqfifo_fill_level           =  mc_reqfifo_fill_level_eclk[1]          ;
 assign   cxlip2iafu_read_eclk[1]              =  ip2hdm_avmm1_read                      ;
 assign   cxlip2iafu_write_eclk[1]             =  ip2hdm_avmm1_write                     ;
 assign   cxlip2iafu_write_poison_eclk[1]      =  ip2hdm_avmm1_write_poison              ;
 assign   cxlip2iafu_write_ras_sbe_eclk[1]     =  ip2hdm_avmm1_write_ras_sbe             ; 
 assign   cxlip2iafu_write_ras_dbe_eclk[1]     =  ip2hdm_avmm1_write_ras_dbe             ; 
 assign   cxlip2iafu_chan_address_eclk[1]      =  ip2hdm_avmm1_address                   ;
 assign   cxlip2iafu_req_mdata_eclk[1]         =  ip2hdm_avmm1_req_mdata                 ;
 assign   cxlip2iafu_writedata_eclk[1]         =  ip2hdm_avmm1_writedata                 ;
 assign   cxlip2iafu_byteenable_eclk[1]        =  ip2hdm_avmm1_byteenable                ;
 assign   hdm2ip_avmm1_ready                   =  iafu2cxlip_ready_eclk[1]               ; 
 assign   hdm2ip_avmm1_readdata                =  iafu2cxlip_readdata_eclk[1]            ;
 assign   hdm2ip_avmm1_rsp_mdata               =  iafu2cxlip_rsp_mdata_eclk[1]           ;
 assign   hdm2ip_avmm1_cxlmem_ready            =  iafu2cxlip_cxlmem_ready[1]   	         ;
 assign   hdm2ip_avmm1_read_poison             =  iafu2cxlip_read_poison_eclk[1]         ;
 assign   hdm2ip_avmm1_readdatavalid           =  iafu2cxlip_readdatavalid_eclk[1]       ;
 assign   hdm2ip_avmm1_ecc_err_corrected       =  iafu2cxlip_ecc_err_corrected_eclk[1]   ;
 assign   hdm2ip_avmm1_ecc_err_detected        =  iafu2cxlip_ecc_err_detected_eclk[1]    ;
 assign   hdm2ip_avmm1_ecc_err_fatal           =  iafu2cxlip_ecc_err_fatal_eclk[1]       ;
 assign   hdm2ip_avmm1_ecc_err_syn_e           =  iafu2cxlip_ecc_err_syn_e_eclk[1]       ;
 assign   hdm2ip_avmm1_ecc_err_valid           =  iafu2cxlip_ecc_err_valid_eclk[1]       ;
 assign   mc2ip_2_sr_status                    =  mc_sr_status_eclk[2]                   ;
 assign   mc2ip_2_rspfifo_full                 =  mc_rspfifo_full_eclk[2]                ;
 assign   mc2ip_2_rspfifo_empty                =  mc_rspfifo_empty_eclk[2]               ;
 assign   mc2ip_2_rspfifo_fill_level           =  mc_rspfifo_fill_level_eclk[2]          ;
 assign   mc2ip_2_reqfifo_full                 =  mc_reqfifo_full_eclk[2]                ;
 assign   mc2ip_2_reqfifo_empty                =  mc_reqfifo_empty_eclk[2]               ;
 assign   mc2ip_2_reqfifo_fill_level           =  mc_reqfifo_fill_level_eclk[2]          ;
 assign   cxlip2iafu_read_eclk[2]              =  ip2hdm_avmm2_read                      ;
 assign   cxlip2iafu_write_eclk[2]             =  ip2hdm_avmm2_write                     ;
 assign   cxlip2iafu_write_poison_eclk[2]      =  ip2hdm_avmm2_write_poison              ;
 assign   cxlip2iafu_write_ras_sbe_eclk[2]     =  ip2hdm_avmm2_write_ras_sbe             ; 
 assign   cxlip2iafu_write_ras_dbe_eclk[2]     =  ip2hdm_avmm2_write_ras_dbe             ; 
 assign   cxlip2iafu_chan_address_eclk[2]      =  ip2hdm_avmm2_address                   ;
 assign   cxlip2iafu_req_mdata_eclk[2]         =  ip2hdm_avmm2_req_mdata                 ;
 assign   cxlip2iafu_writedata_eclk[2]         =  ip2hdm_avmm2_writedata                 ;
 assign   cxlip2iafu_byteenable_eclk[2]        =  ip2hdm_avmm2_byteenable                ;
 assign   hdm2ip_avmm2_ready                   =  iafu2cxlip_ready_eclk[2]               ; 
 assign   hdm2ip_avmm2_readdata                =  iafu2cxlip_readdata_eclk[2]            ;
 assign   hdm2ip_avmm2_rsp_mdata               =  iafu2cxlip_rsp_mdata_eclk[2]           ;
 assign   hdm2ip_avmm2_cxlmem_ready            =  iafu2cxlip_cxlmem_ready[2]   	         ;
 assign   hdm2ip_avmm2_read_poison             =  iafu2cxlip_read_poison_eclk[2]         ;
 assign   hdm2ip_avmm2_readdatavalid           =  iafu2cxlip_readdatavalid_eclk[2]       ;
 assign   hdm2ip_avmm2_ecc_err_corrected       =  iafu2cxlip_ecc_err_corrected_eclk[2]   ;
 assign   hdm2ip_avmm2_ecc_err_detected        =  iafu2cxlip_ecc_err_detected_eclk[2]    ;
 assign   hdm2ip_avmm2_ecc_err_fatal           =  iafu2cxlip_ecc_err_fatal_eclk[2]       ;
 assign   hdm2ip_avmm2_ecc_err_syn_e           =  iafu2cxlip_ecc_err_syn_e_eclk[2]       ;
 assign   hdm2ip_avmm2_ecc_err_valid           =  iafu2cxlip_ecc_err_valid_eclk[2]       ;
 assign   mc2ip_3_sr_status                    =  mc_sr_status_eclk[3]                   ;
 assign   mc2ip_3_rspfifo_full                 =  mc_rspfifo_full_eclk[3]                ;
 assign   mc2ip_3_rspfifo_empty                =  mc_rspfifo_empty_eclk[3]               ;
 assign   mc2ip_3_rspfifo_fill_level           =  mc_rspfifo_fill_level_eclk[3]          ;
 assign   mc2ip_3_reqfifo_full                 =  mc_reqfifo_full_eclk[3]                ;
 assign   mc2ip_3_reqfifo_empty                =  mc_reqfifo_empty_eclk[3]               ;
 assign   mc2ip_3_reqfifo_fill_level           =  mc_reqfifo_fill_level_eclk[3]          ;
 assign   cxlip2iafu_read_eclk[3]              =  ip2hdm_avmm3_read                      ;
 assign   cxlip2iafu_write_eclk[3]             =  ip2hdm_avmm3_write                     ;
 assign   cxlip2iafu_write_poison_eclk[3]      =  ip2hdm_avmm3_write_poison              ;
 assign   cxlip2iafu_write_ras_sbe_eclk[3]     =  ip2hdm_avmm3_write_ras_sbe             ; 
 assign   cxlip2iafu_write_ras_dbe_eclk[3]     =  ip2hdm_avmm3_write_ras_dbe             ; 
 assign   cxlip2iafu_chan_address_eclk[3]      =  ip2hdm_avmm3_address                   ;
 assign   cxlip2iafu_req_mdata_eclk[3]         =  ip2hdm_avmm3_req_mdata                 ;
 assign   cxlip2iafu_writedata_eclk[3]         =  ip2hdm_avmm3_writedata                 ;
 assign   cxlip2iafu_byteenable_eclk[3]        =  ip2hdm_avmm3_byteenable                ;
 assign   hdm2ip_avmm3_ready                   =  iafu2cxlip_ready_eclk[3]               ; 
 assign   hdm2ip_avmm3_readdata                =  iafu2cxlip_readdata_eclk[3]            ;
 assign   hdm2ip_avmm3_rsp_mdata               =  iafu2cxlip_rsp_mdata_eclk[3]           ;
 assign   hdm2ip_avmm3_cxlmem_ready            =  iafu2cxlip_cxlmem_ready[3]   	         ;
 assign   hdm2ip_avmm3_read_poison             =  iafu2cxlip_read_poison_eclk[3]         ;
 assign   hdm2ip_avmm3_readdatavalid           =  iafu2cxlip_readdatavalid_eclk[3]       ;
 assign   hdm2ip_avmm3_ecc_err_corrected       =  iafu2cxlip_ecc_err_corrected_eclk[3]   ;
 assign   hdm2ip_avmm3_ecc_err_detected        =  iafu2cxlip_ecc_err_detected_eclk[3]    ;
 assign   hdm2ip_avmm3_ecc_err_fatal           =  iafu2cxlip_ecc_err_fatal_eclk[3]       ;
 assign   hdm2ip_avmm3_ecc_err_syn_e           =  iafu2cxlip_ecc_err_syn_e_eclk[3]       ;
 assign   hdm2ip_avmm3_ecc_err_valid           =  iafu2cxlip_ecc_err_valid_eclk[3]       ;


`endif


 afu_top afu_top_inst(
    .csr_avmm_clk                        ( ip2csr_avmm_clk                    ),
    .csr_avmm_rstn                       ( ip2csr_avmm_rstn                   ),
    .csr_avmm_waitrequest                ( csr2ip_avmm_waitrequest            ),
    .csr_avmm_readdata                   ( csr2ip_avmm_readdata               ),
    .csr_avmm_readdatavalid              ( csr2ip_avmm_readdatavalid          ),
    .csr_avmm_writedata                  ( ip2csr_avmm_writedata              ),
    .csr_avmm_address                    ( ip2csr_avmm_address                ),
    .csr_avmm_write                      ( ip2csr_avmm_write                  ),
    .csr_avmm_read                       ( ip2csr_avmm_read                   ),
    .csr_avmm_byteenable                 ( ip2csr_avmm_byteenable             ),
    .afu_clk                             ( ip2hdm_clk                         ),
    .afu_rstn                            ( ip2hdm_reset_n                      ),
    .mc2iafu_ready_eclk                  ( mc2iafu_ready_eclk                  ),
    .mc2iafu_read_poison_eclk            ( mc2iafu_read_poison_eclk            ),
    .mc2iafu_readdatavalid_eclk          ( mc2iafu_readdatavalid_eclk          ),
    .mc2iafu_ecc_err_corrected_eclk      ( mc2iafu_ecc_err_corrected_eclk      ),
    .mc2iafu_ecc_err_detected_eclk       ( mc2iafu_ecc_err_detected_eclk       ),
    .mc2iafu_ecc_err_fatal_eclk          ( mc2iafu_ecc_err_fatal_eclk          ),
    .mc2iafu_ecc_err_syn_e_eclk          ( mc2iafu_ecc_err_syn_e_eclk          ),
    .mc2iafu_ecc_err_valid_eclk          ( mc2iafu_ecc_err_valid_eclk          ),
    .mc2iafu_cxlmem_ready                ( mc2iafu_cxlmem_ready                ),
    .mc2iafu_readdata_eclk               ( mc2iafu_readdata_eclk               ),
    .mc2iafu_rsp_mdata_eclk              ( mc2iafu_rsp_mdata_eclk              ),
    .iafu2mc_writedata_eclk              ( iafu2mc_writedata_eclk              ),
    .iafu2mc_byteenable_eclk             ( iafu2mc_byteenable_eclk             ),
    .iafu2mc_read_eclk                   ( iafu2mc_read_eclk                   ),
    .iafu2mc_write_eclk                  ( iafu2mc_write_eclk                  ),
    .iafu2mc_write_poison_eclk           ( iafu2mc_write_poison_eclk           ),
    .iafu2mc_write_ras_sbe_eclk          ( iafu2mc_write_ras_sbe_eclk          ),    
    .iafu2mc_write_ras_dbe_eclk          ( iafu2mc_write_ras_dbe_eclk          ),    
    .iafu2mc_address_eclk                ( iafu2mc_address_eclk                ),
    .iafu2mc_req_mdata_eclk              ( iafu2mc_req_mdata_eclk              ),
    .iafu2cxlip_ready_eclk               ( iafu2cxlip_ready_eclk               ),
    .iafu2cxlip_read_poison_eclk         ( iafu2cxlip_read_poison_eclk         ),
    .iafu2cxlip_readdatavalid_eclk       ( iafu2cxlip_readdatavalid_eclk       ),
    .iafu2cxlip_ecc_err_corrected_eclk   ( iafu2cxlip_ecc_err_corrected_eclk   ),
    .iafu2cxlip_ecc_err_detected_eclk    ( iafu2cxlip_ecc_err_detected_eclk    ),
    .iafu2cxlip_ecc_err_fatal_eclk       ( iafu2cxlip_ecc_err_fatal_eclk       ),
    .iafu2cxlip_ecc_err_syn_e_eclk       ( iafu2cxlip_ecc_err_syn_e_eclk       ),
    .iafu2cxlip_ecc_err_valid_eclk       ( iafu2cxlip_ecc_err_valid_eclk       ),
    .iafu2cxlip_cxlmem_ready             ( iafu2cxlip_cxlmem_ready             ),
    .iafu2cxlip_readdata_eclk            ( iafu2cxlip_readdata_eclk            ),
    .iafu2cxlip_rsp_mdata_eclk           ( iafu2cxlip_rsp_mdata_eclk           ),
    .cxlip2iafu_writedata_eclk           ( cxlip2iafu_writedata_eclk           ),
    .cxlip2iafu_byteenable_eclk          ( cxlip2iafu_byteenable_eclk          ),
    .cxlip2iafu_read_eclk                ( cxlip2iafu_read_eclk                ),
    .cxlip2iafu_write_eclk               ( cxlip2iafu_write_eclk               ),
    .cxlip2iafu_write_poison_eclk        ( cxlip2iafu_write_poison_eclk        ),
    .cxlip2iafu_write_ras_sbe_eclk       ( cxlip2iafu_write_ras_sbe_eclk       ),    
    .cxlip2iafu_write_ras_dbe_eclk       ( cxlip2iafu_write_ras_dbe_eclk       ),    
    .cxlip2iafu_address_eclk             ( cxlip2iafu_chan_address_eclk        ),   ///cxlip2iafu_address_eclk
   
    .cxlip2iafu_req_mdata_eclk           ( cxlip2iafu_req_mdata_eclk           )
 );

  //-------------------------------------------------------
  // DDR EXAMPLE DESIGN                               --
  //-------------------------------------------------------

 logic [63:0]                                      mc2ip_memsize_s[cxlip_top_pkg::NUM_MC_TOP-1:0];


  always_comb 
  begin
    mc2ip_memsize = 0;
    for (int i=0; i<NUM_MC_TOP; i=i+1)
    begin
      mc2ip_memsize = mc2ip_memsize + mc2ip_memsize_s[i];
    end
  end

//--------------------------------------------------------------------
// DDR Memory Controller Module
//--------------------------------------------------------------------

generate
for( genvar chanCount = 0; chanCount < cxlip_top_pkg::NUM_MC_TOP; chanCount=chanCount+1 )
begin : MC_CHANNEL_INST

mc_top #(
    .MC_CHANNEL               (cxlip_top_pkg::DDR_CHANNEL              ),
    .MC_HA_DDR4_ADDR_WIDTH    (cxlip_top_pkg::MC_HA_DDR4_ADDR_WIDTH   ),
    .MC_HA_DDR4_BA_WIDTH      (cxlip_top_pkg::MC_HA_DDR4_BA_WIDTH     ),
    .MC_HA_DDR4_BG_WIDTH      (cxlip_top_pkg::MC_HA_DDR4_BG_WIDTH     ),
    .MC_HA_DDR4_CK_WIDTH      (cxlip_top_pkg::MC_HA_DDR4_CK_WIDTH     ),
    .MC_HA_DDR4_CKE_WIDTH     (cxlip_top_pkg::MC_HA_DDR4_CKE_WIDTH    ),
    .MC_HA_DDR4_CS_WIDTH      (cxlip_top_pkg::MC_HA_DDR4_CS_WIDTH     ),
    .MC_HA_DDR4_ODT_WIDTH     (cxlip_top_pkg::MC_HA_DDR4_ODT_WIDTH    ),
    .MC_HA_DDR4_DQS_WIDTH     (cxlip_top_pkg::MC_HA_DDR4_DQS_WIDTH    ),
    .MC_HA_DDR4_DQ_WIDTH      (cxlip_top_pkg::MC_HA_DDR4_DQ_WIDTH     ),
    `ifdef ENABLE_DDR_DBI_PINS
    .MC_HA_DDR4_DBI_WIDTH     (cxlip_top_pkg::MC_HA_DDR4_DBI_WIDTH    ),
    `endif  
    .EMIF_AMM_ADDR_WIDTH      (cxlip_top_pkg::EMIF_AMM_ADDR_WIDTH     ),
    .EMIF_AMM_DATA_WIDTH      (cxlip_top_pkg::EMIF_AMM_DATA_WIDTH     ),
    .EMIF_AMM_BURST_WIDTH     (cxlip_top_pkg::EMIF_AMM_BURST_WIDTH    ),
    .EMIF_AMM_BE_WIDTH        (cxlip_top_pkg::EMIF_AMM_BE_WIDTH       ),
    .REG_ON_REQFIFO_INPUT_EN  (cxlip_top_pkg::REG_ON_REQFIFO_INPUT_EN ),
    .REG_ON_REQFIFO_OUTPUT_EN (cxlip_top_pkg::REG_ON_REQFIFO_OUTPUT_EN),
    .REG_ON_RSPFIFO_OUTPUT_EN (cxlip_top_pkg::REG_ON_RSPFIFO_OUTPUT_EN),
    .MC_HA_DP_ADDR_WIDTH      (cxlip_top_pkg::MC_HA_DP_ADDR_WIDTH     ),
    .MC_HA_DP_DATA_WIDTH      (cxlip_top_pkg::MC_HA_DP_DATA_WIDTH     ),
    .MC_ECC_EN                (cxlip_top_pkg::MC_ECC_EN               ),
    .MC_ECC_ENC_LATENCY       (cxlip_top_pkg::MC_ECC_ENC_LATENCY      ),
    .MC_ECC_DEC_LATENCY       (cxlip_top_pkg::MC_ECC_DEC_LATENCY      ),
    .MC_RAM_INIT_W_ZERO_EN    (cxlip_top_pkg::MC_RAM_INIT_W_ZERO_EN   ),
    .MEMSIZE_WIDTH            (cxlip_top_pkg::MEMSIZE_WIDTH           )
  )
  mc_top (
    .eclk                            (ip2hdm_clk),                        // input,  BBS Slice clock
    .reset_n_eclk                    (ip2hdm_reset_n),                    // input,  BBS Slice reset_n

    .mc2ha_memsize                   (mc2ip_memsize_s[chanCount]),                        // output, Size (in bytes) of memory exposed to BIOS
    .mc_sr_status_eclk               (mc_sr_status_eclk[(2*chanCount+1):(2*chanCount)]          ),                                                   // output, Memory Controller Status
// == MC <--> iAFU signals ==
    .mc2iafu_ready_eclk              (mc2iafu_ready_eclk[(2*chanCount+1):(2*chanCount)]         ),             // output, AVMM ready to iAFU
    .iafu2mc_read_eclk               (iafu2mc_read_eclk[(2*chanCount+1):(2*chanCount)]          ),              // input,  AVMM read request from iAFU
    .iafu2mc_write_eclk              (iafu2mc_write_eclk[(2*chanCount+1):(2*chanCount)]         ),             // input,  AVMM write request from iAFU
    .iafu2mc_write_poison_eclk       (iafu2mc_write_poison_eclk[(2*chanCount+1):(2*chanCount)]  ),      // input,  AVMM write poison from iAFU
    .iafu2mc_write_ras_sbe_eclk      (iafu2mc_write_ras_sbe_eclk[(2*chanCount+1):(2*chanCount)] ),     // input,  AVMM write inject sbe from iAFU
    .iafu2mc_write_ras_dbe_eclk      (iafu2mc_write_ras_dbe_eclk[(2*chanCount+1):(2*chanCount)] ),     // input,  AVMM write inject dbe from iAFU
    .iafu2mc_address_eclk            (iafu2mc_address_eclk[(2*chanCount+1):(2*chanCount)]       ),           // input,  AVMM address from iAFU
    .iafu2mc_req_mdata_eclk          (iafu2mc_req_mdata_eclk[(2*chanCount+1):(2*chanCount)]     ),         // input,  AVMM reqeust MDATA from iAFU
    .mc2iafu_readdata_eclk           (mc2iafu_readdata_eclk[(2*chanCount+1):(2*chanCount)]      ),          // output, AVMM read data to iAFU
    .mc2iafu_rsp_mdata_eclk          (mc2iafu_rsp_mdata_eclk[(2*chanCount+1):(2*chanCount)]     ),         // output, AVMM response MDATA to iAFU
    .iafu2mc_writedata_eclk          (iafu2mc_writedata_eclk[(2*chanCount+1):(2*chanCount)]     ),         // input,  AVMM write data from iAFU
    .iafu2mc_byteenable_eclk         (iafu2mc_byteenable_eclk[(2*chanCount+1):(2*chanCount)]    ),        // input,  AVMM byte enable from iAFU
    .mc2iafu_read_poison_eclk        (mc2iafu_read_poison_eclk[(2*chanCount+1):(2*chanCount)]   ),       // output, AVMM read poison to iAFU
    .mc2iafu_readdatavalid_eclk      (mc2iafu_readdatavalid_eclk[(2*chanCount+1):(2*chanCount)] ),     // output, AVMM read data valid to iAFU

    // Error Correction Code (ECC)
    // Note *ecc_err_* are valid when mc2iafu_readdatavalid_eclk is active
    .mc2iafu_ecc_err_corrected_eclk  (mc2iafu_ecc_err_corrected_eclk[(2*chanCount+1):(2*chanCount)] ), // output, ECC Error corrected
    .mc2iafu_ecc_err_detected_eclk   (mc2iafu_ecc_err_detected_eclk[(2*chanCount+1):(2*chanCount)]  ),  // output, ECC Error detected
    .mc2iafu_ecc_err_fatal_eclk      (mc2iafu_ecc_err_fatal_eclk[(2*chanCount+1):(2*chanCount)]     ),     // output, ECC Error fatal
    .mc2iafu_ecc_err_syn_e_eclk      (mc2iafu_ecc_err_syn_e_eclk[(2*chanCount+1):(2*chanCount)]     ),     // output, ECC Error syn_e
    .mc2iafu_ecc_err_valid_eclk      (mc2iafu_ecc_err_valid_eclk[(2*chanCount+1):(2*chanCount)]     ),     // output, ECC Error valid

    .reqfifo_full_eclk               (mc_reqfifo_full_eclk[(2*chanCount+1):(2*chanCount)]           ),              // output, Ingress request FIFO full
    .reqfifo_empty_eclk              (mc_reqfifo_empty_eclk[(2*chanCount+1):(2*chanCount)]          ),             // output, Ingress request FIFO empty
    .reqfifo_fill_level_eclk         (mc_reqfifo_fill_level_eclk[(2*chanCount+1):(2*chanCount)]     ),        // output, Ingress request FIFO used entries

    .cxlmem_ready                    (mc2iafu_cxlmem_ready[(2*chanCount+1):(2*chanCount)]           ),

    .rspfifo_full_eclk               (mc_rspfifo_full_eclk[(2*chanCount+1):(2*chanCount)]           ),              // output, Egress response FIFO full
    .rspfifo_empty_eclk              (mc_rspfifo_empty_eclk[(2*chanCount+1):(2*chanCount)]          ),             // output, Egress response FIFO empty
    .rspfifo_fill_level_eclk         (mc_rspfifo_fill_level_eclk[(2*chanCount+1):(2*chanCount)]     ),        // output, Egress response FIFO used entries

    // == DDR4 Interface ==
    .mem_refclk                      (mem_refclk[(2*chanCount+1):(2*chanCount)]                     ),           // input,  EMIF PLL reference clock
    .mem_ck                          (mem_ck[(2*chanCount+1):(2*chanCount)]                         ),           // output, DDR4 interface signals
    .mem_ck_n                        (mem_ck_n[(2*chanCount+1):(2*chanCount)]                       ),           // output
    .mem_a                           (mem_a[(2*chanCount+1):(2*chanCount)]                          ),           // output
    .mem_act_n                       (mem_act_n[(2*chanCount+1):(2*chanCount)]                      ),           // output
    .mem_ba                          (mem_ba[(2*chanCount+1):(2*chanCount)]                         ),           // output
    .mem_bg                          (mem_bg[(2*chanCount+1):(2*chanCount)]                         ),           // output
    .mem_cke                         (mem_cke[(2*chanCount+1):(2*chanCount)]                        ),           // output
    .mem_cs_n                        (mem_cs_n[(2*chanCount+1):(2*chanCount)]                       ),           // output
    .mem_odt                         (mem_odt[(2*chanCount+1):(2*chanCount)]                        ),           // output
    .mem_reset_n                     (mem_reset_n[(2*chanCount+1):(2*chanCount)]                    ),           // output
    .mem_par                         (mem_par[(2*chanCount+1):(2*chanCount)]                        ),           // output
    .mem_oct_rzqin                   (mem_oct_rzqin[(2*chanCount+1):(2*chanCount)]                  ),           // input
    .mem_alert_n                     (mem_alert_n[(2*chanCount+1):(2*chanCount)]                    ),           // input
    .mem_dqs                         (mem_dqs[(2*chanCount+1):(2*chanCount)]                        ),           // inout
    .mem_dqs_n                       (mem_dqs_n[(2*chanCount+1):(2*chanCount)]                      ),           // inout
    .mem_dq                          (mem_dq[(2*chanCount+1):(2*chanCount)]                         )            // inout
    `ifdef ENABLE_DDR_DBI_PINS
    ,.mem_dbi_n                      (mem_dbi_n[(2*chanCount+1):(2*chanCount)]                      )            // inout
    `endif

  );  
end
endgenerate  



endmodule
//------------------------------------------------------------------------------------
//
//
// End ed_top_wrapper_typ2.sv
//
//------------------------------------------------------------------------------------
//set foldmethod=marker
//set foldmarker=<<<,>>>
