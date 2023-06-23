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


//----------------------------------------------------------------------------- 
//  Project Name:  intel_cxl 
//  Module Name :  intel_cxl_pio_ed_top                                 
//  Author      :  ochittur                                   
//  Date        :  Aug 22, 2022                                 
//  Description :  Top file for PIO and Default Config
//-----------------------------------------------------------------------------

//`include "intel_cxl_pio_parameters.svh"
import intel_cxl_pio_parameters :: *;
//`default_nettype none
module intel_cxl_pio_ed_top (

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
     output                     ed_rx_st_ready_o,

     input              	Clk_i,
     input              	Rstn_i,
     output             	ed_clk,
     output             	ed_rst_n,

     output                     ed_tx_st0_eop_o,
     output                     ed_tx_st1_eop_o,
     output                     ed_tx_st2_eop_o,
     output                     ed_tx_st3_eop_o,
     output [127:0]             ed_tx_st0_header_o,
     output [127:0]             ed_tx_st1_header_o,
     output [127:0]             ed_tx_st2_header_o,
     output [127:0]             ed_tx_st3_header_o,

     output [31:0]              ed_tx_st0_prefix_o,
     output [31:0]              ed_tx_st1_prefix_o,
     output [31:0]              ed_tx_st2_prefix_o,
     output [31:0]              ed_tx_st3_prefix_o,
     
     output [255:0]   		ed_tx_st0_payload_o,
     output [255:0]   		ed_tx_st1_payload_o,
     output [255:0]   		ed_tx_st2_payload_o,
     output [255:0]   		ed_tx_st3_payload_o,

     output                     ed_tx_st0_sop_o,
     output                     ed_tx_st1_sop_o,
     output                     ed_tx_st2_sop_o,
     output                     ed_tx_st3_sop_o,

     output                     ed_tx_st0_dvalid_o,
     output                     ed_tx_st1_dvalid_o,
     output                     ed_tx_st2_dvalid_o,
     output                     ed_tx_st3_dvalid_o,
     output                     ed_tx_st0_pvalid_o,
     output                     ed_tx_st1_pvalid_o,
     output                     ed_tx_st2_pvalid_o,
     output                     ed_tx_st3_pvalid_o,
     output                     ed_tx_st0_hvalid_o,
     output                     ed_tx_st1_hvalid_o,
     output                     ed_tx_st2_hvalid_o,
     output                     ed_tx_st3_hvalid_o,

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
     output 		        ed_tx_st0_passthrough_o,
     output 		        ed_tx_st1_passthrough_o,
     output 		        ed_tx_st2_passthrough_o,
     output 		        ed_tx_st3_passthrough_o,
     input 		        ed_rx_st0_passthrough_i,
     input 		        ed_rx_st1_passthrough_i,
     input 		        ed_rx_st2_passthrough_i,
     input 		        ed_rx_st3_passthrough_i

);

// declarations

logic 		rst_controller_reset_out_reset;
logic [2:0]   	pio_rx_bar;
logic         	pio_rx_eop;
logic [127:0] 	pio_rx_header;
logic [DATA_WIDTH-1:0]	pio_rx_payload;
logic [PFNUM_WIDTH-1:0] pio_rx_pfnum;
logic         	pio_rx_sop;
logic         	pio_rx_valid;
logic         	pio_rx_vfactive;
logic [VFNUM_WIDTH-1:0] pio_rx_vfnum;

logic [9:0]  	for_rxcrdt_tlp_len;
logic        	for_rxcrdt_hdr_valid;
logic        	for_rxcrdt_hdr_is_rd;
logic        	for_rxcrdt_hdr_is_wr;

logic [7:0]     default_config_rx_bus_number;
logic [4:0]     default_config_rx_device_number;
logic [2:0]     default_config_rx_function_number;
logic [7:0]     pio_rx_bus_number;
logic [4:0]     pio_rx_device_number;
logic [2:0]     pio_rx_function_number;

logic         	pio_txc_ready;
logic         	pio_rx_ready;
logic [127:0]   pio_txc_header;
logic 		pio_txc_eop;
logic 		pio_txc_sop;
logic 		pio_txc_valid;

logic           tx_hdr_fifo_rreq ;
logic           tx_hdr_fifo_empty ;
logic  [96:0]   tx_hdr_fifo_rdata ;
logic  [8:0]    cplram_rd_addr ;
logic  [BAM_DATAWIDTH+1:0]  cplram_rd_data ;
logic           cpl_cmd_fifo_rdreq ;
logic  [80:0]   cpl_cmd_fifo_rddata ;
logic           cpl_cmd_fifo_empty ;
logic           cpl_ram_rdreq ; 
logic           avmm_read_data_valid ;
logic  [BAM_DATAWIDTH:0]    cplram_read_data ;


logic [BAM_DATAWIDTH-1:0]   pio_txc_payload;


// mm_interconnect <--> mem0
logic           mm_interconnect_0_mem0_s1_chipselect;        // mm_interconnect_0:MEM0_s1_chipselect -> MEM0:chipselect
logic  [1023:0] mm_interconnect_0_mem0_s1_readdata;          // MEM0:readdata -> mm_interconnect_0:MEM0_s1_readdata
logic     [7:0] mm_interconnect_0_mem0_s1_address;           // mm_interconnect_0:MEM0_s1_address -> MEM0:address
logic   [127:0] mm_interconnect_0_mem0_s1_byteenable;        // mm_interconnect_0:MEM0_s1_byteenable -> MEM0:byteenable
logic           mm_interconnect_0_mem0_s1_write;             // mm_interconnect_0:MEM0_s1_write -> MEM0:write
logic  [1023:0] mm_interconnect_0_mem0_s1_writedata;         // mm_interconnect_0:MEM0_s1_writedata -> MEM0:writedata
logic           mm_interconnect_0_mem0_s1_clken;             // mm_interconnect_0:MEM0_s1_clken -> MEM0:clken

//pio <--> mm_interconnect
logic  [1023:0] pio0_pio_master_readdata;                    // mm_interconnect_0:pio0_pio_master_readdata -> pio0:pio_readdata_i
logic           pio0_pio_master_waitrequest;                 // mm_interconnect_0:pio0_pio_master_waitrequest -> pio0:pio_waitrequest_i
logic    [63:0] pio0_pio_master_address;                     // pio0:pio_address_o -> mm_interconnect_0:pio0_pio_master_address
logic           pio0_pio_master_read;                        // pio0:pio_read_o -> mm_interconnect_0:pio0_pio_master_read
logic   [127:0] pio0_pio_master_byteenable;                  // pio0:pio_byteenable_o -> mm_interconnect_0:pio0_pio_master_byteenable
logic           pio0_pio_master_readdatavalid;               // mm_interconnect_0:pio0_pio_master_readdatavalid -> pio0:pio_readdatavalid_i
logic     [1:0] pio0_pio_master_response;                    // mm_interconnect_0:pio0_pio_master_response -> pio0:pio_response_i
logic           pio0_pio_master_write;                       // pio0:pio_write_o -> mm_interconnect_0:pio0_pio_master_write
logic  [1023:0] pio0_pio_master_writedata;                   // pio0:pio_writedata_o -> mm_interconnect_0:pio0_pio_master_writedata
logic     [3:0] pio0_pio_master_burstcount;                  // pio0:pio_burstcount_o -> mm_interconnect_0:pio0_pio_master_burstcount

logic pio_rst_n;
logic pio_clk;

    assign pio_clk = Clk_i;

always_ff@(posedge pio_clk)
begin
	pio_rst_n <= Rstn_i;
end


    //assign pio_rst_n = Rstn_i;

assign pio_rx_pfnum 	= 2'h1;//2'b0;
assign pio_rx_vfactive  = 1'b0;
assign pio_rx_vfnum     = {VFNUM_WIDTH{1'b0}};

assign   default_config_rx_bus_number		=  ed_rx_bus_number;
assign   default_config_rx_device_number	=  ed_rx_device_number;
assign   default_config_rx_function_number	=  ed_rx_function_number;
assign   pio_rx_bus_number			=  ed_rx_bus_number;
assign   pio_rx_device_number			=  ed_rx_device_number;
assign   pio_rx_function_number			=  ed_rx_st0_pfnum_i | ed_rx_st1_pfnum_i  | ed_rx_st2_pfnum_i  | ed_rx_st3_pfnum_i ;

//--default config

     logic  [2:0]                default_config_rx_st0_bar_o;      
     logic  [2:0]                default_config_rx_st1_bar_o;      
     logic  [2:0]                default_config_rx_st2_bar_o;      
     logic  [2:0]                default_config_rx_st3_bar_o;      
     logic  			 default_config_rx_st0_eop_o;      
     logic                       default_config_rx_st1_eop_o;      
     logic                       default_config_rx_st2_eop_o;      
     logic                       default_config_rx_st3_eop_o;      
     logic  [127:0]              default_config_rx_st0_header_o;   
     logic  [127:0]              default_config_rx_st1_header_o;   
     logic  [127:0]              default_config_rx_st2_header_o;   
     logic  [127:0]              default_config_rx_st3_header_o;   
     logic  [255:0]              default_config_rx_st0_payload_o;  
     logic  [255:0]          	 default_config_rx_st1_payload_o;  
     logic  [255:0]          	 default_config_rx_st2_payload_o;  
     logic  [255:0]          	 default_config_rx_st3_payload_o;  
     logic   		         default_config_rx_st0_sop_o;      
     logic                       default_config_rx_st1_sop_o;      
     logic                       default_config_rx_st2_sop_o;      
     logic                       default_config_rx_st3_sop_o;      
     logic  			 default_config_rx_st0_hvalid_o;   
     logic                       default_config_rx_st1_hvalid_o;   
     logic                       default_config_rx_st2_hvalid_o;   
     logic                       default_config_rx_st3_hvalid_o;   
     logic                       default_config_rx_st0_dvalid_o;   
     logic                       default_config_rx_st1_dvalid_o;   
     logic                       default_config_rx_st2_dvalid_o;   
     logic                       default_config_rx_st3_dvalid_o;   
     logic                       default_config_rx_st0_pvalid_o;   
     logic                       default_config_rx_st1_pvalid_o;   
     logic                       default_config_rx_st2_pvalid_o;   
     logic                       default_config_rx_st3_pvalid_o;   
     logic  [2:0]	         default_config_rx_st0_empty_o;    
     logic  [2:0]                default_config_rx_st1_empty_o;    
     logic  [2:0]                default_config_rx_st2_empty_o;    
     logic  [2:0]                default_config_rx_st3_empty_o;    
     logic  [PFNUM_WIDTH-1:0]    default_config_rx_st0_pfnum_o;         
     logic  [PFNUM_WIDTH-1:0]    default_config_rx_st1_pfnum_o;    
     logic  [PFNUM_WIDTH-1:0]    default_config_rx_st2_pfnum_o;    
     logic  [PFNUM_WIDTH-1:0]    default_config_rx_st3_pfnum_o;    
     logic  [31:0]               default_config_rx_st0_tlp_prfx_o; 
     logic  [31:0]               default_config_rx_st1_tlp_prfx_o; 
     logic  [31:0]               default_config_rx_st2_tlp_prfx_o; 
     logic  [31:0]               default_config_rx_st3_tlp_prfx_o; 
     logic  [7:0]		 default_config_rx_st0_data_parity_o;
     logic  [3:0]		 default_config_rx_st0_hdr_parity_o;
     logic  			 default_config_rx_st0_tlp_prfx_parity_o;
     logic  [11:0] 		 default_config_rx_st0_rssai_prefix_o;
     logic  			 default_config_rx_st0_rssai_prefix_parity_o;
     logic  			 default_config_rx_st0_vfactive_o;
     logic  [10:0] 		 default_config_rx_st0_vfnum_o;
     logic  [2:0]  		 default_config_rx_st0_chnum_o;
     logic  			 default_config_rx_st0_misc_parity_o;
     logic  [7:0]		 default_config_rx_st1_data_parity_o;
     logic  [3:0]		 default_config_rx_st1_hdr_parity_o;
     logic  			 default_config_rx_st1_tlp_prfx_parity_o;
     logic  [11:0] 		 default_config_rx_st1_rssai_prefix_o;
     logic  			 default_config_rx_st1_rssai_prefix_parity_o;
     logic  			 default_config_rx_st1_vfactive_o;
     logic  [10:0] 		 default_config_rx_st1_vfnum_o;
     logic  [2:0]  		 default_config_rx_st1_chnum_o;
     logic  			 default_config_rx_st1_misc_parity_o;
     logic  [7:0]		 default_config_rx_st2_data_parity_o;
     logic  [3:0]		 default_config_rx_st2_hdr_parity_o;
     logic  			 default_config_rx_st2_tlp_prfx_parity_o;
     logic  [11:0] 		 default_config_rx_st2_rssai_prefix_o;
     logic  			 default_config_rx_st2_rssai_prefix_parity_o;
     logic  			 default_config_rx_st2_vfactive_o;
     logic  [10:0] 		 default_config_rx_st2_vfnum_o;
     logic  [2:0]  		 default_config_rx_st2_chnum_o;
     logic  			 default_config_rx_st2_misc_parity_o;
     logic  [7:0]		 default_config_rx_st3_data_parity_o;
     logic  [3:0]		 default_config_rx_st3_hdr_parity_o;
     logic  			 default_config_rx_st3_tlp_prfx_parity_o;
     logic  [11:0] 		 default_config_rx_st3_rssai_prefix_o;
     logic  			 default_config_rx_st3_rssai_prefix_parity_o;
     logic  			 default_config_rx_st3_vfactive_o;
     logic  [10:0] 		 default_config_rx_st3_vfnum_o;
     logic  [2:0]  		 default_config_rx_st3_chnum_o;
     logic  			 default_config_rx_st3_misc_parity_o;
     logic  		         default_config_rx_st0_passthrough_o;
     logic  		         default_config_rx_st1_passthrough_o;
     logic  		         default_config_rx_st2_passthrough_o;
     logic  		         default_config_rx_st3_passthrough_o;
     logic                       default_config_rx_st_ready_i;     

//     logic [7:0]		 default_config_rx_bus_number;
//     logic [4:0]		 default_config_rx_device_number;
//     logic [2:0]		 default_config_rx_function_number;
	logic default_config_tx_st0_passthrough_i_reg1 			;
	logic default_config_tx_st0_passthrough_i_reg2 			;
	logic default_config_tx_st0_passthrough_i_reg3 			;
	logic default_config_tx_st0_passthrough_i_reg4 			;
	logic default_config_tx_st0_passthrough_i_reg5 			;
//--tx

     logic                       default_config_tx_st0_eop_i;   
     logic                       default_config_tx_st1_eop_i;  
     logic                       default_config_tx_st2_eop_i;  
     logic                       default_config_tx_st3_eop_i;  
     logic [127:0]               default_config_tx_st0_header_i;       
     logic [127:0]               default_config_tx_st1_header_i;      
     logic [127:0]               default_config_tx_st2_header_i;      
     logic [127:0]               default_config_tx_st3_header_i;      
     logic [31:0]                default_config_tx_st0_prefix_i;       
     logic [31:0]                default_config_tx_st1_prefix_i;      
     logic [31:0]                default_config_tx_st2_prefix_i;      
     logic [31:0]                default_config_tx_st3_prefix_i;          
     logic [255:0]   		 default_config_tx_st0_payload_i;      
     logic [255:0]   		 default_config_tx_st1_payload_i;     
     logic [255:0]   		 default_config_tx_st2_payload_i;     
     logic [255:0]   		 default_config_tx_st3_payload_i;     
     logic                       default_config_tx_st0_sop_i;   
     logic                       default_config_tx_st1_sop_i;  
     logic                       default_config_tx_st2_sop_i;  
     logic                       default_config_tx_st3_sop_i;  
     logic                       default_config_tx_st0_dvalid_i; 
     logic                       default_config_tx_st1_dvalid_i;
     logic                       default_config_tx_st2_dvalid_i;
     logic                       default_config_tx_st3_dvalid_i;
     logic                       default_config_tx_st0_pvalid_i;
     logic                       default_config_tx_st1_pvalid_i;
     logic                       default_config_tx_st2_pvalid_i;
     logic                       default_config_tx_st3_pvalid_i;
     logic                       default_config_tx_st0_hvalid_i;
     logic                       default_config_tx_st1_hvalid_i;
     logic                       default_config_tx_st2_hvalid_i;
     logic                       default_config_tx_st3_hvalid_i;
    logic [7:0]   		 default_config_tx_st0_data_parity;
    logic [3:0]        		 default_config_tx_st0_hdr_parity;
    logic    			 default_config_tx_st0_prefix_parity;
    logic [11:0]       		 default_config_tx_st0_RSSAI_prefix;
    logic              		 default_config_tx_st0_RSSAI_prefix_parity;
    logic              		 default_config_tx_st0_vfactive;
    logic [10:0]       		 default_config_tx_st0_vfnum ;
    logic [2:0]        		 default_config_tx_st0_pfnum;
    logic              		 default_config_tx_st0_chnum;
    logic [2:0]        		 default_config_tx_st0_empty; 
    logic              	 	 default_config_tx_st0_misc_parity;
    logic [7:0]   	 	 default_config_tx_st1_data_parity;
    logic [3:0]        		 default_config_tx_st1_hdr_parity;
    logic    			 default_config_tx_st1_prefix_parity;
    logic [11:0]       		 default_config_tx_st1_RSSAI_prefix;
    logic              		 default_config_tx_st1_RSSAI_prefix_parity;
    logic              		 default_config_tx_st1_vfactive;
    logic [10:0]       		 default_config_tx_st1_vfnum ;
    logic [2:0]        		 default_config_tx_st1_pfnum;
    logic              		 default_config_tx_st1_chnum;
    logic [2:0]        		 default_config_tx_st1_empty; 
    logic              		 default_config_tx_st1_misc_parity;
    logic [7:0]        		 default_config_tx_st2_data_parity;
    logic [3:0]        		 default_config_tx_st2_hdr_parity;
    logic    	       		 default_config_tx_st2_prefix_parity;
    logic [11:0]       		 default_config_tx_st2_RSSAI_prefix;
    logic              		 default_config_tx_st2_RSSAI_prefix_parity;
    logic              		 default_config_tx_st2_vfactive;
    logic [10:0]       		 default_config_tx_st2_vfnum ;
    logic [2:0]        		 default_config_tx_st2_pfnum;
    logic              		 default_config_tx_st2_chnum;
    logic [2:0]        		 default_config_tx_st2_empty; 
    logic              		 default_config_tx_st2_misc_parity;
    logic [7:0]        		 default_config_tx_st3_data_parity;
    logic [3:0]        		 default_config_tx_st3_hdr_parity;
    logic    	       		 default_config_tx_st3_prefix_parity;
    logic [11:0]       		 default_config_tx_st3_RSSAI_prefix;
    logic              		 default_config_tx_st3_RSSAI_prefix_parity;
    logic              		 default_config_tx_st3_vfactive;
    logic [10:0]       		 default_config_tx_st3_vfnum ;
    logic [2:0]        		 default_config_tx_st3_pfnum;
    logic              		 default_config_tx_st3_chnum;
    logic [2:0]        		 default_config_tx_st3_empty; 
    logic              		 default_config_tx_st3_misc_parity;
     logic 		         default_config_tx_st0_passthrough_i;
     logic 		         default_config_tx_st1_passthrough_i;
     logic 		         default_config_tx_st2_passthrough_i;
     logic 		         default_config_tx_st3_passthrough_i;
     logic                       default_config_tx_st_ready_o;        

//--pio

     logic  [2:0]                pio_rx_st0_bar_o;      
//     logic  [2:0]                pio_rx_st0_bar_o;      
     logic  [2:0]                pio_rx_st1_bar_o;      
     logic  [2:0]                pio_rx_st2_bar_o;      
     logic  [2:0]                pio_rx_st3_bar_o;      
     logic  			 pio_rx_st0_eop_o;      
     logic                       pio_rx_st1_eop_o;      
     logic                       pio_rx_st2_eop_o;      
     logic                       pio_rx_st3_eop_o;      
     logic  [127:0]              pio_rx_st0_header_o;   
     logic  [127:0]              pio_rx_st1_header_o;   
     logic  [127:0]              pio_rx_st2_header_o;   
     logic  [127:0]              pio_rx_st3_header_o;   
     logic  [255:0]              pio_rx_st0_payload_o;  
     logic  [255:0]          	 pio_rx_st1_payload_o;  
     logic  [255:0]          	 pio_rx_st2_payload_o;  
     logic  [255:0]          	 pio_rx_st3_payload_o;  
     logic   		         pio_rx_st0_sop_o;      
     logic                       pio_rx_st1_sop_o;      
     logic                       pio_rx_st2_sop_o;      
     logic                       pio_rx_st3_sop_o;      
     logic  			 pio_rx_st0_hvalid_o;   
     logic                       pio_rx_st1_hvalid_o;   
     logic                       pio_rx_st2_hvalid_o;   
     logic                       pio_rx_st3_hvalid_o;   
     logic                       pio_rx_st0_dvalid_o;   
     logic                       pio_rx_st1_dvalid_o;   
     logic                       pio_rx_st2_dvalid_o;   
     logic                       pio_rx_st3_dvalid_o;   
     logic                       pio_rx_st0_pvalid_o;   
     logic                       pio_rx_st1_pvalid_o;   
     logic                       pio_rx_st2_pvalid_o;   
     logic                       pio_rx_st3_pvalid_o;   
     logic  [2:0]	         pio_rx_st0_empty_o;    
     logic  [2:0]                pio_rx_st1_empty_o;    
     logic  [2:0]                pio_rx_st2_empty_o;    
     logic  [2:0]                pio_rx_st3_empty_o;    
     logic  [PFNUM_WIDTH-1:0]    pio_rx_st0_pfnum_o;         
     logic  [PFNUM_WIDTH-1:0]    pio_rx_st1_pfnum_o;    
     logic  [PFNUM_WIDTH-1:0]    pio_rx_st2_pfnum_o;    
     logic  [PFNUM_WIDTH-1:0]    pio_rx_st3_pfnum_o;    
     logic  [31:0]               pio_rx_st0_tlp_prfx_o; 
     logic  [31:0]               pio_rx_st1_tlp_prfx_o; 
     logic  [31:0]               pio_rx_st2_tlp_prfx_o; 
     logic  [31:0]               pio_rx_st3_tlp_prfx_o; 
     logic  [7:0]		 pio_rx_st0_data_parity_o;
     logic  [3:0]		 pio_rx_st0_hdr_parity_o;
     logic  			 pio_rx_st0_tlp_prfx_parity_o;
     logic  [11:0] 		 pio_rx_st0_rssai_prefix_o;
     logic  			 pio_rx_st0_rssai_prefix_parity_o;
     logic  			 pio_rx_st0_vfactive_o;
     logic  [10:0] 		 pio_rx_st0_vfnum_o;
     logic  [2:0]  		 pio_rx_st0_chnum_o;
     logic  			 pio_rx_st0_misc_parity_o;
     logic  [7:0]		 pio_rx_st1_data_parity_o;
     logic  [3:0]		 pio_rx_st1_hdr_parity_o;
     logic  			 pio_rx_st1_tlp_prfx_parity_o;
     logic  [11:0] 		 pio_rx_st1_rssai_prefix_o;
     logic  			 pio_rx_st1_rssai_prefix_parity_o;
     logic  			 pio_rx_st1_vfactive_o;
     logic  [10:0] 		 pio_rx_st1_vfnum_o;
     logic  [2:0]  		 pio_rx_st1_chnum_o;
     logic  			 pio_rx_st1_misc_parity_o;
     logic  [7:0]		 pio_rx_st2_data_parity_o;
     logic  [3:0]		 pio_rx_st2_hdr_parity_o;
     logic  			 pio_rx_st2_tlp_prfx_parity_o;
     logic  [11:0] 		 pio_rx_st2_rssai_prefix_o;
     logic  			 pio_rx_st2_rssai_prefix_parity_o;
     logic  			 pio_rx_st2_vfactive_o;
     logic  [10:0] 		 pio_rx_st2_vfnum_o;
     logic  [2:0]  		 pio_rx_st2_chnum_o;
     logic  			 pio_rx_st2_misc_parity_o;
     logic  [7:0]		 pio_rx_st3_data_parity_o;
     logic  [3:0]		 pio_rx_st3_hdr_parity_o;
     logic  			 pio_rx_st3_tlp_prfx_parity_o;
     logic  [11:0] 		 pio_rx_st3_rssai_prefix_o;
     logic  			 pio_rx_st3_rssai_prefix_parity_o;
     logic  			 pio_rx_st3_vfactive_o;
     logic  [10:0] 		 pio_rx_st3_vfnum_o;
     logic  [2:0]  		 pio_rx_st3_chnum_o;
     logic  			 pio_rx_st3_misc_parity_o;
     logic  		         pio_rx_st0_passthrough_o;
     logic  		         pio_rx_st1_passthrough_o;
     logic  		         pio_rx_st2_passthrough_o;
     logic  		         pio_rx_st3_passthrough_o;
     logic                       pio_rx_st_ready_i;     
//     logic [7:0]		 pio_rx_bus_number;
//     logic [4:0]		 pio_rx_device_number;
//     logic [2:0]		 pio_rx_function_number;

//--tx

     logic                     pio_tx_st0_eop_i;   
     logic                     pio_tx_st1_eop_i;  
     logic                     pio_tx_st2_eop_i;  
     logic                     pio_tx_st3_eop_i;  
     logic [127:0]             pio_tx_st0_header_i;       
     logic [127:0]             pio_tx_st1_header_i;      
     logic [127:0]             pio_tx_st2_header_i;      
     logic [127:0]             pio_tx_st3_header_i;      
     logic [31:0]              pio_tx_st0_prefix_i;       
     logic [31:0]              pio_tx_st1_prefix_i;      
     logic [31:0]              pio_tx_st2_prefix_i;      
     logic [31:0]              pio_tx_st3_prefix_i;          
     logic [255:0]   	       pio_tx_st0_payload_i;      
     logic [255:0]   	       pio_tx_st1_payload_i;     
     logic [255:0]   	       pio_tx_st2_payload_i;     
     logic [255:0]   	       pio_tx_st3_payload_i;     
     logic                     pio_tx_st0_sop_i;   
     logic                     pio_tx_st1_sop_i;  
     logic                     pio_tx_st2_sop_i;  
     logic                     pio_tx_st3_sop_i;  
     logic                     pio_tx_st0_dvalid_i; 
     logic                     pio_tx_st1_dvalid_i;
     logic                     pio_tx_st2_dvalid_i;
     logic                     pio_tx_st3_dvalid_i;
     logic                     pio_tx_st0_pvalid_i;
     logic                     pio_tx_st1_pvalid_i;
     logic                     pio_tx_st2_pvalid_i;
     logic                     pio_tx_st3_pvalid_i;
     logic                     pio_tx_st0_hvalid_i;
     logic                     pio_tx_st1_hvalid_i;
     logic                     pio_tx_st2_hvalid_i;
     logic                     pio_tx_st3_hvalid_i;
    logic [7:0]        pio_tx_st0_data_parity;
    logic [3:0]        pio_tx_st0_hdr_parity;
    logic    	       pio_tx_st0_prefix_parity;
    logic [11:0]       pio_tx_st0_RSSAI_prefix;
    logic              pio_tx_st0_RSSAI_prefix_parity;
    logic              pio_tx_st0_vfactive;
    logic [10:0]       pio_tx_st0_vfnum ;
    logic [2:0]        pio_tx_st0_pfnum;
    logic              pio_tx_st0_chnum;
    logic [2:0]        pio_tx_st0_empty; 
    logic              pio_tx_st0_misc_parity;
    logic [7:0]        pio_tx_st1_data_parity;
    logic [3:0]        pio_tx_st1_hdr_parity;
    logic    	       pio_tx_st1_prefix_parity;
    logic [11:0]       pio_tx_st1_RSSAI_prefix;
    logic              pio_tx_st1_RSSAI_prefix_parity;
    logic              pio_tx_st1_vfactive;
    logic [10:0]       pio_tx_st1_vfnum ;
    logic [2:0]        pio_tx_st1_pfnum;
    logic              pio_tx_st1_chnum;
    logic [2:0]        pio_tx_st1_empty; 
    logic              pio_tx_st1_misc_parity;
    logic [7:0]        pio_tx_st2_data_parity;
    logic [3:0]        pio_tx_st2_hdr_parity;
    logic    	       pio_tx_st2_prefix_parity;
    logic [11:0]       pio_tx_st2_RSSAI_prefix;
    logic              pio_tx_st2_RSSAI_prefix_parity;
    logic              pio_tx_st2_vfactive;
    logic [10:0]       pio_tx_st2_vfnum ;
    logic [2:0]        pio_tx_st2_pfnum;
    logic              pio_tx_st2_chnum;
    logic [2:0]        pio_tx_st2_empty; 
    logic              pio_tx_st2_misc_parity;
    logic [7:0]        pio_tx_st3_data_parity;
    logic [3:0]        pio_tx_st3_hdr_parity;
    logic    	       pio_tx_st3_prefix_parity;
    logic [11:0]       pio_tx_st3_RSSAI_prefix;
    logic              pio_tx_st3_RSSAI_prefix_parity;
    logic              pio_tx_st3_vfactive;
    logic [10:0]       pio_tx_st3_vfnum ;
    logic [2:0]        pio_tx_st3_pfnum;
    logic              pio_tx_st3_chnum;
    logic [2:0]        pio_tx_st3_empty; 
    logic              pio_tx_st3_misc_parity;
    logic 	       pio_tx_st0_passthrough_i;
    logic 	       pio_tx_st1_passthrough_i;
    logic 	       pio_tx_st2_passthrough_i;
    logic 	       pio_tx_st3_passthrough_i;
    logic              pio_tx_st_ready_o;        


logic [2:0]                   default_config_rx_bar;
logic                         default_config_rx_sop;
logic                         default_config_rx_eop;
logic [127:0]                 default_config_rx_header;
logic [BAM_DATAWIDTH-1:0]     default_config_rx_payload;
logic                         default_config_rx_valid;
logic			      default_config_rx_st_ready_o;
logic			      default_config_tx_st_ready_i;
logic                         default_config_txc_eop;
logic [127:0]                 default_config_txc_header;
logic [BAM_DATAWIDTH-1:0]     default_config_txc_payload;
logic                         default_config_txc_sop;
logic                         default_config_txc_valid;
// to credit module
logic [9:0] 	          dc_hdr_len_o;
logic 	                  dc_hdr_valid_o;
logic 	                  dc_hdr_is_rd_o;
logic 	                  dc_hdr_is_rd_with_data_o;
logic  	                  dc_hdr_is_wr_o; 
logic 	                  dc_bam_rx_signal_ready_o;
logic 	                  dc_tx_hdr_valid_o ; 


logic [127:0] default_config_rx_st0_header_update;
logic [127:0] default_config_rx_st1_header_update;
logic [127:0] default_config_rx_st2_header_update;
logic [127:0] default_config_rx_st3_header_update;


logic [127:0] default_config_tx_st_header_update;
logic [127:0] default_config_tx_st0_header_update;
logic [127:0] default_config_tx_st1_header_update;
logic [127:0] default_config_tx_st2_header_update;
logic [127:0] default_config_tx_st3_header_update;

logic dc_hdr_is_wr_no_data_o      ;
logic dc_hdr_is_cpl_no_data_o     ;
logic dc_hdr_is_cpl_o             ;

assign    pio_tx_st0_passthrough_i = 1'b0;
assign    pio_tx_st1_passthrough_i = 1'b0;
assign    pio_tx_st2_passthrough_i = 1'b0;
assign    pio_tx_st3_passthrough_i = 1'b0;

assign default_config_rx_st0_header_update = {default_config_rx_st0_header_o[31:0],default_config_rx_st0_header_o[63:32],default_config_rx_st0_header_o[95:64],default_config_rx_st0_header_o[127:96]};
assign default_config_rx_st1_header_update = {default_config_rx_st1_header_o[31:0],default_config_rx_st1_header_o[63:32],default_config_rx_st1_header_o[95:64],default_config_rx_st1_header_o[127:96]};
assign default_config_rx_st2_header_update = {default_config_rx_st2_header_o[31:0],default_config_rx_st2_header_o[63:32],default_config_rx_st2_header_o[95:64],default_config_rx_st2_header_o[127:96]};
assign default_config_rx_st3_header_update = {default_config_rx_st3_header_o[31:0],default_config_rx_st3_header_o[63:32],default_config_rx_st3_header_o[95:64],default_config_rx_st3_header_o[127:96]};

assign   {default_config_tx_st_header_update[31:0],default_config_tx_st_header_update[63:32],default_config_tx_st_header_update[95:64],default_config_tx_st_header_update[127:96]} =  default_config_txc_header ;                              	

// pf checker module for switching packet between pio and default config

//--both
generate if(ENABLE_BOTH_DEFAULT_CONFIG_PIO)
begin: PF_CHECKER_BOTH
intel_cxl_pf_checker pf_checker_inst(
		.clk                                          (       pio_clk                                      ),
		.rstn                                         (       pio_rst_n                                    ),
		.ed_rx_st0_bar_i                              (       ed_rx_st0_bar_i                              ),
		.ed_rx_st1_bar_i                              (       ed_rx_st1_bar_i                              ),
		.ed_rx_st2_bar_i                              (       ed_rx_st2_bar_i                              ),
		.ed_rx_st3_bar_i                              (       ed_rx_st3_bar_i                              ),
		.ed_rx_st0_eop_i                              (       ed_rx_st0_eop_i                              ),
		.ed_rx_st1_eop_i                              (       ed_rx_st1_eop_i                              ),
		.ed_rx_st2_eop_i                              (       ed_rx_st2_eop_i                              ),
		.ed_rx_st3_eop_i                              (       ed_rx_st3_eop_i                              ),
		.ed_rx_st0_header_i                           (       ed_rx_st0_header_i                           ),
		.ed_rx_st1_header_i                           (       ed_rx_st1_header_i                           ),
		.ed_rx_st2_header_i                           (       ed_rx_st2_header_i                           ),
		.ed_rx_st3_header_i                           (       ed_rx_st3_header_i                           ),
		.ed_rx_st0_payload_i                          (       ed_rx_st0_payload_i                          ),
		.ed_rx_st1_payload_i                          (       ed_rx_st1_payload_i                          ),
		.ed_rx_st2_payload_i                          (       ed_rx_st2_payload_i                          ),
		.ed_rx_st3_payload_i                          (       ed_rx_st3_payload_i                          ),
		.ed_rx_st0_sop_i                              (       ed_rx_st0_sop_i                              ),
		.ed_rx_st1_sop_i                              (       ed_rx_st1_sop_i                              ),
		.ed_rx_st2_sop_i                              (       ed_rx_st2_sop_i                              ),
		.ed_rx_st3_sop_i                              (       ed_rx_st3_sop_i                              ),
		.ed_rx_st0_hvalid_i                           (       ed_rx_st0_hvalid_i                           ),
		.ed_rx_st1_hvalid_i                           (       ed_rx_st1_hvalid_i                           ),
		.ed_rx_st2_hvalid_i                           (       ed_rx_st2_hvalid_i                           ),
		.ed_rx_st3_hvalid_i                           (       ed_rx_st3_hvalid_i                           ),
		.ed_rx_st0_dvalid_i                           (       ed_rx_st0_dvalid_i                           ),
		.ed_rx_st1_dvalid_i                           (       ed_rx_st1_dvalid_i                           ),
		.ed_rx_st2_dvalid_i                           (       ed_rx_st2_dvalid_i                           ),
		.ed_rx_st3_dvalid_i                           (       ed_rx_st3_dvalid_i                           ),
		.ed_rx_st0_pvalid_i                           (       ed_rx_st0_pvalid_i                           ),
		.ed_rx_st1_pvalid_i                           (       ed_rx_st1_pvalid_i                           ),
		.ed_rx_st2_pvalid_i                           (       ed_rx_st2_pvalid_i                           ),
		.ed_rx_st3_pvalid_i                           (       ed_rx_st3_pvalid_i                           ),
		.ed_rx_st0_empty_i                            (       ed_rx_st0_empty_i                            ),
		.ed_rx_st1_empty_i                            (       ed_rx_st1_empty_i                            ),
		.ed_rx_st2_empty_i                            (       ed_rx_st2_empty_i                            ),
		.ed_rx_st3_empty_i                            (       ed_rx_st3_empty_i                            ),
		.ed_rx_st0_pfnum_i                            (       ed_rx_st0_pfnum_i                            ),
		.ed_rx_st1_pfnum_i                            (       ed_rx_st1_pfnum_i                            ),
		.ed_rx_st2_pfnum_i                            (       ed_rx_st2_pfnum_i                            ),
		.ed_rx_st3_pfnum_i                            (       ed_rx_st3_pfnum_i                            ),
		.ed_rx_st0_tlp_prfx_i                         (       ed_rx_st0_tlp_prfx_i                         ),
		.ed_rx_st1_tlp_prfx_i                         (       ed_rx_st1_tlp_prfx_i                         ),
		.ed_rx_st2_tlp_prfx_i                         (       ed_rx_st2_tlp_prfx_i                         ),
		.ed_rx_st3_tlp_prfx_i                         (       ed_rx_st3_tlp_prfx_i                         ),
		.ed_rx_st0_data_parity_i                      (       ed_rx_st0_data_parity_i                      ),
		.ed_rx_st0_hdr_parity_i                       (       ed_rx_st0_hdr_parity_i                       ),
		.ed_rx_st0_tlp_prfx_parity_i                  (       ed_rx_st0_tlp_prfx_parity_i                  ),
		.ed_rx_st0_rssai_prefix_i                     (       ed_rx_st0_rssai_prefix_i                     ),
		.ed_rx_st0_rssai_prefix_parity_i              (       ed_rx_st0_rssai_prefix_parity_i              ),
		.ed_rx_st0_vfactive_i                         (       ed_rx_st0_vfactive_i                         ),
		.ed_rx_st0_vfnum_i                            (       ed_rx_st0_vfnum_i                            ),
		.ed_rx_st0_chnum_i                            (       ed_rx_st0_chnum_i                            ),
		.ed_rx_st0_misc_parity_i                      (       ed_rx_st0_misc_parity_i                      ),
		.ed_rx_st1_data_parity_i                      (       ed_rx_st1_data_parity_i                      ),
		.ed_rx_st1_hdr_parity_i                       (       ed_rx_st1_hdr_parity_i                       ),
		.ed_rx_st1_tlp_prfx_parity_i                  (       ed_rx_st1_tlp_prfx_parity_i                  ),
		.ed_rx_st1_rssai_prefix_i                     (       ed_rx_st1_rssai_prefix_i                     ),
		.ed_rx_st1_rssai_prefix_parity_i              (       ed_rx_st1_rssai_prefix_parity_i              ),
		.ed_rx_st1_vfactive_i                         (       ed_rx_st1_vfactive_i                         ),
		.ed_rx_st1_vfnum_i                            (       ed_rx_st1_vfnum_i                            ),
		.ed_rx_st1_chnum_i                            (       ed_rx_st1_chnum_i                            ),
		.ed_rx_st1_misc_parity_i                      (       ed_rx_st1_misc_parity_i                      ),
		.ed_rx_st2_data_parity_i                      (       ed_rx_st2_data_parity_i                      ),
		.ed_rx_st2_hdr_parity_i                       (       ed_rx_st2_hdr_parity_i                       ),
		.ed_rx_st2_tlp_prfx_parity_i                  (       ed_rx_st2_tlp_prfx_parity_i                  ),
		.ed_rx_st2_rssai_prefix_i                     (       ed_rx_st2_rssai_prefix_i                     ),
		.ed_rx_st2_rssai_prefix_parity_i              (       ed_rx_st2_rssai_prefix_parity_i              ),
		.ed_rx_st2_vfactive_i                         (       ed_rx_st2_vfactive_i                         ),
		.ed_rx_st2_vfnum_i                            (       ed_rx_st2_vfnum_i                            ),
		.ed_rx_st2_chnum_i                            (       ed_rx_st2_chnum_i                            ),
		.ed_rx_st2_misc_parity_i                      (       ed_rx_st2_misc_parity_i                      ),
		.ed_rx_st3_data_parity_i                      (       ed_rx_st3_data_parity_i                      ),
		.ed_rx_st3_hdr_parity_i                       (       ed_rx_st3_hdr_parity_i                       ),
		.ed_rx_st3_tlp_prfx_parity_i                  (       ed_rx_st3_tlp_prfx_parity_i                  ),
		.ed_rx_st3_rssai_prefix_i                     (       ed_rx_st3_rssai_prefix_i                     ),
		.ed_rx_st3_rssai_prefix_parity_i              (       ed_rx_st3_rssai_prefix_parity_i              ),
		.ed_rx_st3_vfactive_i                         (       ed_rx_st3_vfactive_i                         ),
		.ed_rx_st3_vfnum_i                            (       ed_rx_st3_vfnum_i                            ),
		.ed_rx_st3_chnum_i                            (       ed_rx_st3_chnum_i                            ),
		.ed_rx_st3_misc_parity_i                      (       ed_rx_st3_misc_parity_i                      ),
		.ed_rx_st0_passthrough_i                      (       ed_rx_st0_passthrough_i                      ),
		.ed_rx_st1_passthrough_i                      (       ed_rx_st1_passthrough_i                      ),
		.ed_rx_st2_passthrough_i                      (       ed_rx_st2_passthrough_i                      ),
		.ed_rx_st3_passthrough_i                      (       ed_rx_st3_passthrough_i                      ),
		.ed_rx_st_ready_o                             (       ed_rx_st_ready_o                             ),
		//--default                                   config  rx                                           
		.default_config_rx_st0_bar_o                  (       default_config_rx_st0_bar_o                  ),
		.default_config_rx_st1_bar_o                  (       default_config_rx_st1_bar_o                  ),
		.default_config_rx_st2_bar_o                  (       default_config_rx_st2_bar_o                  ),
		.default_config_rx_st3_bar_o                  (       default_config_rx_st3_bar_o                  ),
		.default_config_rx_st0_eop_o                  (       default_config_rx_st0_eop_o                  ),
		.default_config_rx_st1_eop_o                  (       default_config_rx_st1_eop_o                  ),
		.default_config_rx_st2_eop_o                  (       default_config_rx_st2_eop_o                  ),
		.default_config_rx_st3_eop_o                  (       default_config_rx_st3_eop_o                  ),
		.default_config_rx_st0_header_o               (       default_config_rx_st0_header_o               ),
		.default_config_rx_st1_header_o               (       default_config_rx_st1_header_o               ),
		.default_config_rx_st2_header_o               (       default_config_rx_st2_header_o               ),
		.default_config_rx_st3_header_o               (       default_config_rx_st3_header_o               ),
		.default_config_rx_st0_payload_o              (       default_config_rx_st0_payload_o              ),
		.default_config_rx_st1_payload_o              (       default_config_rx_st1_payload_o              ),
		.default_config_rx_st2_payload_o              (       default_config_rx_st2_payload_o              ),
		.default_config_rx_st3_payload_o              (       default_config_rx_st3_payload_o              ),
		.default_config_rx_st0_sop_o                  (       default_config_rx_st0_sop_o                  ),
		.default_config_rx_st1_sop_o                  (       default_config_rx_st1_sop_o                  ),
		.default_config_rx_st2_sop_o                  (       default_config_rx_st2_sop_o                  ),
		.default_config_rx_st3_sop_o                  (       default_config_rx_st3_sop_o                  ),
		.default_config_rx_st0_hvalid_o               (       default_config_rx_st0_hvalid_o               ),
		.default_config_rx_st1_hvalid_o               (       default_config_rx_st1_hvalid_o               ),
		.default_config_rx_st2_hvalid_o               (       default_config_rx_st2_hvalid_o               ),
		.default_config_rx_st3_hvalid_o               (       default_config_rx_st3_hvalid_o               ),
		.default_config_rx_st0_dvalid_o               (       default_config_rx_st0_dvalid_o               ),
		.default_config_rx_st1_dvalid_o               (       default_config_rx_st1_dvalid_o               ),
		.default_config_rx_st2_dvalid_o               (       default_config_rx_st2_dvalid_o               ),
		.default_config_rx_st3_dvalid_o               (       default_config_rx_st3_dvalid_o               ),
		.default_config_rx_st0_pvalid_o               (       default_config_rx_st0_pvalid_o               ),
		.default_config_rx_st1_pvalid_o               (       default_config_rx_st1_pvalid_o               ),
		.default_config_rx_st2_pvalid_o               (       default_config_rx_st2_pvalid_o               ),
		.default_config_rx_st3_pvalid_o               (       default_config_rx_st3_pvalid_o               ),
		.default_config_rx_st0_empty_o                (       default_config_rx_st0_empty_o                ),
		.default_config_rx_st1_empty_o                (       default_config_rx_st1_empty_o                ),
		.default_config_rx_st2_empty_o                (       default_config_rx_st2_empty_o                ),
		.default_config_rx_st3_empty_o                (       default_config_rx_st3_empty_o                ),
		.default_config_rx_st0_pfnum_o                (       default_config_rx_st0_pfnum_o                ),
		.default_config_rx_st1_pfnum_o                (       default_config_rx_st1_pfnum_o                ),
		.default_config_rx_st2_pfnum_o                (       default_config_rx_st2_pfnum_o                ),
		.default_config_rx_st3_pfnum_o                (       default_config_rx_st3_pfnum_o                ),
		.default_config_rx_st0_tlp_prfx_o             (       default_config_rx_st0_tlp_prfx_o             ),
		.default_config_rx_st1_tlp_prfx_o             (       default_config_rx_st1_tlp_prfx_o             ),
		.default_config_rx_st2_tlp_prfx_o             (       default_config_rx_st2_tlp_prfx_o             ),
		.default_config_rx_st3_tlp_prfx_o             (       default_config_rx_st3_tlp_prfx_o             ),
		.default_config_rx_st0_data_parity_o          (       default_config_rx_st0_data_parity_o          ),
		.default_config_rx_st0_hdr_parity_o           (       default_config_rx_st0_hdr_parity_o           ),
		.default_config_rx_st0_tlp_prfx_parity_o      (       default_config_rx_st0_tlp_prfx_parity        ),
		.default_config_rx_st0_rssai_prefix_o         (       default_config_rx_st0_rssai_prefix_o         ),
		.default_config_rx_st0_rssai_prefix_parity_o  (       default_config_rx_st0_rssai_prefix_parity_o  ),
		.default_config_rx_st0_vfactive_o             (       default_config_rx_st0_vfactive_o             ),
		.default_config_rx_st0_vfnum_o                (       default_config_rx_st0_vfnum_o                ),
		.default_config_rx_st0_chnum_o                (       default_config_rx_st0_chnum_o                ),
		.default_config_rx_st0_misc_parity_o          (       default_config_rx_st0_misc_parity_o          ),
		.default_config_rx_st1_data_parity_o          (       default_config_rx_st1_data_parity_o          ),
		.default_config_rx_st1_hdr_parity_o           (       default_config_rx_st1_hdr_parity_o           ),
		.default_config_rx_st1_tlp_prfx_parity_o      (       default_config_rx_st1_tlp_prfx_parity        ),
		.default_config_rx_st1_rssai_prefix_o         (       default_config_rx_st1_rssai_prefix_o         ),
		.default_config_rx_st1_rssai_prefix_parity_o  (       default_config_rx_st1_rssai_prefix_parity_o  ),
		.default_config_rx_st1_vfactive_o             (       default_config_rx_st1_vfactive_o             ),
		.default_config_rx_st1_vfnum_o                (       default_config_rx_st1_vfnum_o                ),
		.default_config_rx_st1_chnum_o                (       default_config_rx_st1_chnum_o                ),
		.default_config_rx_st1_misc_parity_o          (       default_config_rx_st1_misc_parity_o          ),
		.default_config_rx_st2_data_parity_o          (       default_config_rx_st2_data_parity_o          ),
		.default_config_rx_st2_hdr_parity_o           (       default_config_rx_st2_hdr_parity_o           ),
		.default_config_rx_st2_tlp_prfx_parity_o      (       default_config_rx_st2_tlp_prfx_parity        ),
		.default_config_rx_st2_rssai_prefix_o         (       default_config_rx_st2_rssai_prefix_o         ),
		.default_config_rx_st2_rssai_prefix_parity_o  (       default_config_rx_st2_rssai_prefix_parity_o  ),
		.default_config_rx_st2_vfactive_o             (       default_config_rx_st2_vfactive_o             ),
		.default_config_rx_st2_vfnum_o                (       default_config_rx_st2_vfnum_o                ),
		.default_config_rx_st2_chnum_o                (       default_config_rx_st2_chnum_o                ),
		.default_config_rx_st2_misc_parity_o          (       default_config_rx_st2_misc_parity_o          ),
		.default_config_rx_st3_data_parity_o          (       default_config_rx_st3_data_parity_o          ),
		.default_config_rx_st3_hdr_parity_o           (       default_config_rx_st3_hdr_parity_o           ),
		.default_config_rx_st3_tlp_prfx_parity_o      (       default_config_rx_st3_tlp_prfx_parity        ),
		.default_config_rx_st3_rssai_prefix_o         (       default_config_rx_st3_rssai_prefix_o         ),
		.default_config_rx_st3_rssai_prefix_parity_o  (       default_config_rx_st3_rssai_prefix_parity_o  ),
		.default_config_rx_st3_vfactive_o             (       default_config_rx_st3_vfactive_o             ),
		.default_config_rx_st3_vfnum_o                (       default_config_rx_st3_vfnum_o                ),
		.default_config_rx_st3_chnum_o                (       default_config_rx_st3_chnum_o                ),
		.default_config_rx_st3_misc_parity_o          (       default_config_rx_st3_misc_parity_o          ),
		.default_config_rx_st0_passthrough_o          (       default_config_rx_st0_passthrough_o          ),
		.default_config_rx_st1_passthrough_o          (       default_config_rx_st1_passthrough_o          ),
		.default_config_rx_st2_passthrough_o          (       default_config_rx_st2_passthrough_o          ),
		.default_config_rx_st3_passthrough_o          (       default_config_rx_st3_passthrough_o          ),
		.default_config_rx_st_ready_i                 (       default_config_rx_st_ready_o                 ),
		//--pio                                       (       //--pio                                      ),
		.pio_rx_st0_bar_o                             (       pio_rx_st0_bar_o                             ),
		.pio_rx_st1_bar_o                             (       pio_rx_st1_bar_o                             ),
		.pio_rx_st2_bar_o                             (       pio_rx_st2_bar_o                             ),
		.pio_rx_st3_bar_o                             (       pio_rx_st3_bar_o                             ),
		.pio_rx_st0_eop_o                             (       pio_rx_st0_eop_o                             ),
		.pio_rx_st1_eop_o                             (       pio_rx_st1_eop_o                             ),
		.pio_rx_st2_eop_o                             (       pio_rx_st2_eop_o                             ),
		.pio_rx_st3_eop_o                             (       pio_rx_st3_eop_o                             ),
		.pio_rx_st0_header_o                          (       pio_rx_st0_header_o                          ),
		.pio_rx_st1_header_o                          (       pio_rx_st1_header_o                          ),
		.pio_rx_st2_header_o                          (       pio_rx_st2_header_o                          ),
		.pio_rx_st3_header_o                          (       pio_rx_st3_header_o                          ),
		.pio_rx_st0_payload_o                         (       pio_rx_st0_payload_o                         ),
		.pio_rx_st1_payload_o                         (       pio_rx_st1_payload_o                         ),
		.pio_rx_st2_payload_o                         (       pio_rx_st2_payload_o                         ),
		.pio_rx_st3_payload_o                         (       pio_rx_st3_payload_o                         ),
		.pio_rx_st0_sop_o                             (       pio_rx_st0_sop_o                             ),
		.pio_rx_st1_sop_o                             (       pio_rx_st1_sop_o                             ),
		.pio_rx_st2_sop_o                             (       pio_rx_st2_sop_o                             ),
		.pio_rx_st3_sop_o                             (       pio_rx_st3_sop_o                             ),
		.pio_rx_st0_hvalid_o                          (       pio_rx_st0_hvalid_o                          ),
		.pio_rx_st1_hvalid_o                          (       pio_rx_st1_hvalid_o                          ),
		.pio_rx_st2_hvalid_o                          (       pio_rx_st2_hvalid_o                          ),
		.pio_rx_st3_hvalid_o                          (       pio_rx_st3_hvalid_o                          ),
		.pio_rx_st0_dvalid_o                          (       pio_rx_st0_dvalid_o                          ),
		.pio_rx_st1_dvalid_o                          (       pio_rx_st1_dvalid_o                          ),
		.pio_rx_st2_dvalid_o                          (       pio_rx_st2_dvalid_o                          ),
		.pio_rx_st3_dvalid_o                          (       pio_rx_st3_dvalid_o                          ),
		.pio_rx_st0_pvalid_o                          (       pio_rx_st0_pvalid_o                          ),
		.pio_rx_st1_pvalid_o                          (       pio_rx_st1_pvalid_o                          ),
		.pio_rx_st2_pvalid_o                          (       pio_rx_st2_pvalid_o                          ),
		.pio_rx_st3_pvalid_o                          (       pio_rx_st3_pvalid_o                          ),
		.pio_rx_st0_empty_o                           (       pio_rx_st0_empty_o                           ),
		.pio_rx_st1_empty_o                           (       pio_rx_st1_empty_o                           ),
		.pio_rx_st2_empty_o                           (       pio_rx_st2_empty_o                           ),
		.pio_rx_st3_empty_o                           (       pio_rx_st3_empty_o                           ),
		.pio_rx_st0_pfnum_o                           (       pio_rx_st0_pfnum_o                           ),
		.pio_rx_st1_pfnum_o                           (       pio_rx_st1_pfnum_o                           ),
		.pio_rx_st2_pfnum_o                           (       pio_rx_st2_pfnum_o                           ),
		.pio_rx_st3_pfnum_o                           (       pio_rx_st3_pfnum_o                           ),
		.pio_rx_st0_tlp_prfx_o                        (       pio_rx_st0_tlp_prfx_o                        ),
		.pio_rx_st1_tlp_prfx_o                        (       pio_rx_st1_tlp_prfx_o                        ),
		.pio_rx_st2_tlp_prfx_o                        (       pio_rx_st2_tlp_prfx_o                        ),
		.pio_rx_st3_tlp_prfx_o                        (       pio_rx_st3_tlp_prfx_o                        ),
		.pio_rx_st0_data_parity_o                     (       pio_rx_st0_data_parity_o                     ),
		.pio_rx_st0_hdr_parity_o                      (       pio_rx_st0_hdr_parity_o                      ),
		.pio_rx_st0_tlp_prfx_parity_o                 (       pio_rx_st0_tlp_prfx_parity_o                 ),
		.pio_rx_st0_rssai_prefix_o                    (       pio_rx_st0_rssai_prefix_o                    ),
		.pio_rx_st0_rssai_prefix_parity_o             (       pio_rx_st0_rssai_prefix_parity_o             ),
		.pio_rx_st0_vfactive_o                        (       pio_rx_st0_vfactive_o                        ),
		.pio_rx_st0_vfnum_o                           (       pio_rx_st0_vfnum_o                           ),
		.pio_rx_st0_chnum_o                           (       pio_rx_st0_chnum_o                           ),
		.pio_rx_st0_misc_parity_o                     (       pio_rx_st0_misc_parity_o                     ),
		.pio_rx_st1_data_parity_o                     (       pio_rx_st1_data_parity_o                     ),
		.pio_rx_st1_hdr_parity_o                      (       pio_rx_st1_hdr_parity_o                      ),
		.pio_rx_st1_tlp_prfx_parity_o                 (       pio_rx_st1_tlp_prfx_parity_o                 ),
		.pio_rx_st1_rssai_prefix_o                    (       pio_rx_st1_rssai_prefix_o                    ),
		.pio_rx_st1_rssai_prefix_parity_o             (       pio_rx_st1_rssai_prefix_parity_o             ),
		.pio_rx_st1_vfactive_o                        (       pio_rx_st1_vfactive_o                        ),
		.pio_rx_st1_vfnum_o                           (       pio_rx_st1_vfnum_o                           ),
		.pio_rx_st1_chnum_o                           (       pio_rx_st1_chnum_o                           ),
		.pio_rx_st1_misc_parity_o                     (       pio_rx_st1_misc_parity_o                     ),
		.pio_rx_st2_data_parity_o                     (       pio_rx_st2_data_parity_o                     ),
		.pio_rx_st2_hdr_parity_o                      (       pio_rx_st2_hdr_parity_o                      ),
		.pio_rx_st2_tlp_prfx_parity_o                 (       pio_rx_st2_tlp_prfx_parity_o                 ),
		.pio_rx_st2_rssai_prefix_o                    (       pio_rx_st2_rssai_prefix_o                    ),
		.pio_rx_st2_rssai_prefix_parity_o             (       pio_rx_st2_rssai_prefix_parity_o             ),
		.pio_rx_st2_vfactive_o                        (       pio_rx_st2_vfactive_o                        ),
		.pio_rx_st2_vfnum_o                           (       pio_rx_st2_vfnum_o                           ),
		.pio_rx_st2_chnum_o                           (       pio_rx_st2_chnum_o                           ),
		.pio_rx_st2_misc_parity_o                     (       pio_rx_st2_misc_parity_o                     ),
		.pio_rx_st3_data_parity_o                     (       pio_rx_st3_data_parity_o                     ),
		.pio_rx_st3_hdr_parity_o                      (       pio_rx_st3_hdr_parity_o                      ),
		.pio_rx_st3_tlp_prfx_parity_o                 (       pio_rx_st3_tlp_prfx_parity_o                 ),
		.pio_rx_st3_rssai_prefix_o                    (       pio_rx_st3_rssai_prefix_o                    ),
		.pio_rx_st3_rssai_prefix_parity_o             (       pio_rx_st3_rssai_prefix_parity_o             ),
		.pio_rx_st3_vfactive_o                        (       pio_rx_st3_vfactive_o                        ),
		.pio_rx_st3_vfnum_o                           (       pio_rx_st3_vfnum_o                           ),
		.pio_rx_st3_chnum_o                           (       pio_rx_st3_chnum_o                           ),
		.pio_rx_st3_misc_parity_o                     (       pio_rx_st3_misc_parity_o                     ),
		.pio_rx_st0_passthrough_o                     (       pio_rx_st0_passthrough_o                     ),
		.pio_rx_st1_passthrough_o                     (       pio_rx_st1_passthrough_o                     ),
		.pio_rx_st2_passthrough_o                     (       pio_rx_st2_passthrough_o                     ),
		.pio_rx_st3_passthrough_o                     (       pio_rx_st3_passthrough_o                     ),
		.pio_rx_st_ready_i                            (       pio_rx_st_ready_i                            )
);	
end
endgenerate
//--pio

generate if(ENABLE_ONLY_PIO)
begin: PF_CHECKER_ONLY_PIO
intel_cxl_pf_checker pf_checker_inst(
		.clk                                          (       pio_clk                                      ),
		.rstn                                         (       pio_rst_n                                    ),
		.ed_rx_st0_bar_i                              (       ed_rx_st0_bar_i                              ),
		.ed_rx_st1_bar_i                              (       ed_rx_st1_bar_i                              ),
		.ed_rx_st2_bar_i                              (       ed_rx_st2_bar_i                              ),
		.ed_rx_st3_bar_i                              (       ed_rx_st3_bar_i                              ),
		.ed_rx_st0_eop_i                              (       ed_rx_st0_eop_i                              ),
		.ed_rx_st1_eop_i                              (       ed_rx_st1_eop_i                              ),
		.ed_rx_st2_eop_i                              (       ed_rx_st2_eop_i                              ),
		.ed_rx_st3_eop_i                              (       ed_rx_st3_eop_i                              ),
		.ed_rx_st0_header_i                           (       ed_rx_st0_header_i                           ),
		.ed_rx_st1_header_i                           (       ed_rx_st1_header_i                           ),
		.ed_rx_st2_header_i                           (       ed_rx_st2_header_i                           ),
		.ed_rx_st3_header_i                           (       ed_rx_st3_header_i                           ),
		.ed_rx_st0_payload_i                          (       ed_rx_st0_payload_i                          ),
		.ed_rx_st1_payload_i                          (       ed_rx_st1_payload_i                          ),
		.ed_rx_st2_payload_i                          (       ed_rx_st2_payload_i                          ),
		.ed_rx_st3_payload_i                          (       ed_rx_st3_payload_i                          ),
		.ed_rx_st0_sop_i                              (       ed_rx_st0_sop_i                              ),
		.ed_rx_st1_sop_i                              (       ed_rx_st1_sop_i                              ),
		.ed_rx_st2_sop_i                              (       ed_rx_st2_sop_i                              ),
		.ed_rx_st3_sop_i                              (       ed_rx_st3_sop_i                              ),
		.ed_rx_st0_hvalid_i                           (       ed_rx_st0_hvalid_i                           ),
		.ed_rx_st1_hvalid_i                           (       ed_rx_st1_hvalid_i                           ),
		.ed_rx_st2_hvalid_i                           (       ed_rx_st2_hvalid_i                           ),
		.ed_rx_st3_hvalid_i                           (       ed_rx_st3_hvalid_i                           ),
		.ed_rx_st0_dvalid_i                           (       ed_rx_st0_dvalid_i                           ),
		.ed_rx_st1_dvalid_i                           (       ed_rx_st1_dvalid_i                           ),
		.ed_rx_st2_dvalid_i                           (       ed_rx_st2_dvalid_i                           ),
		.ed_rx_st3_dvalid_i                           (       ed_rx_st3_dvalid_i                           ),
		.ed_rx_st0_pvalid_i                           (       ed_rx_st0_pvalid_i                           ),
		.ed_rx_st1_pvalid_i                           (       ed_rx_st1_pvalid_i                           ),
		.ed_rx_st2_pvalid_i                           (       ed_rx_st2_pvalid_i                           ),
		.ed_rx_st3_pvalid_i                           (       ed_rx_st3_pvalid_i                           ),
		.ed_rx_st0_empty_i                            (       ed_rx_st0_empty_i                            ),
		.ed_rx_st1_empty_i                            (       ed_rx_st1_empty_i                            ),
		.ed_rx_st2_empty_i                            (       ed_rx_st2_empty_i                            ),
		.ed_rx_st3_empty_i                            (       ed_rx_st3_empty_i                            ),
		.ed_rx_st0_pfnum_i                            (       ed_rx_st0_pfnum_i                            ),
		.ed_rx_st1_pfnum_i                            (       ed_rx_st1_pfnum_i                            ),
		.ed_rx_st2_pfnum_i                            (       ed_rx_st2_pfnum_i                            ),
		.ed_rx_st3_pfnum_i                            (       ed_rx_st3_pfnum_i                            ),
		.ed_rx_st0_tlp_prfx_i                         (       ed_rx_st0_tlp_prfx_i                         ),
		.ed_rx_st1_tlp_prfx_i                         (       ed_rx_st1_tlp_prfx_i                         ),
		.ed_rx_st2_tlp_prfx_i                         (       ed_rx_st2_tlp_prfx_i                         ),
		.ed_rx_st3_tlp_prfx_i                         (       ed_rx_st3_tlp_prfx_i                         ),
		.ed_rx_st0_data_parity_i                      (       ed_rx_st0_data_parity_i                      ),
		.ed_rx_st0_hdr_parity_i                       (       ed_rx_st0_hdr_parity_i                       ),
		.ed_rx_st0_tlp_prfx_parity_i                  (       ed_rx_st0_tlp_prfx_parity_i                  ),
		.ed_rx_st0_rssai_prefix_i                     (       ed_rx_st0_rssai_prefix_i                     ),
		.ed_rx_st0_rssai_prefix_parity_i              (       ed_rx_st0_rssai_prefix_parity_i              ),
		.ed_rx_st0_vfactive_i                         (       ed_rx_st0_vfactive_i                         ),
		.ed_rx_st0_vfnum_i                            (       ed_rx_st0_vfnum_i                            ),
		.ed_rx_st0_chnum_i                            (       ed_rx_st0_chnum_i                            ),
		.ed_rx_st0_misc_parity_i                      (       ed_rx_st0_misc_parity_i                      ),
		.ed_rx_st1_data_parity_i                      (       ed_rx_st1_data_parity_i                      ),
		.ed_rx_st1_hdr_parity_i                       (       ed_rx_st1_hdr_parity_i                       ),
		.ed_rx_st1_tlp_prfx_parity_i                  (       ed_rx_st1_tlp_prfx_parity_i                  ),
		.ed_rx_st1_rssai_prefix_i                     (       ed_rx_st1_rssai_prefix_i                     ),
		.ed_rx_st1_rssai_prefix_parity_i              (       ed_rx_st1_rssai_prefix_parity_i              ),
		.ed_rx_st1_vfactive_i                         (       ed_rx_st1_vfactive_i                         ),
		.ed_rx_st1_vfnum_i                            (       ed_rx_st1_vfnum_i                            ),
		.ed_rx_st1_chnum_i                            (       ed_rx_st1_chnum_i                            ),
		.ed_rx_st1_misc_parity_i                      (       ed_rx_st1_misc_parity_i                      ),
		.ed_rx_st2_data_parity_i                      (       ed_rx_st2_data_parity_i                      ),
		.ed_rx_st2_hdr_parity_i                       (       ed_rx_st2_hdr_parity_i                       ),
		.ed_rx_st2_tlp_prfx_parity_i                  (       ed_rx_st2_tlp_prfx_parity_i                  ),
		.ed_rx_st2_rssai_prefix_i                     (       ed_rx_st2_rssai_prefix_i                     ),
		.ed_rx_st2_rssai_prefix_parity_i              (       ed_rx_st2_rssai_prefix_parity_i              ),
		.ed_rx_st2_vfactive_i                         (       ed_rx_st2_vfactive_i                         ),
		.ed_rx_st2_vfnum_i                            (       ed_rx_st2_vfnum_i                            ),
		.ed_rx_st2_chnum_i                            (       ed_rx_st2_chnum_i                            ),
		.ed_rx_st2_misc_parity_i                      (       ed_rx_st2_misc_parity_i                      ),
		.ed_rx_st3_data_parity_i                      (       ed_rx_st3_data_parity_i                      ),
		.ed_rx_st3_hdr_parity_i                       (       ed_rx_st3_hdr_parity_i                       ),
		.ed_rx_st3_tlp_prfx_parity_i                  (       ed_rx_st3_tlp_prfx_parity_i                  ),
		.ed_rx_st3_rssai_prefix_i                     (       ed_rx_st3_rssai_prefix_i                     ),
		.ed_rx_st3_rssai_prefix_parity_i              (       ed_rx_st3_rssai_prefix_parity_i              ),
		.ed_rx_st3_vfactive_i                         (       ed_rx_st3_vfactive_i                         ),
		.ed_rx_st3_vfnum_i                            (       ed_rx_st3_vfnum_i                            ),
		.ed_rx_st3_chnum_i                            (       ed_rx_st3_chnum_i                            ),
		.ed_rx_st3_misc_parity_i                      (       ed_rx_st3_misc_parity_i                      ),
		.ed_rx_st0_passthrough_i                      (       ed_rx_st0_passthrough_i                      ),
		.ed_rx_st1_passthrough_i                      (       ed_rx_st1_passthrough_i                      ),
		.ed_rx_st2_passthrough_i                      (       ed_rx_st2_passthrough_i                      ),
		.ed_rx_st3_passthrough_i                      (       ed_rx_st3_passthrough_i                      ),
		.ed_rx_st_ready_o                             (       ed_rx_st_ready_o                             ),
		//--pio                                       (       //--pio                                      ),
		.pio_rx_st0_bar_o                             (       pio_rx_st0_bar_o                             ),
		.pio_rx_st1_bar_o                             (       pio_rx_st1_bar_o                             ),
		.pio_rx_st2_bar_o                             (       pio_rx_st2_bar_o                             ),
		.pio_rx_st3_bar_o                             (       pio_rx_st3_bar_o                             ),
		.pio_rx_st0_eop_o                             (       pio_rx_st0_eop_o                             ),
		.pio_rx_st1_eop_o                             (       pio_rx_st1_eop_o                             ),
		.pio_rx_st2_eop_o                             (       pio_rx_st2_eop_o                             ),
		.pio_rx_st3_eop_o                             (       pio_rx_st3_eop_o                             ),
		.pio_rx_st0_header_o                          (       pio_rx_st0_header_o                          ),
		.pio_rx_st1_header_o                          (       pio_rx_st1_header_o                          ),
		.pio_rx_st2_header_o                          (       pio_rx_st2_header_o                          ),
		.pio_rx_st3_header_o                          (       pio_rx_st3_header_o                          ),
		.pio_rx_st0_payload_o                         (       pio_rx_st0_payload_o                         ),
		.pio_rx_st1_payload_o                         (       pio_rx_st1_payload_o                         ),
		.pio_rx_st2_payload_o                         (       pio_rx_st2_payload_o                         ),
		.pio_rx_st3_payload_o                         (       pio_rx_st3_payload_o                         ),
		.pio_rx_st0_sop_o                             (       pio_rx_st0_sop_o                             ),
		.pio_rx_st1_sop_o                             (       pio_rx_st1_sop_o                             ),
		.pio_rx_st2_sop_o                             (       pio_rx_st2_sop_o                             ),
		.pio_rx_st3_sop_o                             (       pio_rx_st3_sop_o                             ),
		.pio_rx_st0_hvalid_o                          (       pio_rx_st0_hvalid_o                          ),
		.pio_rx_st1_hvalid_o                          (       pio_rx_st1_hvalid_o                          ),
		.pio_rx_st2_hvalid_o                          (       pio_rx_st2_hvalid_o                          ),
		.pio_rx_st3_hvalid_o                          (       pio_rx_st3_hvalid_o                          ),
		.pio_rx_st0_dvalid_o                          (       pio_rx_st0_dvalid_o                          ),
		.pio_rx_st1_dvalid_o                          (       pio_rx_st1_dvalid_o                          ),
		.pio_rx_st2_dvalid_o                          (       pio_rx_st2_dvalid_o                          ),
		.pio_rx_st3_dvalid_o                          (       pio_rx_st3_dvalid_o                          ),
		.pio_rx_st0_pvalid_o                          (       pio_rx_st0_pvalid_o                          ),
		.pio_rx_st1_pvalid_o                          (       pio_rx_st1_pvalid_o                          ),
		.pio_rx_st2_pvalid_o                          (       pio_rx_st2_pvalid_o                          ),
		.pio_rx_st3_pvalid_o                          (       pio_rx_st3_pvalid_o                          ),
		.pio_rx_st0_empty_o                           (       pio_rx_st0_empty_o                           ),
		.pio_rx_st1_empty_o                           (       pio_rx_st1_empty_o                           ),
		.pio_rx_st2_empty_o                           (       pio_rx_st2_empty_o                           ),
		.pio_rx_st3_empty_o                           (       pio_rx_st3_empty_o                           ),
		.pio_rx_st0_pfnum_o                           (       pio_rx_st0_pfnum_o                           ),
		.pio_rx_st1_pfnum_o                           (       pio_rx_st1_pfnum_o                           ),
		.pio_rx_st2_pfnum_o                           (       pio_rx_st2_pfnum_o                           ),
		.pio_rx_st3_pfnum_o                           (       pio_rx_st3_pfnum_o                           ),
		.pio_rx_st0_tlp_prfx_o                        (       pio_rx_st0_tlp_prfx_o                        ),
		.pio_rx_st1_tlp_prfx_o                        (       pio_rx_st1_tlp_prfx_o                        ),
		.pio_rx_st2_tlp_prfx_o                        (       pio_rx_st2_tlp_prfx_o                        ),
		.pio_rx_st3_tlp_prfx_o                        (       pio_rx_st3_tlp_prfx_o                        ),
		.pio_rx_st0_data_parity_o                     (       pio_rx_st0_data_parity_o                     ),
		.pio_rx_st0_hdr_parity_o                      (       pio_rx_st0_hdr_parity_o                      ),
		.pio_rx_st0_tlp_prfx_parity_o                 (       pio_rx_st0_tlp_prfx_parity_o                 ),
		.pio_rx_st0_rssai_prefix_o                    (       pio_rx_st0_rssai_prefix_o                    ),
		.pio_rx_st0_rssai_prefix_parity_o             (       pio_rx_st0_rssai_prefix_parity_o             ),
		.pio_rx_st0_vfactive_o                        (       pio_rx_st0_vfactive_o                        ),
		.pio_rx_st0_vfnum_o                           (       pio_rx_st0_vfnum_o                           ),
		.pio_rx_st0_chnum_o                           (       pio_rx_st0_chnum_o                           ),
		.pio_rx_st0_misc_parity_o                     (       pio_rx_st0_misc_parity_o                     ),
		.pio_rx_st1_data_parity_o                     (       pio_rx_st1_data_parity_o                     ),
		.pio_rx_st1_hdr_parity_o                      (       pio_rx_st1_hdr_parity_o                      ),
		.pio_rx_st1_tlp_prfx_parity_o                 (       pio_rx_st1_tlp_prfx_parity_o                 ),
		.pio_rx_st1_rssai_prefix_o                    (       pio_rx_st1_rssai_prefix_o                    ),
		.pio_rx_st1_rssai_prefix_parity_o             (       pio_rx_st1_rssai_prefix_parity_o             ),
		.pio_rx_st1_vfactive_o                        (       pio_rx_st1_vfactive_o                        ),
		.pio_rx_st1_vfnum_o                           (       pio_rx_st1_vfnum_o                           ),
		.pio_rx_st1_chnum_o                           (       pio_rx_st1_chnum_o                           ),
		.pio_rx_st1_misc_parity_o                     (       pio_rx_st1_misc_parity_o                     ),
		.pio_rx_st2_data_parity_o                     (       pio_rx_st2_data_parity_o                     ),
		.pio_rx_st2_hdr_parity_o                      (       pio_rx_st2_hdr_parity_o                      ),
		.pio_rx_st2_tlp_prfx_parity_o                 (       pio_rx_st2_tlp_prfx_parity_o                 ),
		.pio_rx_st2_rssai_prefix_o                    (       pio_rx_st2_rssai_prefix_o                    ),
		.pio_rx_st2_rssai_prefix_parity_o             (       pio_rx_st2_rssai_prefix_parity_o             ),
		.pio_rx_st2_vfactive_o                        (       pio_rx_st2_vfactive_o                        ),
		.pio_rx_st2_vfnum_o                           (       pio_rx_st2_vfnum_o                           ),
		.pio_rx_st2_chnum_o                           (       pio_rx_st2_chnum_o                           ),
		.pio_rx_st2_misc_parity_o                     (       pio_rx_st2_misc_parity_o                     ),
		.pio_rx_st3_data_parity_o                     (       pio_rx_st3_data_parity_o                     ),
		.pio_rx_st3_hdr_parity_o                      (       pio_rx_st3_hdr_parity_o                      ),
		.pio_rx_st3_tlp_prfx_parity_o                 (       pio_rx_st3_tlp_prfx_parity_o                 ),
		.pio_rx_st3_rssai_prefix_o                    (       pio_rx_st3_rssai_prefix_o                    ),
		.pio_rx_st3_rssai_prefix_parity_o             (       pio_rx_st3_rssai_prefix_parity_o             ),
		.pio_rx_st3_vfactive_o                        (       pio_rx_st3_vfactive_o                        ),
		.pio_rx_st3_vfnum_o                           (       pio_rx_st3_vfnum_o                           ),
		.pio_rx_st3_chnum_o                           (       pio_rx_st3_chnum_o                           ),
		.pio_rx_st3_misc_parity_o                     (       pio_rx_st3_misc_parity_o                     ),
		.pio_rx_st0_passthrough_o                     (       pio_rx_st0_passthrough_o                     ),
		.pio_rx_st1_passthrough_o                     (       pio_rx_st1_passthrough_o                     ),
		.pio_rx_st2_passthrough_o                     (       pio_rx_st2_passthrough_o                     ),
		.pio_rx_st3_passthrough_o                     (       pio_rx_st3_passthrough_o                     ),
		.pio_rx_st_ready_i                            (       pio_rx_st_ready_i                            )
);	
end
endgenerate
//--default conifig
generate if(ENABLE_ONLY_DEFAULT_CONFIG)
begin: PF_CHECKER_DEFAULT_CONFIG
intel_cxl_pf_checker pf_checker_inst(
		.clk                                          (       pio_clk                                      ),
		.rstn                                         (       pio_rst_n                                    ),
		.ed_rx_st0_bar_i                              (       ed_rx_st0_bar_i                              ),
		.ed_rx_st1_bar_i                              (       ed_rx_st1_bar_i                              ),
		.ed_rx_st2_bar_i                              (       ed_rx_st2_bar_i                              ),
		.ed_rx_st3_bar_i                              (       ed_rx_st3_bar_i                              ),
		.ed_rx_st0_eop_i                              (       ed_rx_st0_eop_i                              ),
		.ed_rx_st1_eop_i                              (       ed_rx_st1_eop_i                              ),
		.ed_rx_st2_eop_i                              (       ed_rx_st2_eop_i                              ),
		.ed_rx_st3_eop_i                              (       ed_rx_st3_eop_i                              ),
		.ed_rx_st0_header_i                           (       ed_rx_st0_header_i                           ),
		.ed_rx_st1_header_i                           (       ed_rx_st1_header_i                           ),
		.ed_rx_st2_header_i                           (       ed_rx_st2_header_i                           ),
		.ed_rx_st3_header_i                           (       ed_rx_st3_header_i                           ),
		.ed_rx_st0_payload_i                          (       ed_rx_st0_payload_i                          ),
		.ed_rx_st1_payload_i                          (       ed_rx_st1_payload_i                          ),
		.ed_rx_st2_payload_i                          (       ed_rx_st2_payload_i                          ),
		.ed_rx_st3_payload_i                          (       ed_rx_st3_payload_i                          ),
		.ed_rx_st0_sop_i                              (       ed_rx_st0_sop_i                              ),
		.ed_rx_st1_sop_i                              (       ed_rx_st1_sop_i                              ),
		.ed_rx_st2_sop_i                              (       ed_rx_st2_sop_i                              ),
		.ed_rx_st3_sop_i                              (       ed_rx_st3_sop_i                              ),
		.ed_rx_st0_hvalid_i                           (       ed_rx_st0_hvalid_i                           ),
		.ed_rx_st1_hvalid_i                           (       ed_rx_st1_hvalid_i                           ),
		.ed_rx_st2_hvalid_i                           (       ed_rx_st2_hvalid_i                           ),
		.ed_rx_st3_hvalid_i                           (       ed_rx_st3_hvalid_i                           ),
		.ed_rx_st0_dvalid_i                           (       ed_rx_st0_dvalid_i                           ),
		.ed_rx_st1_dvalid_i                           (       ed_rx_st1_dvalid_i                           ),
		.ed_rx_st2_dvalid_i                           (       ed_rx_st2_dvalid_i                           ),
		.ed_rx_st3_dvalid_i                           (       ed_rx_st3_dvalid_i                           ),
		.ed_rx_st0_pvalid_i                           (       ed_rx_st0_pvalid_i                           ),
		.ed_rx_st1_pvalid_i                           (       ed_rx_st1_pvalid_i                           ),
		.ed_rx_st2_pvalid_i                           (       ed_rx_st2_pvalid_i                           ),
		.ed_rx_st3_pvalid_i                           (       ed_rx_st3_pvalid_i                           ),
		.ed_rx_st0_empty_i                            (       ed_rx_st0_empty_i                            ),
		.ed_rx_st1_empty_i                            (       ed_rx_st1_empty_i                            ),
		.ed_rx_st2_empty_i                            (       ed_rx_st2_empty_i                            ),
		.ed_rx_st3_empty_i                            (       ed_rx_st3_empty_i                            ),
		.ed_rx_st0_pfnum_i                            (       ed_rx_st0_pfnum_i                            ),
		.ed_rx_st1_pfnum_i                            (       ed_rx_st1_pfnum_i                            ),
		.ed_rx_st2_pfnum_i                            (       ed_rx_st2_pfnum_i                            ),
		.ed_rx_st3_pfnum_i                            (       ed_rx_st3_pfnum_i                            ),
		.ed_rx_st0_tlp_prfx_i                         (       ed_rx_st0_tlp_prfx_i                         ),
		.ed_rx_st1_tlp_prfx_i                         (       ed_rx_st1_tlp_prfx_i                         ),
		.ed_rx_st2_tlp_prfx_i                         (       ed_rx_st2_tlp_prfx_i                         ),
		.ed_rx_st3_tlp_prfx_i                         (       ed_rx_st3_tlp_prfx_i                         ),
		.ed_rx_st0_data_parity_i                      (       ed_rx_st0_data_parity_i                      ),
		.ed_rx_st0_hdr_parity_i                       (       ed_rx_st0_hdr_parity_i                       ),
		.ed_rx_st0_tlp_prfx_parity_i                  (       ed_rx_st0_tlp_prfx_parity_i                  ),
		.ed_rx_st0_rssai_prefix_i                     (       ed_rx_st0_rssai_prefix_i                     ),
		.ed_rx_st0_rssai_prefix_parity_i              (       ed_rx_st0_rssai_prefix_parity_i              ),
		.ed_rx_st0_vfactive_i                         (       ed_rx_st0_vfactive_i                         ),
		.ed_rx_st0_vfnum_i                            (       ed_rx_st0_vfnum_i                            ),
		.ed_rx_st0_chnum_i                            (       ed_rx_st0_chnum_i                            ),
		.ed_rx_st0_misc_parity_i                      (       ed_rx_st0_misc_parity_i                      ),
		.ed_rx_st1_data_parity_i                      (       ed_rx_st1_data_parity_i                      ),
		.ed_rx_st1_hdr_parity_i                       (       ed_rx_st1_hdr_parity_i                       ),
		.ed_rx_st1_tlp_prfx_parity_i                  (       ed_rx_st1_tlp_prfx_parity_i                  ),
		.ed_rx_st1_rssai_prefix_i                     (       ed_rx_st1_rssai_prefix_i                     ),
		.ed_rx_st1_rssai_prefix_parity_i              (       ed_rx_st1_rssai_prefix_parity_i              ),
		.ed_rx_st1_vfactive_i                         (       ed_rx_st1_vfactive_i                         ),
		.ed_rx_st1_vfnum_i                            (       ed_rx_st1_vfnum_i                            ),
		.ed_rx_st1_chnum_i                            (       ed_rx_st1_chnum_i                            ),
		.ed_rx_st1_misc_parity_i                      (       ed_rx_st1_misc_parity_i                      ),
		.ed_rx_st2_data_parity_i                      (       ed_rx_st2_data_parity_i                      ),
		.ed_rx_st2_hdr_parity_i                       (       ed_rx_st2_hdr_parity_i                       ),
		.ed_rx_st2_tlp_prfx_parity_i                  (       ed_rx_st2_tlp_prfx_parity_i                  ),
		.ed_rx_st2_rssai_prefix_i                     (       ed_rx_st2_rssai_prefix_i                     ),
		.ed_rx_st2_rssai_prefix_parity_i              (       ed_rx_st2_rssai_prefix_parity_i              ),
		.ed_rx_st2_vfactive_i                         (       ed_rx_st2_vfactive_i                         ),
		.ed_rx_st2_vfnum_i                            (       ed_rx_st2_vfnum_i                            ),
		.ed_rx_st2_chnum_i                            (       ed_rx_st2_chnum_i                            ),
		.ed_rx_st2_misc_parity_i                      (       ed_rx_st2_misc_parity_i                      ),
		.ed_rx_st3_data_parity_i                      (       ed_rx_st3_data_parity_i                      ),
		.ed_rx_st3_hdr_parity_i                       (       ed_rx_st3_hdr_parity_i                       ),
		.ed_rx_st3_tlp_prfx_parity_i                  (       ed_rx_st3_tlp_prfx_parity_i                  ),
		.ed_rx_st3_rssai_prefix_i                     (       ed_rx_st3_rssai_prefix_i                     ),
		.ed_rx_st3_rssai_prefix_parity_i              (       ed_rx_st3_rssai_prefix_parity_i              ),
		.ed_rx_st3_vfactive_i                         (       ed_rx_st3_vfactive_i                         ),
		.ed_rx_st3_vfnum_i                            (       ed_rx_st3_vfnum_i                            ),
		.ed_rx_st3_chnum_i                            (       ed_rx_st3_chnum_i                            ),
		.ed_rx_st3_misc_parity_i                      (       ed_rx_st3_misc_parity_i                      ),
		.ed_rx_st0_passthrough_i                      (       ed_rx_st0_passthrough_i                      ),
		.ed_rx_st1_passthrough_i                      (       ed_rx_st1_passthrough_i                      ),
		.ed_rx_st2_passthrough_i                      (       ed_rx_st2_passthrough_i                      ),
		.ed_rx_st3_passthrough_i                      (       ed_rx_st3_passthrough_i                      ),
		.ed_rx_st_ready_o                             (       ed_rx_st_ready_o                             ),
		//--default                                   config  rx                                           
		.default_config_rx_st0_bar_o                  (       default_config_rx_st0_bar_o                  ),
		.default_config_rx_st1_bar_o                  (       default_config_rx_st1_bar_o                  ),
		.default_config_rx_st2_bar_o                  (       default_config_rx_st2_bar_o                  ),
		.default_config_rx_st3_bar_o                  (       default_config_rx_st3_bar_o                  ),
		.default_config_rx_st0_eop_o                  (       default_config_rx_st0_eop_o                  ),
		.default_config_rx_st1_eop_o                  (       default_config_rx_st1_eop_o                  ),
		.default_config_rx_st2_eop_o                  (       default_config_rx_st2_eop_o                  ),
		.default_config_rx_st3_eop_o                  (       default_config_rx_st3_eop_o                  ),
		.default_config_rx_st0_header_o               (       default_config_rx_st0_header_o               ),
		.default_config_rx_st1_header_o               (       default_config_rx_st1_header_o               ),
		.default_config_rx_st2_header_o               (       default_config_rx_st2_header_o               ),
		.default_config_rx_st3_header_o               (       default_config_rx_st3_header_o               ),
		.default_config_rx_st0_payload_o              (       default_config_rx_st0_payload_o              ),
		.default_config_rx_st1_payload_o              (       default_config_rx_st1_payload_o              ),
		.default_config_rx_st2_payload_o              (       default_config_rx_st2_payload_o              ),
		.default_config_rx_st3_payload_o              (       default_config_rx_st3_payload_o              ),
		.default_config_rx_st0_sop_o                  (       default_config_rx_st0_sop_o                  ),
		.default_config_rx_st1_sop_o                  (       default_config_rx_st1_sop_o                  ),
		.default_config_rx_st2_sop_o                  (       default_config_rx_st2_sop_o                  ),
		.default_config_rx_st3_sop_o                  (       default_config_rx_st3_sop_o                  ),
		.default_config_rx_st0_hvalid_o               (       default_config_rx_st0_hvalid_o               ),
		.default_config_rx_st1_hvalid_o               (       default_config_rx_st1_hvalid_o               ),
		.default_config_rx_st2_hvalid_o               (       default_config_rx_st2_hvalid_o               ),
		.default_config_rx_st3_hvalid_o               (       default_config_rx_st3_hvalid_o               ),
		.default_config_rx_st0_dvalid_o               (       default_config_rx_st0_dvalid_o               ),
		.default_config_rx_st1_dvalid_o               (       default_config_rx_st1_dvalid_o               ),
		.default_config_rx_st2_dvalid_o               (       default_config_rx_st2_dvalid_o               ),
		.default_config_rx_st3_dvalid_o               (       default_config_rx_st3_dvalid_o               ),
		.default_config_rx_st0_pvalid_o               (       default_config_rx_st0_pvalid_o               ),
		.default_config_rx_st1_pvalid_o               (       default_config_rx_st1_pvalid_o               ),
		.default_config_rx_st2_pvalid_o               (       default_config_rx_st2_pvalid_o               ),
		.default_config_rx_st3_pvalid_o               (       default_config_rx_st3_pvalid_o               ),
		.default_config_rx_st0_empty_o                (       default_config_rx_st0_empty_o                ),
		.default_config_rx_st1_empty_o                (       default_config_rx_st1_empty_o                ),
		.default_config_rx_st2_empty_o                (       default_config_rx_st2_empty_o                ),
		.default_config_rx_st3_empty_o                (       default_config_rx_st3_empty_o                ),
		.default_config_rx_st0_pfnum_o                (       default_config_rx_st0_pfnum_o                ),
		.default_config_rx_st1_pfnum_o                (       default_config_rx_st1_pfnum_o                ),
		.default_config_rx_st2_pfnum_o                (       default_config_rx_st2_pfnum_o                ),
		.default_config_rx_st3_pfnum_o                (       default_config_rx_st3_pfnum_o                ),
		.default_config_rx_st0_tlp_prfx_o             (       default_config_rx_st0_tlp_prfx_o             ),
		.default_config_rx_st1_tlp_prfx_o             (       default_config_rx_st1_tlp_prfx_o             ),
		.default_config_rx_st2_tlp_prfx_o             (       default_config_rx_st2_tlp_prfx_o             ),
		.default_config_rx_st3_tlp_prfx_o             (       default_config_rx_st3_tlp_prfx_o             ),
		.default_config_rx_st0_data_parity_o          (       default_config_rx_st0_data_parity_o          ),
		.default_config_rx_st0_hdr_parity_o           (       default_config_rx_st0_hdr_parity_o           ),
		.default_config_rx_st0_tlp_prfx_parity_o      (       default_config_rx_st0_tlp_prfx_parity        ),
		.default_config_rx_st0_rssai_prefix_o         (       default_config_rx_st0_rssai_prefix_o         ),
		.default_config_rx_st0_rssai_prefix_parity_o  (       default_config_rx_st0_rssai_prefix_parity_o  ),
		.default_config_rx_st0_vfactive_o             (       default_config_rx_st0_vfactive_o             ),
		.default_config_rx_st0_vfnum_o                (       default_config_rx_st0_vfnum_o                ),
		.default_config_rx_st0_chnum_o                (       default_config_rx_st0_chnum_o                ),
		.default_config_rx_st0_misc_parity_o          (       default_config_rx_st0_misc_parity_o          ),
		.default_config_rx_st1_data_parity_o          (       default_config_rx_st1_data_parity_o          ),
		.default_config_rx_st1_hdr_parity_o           (       default_config_rx_st1_hdr_parity_o           ),
		.default_config_rx_st1_tlp_prfx_parity_o      (       default_config_rx_st1_tlp_prfx_parity        ),
		.default_config_rx_st1_rssai_prefix_o         (       default_config_rx_st1_rssai_prefix_o         ),
		.default_config_rx_st1_rssai_prefix_parity_o  (       default_config_rx_st1_rssai_prefix_parity_o  ),
		.default_config_rx_st1_vfactive_o             (       default_config_rx_st1_vfactive_o             ),
		.default_config_rx_st1_vfnum_o                (       default_config_rx_st1_vfnum_o                ),
		.default_config_rx_st1_chnum_o                (       default_config_rx_st1_chnum_o                ),
		.default_config_rx_st1_misc_parity_o          (       default_config_rx_st1_misc_parity_o          ),
		.default_config_rx_st2_data_parity_o          (       default_config_rx_st2_data_parity_o          ),
		.default_config_rx_st2_hdr_parity_o           (       default_config_rx_st2_hdr_parity_o           ),
		.default_config_rx_st2_tlp_prfx_parity_o      (       default_config_rx_st2_tlp_prfx_parity        ),
		.default_config_rx_st2_rssai_prefix_o         (       default_config_rx_st2_rssai_prefix_o         ),
		.default_config_rx_st2_rssai_prefix_parity_o  (       default_config_rx_st2_rssai_prefix_parity_o  ),
		.default_config_rx_st2_vfactive_o             (       default_config_rx_st2_vfactive_o             ),
		.default_config_rx_st2_vfnum_o                (       default_config_rx_st2_vfnum_o                ),
		.default_config_rx_st2_chnum_o                (       default_config_rx_st2_chnum_o                ),
		.default_config_rx_st2_misc_parity_o          (       default_config_rx_st2_misc_parity_o          ),
		.default_config_rx_st3_data_parity_o          (       default_config_rx_st3_data_parity_o          ),
		.default_config_rx_st3_hdr_parity_o           (       default_config_rx_st3_hdr_parity_o           ),
		.default_config_rx_st3_tlp_prfx_parity_o      (       default_config_rx_st3_tlp_prfx_parity        ),
		.default_config_rx_st3_rssai_prefix_o         (       default_config_rx_st3_rssai_prefix_o         ),
		.default_config_rx_st3_rssai_prefix_parity_o  (       default_config_rx_st3_rssai_prefix_parity_o  ),
		.default_config_rx_st3_vfactive_o             (       default_config_rx_st3_vfactive_o             ),
		.default_config_rx_st3_vfnum_o                (       default_config_rx_st3_vfnum_o                ),
		.default_config_rx_st3_chnum_o                (       default_config_rx_st3_chnum_o                ),
		.default_config_rx_st3_misc_parity_o          (       default_config_rx_st3_misc_parity_o          ),
		.default_config_rx_st0_passthrough_o          (       default_config_rx_st0_passthrough_o          ),
		.default_config_rx_st1_passthrough_o          (       default_config_rx_st1_passthrough_o          ),
		.default_config_rx_st2_passthrough_o          (       default_config_rx_st2_passthrough_o          ),
		.default_config_rx_st3_passthrough_o          (       default_config_rx_st3_passthrough_o          ),
		.default_config_rx_st_ready_i                 (       default_config_rx_st_ready_o                 )
);	
end
endgenerate


generate if(ENABLE_ONLY_DEFAULT_CONFIG || ENABLE_BOTH_DEFAULT_CONFIG_PIO)
begin: DEFAULT_CONFIG_AVST
// avst interface module for pio
  intel_pcie_bam_v2_avst_intf
 # (
   .BAM_DATAWIDTH(DATA_WIDTH) 
) avst_interface_default_config (

		.clk                                          	(   pio_clk),
		.reset_n                                      	(   pio_rst_n),
		.pio_rx_st0_bar_i                             	(   default_config_rx_st0_bar_o                             	),
		.pio_rx_st1_bar_i                             	(   default_config_rx_st1_bar_o                             	),
		.pio_rx_st2_bar_i                             	(   default_config_rx_st2_bar_o                             	),
		.pio_rx_st3_bar_i                             	(   default_config_rx_st3_bar_o                             	),
		.pio_rx_st0_eop_i                             	(   default_config_rx_st0_eop_o                             	),
		.pio_rx_st1_eop_i                             	(   default_config_rx_st1_eop_o                             	),
		.pio_rx_st2_eop_i                             	(   default_config_rx_st2_eop_o                             	),
		.pio_rx_st3_eop_i                             	(   default_config_rx_st3_eop_o                             	),
		.pio_rx_st0_header_i                          	(   default_config_rx_st0_header_update                         ),
		.pio_rx_st1_header_i                          	(   default_config_rx_st1_header_update                         ),
		.pio_rx_st2_header_i                          	(   default_config_rx_st2_header_update                         ),
		.pio_rx_st3_header_i                          	(   default_config_rx_st3_header_update                         ),
		.pio_rx_st0_payload_i                         	(   default_config_rx_st0_payload_o                         	),
		.pio_rx_st1_payload_i                         	(   default_config_rx_st1_payload_o                         	),
		.pio_rx_st2_payload_i                         	(   default_config_rx_st2_payload_o                         	),
		.pio_rx_st3_payload_i                         	(   default_config_rx_st3_payload_o                         	),
		.pio_rx_st0_sop_i                             	(   default_config_rx_st0_sop_o                             	),
		.pio_rx_st1_sop_i                             	(   default_config_rx_st1_sop_o                             	),
		.pio_rx_st2_sop_i                             	(   default_config_rx_st2_sop_o                             	),
		.pio_rx_st3_sop_i                             	(   default_config_rx_st3_sop_o                             	),
		.pio_rx_st0_hvalid_i                          	(   default_config_rx_st0_hvalid_o                          	),
		.pio_rx_st1_hvalid_i                          	(   default_config_rx_st1_hvalid_o                          	),
		.pio_rx_st2_hvalid_i                          	(   default_config_rx_st2_hvalid_o                          	),
		.pio_rx_st3_hvalid_i                          	(   default_config_rx_st3_hvalid_o                          	),
		.pio_rx_st0_dvalid_i                          	(   default_config_rx_st0_dvalid_o                          	),
		.pio_rx_st1_dvalid_i                          	(   default_config_rx_st1_dvalid_o                          	),
		.pio_rx_st2_dvalid_i                          	(   default_config_rx_st2_dvalid_o                          	),
		.pio_rx_st3_dvalid_i                          	(   default_config_rx_st3_dvalid_o                          	),
		.pio_rx_st0_pvalid_i                          	(   default_config_rx_st0_pvalid_o                          	),
		.pio_rx_st1_pvalid_i                          	(   default_config_rx_st1_pvalid_o                          	),
		.pio_rx_st2_pvalid_i                          	(   default_config_rx_st2_pvalid_o                          	),
		.pio_rx_st3_pvalid_i                          	(   default_config_rx_st3_pvalid_o                          	),
		.pio_rx_st0_empty_i                           	(   default_config_rx_st0_empty_o                           	),
		.pio_rx_st1_empty_i                           	(   default_config_rx_st1_empty_o                           	),
		.pio_rx_st2_empty_i                           	(   default_config_rx_st2_empty_o                           	),
		.pio_rx_st3_empty_i                           	(   default_config_rx_st3_empty_o                           	),
		.pio_rx_bar                                   	(   default_config_rx_bar                                   	),
		.pio_rx_sop                                   	(   default_config_rx_sop                                   	),
		.pio_rx_eop                                   	(   default_config_rx_eop                                   	),
		.pio_rx_header                                	(   default_config_rx_header                                	),
		.pio_rx_payload                               	(   default_config_rx_payload                               	),
		.pio_rx_valid                                 	(   default_config_rx_valid                                 	),
		.pio_rx_st0_tlp_prfx_i                        	(   default_config_rx_st0_tlp_prfx_o                        	),
		.pio_rx_st1_tlp_prfx_i                        	(   default_config_rx_st1_tlp_prfx_o                        	),
		.pio_rx_st2_tlp_prfx_i                        	(   default_config_rx_st2_tlp_prfx_o                        	),
		.pio_rx_st3_tlp_prfx_i                        	(   default_config_rx_st3_tlp_prfx_o                        	),
		.pio_tx_st0_eop_o                             	(   default_config_tx_st0_eop_i                             	),
		.pio_tx_st1_eop_o                             	(   default_config_tx_st1_eop_i                             	),
		.pio_tx_st2_eop_o                             	(   default_config_tx_st2_eop_i                             	),
		.pio_tx_st3_eop_o                             	(   default_config_tx_st3_eop_i                             	),
		.pio_tx_st0_header_o                          	(   default_config_tx_st0_header_i                          	),
		.pio_tx_st1_header_o                          	(   default_config_tx_st1_header_i                          	),
		.pio_tx_st2_header_o                          	(   default_config_tx_st2_header_i                          	),
		.pio_tx_st3_header_o                          	(   default_config_tx_st3_header_i                          	),
		.pio_tx_st0_prefix_o                          	(   default_config_tx_st0_prefix_i                          	),
		.pio_tx_st1_prefix_o                          	(   default_config_tx_st1_prefix_i                          	),
		.pio_tx_st2_prefix_o                          	(   default_config_tx_st2_prefix_i                          	),
		.pio_tx_st3_prefix_o                          	(   default_config_tx_st3_prefix_i                          	),
		.pio_tx_st0_payload_o                         	(   default_config_tx_st0_payload_i                         	),
		.pio_tx_st1_payload_o                         	(   default_config_tx_st1_payload_i                         	),
		.pio_tx_st2_payload_o                         	(   default_config_tx_st2_payload_i                         	),
		.pio_tx_st3_payload_o                         	(   default_config_tx_st3_payload_i                         	),
		.pio_tx_st0_sop_o                             	(   default_config_tx_st0_sop_i                             	),
		.pio_tx_st1_sop_o                             	(   default_config_tx_st1_sop_i                             	),
		.pio_tx_st2_sop_o                             	(   default_config_tx_st2_sop_i                             	),
		.pio_tx_st3_sop_o                             	(   default_config_tx_st3_sop_i                             	),
		.pio_tx_st0_dvalid_o                          	(   default_config_tx_st0_dvalid_i                          	),
		.pio_tx_st1_dvalid_o                          	(   default_config_tx_st1_dvalid_i                          	),
		.pio_tx_st2_dvalid_o                          	(   default_config_tx_st2_dvalid_i                          	),
		.pio_tx_st3_dvalid_o                          	(   default_config_tx_st3_dvalid_i                          	),
		.pio_tx_st0_hvalid_o                          	(   default_config_tx_st0_hvalid_i                          	),
		.pio_tx_st1_hvalid_o                          	(   default_config_tx_st1_hvalid_i                          	),
		.pio_tx_st2_hvalid_o                          	(   default_config_tx_st2_hvalid_i                          	),
		.pio_tx_st3_hvalid_o                          	(   default_config_tx_st3_hvalid_i                          	),
		.pio_tx_st0_pvalid_o                          	(   default_config_tx_st0_pvalid_i                          	),
		.pio_tx_st1_pvalid_o                          	(   default_config_tx_st1_pvalid_i                          	),
		.pio_tx_st2_pvalid_o                          	(   default_config_tx_st2_pvalid_i                          	),
		.pio_tx_st3_pvalid_o                          	(   default_config_tx_st3_pvalid_i                          	),
		.pio_txc_eop                                  	(   default_config_txc_eop                                  	),
		.pio_txc_header                               	(   default_config_tx_st_header_update                        	),
		.pio_txc_payload                              	(   default_config_txc_payload                              	),
		.pio_txc_sop                                  	(   default_config_txc_sop                                  	),
		.pio_txc_valid                                	(   default_config_txc_valid                                	)

);

// default config block for sending UR
intel_cxl_default_config inst_default_config(

		.clk                                (       pio_clk                              ),              
		.rst_n                              (       pio_rst_n                            ),              
		.default_config_rx_bar              (       default_config_rx_bar                ),              
		.default_config_rx_sop_i            (       default_config_rx_sop                ),              
		.default_config_rx_eop_i            (       default_config_rx_eop                ),              
		.default_config_rx_header_i         (       default_config_rx_header             ),              
		.default_config_rx_payload_i        (       default_config_rx_payload            ),              
		.default_config_rx_valid_i          (       default_config_rx_valid              ),              
		.default_config_rx_st_ready_o       (       default_config_rx_st_ready_o         ),              
		.default_config_tx_st_ready_i       (       pio_txc_ready                        ),              
		.default_config_rx_bus_number       (       default_config_rx_bus_number         ),              
		.default_config_rx_device_number    (       default_config_rx_device_number      ),              
		.default_config_rx_function_number  (       default_config_rx_function_number    ),              
		.default_config_txc_eop             (       default_config_txc_eop               ),              
		.default_config_txc_header          (       default_config_txc_header            ),              
		.default_config_txc_payload         (       default_config_txc_payload           ),              
		.default_config_txc_sop             (       default_config_txc_sop               ),              
		.default_config_txc_valid           (       default_config_txc_valid             ),              
		//--to  credit  module                               //--to  credit  module
		.dc_hdr_len_o                       (       dc_hdr_len_o                         ),              
		.dc_hdr_valid_o                     (       dc_hdr_valid_o                       ),              
		.dc_hdr_is_rd_o                     (       dc_hdr_is_rd_o                       ),              
		.dc_hdr_is_rd_with_data_o           (       dc_hdr_is_rd_with_data_o             ),              
		.dc_hdr_is_wr_o                     (       dc_hdr_is_wr_o                       ),              
		.dc_hdr_is_wr_no_data_o	            (	    dc_hdr_is_wr_no_data_o               ),
		.dc_hdr_is_cpl_no_data_o            (       dc_hdr_is_cpl_no_data_o              ),
		.dc_hdr_is_cpl_o                    (       dc_hdr_is_cpl_o                      ),
		.dc_bam_rx_signal_ready_o           (       dc_bam_rx_signal_ready_o             ),              
		.dc_tx_hdr_valid_o                  (       dc_tx_hdr_valid_o                    ),              
		.ed_tx_st0_passthrough_o            (       default_config_tx_st0_passthrough_i  ),              
		.ed_tx_st1_passthrough_o            (       default_config_tx_st1_passthrough_i  ),              
		.ed_tx_st2_passthrough_o            (       default_config_tx_st2_passthrough_i  ),              
		.ed_tx_st3_passthrough_o            (       default_config_tx_st3_passthrough_i  )               

);
end
endgenerate


generate if(ENABLE_ONLY_PIO || ENABLE_BOTH_DEFAULT_CONFIG_PIO)
begin: PIO_AVST
// avst interface module for pio
intel_pcie_bam_v2_avst_intf                                                                                                     
#        (               
.BAM_DATAWIDTH(DATA_WIDTH)               
)    avst_interface  (
		.clk                    (  pio_clk                                                                                                        ),
		.reset_n                (  pio_rst_n                                                                                                      ),
		.pio_rx_st0_bar_i       (  pio_rx_st0_bar_o                                                                                               ),
		.pio_rx_st1_bar_i       (  pio_rx_st1_bar_o                                                                                               ),
		.pio_rx_st2_bar_i       (  pio_rx_st2_bar_o                                                                                               ),
		.pio_rx_st3_bar_i       (  pio_rx_st3_bar_o                                                                                               ),
		.pio_rx_st0_eop_i       (  pio_rx_st0_eop_o                                                                                               ),
		.pio_rx_st1_eop_i       (  pio_rx_st1_eop_o                                                                                               ),
		.pio_rx_st2_eop_i       (  pio_rx_st2_eop_o                                                                                               ),
		.pio_rx_st3_eop_i       (  pio_rx_st3_eop_o                                                                                               ),
		.pio_rx_st0_header_i    (  {pio_rx_st0_header_o[31:0],pio_rx_st0_header_o[63:32],pio_rx_st0_header_o[95:64],pio_rx_st0_header_o[127:96]}  ),
		.pio_rx_st1_header_i    (  {pio_rx_st1_header_o[31:0],pio_rx_st1_header_o[63:32],pio_rx_st1_header_o[95:64],pio_rx_st1_header_o[127:96]}  ),
		.pio_rx_st2_header_i    (  {pio_rx_st2_header_o[31:0],pio_rx_st2_header_o[63:32],pio_rx_st2_header_o[95:64],pio_rx_st2_header_o[127:96]}  ),
		.pio_rx_st3_header_i    (  {pio_rx_st3_header_o[31:0],pio_rx_st3_header_o[63:32],pio_rx_st3_header_o[95:64],pio_rx_st3_header_o[127:96]}  ),
		.pio_rx_st0_payload_i   (  pio_rx_st0_payload_o                                                                                           ),
		.pio_rx_st1_payload_i   (  pio_rx_st1_payload_o                                                                                           ),
		.pio_rx_st2_payload_i   (  pio_rx_st2_payload_o                                                                                           ),
		.pio_rx_st3_payload_i   (  pio_rx_st3_payload_o                                                                                           ),
		.pio_rx_st0_sop_i       (  pio_rx_st0_sop_o                                                                                               ),
		.pio_rx_st1_sop_i       (  pio_rx_st1_sop_o                                                                                               ),
		.pio_rx_st2_sop_i       (  pio_rx_st2_sop_o                                                                                               ),
		.pio_rx_st3_sop_i       (  pio_rx_st3_sop_o                                                                                               ),
		.pio_rx_st0_hvalid_i    (  pio_rx_st0_hvalid_o                                                                                            ),
		.pio_rx_st1_hvalid_i    (  pio_rx_st1_hvalid_o                                                                                            ),
		.pio_rx_st2_hvalid_i    (  pio_rx_st2_hvalid_o                                                                                            ),
		.pio_rx_st3_hvalid_i    (  pio_rx_st3_hvalid_o                                                                                            ),
		.pio_rx_st0_dvalid_i    (  pio_rx_st0_dvalid_o                                                                                            ),
		.pio_rx_st1_dvalid_i    (  pio_rx_st1_dvalid_o                                                                                            ),
		.pio_rx_st2_dvalid_i    (  pio_rx_st2_dvalid_o                                                                                            ),
		.pio_rx_st3_dvalid_i    (  pio_rx_st3_dvalid_o                                                                                            ),
		.pio_rx_st0_pvalid_i    (  pio_rx_st0_pvalid_o                                                                                            ),
		.pio_rx_st1_pvalid_i    (  pio_rx_st1_pvalid_o                                                                                            ),
		.pio_rx_st2_pvalid_i    (  pio_rx_st2_pvalid_o                                                                                            ),
		.pio_rx_st3_pvalid_i    (  pio_rx_st3_pvalid_o                                                                                            ),
		.pio_rx_st0_empty_i     (  pio_rx_st0_empty_o                                                                                             ),
		.pio_rx_st1_empty_i     (  pio_rx_st1_empty_o                                                                                             ),
		.pio_rx_st2_empty_i     (  pio_rx_st2_empty_o                                                                                             ),
		.pio_rx_st3_empty_i     (  pio_rx_st3_empty_o                                                                                             ),
		.pio_rx_bar             (  pio_rx_bar                                                                                                     ),
		.pio_rx_sop             (  pio_rx_sop                                                                                                     ),
		.pio_rx_eop             (  pio_rx_eop                                                                                                     ),
		.pio_rx_header          (  pio_rx_header                                                                                                  ),
		.pio_rx_payload         (  pio_rx_payload                                                                                                 ),
		.pio_rx_valid           (  pio_rx_valid                                                                                                   ),
		.pio_rx_st0_tlp_prfx_i  (  pio_rx_st0_tlp_prfx_o                                                                                          ),
		.pio_rx_st1_tlp_prfx_i  (  pio_rx_st1_tlp_prfx_o                                                                                          ),
		.pio_rx_st2_tlp_prfx_i  (  pio_rx_st2_tlp_prfx_o                                                                                          ),
		.pio_rx_st3_tlp_prfx_i  (  pio_rx_st3_tlp_prfx_o                                                                                          ),
		.pio_tx_st0_eop_o       (  pio_tx_st0_eop_i                                                                                               ),
		.pio_tx_st1_eop_o       (  pio_tx_st1_eop_i                                                                                               ),
		.pio_tx_st2_eop_o       (  pio_tx_st2_eop_i                                                                                               ),
		.pio_tx_st3_eop_o       (  pio_tx_st3_eop_i                                                                                               ),
		.pio_tx_st0_header_o    (  {pio_tx_st0_header_i[31:0],pio_tx_st0_header_i[63:32],pio_tx_st0_header_i[95:64],pio_tx_st0_header_i[127:96]}  ),
		.pio_tx_st1_header_o    (  {pio_tx_st1_header_i[31:0],pio_tx_st1_header_i[63:32],pio_tx_st1_header_i[95:64],pio_tx_st1_header_i[127:96]}  ),
		.pio_tx_st2_header_o    (  {pio_tx_st2_header_i[31:0],pio_tx_st2_header_i[63:32],pio_tx_st2_header_i[95:64],pio_tx_st2_header_i[127:96]}  ),
		.pio_tx_st3_header_o    (  {pio_tx_st3_header_i[31:0],pio_tx_st3_header_i[63:32],pio_tx_st3_header_i[95:64],pio_tx_st3_header_i[127:96]}  ),
		.pio_tx_st0_prefix_o    (  pio_tx_st0_prefix_i                                                                                            ),
		.pio_tx_st1_prefix_o    (  pio_tx_st1_prefix_i                                                                                            ),
		.pio_tx_st2_prefix_o    (  pio_tx_st2_prefix_i                                                                                            ),
		.pio_tx_st3_prefix_o    (  pio_tx_st3_prefix_i                                                                                            ),
		.pio_tx_st0_payload_o   (  pio_tx_st0_payload_i                                                                                           ),
		.pio_tx_st1_payload_o   (  pio_tx_st1_payload_i                                                                                           ),
		.pio_tx_st2_payload_o   (  pio_tx_st2_payload_i                                                                                           ),
		.pio_tx_st3_payload_o   (  pio_tx_st3_payload_i                                                                                           ),
		.pio_tx_st0_sop_o       (  pio_tx_st0_sop_i                                                                                               ),
		.pio_tx_st1_sop_o       (  pio_tx_st1_sop_i                                                                                               ),
		.pio_tx_st2_sop_o       (  pio_tx_st2_sop_i                                                                                               ),
		.pio_tx_st3_sop_o       (  pio_tx_st3_sop_i                                                                                               ),
		.pio_tx_st0_dvalid_o    (  pio_tx_st0_dvalid_i                                                                                            ),
		.pio_tx_st1_dvalid_o    (  pio_tx_st1_dvalid_i                                                                                            ),
		.pio_tx_st2_dvalid_o    (  pio_tx_st2_dvalid_i                                                                                            ),
		.pio_tx_st3_dvalid_o    (  pio_tx_st3_dvalid_i                                                                                            ),
		.pio_tx_st0_hvalid_o    (  pio_tx_st0_hvalid_i                                                                                            ),
		.pio_tx_st1_hvalid_o    (  pio_tx_st1_hvalid_i                                                                                            ),
		.pio_tx_st2_hvalid_o    (  pio_tx_st2_hvalid_i                                                                                            ),
		.pio_tx_st3_hvalid_o    (  pio_tx_st3_hvalid_i                                                                                            ),
		.pio_tx_st0_pvalid_o    (  pio_tx_st0_pvalid_i                                                                                            ),
		.pio_tx_st1_pvalid_o    (  pio_tx_st1_pvalid_i                                                                                            ),
		.pio_tx_st2_pvalid_o    (  pio_tx_st2_pvalid_i                                                                                            ),
		.pio_tx_st3_pvalid_o    (  pio_tx_st3_pvalid_i                                                                                            ),
		.pio_txc_eop            (  pio_txc_eop                                                                                                    ),
		.pio_txc_header         (  pio_txc_header                                                                                                 ),
		.pio_txc_payload        (  pio_txc_payload                                                                                                ),
		.pio_txc_sop            (  pio_txc_sop                                                                                                    ),
		.pio_txc_valid          (  pio_txc_valid                                                                                                  )
);                                                                                                                              


// pio top module
//
intel_cxl_pio pio(

		.clk                       (             pio_clk                        ),
		.rst_n                     (             pio_rst_n                      ),
		//--avst signals                                      
		.bam_rx_bar_i              (             pio_rx_bar[2:0]                ),
		.bam_rx_eop_i              (             pio_rx_eop                     ),
		.bam_rx_header_i           (             pio_rx_header[127:0]           ),
		.bam_rx_payload_i          (             pio_rx_payload                 ),
		.bam_rx_pfnum_i            (             pio_rx_pfnum                   ),
		.bam_rx_sop_i              (             pio_rx_sop                     ),
		.bam_rx_valid_i            (             pio_rx_valid                   ),
		.bam_rx_vfactive_i         (             pio_rx_vfactive                ),
		.bam_rx_vfnum_i            (             pio_rx_vfnum                   ),
		.bam_rx_ready_o            (             pio_rx_ready                   ),
		.bam_txc_eop_o             (             pio_txc_eop                    ),
		.bam_txc_header_o          (             pio_txc_header[127:0]          ),
		.bam_txc_payload_o         (             pio_txc_payload                ),
		.bam_txc_sop_o             (             pio_txc_sop                    ),
		.bam_txc_valid_o           (             pio_txc_valid                  ),
		.dev_mps                   (             3'b0                           ),
		//==mem interconnect                                 
		.bam_address_o             (             pio0_pio_master_address        ),
		.bam_read_o                (             pio0_pio_master_read           ),
		.bam_readdata_i            (             pio0_pio_master_readdata       ),
		.bam_readdatavalid_i       (             pio0_pio_master_readdatavalid  ),
		.bam_write_o               (             pio0_pio_master_write          ),
		.bam_writedata_o           (             pio0_pio_master_writedata      ),
		.bam_waitrequest_i         (             pio0_pio_master_waitrequest    ),
		.bam_byteenable_o          (             pio0_pio_master_byteenable     ),
		.bam_response_i            (             pio0_pio_master_response       ),
		.bam_burstcount_o          (             pio0_pio_master_burstcount     ),
		//==crdt intf signals                        
		.for_rxcrdt_tlp_len_o      (             for_rxcrdt_tlp_len             ),
		.for_rxcrdt_hdr_valid_o    (             for_rxcrdt_hdr_valid           ),
		.for_rxcrdt_hdr_is_rd_o    (             for_rxcrdt_hdr_is_rd           ),
		.for_rxcrdt_hdr_is_wr_o    (             for_rxcrdt_hdr_is_wr           ),
		.bam_txc_ready_i           (             pio_txc_ready                  ),
		.bam_writeresponsevalid_i  (             1'b0                           ),
		.tx_hdr_fifo_rreq_o        (             tx_hdr_fifo_rreq               ),
		.tx_hdr_fifo_empty_i       (             tx_hdr_fifo_empty              ),
		.tx_hdr_fifo_rdata_i       (             tx_hdr_fifo_rdata              ),
		.cplram_rd_addr_o          (             cplram_rd_addr                 ),
		.cplram_rd_data_i          (             cplram_rd_data                 ),
		.cpl_cmd_fifo_rdreq_i      (             cpl_cmd_fifo_rdreq             ),
		.cpl_cmd_fifo_rddata_o     (             cpl_cmd_fifo_rddata            ),
		.cpl_cmd_fifo_empty_o      (             cpl_cmd_fifo_empty             ),
		.cpl_ram_rdreq_i           (             cpl_ram_rdreq                  ),
		.avmm_read_data_valid_o    (             avmm_read_data_valid           ),
		.cplram_read_data_o        (             cplram_read_data               )

);
 

intel_pcie_bam_v2_cpl 
#(
    .BAM_DATAWIDTH(BAM_DATAWIDTH)

) bam_cpl (
		.clk                     (  pio_clk                 ),
		.rst_n                   (  pio_rst_n               ),
		.cplcmd_fifo_rdreq_o     (  cpl_cmd_fifo_rdreq      ),
		.cplcmd_fifo_data_i      (  cpl_cmd_fifo_rddata     ),
		.cplcmd_fifo_empty_i     (  cpl_cmd_fifo_empty      ),
		.cpl_buf_rdreq_o         (  cpl_ram_rdreq           ),
		.cpl_buf_data_i          (  cplram_read_data        ),
		.cpl_buff_wrreq_i        (  avmm_read_data_valid    ),
		.pio_rx_bus_number       (  pio_rx_bus_number       ),
		.pio_rx_device_number    (  pio_rx_device_number    ),
		.pio_rx_function_number  (  pio_rx_function_number  ),
		.tx_data_buff_rd_addr_i  (  cplram_rd_addr          ),
		.tx_data_buff_o          (  cplram_rd_data          ),
		.tx_hdr_fifo_rreq_i      (  tx_hdr_fifo_rreq        ),
		.tx_hdr_fifo_rdata_o     (  tx_hdr_fifo_rdata       ),
		.tx_hdr_fifo_empty_o     (  tx_hdr_fifo_empty       ),
		.busdev_num_i            (  13'b0                   )
 );


pcie_ed_altera_mm_interconnect_1920_sx2feoa mm_interconnect_0 (
		.pio0_pio_master_address                                      (pio0_pio_master_address),
		.pio0_pio_master_waitrequest                                  (pio0_pio_master_waitrequest),
		.pio0_pio_master_burstcount                                   (pio0_pio_master_burstcount),
		.pio0_pio_master_byteenable                                   (pio0_pio_master_byteenable),
		.pio0_pio_master_read                                         (pio0_pio_master_read),
		.pio0_pio_master_readdata                                     (pio0_pio_master_readdata),
		.pio0_pio_master_readdatavalid                                (pio0_pio_master_readdatavalid),
		.pio0_pio_master_write                                        (pio0_pio_master_write),
		.pio0_pio_master_writedata                                    (pio0_pio_master_writedata),
		.pio0_pio_master_response                                     (pio0_pio_master_response),
		.MEM0_s1_address                                              (mm_interconnect_0_mem0_s1_address),
		.MEM0_s1_write                                                (mm_interconnect_0_mem0_s1_write),
		.MEM0_s1_readdata                                             (mm_interconnect_0_mem0_s1_readdata),
		.MEM0_s1_writedata                                            (mm_interconnect_0_mem0_s1_writedata),
		.MEM0_s1_byteenable                                           (mm_interconnect_0_mem0_s1_byteenable),
		.MEM0_s1_chipselect                                           (mm_interconnect_0_mem0_s1_chipselect),
		.MEM0_s1_clken                                                (mm_interconnect_0_mem0_s1_clken),
		.MEM0_reset1_reset_bridge_in_reset_reset                      (~pio_rst_n ),
		.pio0_pio_master_translator_reset_reset_bridge_in_reset_reset (~pio_rst_n ),
		.pio0_pio_master_clk_clk                                      (pio_clk )                  
	);

	pcie_ed_MEM0 mem0 (
		.clk        (pio_clk ),
		.address    (mm_interconnect_0_mem0_s1_address),
		.clken      (mm_interconnect_0_mem0_s1_clken),
		.chipselect (mm_interconnect_0_mem0_s1_chipselect),
		.write      (mm_interconnect_0_mem0_s1_write),
		.readdata   (mm_interconnect_0_mem0_s1_readdata),
		.writedata  (mm_interconnect_0_mem0_s1_writedata),
		.byteenable (mm_interconnect_0_mem0_s1_byteenable),
		.reset      (~pio_rst_n )          
	);
end
endgenerate

// credit interface module
//intel_pcie_bam_v2_crdt_intf crdt_intf (

generate if(ENABLE_BOTH_DEFAULT_CONFIG_PIO)
begin: CRDT_INTF_BOTH
intel_cxl_bam_v2_crdt_intf crdt_intf (
		.clk                       (  pio_clk                   ),
		.rst_n                     (  pio_rst_n                 ),
		.rx_st_hcrdt_update_o      (  rx_st_hcrdt_update_o      ),
		.rx_st_hcrdt_update_cnt_o  (  rx_st_hcrdt_update_cnt_o  ),
		.rx_st_hcrdt_init_o        (  rx_st_hcrdt_init_o        ),
		.rx_st_hcrdt_init_ack_i    (  rx_st_hcrdt_init_ack_i    ),
		.rx_st_dcrdt_update_o      (  rx_st_dcrdt_update_o      ),
		.rx_st_dcrdt_update_cnt_o  (  rx_st_dcrdt_update_cnt_o  ),
		.rx_st_dcrdt_init_o        (  rx_st_dcrdt_init_o        ),
		.rx_st_dcrdt_init_ack_i    (  rx_st_dcrdt_init_ack_i    ),
		.tx_st_hcrdt_update_i      (  tx_st_hcrdt_update_i      ),
		.tx_st_hcrdt_update_cnt_i  (  tx_st_hcrdt_update_cnt_i  ),
		.tx_st_hcrdt_init_i        (  tx_st_hcrdt_init_i        ),
		.tx_st_hcrdt_init_ack_o    (  tx_st_hcrdt_init_ack_o    ),
		.tx_st_dcrdt_update_i      (  tx_st_dcrdt_update_i      ),
		.tx_st_dcrdt_update_cnt_i  (  tx_st_dcrdt_update_cnt_i  ),
		.tx_st_dcrdt_init_i        (  tx_st_dcrdt_init_i        ),
		.tx_st_dcrdt_init_ack_o    (  tx_st_dcrdt_init_ack_o    ),
		.pio_tx_st_ready_i         (  ed_tx_st_ready_i          ),
		.hdr_len_i                 (  for_rxcrdt_tlp_len        ),
		.hdr_valid_i               (  for_rxcrdt_hdr_valid      ),
		.hdr_is_rd_i               (  for_rxcrdt_hdr_is_rd      ),
		.hdr_is_wr_i               (  for_rxcrdt_hdr_is_wr      ),
		.bam_rx_signal_ready_i     (  pio_rx_ready              ),
		.bam_tx_signal_ready_o     (  pio_txc_ready             ),
		.tx_hdr_i                  (  pio_txc_header[9:0]       ),
		.tx_hdr_valid_i            (  pio_txc_valid             ),
		.dc_hdr_len_i              (  dc_hdr_len_o              ),
		.dc_hdr_valid_i            (  dc_hdr_valid_o            ),
		.dc_hdr_is_rd_i            (  dc_hdr_is_rd_o            ),
		.dc_hdr_is_rd_with_data_i  (  dc_hdr_is_rd_with_data_o  ),              
		.dc_hdr_is_wr_i            (  dc_hdr_is_wr_o            ),
		.dc_hdr_is_wr_no_data_i	   (  dc_hdr_is_wr_no_data_o    ),
		.dc_hdr_is_cpl_no_data_i   (  dc_hdr_is_cpl_no_data_o   ),
		.dc_hdr_is_cpl_i           (  dc_hdr_is_cpl_o           ),
		.dc_bam_rx_signal_ready_i  (  dc_bam_rx_signal_ready_o  ),
		.dc_tx_hdr_valid_i         (  dc_tx_hdr_valid_o         )
	);
end
endgenerate		

generate if(ENABLE_ONLY_PIO)
begin: CRDT_INTF_PIO
intel_cxl_bam_v2_crdt_intf crdt_intf (
		.clk                       (  pio_clk                   ),
		.rst_n                     (  pio_rst_n                 ),
		.rx_st_hcrdt_update_o      (  rx_st_hcrdt_update_o      ),
		.rx_st_hcrdt_update_cnt_o  (  rx_st_hcrdt_update_cnt_o  ),
		.rx_st_hcrdt_init_o        (  rx_st_hcrdt_init_o        ),
		.rx_st_hcrdt_init_ack_i    (  rx_st_hcrdt_init_ack_i    ),
		.rx_st_dcrdt_update_o      (  rx_st_dcrdt_update_o      ),
		.rx_st_dcrdt_update_cnt_o  (  rx_st_dcrdt_update_cnt_o  ),
		.rx_st_dcrdt_init_o        (  rx_st_dcrdt_init_o        ),
		.rx_st_dcrdt_init_ack_i    (  rx_st_dcrdt_init_ack_i    ),
		.tx_st_hcrdt_update_i      (  tx_st_hcrdt_update_i      ),
		.tx_st_hcrdt_update_cnt_i  (  tx_st_hcrdt_update_cnt_i  ),
		.tx_st_hcrdt_init_i        (  tx_st_hcrdt_init_i        ),
		.tx_st_hcrdt_init_ack_o    (  tx_st_hcrdt_init_ack_o    ),
		.tx_st_dcrdt_update_i      (  tx_st_dcrdt_update_i      ),
		.tx_st_dcrdt_update_cnt_i  (  tx_st_dcrdt_update_cnt_i  ),
		.tx_st_dcrdt_init_i        (  tx_st_dcrdt_init_i        ),
		.tx_st_dcrdt_init_ack_o    (  tx_st_dcrdt_init_ack_o    ),
		.pio_tx_st_ready_i         (  ed_tx_st_ready_i          ),
		.hdr_len_i                 (  for_rxcrdt_tlp_len        ),
		.hdr_valid_i               (  for_rxcrdt_hdr_valid      ),
		.hdr_is_rd_i               (  for_rxcrdt_hdr_is_rd      ),
		.hdr_is_wr_i               (  for_rxcrdt_hdr_is_wr      ),
		.bam_rx_signal_ready_i     (  pio_rx_ready              ),
		.bam_tx_signal_ready_o     (  pio_txc_ready             ),
		.tx_hdr_i                  (  pio_txc_header[9:0]       ),
		.tx_hdr_valid_i            (  pio_txc_valid             ),
		.dc_hdr_len_i              (  'h0  			),
		.dc_hdr_valid_i            (  'h0  			),
		.dc_hdr_is_rd_i            (  'h0  			),
		.dc_hdr_is_rd_with_data_i  (  'h0                       ),              
		.dc_hdr_is_wr_i            (  'h0  			),
		.dc_hdr_is_wr_no_data_i	   (  'h0			),
		.dc_hdr_is_cpl_no_data_i   (  'h0                       ),
		.dc_hdr_is_cpl_i           (  'h0                       ),
		.dc_bam_rx_signal_ready_i  (  'h1  			),
		.dc_tx_hdr_valid_i         (  'h0  			)
		);
end
endgenerate		

generate if(ENABLE_ONLY_DEFAULT_CONFIG)
begin: CRDT_INT_DEFAULT_CONFIG
intel_cxl_bam_v2_crdt_intf crdt_intf (
		.clk                       (  pio_clk                   ),
		.rst_n                     (  pio_rst_n                 ),
		.rx_st_hcrdt_update_o      (  rx_st_hcrdt_update_o      ),
		.rx_st_hcrdt_update_cnt_o  (  rx_st_hcrdt_update_cnt_o  ),
		.rx_st_hcrdt_init_o        (  rx_st_hcrdt_init_o        ),
		.rx_st_hcrdt_init_ack_i    (  rx_st_hcrdt_init_ack_i    ),
		.rx_st_dcrdt_update_o      (  rx_st_dcrdt_update_o      ),
		.rx_st_dcrdt_update_cnt_o  (  rx_st_dcrdt_update_cnt_o  ),
		.rx_st_dcrdt_init_o        (  rx_st_dcrdt_init_o        ),
		.rx_st_dcrdt_init_ack_i    (  rx_st_dcrdt_init_ack_i    ),
		.tx_st_hcrdt_update_i      (  tx_st_hcrdt_update_i      ),
		.tx_st_hcrdt_update_cnt_i  (  tx_st_hcrdt_update_cnt_i  ),
		.tx_st_hcrdt_init_i        (  tx_st_hcrdt_init_i        ),
		.tx_st_hcrdt_init_ack_o    (  tx_st_hcrdt_init_ack_o    ),
		.tx_st_dcrdt_update_i      (  tx_st_dcrdt_update_i      ),
		.tx_st_dcrdt_update_cnt_i  (  tx_st_dcrdt_update_cnt_i  ),
		.tx_st_dcrdt_init_i        (  tx_st_dcrdt_init_i        ),
		.tx_st_dcrdt_init_ack_o    (  tx_st_dcrdt_init_ack_o    ),
		.pio_tx_st_ready_i         (  ed_tx_st_ready_i          ),
		.hdr_len_i                 (  'h0     			),
		.hdr_valid_i               (  'h0     			),
		.hdr_is_rd_i               (  'h0     			),
		.hdr_is_wr_i               (  'h0     			),
		.bam_rx_signal_ready_i     (  'h1     			),
		.bam_tx_signal_ready_o     (  pio_txc_ready		),
		.tx_hdr_i                  (  'h0     			),
		.tx_hdr_valid_i            (  'h0     			),
		.dc_hdr_len_i              (  dc_hdr_len_o              ),
		.dc_hdr_valid_i            (  dc_hdr_valid_o            ),
		.dc_hdr_is_rd_i            (  dc_hdr_is_rd_o            ),
		.dc_hdr_is_rd_with_data_i  (  dc_hdr_is_rd_with_data_o  ),              
		.dc_hdr_is_wr_i            (  dc_hdr_is_wr_o            ),
		.dc_hdr_is_wr_no_data_i	   (  dc_hdr_is_wr_no_data_o    ),
		.dc_hdr_is_cpl_no_data_i   (  dc_hdr_is_cpl_no_data_o   ),
		.dc_hdr_is_cpl_i           (  dc_hdr_is_cpl_o           ),
		.dc_bam_rx_signal_ready_i  (  dc_bam_rx_signal_ready_o  ),
		.dc_tx_hdr_valid_i         (  dc_tx_hdr_valid_o         )
		);
end
endgenerate



generate if(ENABLE_ONLY_DEFAULT_CONFIG || ENABLE_BOTH_DEFAULT_CONFIG_PIO)
begin	
always_ff@(posedge pio_clk)
begin
default_config_tx_st0_passthrough_i_reg1    <=		default_config_tx_st0_passthrough_i 	;	
default_config_tx_st0_passthrough_i_reg2    <=		default_config_tx_st0_passthrough_i_reg1 	;	
default_config_tx_st0_passthrough_i_reg3    <=		default_config_tx_st0_passthrough_i_reg2 	;	
default_config_tx_st0_passthrough_i_reg4    <=		default_config_tx_st0_passthrough_i_reg3 	;	
default_config_tx_st0_passthrough_i_reg5    <=		default_config_tx_st0_passthrough_i_reg4 	;	
end	

assign default_config_tx_st0_hdr_parity[0] = ^default_config_tx_st0_header_i[31:0];
assign default_config_tx_st0_hdr_parity[1] = ^default_config_tx_st0_header_i[63:32];
assign default_config_tx_st0_hdr_parity[2] = ^default_config_tx_st0_header_i[95:64];
assign default_config_tx_st0_hdr_parity[3] = ^default_config_tx_st0_header_i[127:96];
end
endgenerate

generate if(ENABLE_ONLY_PIO || ENABLE_BOTH_DEFAULT_CONFIG_PIO)
begin
assign pio_tx_st0_hdr_parity[0] = ^pio_tx_st0_header_i[31:0];
assign pio_tx_st0_hdr_parity[1] = ^pio_tx_st0_header_i[63:32];
assign pio_tx_st0_hdr_parity[2] = ^pio_tx_st0_header_i[95:64];
assign pio_tx_st0_hdr_parity[3] = ^pio_tx_st0_header_i[127:96];
assign pio_tx_st0_data_parity[0] = ^pio_tx_st0_payload_i[31:0];    
assign pio_tx_st0_data_parity[1] = ^pio_tx_st0_payload_i[63:32];    
assign pio_tx_st0_data_parity[2] = ^pio_tx_st0_payload_i[95:64];    
assign pio_tx_st0_data_parity[3] = ^pio_tx_st0_payload_i[127:96];    
assign pio_tx_st0_data_parity[4] = ^pio_tx_st0_payload_i[159:128];    
assign pio_tx_st0_data_parity[5] = ^pio_tx_st0_payload_i[191:160];    
assign pio_tx_st0_data_parity[6] = ^pio_tx_st0_payload_i[223:192];    
assign pio_tx_st0_data_parity[7] = ^pio_tx_st0_payload_i[255:224];    

end
endgenerate
//-- merger block --//
//


generate if(ENABLE_BOTH_DEFAULT_CONFIG_PIO)
begin: MERGER
cxl_io_avst_merger_top  inst_avst_merger(                                            
.clk_i                              (                  pio_clk                                   ),
.rstn_i                             (                  pio_rst_n                                 ),
//default config interface                                 
.usr_tx_st_ready                    (                  						 ),
.usr_tx_st_0_dvalid                 (                  default_config_tx_st0_dvalid_i            ),
.usr_tx_st_0_sop                    (                  default_config_tx_st0_sop_i               ),
.usr_tx_st_0_eop                    (                  default_config_tx_st0_eop_i               ),
.usr_tx_st_0_passthrough            (                  default_config_tx_st0_passthrough_i_reg4  ),
.usr_tx_st_0_data                   (                  default_config_tx_st0_payload_i           ),
.usr_tx_st_0_data_parity            (                  'h0					 ),
.usr_tx_st_0_hdr                    (                  default_config_tx_st0_header_i            ),
.usr_tx_st_0_hdr_parity             (                  default_config_tx_st0_hdr_parity          ),
.usr_tx_st_0_hvalid                 (                  default_config_tx_st0_hvalid_i            ),
.usr_tx_st_0_prefix                 (                  'h0                                       ),
.usr_tx_st_0_prefix_parity          (                  'h0                                       ),
.usr_tx_st_0_RSSAI_prefix           (                  'h0                                       ),
.usr_tx_st_0_RSSAI_prefix_parity    (                  'h0                                       ),
.usr_tx_st_0_pvalid                 (                  'h0                                       ),
.usr_tx_st_0_vfactive               (                  'h0                                       ),
.usr_tx_st_0_vfnum                  (                  'h0                                       ),
.usr_tx_st_0_pfnum                  (                  'h0                                       ),
.usr_tx_st_0_chnum                  (                  'h0                                       ),
.usr_tx_st_0_empty                  (                  'h0                                       ),
.usr_tx_st_0_misc_parity            (                  'h0                                       ),
.usr_tx_st_1_dvalid                 (                  default_config_tx_st1_dvalid_i            ),
.usr_tx_st_1_sop                    (                  default_config_tx_st1_sop_i               ),
.usr_tx_st_1_eop                    (                  default_config_tx_st1_eop_i               ),
.usr_tx_st_1_passthrough            (                  default_config_tx_st1_passthrough_i       ),
.usr_tx_st_1_data                   (                  default_config_tx_st1_payload_i           ),
.usr_tx_st_1_data_parity            (                  'h0),
.usr_tx_st_1_hdr                    (                  default_config_tx_st1_header_i            ),
.usr_tx_st_1_hdr_parity             (                  'h0					 ),
.usr_tx_st_1_hvalid                 (                  default_config_tx_st1_hvalid_i            ),
.usr_tx_st_1_prefix                 (                  'h0                                       ),
.usr_tx_st_1_prefix_parity          (                  'h0                                       ),
.usr_tx_st_1_RSSAI_prefix           (                  'h0                                       ),
.usr_tx_st_1_RSSAI_prefix_parity    (                  'h0                                       ),
.usr_tx_st_1_pvalid                 (                  'h0                                       ),
.usr_tx_st_1_vfactive               (                  'h0                                       ),
.usr_tx_st_1_vfnum                  (                  'h0                                       ),
.usr_tx_st_1_pfnum                  (                  'h0                                       ),
.usr_tx_st_1_chnum                  (                  'h0                                       ),
.usr_tx_st_1_empty                  (                  'h0                                       ),
.usr_tx_st_1_misc_parity            (                  'h0                                       ),
.usr_tx_st_2_dvalid                 (                  default_config_tx_st2_dvalid_i            ),
.usr_tx_st_2_sop                    (                  default_config_tx_st2_sop_i               ),
.usr_tx_st_2_eop                    (                  default_config_tx_st2_eop_i               ),
.usr_tx_st_2_passthrough            (                  default_config_tx_st2_passthrough_i       ),
.usr_tx_st_2_data                   (                  default_config_tx_st2_payload_i           ),
.usr_tx_st_2_data_parity            (                  'h0),
.usr_tx_st_2_hdr                    (                  default_config_tx_st2_header_i            ),
.usr_tx_st_2_hdr_parity             (                  'h0				 	 ),
.usr_tx_st_2_hvalid                 (                  default_config_tx_st2_hvalid_i            ),
.usr_tx_st_2_prefix                 (                  'h0                                       ),
.usr_tx_st_2_prefix_parity          (                  'h0                                       ),
.usr_tx_st_2_RSSAI_prefix           (                  'h0                                       ),
.usr_tx_st_2_RSSAI_prefix_parity    (                  'h0                                       ),
.usr_tx_st_2_pvalid                 (                  'h0                                       ),
.usr_tx_st_2_vfactive               (                  'h0                                       ),
.usr_tx_st_2_vfnum                  (                  'h0                                       ),
.usr_tx_st_2_pfnum                  (                  'h0                                       ),
.usr_tx_st_2_chnum                  (                  'h0                                       ),
.usr_tx_st_2_empty                  (                  'h0                                       ),
.usr_tx_st_2_misc_parity            (                  default_config_tx_st2_misc_parity         ),
.usr_tx_st_3_dvalid                 (                  default_config_tx_st3_dvalid_i            ),
.usr_tx_st_3_sop                    (                  default_config_tx_st3_sop_i               ),
.usr_tx_st_3_eop                    (                  default_config_tx_st3_eop_i               ),
.usr_tx_st_3_passthrough            (                  default_config_tx_st3_passthrough_i       ),
.usr_tx_st_3_data                   (                  default_config_tx_st3_payload_i           ),
.usr_tx_st_3_data_parity            (                  'h0),
.usr_tx_st_3_hdr                    (                  default_config_tx_st3_header_i            ),
.usr_tx_st_3_hdr_parity             (                  'h0					 ),
.usr_tx_st_3_hvalid                 (                  default_config_tx_st3_hvalid_i            ),
.usr_tx_st_3_prefix                 (                  'h0                                       ),
.usr_tx_st_3_prefix_parity          (                  'h0                                       ),
.usr_tx_st_3_RSSAI_prefix           (                  'h0                                       ),
.usr_tx_st_3_RSSAI_prefix_parity    (                  'h0                                       ),
.usr_tx_st_3_pvalid                 (                  'h0                                       ),
.usr_tx_st_3_vfactive               (                  'h0                                       ),
.usr_tx_st_3_vfnum                  (                  'h0                                       ),
.usr_tx_st_3_pfnum                  (                  'h0                                       ),
.usr_tx_st_3_chnum                  (                  'h0                                       ),
.usr_tx_st_3_empty                  (                  'h0                                       ),
.usr_tx_st_3_misc_parity            (                  'h0                                       ),
//   pio interface                                 
.mrrIP_tx_st_ready                  (                  						 ),
.mrrIP_tx_st_0_dvalid               (                  pio_tx_st0_dvalid_i                       ),
.mrrIP_tx_st_0_sop                  (                  pio_tx_st0_sop_i                          ),
.mrrIP_tx_st_0_eop                  (                  pio_tx_st0_eop_i                          ),
.mrrIP_tx_st_0_passthrough          (                  pio_tx_st0_passthrough_i                  ),
.mrrIP_tx_st_0_data                 (                  pio_tx_st0_payload_i                      ),
.mrrIP_tx_st_0_data_parity          (                  pio_tx_st0_data_parity                    ),
.mrrIP_tx_st_0_hdr                  (                  pio_tx_st0_header_i                       ),
.mrrIP_tx_st_0_hdr_parity           (                  pio_tx_st0_hdr_parity                     ),
.mrrIP_tx_st_0_hvalid               (                  pio_tx_st0_hvalid_i                       ),
.mrrIP_tx_st_0_prefix               (                  'h0                                       ),
.mrrIP_tx_st_0_prefix_parity        (                  'h0                                       ),
.mrrIP_tx_st_0_RSSAI_prefix         (                  'h0                                       ),
.mrrIP_tx_st_0_RSSAI_prefix_parity  (                  'h0                                       ),
.mrrIP_tx_st_0_pvalid               (                  'h0                                       ),
.mrrIP_tx_st_0_vfactive             (                  'h0                                       ),
.mrrIP_tx_st_0_vfnum                (                  'h0                                       ),
.mrrIP_tx_st_0_pfnum                (                  'h1                                       ),
.mrrIP_tx_st_0_chnum                (                  'h0                                       ),
.mrrIP_tx_st_0_empty                (                  'h0                                       ),
.mrrIP_tx_st_0_misc_parity          (                  'h0                                       ),
.mrrIP_tx_st_1_dvalid               (                  pio_tx_st1_dvalid_i                       ),
.mrrIP_tx_st_1_sop                  (                  pio_tx_st1_sop_i                          ),
.mrrIP_tx_st_1_eop                  (                  pio_tx_st1_eop_i                          ),
.mrrIP_tx_st_1_passthrough          (                  pio_tx_st1_passthrough_i                  ),
.mrrIP_tx_st_1_data                 (                  pio_tx_st1_payload_i                      ),
.mrrIP_tx_st_1_data_parity          (                  'h0),
.mrrIP_tx_st_1_hdr                  (                  pio_tx_st1_header_i                       ),
.mrrIP_tx_st_1_hdr_parity           (                  'h0					 ),
.mrrIP_tx_st_1_hvalid               (                  pio_tx_st1_hvalid_i                       ),
.mrrIP_tx_st_1_prefix               (                  'h0                                       ),
.mrrIP_tx_st_1_prefix_parity        (                  'h0                                       ),
.mrrIP_tx_st_1_RSSAI_prefix         (                  'h0                                       ),
.mrrIP_tx_st_1_RSSAI_prefix_parity  (                  'h0                                       ),
.mrrIP_tx_st_1_pvalid               (                  'h0                                       ),
.mrrIP_tx_st_1_vfactive             (                  'h0                                       ),
.mrrIP_tx_st_1_vfnum                (                  'h0                                       ),
.mrrIP_tx_st_1_pfnum                (                  'h1                                       ),
.mrrIP_tx_st_1_chnum                (                  'h0                                       ),
.mrrIP_tx_st_1_empty                (                  'h0                                       ),
.mrrIP_tx_st_1_misc_parity          (                  'h0                                       ),
.mrrIP_tx_st_2_dvalid               (                  pio_tx_st2_dvalid_i                       ),
.mrrIP_tx_st_2_sop                  (                  pio_tx_st2_sop_i                          ),
.mrrIP_tx_st_2_eop                  (                  pio_tx_st2_eop_i                          ),
.mrrIP_tx_st_2_passthrough          (                  pio_tx_st2_passthrough_i                  ),
.mrrIP_tx_st_2_data                 (                  pio_tx_st2_payload_i                      ),
.mrrIP_tx_st_2_data_parity          (                  'h0),
.mrrIP_tx_st_2_hdr                  (                  pio_tx_st2_header_i                       ),
.mrrIP_tx_st_2_hdr_parity           (                  'h0					 ),
.mrrIP_tx_st_2_hvalid               (                  pio_tx_st2_hvalid_i                       ),
.mrrIP_tx_st_2_prefix               (                  'h0                                       ),
.mrrIP_tx_st_2_prefix_parity        (                  'h0                                       ),
.mrrIP_tx_st_2_RSSAI_prefix         (                  'h0                                       ),
.mrrIP_tx_st_2_RSSAI_prefix_parity  (                  'h0                                       ),
.mrrIP_tx_st_2_pvalid               (                  'h0                                       ),
.mrrIP_tx_st_2_vfactive             (                  'h0                                       ),
.mrrIP_tx_st_2_vfnum                (                  'h0                                       ),
.mrrIP_tx_st_2_pfnum                (                  'h1                                       ),
.mrrIP_tx_st_2_chnum                (                  'h0                                       ),
.mrrIP_tx_st_2_empty                (                  'h0                                       ),
.mrrIP_tx_st_2_misc_parity          (                  'h0                                       ),
.mrrIP_tx_st_3_dvalid               (                  pio_tx_st3_dvalid_i                       ),
.mrrIP_tx_st_3_sop                  (                  pio_tx_st3_sop_i                          ),
.mrrIP_tx_st_3_eop                  (                  pio_tx_st3_eop_i                          ),
.mrrIP_tx_st_3_passthrough          (                  pio_tx_st3_passthrough_i                  ),
.mrrIP_tx_st_3_data                 (                  pio_tx_st3_payload_i                      ),
.mrrIP_tx_st_3_data_parity          (                  'h0),
.mrrIP_tx_st_3_hdr                  (                  pio_tx_st3_header_i                       ),
.mrrIP_tx_st_3_hdr_parity           (                  'h0					 ),
.mrrIP_tx_st_3_hvalid               (                  pio_tx_st3_hvalid_i                       ),
.mrrIP_tx_st_3_prefix               (                  'h0                                       ),
.mrrIP_tx_st_3_prefix_parity        (                  'h0                                       ),
.mrrIP_tx_st_3_RSSAI_prefix         (                  'h0                                       ),
.mrrIP_tx_st_3_RSSAI_prefix_parity  (                  'h0                                       ),
.mrrIP_tx_st_3_pvalid               (                  'h0                                       ),
.mrrIP_tx_st_3_vfactive             (                  'h0                                       ),
.mrrIP_tx_st_3_vfnum                (                  'h0                                       ),
.mrrIP_tx_st_3_pfnum                (                  'h1                                       ),
.mrrIP_tx_st_3_chnum                (                  'h0                                       ),
.mrrIP_tx_st_3_empty                (                  'h0                                       ),
.mrrIP_tx_st_3_misc_parity          (                  'h0                                       ),
//ed top interface                                 
.tx_st_ready                        (                  ed_tx_st_ready_i                          ),
.tx_st_0_dvalid                     (                  ed_tx_st0_dvalid_o                        ),
.tx_st_0_sop                        (                  ed_tx_st0_sop_o                           ),
.tx_st_0_eop                        (                  ed_tx_st0_eop_o                           ),
.tx_st_0_passthrough                (                  ed_tx_st0_passthrough_o                   ),
.tx_st_0_data                       (                  ed_tx_st0_payload_o                       ),
.tx_st_0_data_parity                (                  ed_tx_st0_data_parity			 ),
.tx_st_0_hdr                        (                  ed_tx_st0_header_o                        ),
.tx_st_0_hdr_parity                 (                  ed_tx_st0_hdr_parity                      ),
.tx_st_0_hvalid                     (                  ed_tx_st0_hvalid_o                        ),
.tx_st_0_prefix                     (                  ed_tx_st0_prefix_o                        ),
.tx_st_0_prefix_parity              (                  ed_tx_st0_prefix_parity                   ),
.tx_st_0_RSSAI_prefix               (                  ed_tx_st0_RSSAI_prefix                    ),
.tx_st_0_RSSAI_prefix_parity        (                  ed_tx_st0_RSSAI_prefix_parity             ),
.tx_st_0_pvalid                     (                  ed_tx_st0_pvalid_o                        ),
.tx_st_0_vfactive                   (                  ed_tx_st0_vfactive                        ),
.tx_st_0_vfnum                      (                  ed_tx_st0_vfnum                           ),
.tx_st_0_pfnum                      (                  ed_tx_st0_pfnum                           ),
.tx_st_0_chnum                      (                  ed_tx_st0_chnum                           ),
.tx_st_0_empty                      (                  ed_tx_st0_empty                           ),
.tx_st_0_misc_parity                (                  ed_tx_st0_misc_parity                     ),
.tx_st_1_dvalid                     (                  ed_tx_st1_dvalid_o                        ),
.tx_st_1_sop                        (                  ed_tx_st1_sop_o                           ),
.tx_st_1_eop                        (                  ed_tx_st1_eop_o                           ),
.tx_st_1_passthrough                (                  ed_tx_st1_passthrough_o                   ),
.tx_st_1_data                       (                  ed_tx_st1_payload_o                       ),
.tx_st_1_data_parity                (                  ed_tx_st1_data_parity			 ),
.tx_st_1_hdr                        (                  ed_tx_st1_header_o                        ),
.tx_st_1_hdr_parity                 (                  ed_tx_st1_hdr_parity                      ),
.tx_st_1_hvalid                     (                  ed_tx_st1_hvalid_o                        ),
.tx_st_1_prefix                     (                  ed_tx_st1_prefix_o                        ),
.tx_st_1_prefix_parity              (                  ed_tx_st1_prefix_parity                   ),
.tx_st_1_RSSAI_prefix               (                  ed_tx_st1_RSSAI_prefix                    ),
.tx_st_1_RSSAI_prefix_parity        (                  ed_tx_st1_RSSAI_prefix_parity             ),
.tx_st_1_pvalid                     (                  ed_tx_st1_pvalid_o                        ),
.tx_st_1_vfactive                   (                  ed_tx_st1_vfactive                        ),
.tx_st_1_vfnum                      (                  ed_tx_st1_vfnum                           ),
.tx_st_1_pfnum                      (                  ed_tx_st1_pfnum                           ),
.tx_st_1_chnum                      (                  ed_tx_st1_chnum                           ),
.tx_st_1_empty                      (                  ed_tx_st1_empty                           ),
.tx_st_1_misc_parity                (                  ed_tx_st1_misc_parity                     ),
.tx_st_2_dvalid                     (                  ed_tx_st2_dvalid_o                        ),
.tx_st_2_sop                        (                  ed_tx_st2_sop_o                           ),
.tx_st_2_eop                        (                  ed_tx_st2_eop_o                           ),
.tx_st_2_passthrough                (                  ed_tx_st2_passthrough_o                   ),
.tx_st_2_data                       (                  ed_tx_st2_payload_o                       ),
.tx_st_2_data_parity                (                  ed_tx_st2_data_parity			 ),
.tx_st_2_hdr                        (                  ed_tx_st2_header_o                        ),
.tx_st_2_hdr_parity                 (                  ed_tx_st2_hdr_parity                      ),
.tx_st_2_hvalid                     (                  ed_tx_st2_hvalid_o                        ),
.tx_st_2_prefix                     (                  ed_tx_st2_prefix_o                        ),
.tx_st_2_prefix_parity              (                  ed_tx_st2_prefix_parity                   ),
.tx_st_2_RSSAI_prefix               (                  ed_tx_st2_RSSAI_prefix                    ),
.tx_st_2_RSSAI_prefix_parity        (                  ed_tx_st2_RSSAI_prefix_parity             ),
.tx_st_2_pvalid                     (                  ed_tx_st2_pvalid_o                        ),
.tx_st_2_vfactive                   (                  ed_tx_st2_vfactive_o                      ),
.tx_st_2_vfnum                      (                  ed_tx_st2_vfnum                           ),
.tx_st_2_pfnum                      (                  ed_tx_st2_pfnum                           ),
.tx_st_2_chnum                      (                  ed_tx_st2_chnum                           ),
.tx_st_2_empty                      (                  ed_tx_st2_empty                           ),
.tx_st_2_misc_parity                (                  ed_tx_st2_misc_parity                     ),
.tx_st_3_dvalid                     (                  ed_tx_st3_dvalid_o                        ),
.tx_st_3_sop                        (                  ed_tx_st3_sop_o                           ),
.tx_st_3_eop                        (                  ed_tx_st3_eop_o                           ),
.tx_st_3_passthrough                (                  ed_tx_st3_passthrough_o                   ),
.tx_st_3_data                       (                  ed_tx_st3_payload_o                       ),
.tx_st_3_data_parity                (                  ed_tx_st3_data_parity			 ),
.tx_st_3_hdr                        (                  ed_tx_st3_header_o                        ),
.tx_st_3_hdr_parity                 (                  ed_tx_st3_hdr_parity                      ),
.tx_st_3_hvalid                     (                  ed_tx_st3_hvalid_o                        ),
.tx_st_3_prefix                     (                  ed_tx_st3_prefix_o                        ),
.tx_st_3_prefix_parity              (                  ed_tx_st3_prefix_parity                   ),
.tx_st_3_RSSAI_prefix               (                  ed_tx_st3_RSSAI_prefix                    ),
.tx_st_3_RSSAI_prefix_parity        (                  ed_tx_st3_RSSAI_prefix_parity             ),
.tx_st_3_pvalid                     (                  ed_tx_st3_pvalid_o                        ),
.tx_st_3_vfactive                   (                  ed_tx_st3_vfactive                        ),
.tx_st_3_vfnum                      (                  ed_tx_st3_vfnum                           ),
.tx_st_3_pfnum                      (                  ed_tx_st3_pfnum                           ),
.tx_st_3_chnum                      (                  ed_tx_st3_chnum                           ),
.tx_st_3_empty                      (                  ed_tx_st3_empty                           ),
.tx_st_3_misc_parity                (                  ed_tx_st3_misc_parity                     )
);                                                                                               
end
endgenerate



//--pio                                                                                  
generate 
if(ENABLE_ONLY_PIO ==1)
begin :ONLY_PIO
//assign       ed_tx_st_ready_i               =  pio_tx_st_ready_o                         ;
assign       ed_tx_st0_dvalid_o             =  pio_tx_st0_dvalid_i                       ;
assign       ed_tx_st0_sop_o                =  pio_tx_st0_sop_i                          ;
assign       ed_tx_st0_eop_o                =  pio_tx_st0_eop_i                          ;
assign       ed_tx_st0_passthrough_o        =  'h0					 ;
assign       ed_tx_st0_payload_o            =  pio_tx_st0_payload_i                      ;
assign       ed_tx_st0_data_parity          =  pio_tx_st0_data_parity			 ;
assign       ed_tx_st0_header_o             =  pio_tx_st0_header_i                       ;
assign       ed_tx_st0_hdr_parity           =  pio_tx_st0_hdr_parity         		 ;
assign       ed_tx_st0_hvalid_o             =  pio_tx_st0_hvalid_i                       ;
assign       ed_tx_st0_prefix_o             =  'h0                                       ;
assign       ed_tx_st0_prefix_parity        =  'h0                                       ;
assign       ed_tx_st0_RSSAI_prefix         =  'h0                                       ;
assign       ed_tx_st0_RSSAI_prefix_parity  =  'h0                                       ;
assign       ed_tx_st0_pvalid_o             =  'h0                                       ;
assign       ed_tx_st0_vfactive             =  'h0                                       ;
assign       ed_tx_st0_vfnum                =  'h0                                       ;
assign       ed_tx_st0_pfnum                =  'h0                                       ;
assign       ed_tx_st0_chnum                =  'h0                                       ;
assign       ed_tx_st0_empty                =  'h0                                       ;
assign       ed_tx_st0_misc_parity          =  'h0                                       ;
assign       ed_tx_st1_dvalid_o             =  pio_tx_st1_dvalid_i                       ;
assign       ed_tx_st1_sop_o                =  pio_tx_st1_sop_i                          ;
assign       ed_tx_st1_eop_o                =  pio_tx_st1_eop_i                          ;
assign       ed_tx_st1_passthrough_o        =  'h0					 ;
assign       ed_tx_st1_payload_o            =  pio_tx_st1_payload_i                      ;
assign       ed_tx_st1_data_parity          =  'h0					 ;
assign       ed_tx_st1_header_o             =  pio_tx_st1_header_i                       ;
assign       ed_tx_st1_hdr_parity           =  'h0;
assign       ed_tx_st1_hvalid_o             =  pio_tx_st1_hvalid_i                       ;
assign       ed_tx_st1_prefix_o             =  'h0                                       ;
assign       ed_tx_st1_prefix_parity        =  'h0                                       ;
assign       ed_tx_st1_RSSAI_prefix         =  'h0                                       ;
assign       ed_tx_st1_RSSAI_prefix_parity  =  'h0                                       ;
assign       ed_tx_st1_pvalid_o             =  'h0                                       ;
assign       ed_tx_st1_vfactive             =  'h0                                       ;
assign       ed_tx_st1_vfnum                =  'h0                                       ;
assign       ed_tx_st1_pfnum                =  'h0                                       ;
assign       ed_tx_st1_chnum                =  'h0                                       ;
assign       ed_tx_st1_empty                =  'h0                                       ;
assign       ed_tx_st1_misc_parity          =  'h0                                       ;
assign       ed_tx_st2_dvalid_o             =  pio_tx_st2_dvalid_i                       ;
assign       ed_tx_st2_sop_o                =  pio_tx_st2_sop_i                          ;
assign       ed_tx_st2_eop_o                =  pio_tx_st2_eop_i                          ;
assign       ed_tx_st2_passthrough_o        =  'h0					 ;
assign       ed_tx_st2_payload_o            =  pio_tx_st2_payload_i                      ;
assign       ed_tx_st2_data_parity          =  'h0					 ;
assign       ed_tx_st2_header_o             =  pio_tx_st2_header_i                       ;
assign       ed_tx_st2_hdr_parity           =  'h0;
assign       ed_tx_st2_hvalid_o             =  pio_tx_st2_hvalid_i                       ;
assign       ed_tx_st2_prefix_o             =  'h0                                       ;
assign       ed_tx_st2_prefix_parity        =  'h0                                       ;
assign       ed_tx_st2_RSSAI_prefix         =  'h0                                       ;
assign       ed_tx_st2_RSSAI_prefix_parity  =  'h0                                       ;
assign       ed_tx_st2_pvalid_o             =  'h0                                       ;
assign       ed_tx_st2_vfactive             =  'h0                                       ;
assign       ed_tx_st2_vfnum                =  'h0                                       ;
assign       ed_tx_st2_pfnum                =  'h0                                       ;
assign       ed_tx_st2_chnum                =  'h0                                       ;
assign       ed_tx_st2_empty                =  'h0                                       ;
assign       ed_tx_st2_misc_parity          =  'h0                                       ;
assign       ed_tx_st3_dvalid_o             =  pio_tx_st3_dvalid_i                       ;
assign       ed_tx_st3_sop_o                =  pio_tx_st3_sop_i                          ;
assign       ed_tx_st3_eop_o                =  pio_tx_st3_eop_i                          ;
assign       ed_tx_st3_passthrough_o        =  'h0					 ;
assign       ed_tx_st3_payload_o            =  pio_tx_st3_payload_i                      ;
assign       ed_tx_st3_data_parity          =  'h0					 ;
assign       ed_tx_st3_header_o             =  pio_tx_st3_header_i                       ;
assign       ed_tx_st3_hdr_parity           =  'h0;
assign       ed_tx_st3_hvalid_o             =  pio_tx_st3_hvalid_i                       ;
assign       ed_tx_st3_prefix_o             =  'h0                                       ;
assign       ed_tx_st3_prefix_parity        =  'h0                                       ;
assign       ed_tx_st3_RSSAI_prefix         =  'h0                                       ;
assign       ed_tx_st3_RSSAI_prefix_parity  =  'h0                                       ;
assign       ed_tx_st3_pvalid_o             =  'h0                                       ;
assign       ed_tx_st3_vfactive             =  'h0                                       ;
assign       ed_tx_st3_vfnum                =  'h0                                       ;
assign       ed_tx_st3_pfnum                =  'h0                                       ;
assign       ed_tx_st3_chnum                =  'h0                                       ;
assign       ed_tx_st3_empty                =  'h0                                       ;
assign       ed_tx_st3_misc_parity          =  'h0                                       ;
end
endgenerate


generate
if(ENABLE_ONLY_DEFAULT_CONFIG==1)
begin: ONLY_CONFIG	
//--default  config                                                                      
//assign       ed_tx_st_ready_i               =  default_config_tx_st_ready_o              ;
assign       ed_tx_st0_dvalid_o             =  default_config_tx_st0_dvalid_i            ;
assign       ed_tx_st0_sop_o                =  default_config_tx_st0_sop_i               ;
assign       ed_tx_st0_eop_o                =  default_config_tx_st0_eop_i               ;
assign       ed_tx_st0_passthrough_o        =  default_config_tx_st0_passthrough_i_reg4  ;
assign       ed_tx_st0_payload_o            =  default_config_tx_st0_payload_i           ;
assign       ed_tx_st0_data_parity          =  'h0					 ;
assign       ed_tx_st0_header_o             =  default_config_tx_st0_header_i            ;
assign       ed_tx_st0_hdr_parity           =  default_config_tx_st0_hdr_parity		 ;
assign       ed_tx_st0_hvalid_o             =  default_config_tx_st0_hvalid_i            ;
assign       ed_tx_st0_prefix_o             =  'h0                                       ;
assign       ed_tx_st0_prefix_parity        =  'h0                                       ;
assign       ed_tx_st0_RSSAI_prefix         =  'h0                                       ;
assign       ed_tx_st0_RSSAI_prefix_parity  =  'h0                                       ;
assign       ed_tx_st0_pvalid_o             =  'h0                                       ;
assign       ed_tx_st0_vfactive             =  'h0                                       ;
assign       ed_tx_st0_vfnum                =  'h0                                       ;
assign       ed_tx_st0_pfnum                =  'h0                                       ;
assign       ed_tx_st0_chnum                =  'h0                                       ;
assign       ed_tx_st0_empty                =  'h0                                       ;
assign       ed_tx_st0_misc_parity          =  'h0                                       ;
assign       ed_tx_st1_dvalid_o             =  default_config_tx_st1_dvalid_i            ;
assign       ed_tx_st1_sop_o                =  default_config_tx_st1_sop_i               ;
assign       ed_tx_st1_eop_o                =  default_config_tx_st1_eop_i               ;
assign       ed_tx_st1_passthrough_o        =  'h0					 ;
assign       ed_tx_st1_payload_o            =  default_config_tx_st1_payload_i           ;
assign       ed_tx_st1_data_parity          =  'h0					 ;
assign       ed_tx_st1_header_o             =  default_config_tx_st1_header_i            ;
assign       ed_tx_st1_hdr_parity           =  'h0;
assign       ed_tx_st1_hvalid_o             =  default_config_tx_st1_hvalid_i            ;
assign       ed_tx_st1_prefix_o             =  'h0                                       ;
assign       ed_tx_st1_prefix_parity        =  'h0                                       ;
assign       ed_tx_st1_RSSAI_prefix         =  'h0                                       ;
assign       ed_tx_st1_RSSAI_prefix_parity  =  'h0                                       ;
assign       ed_tx_st1_pvalid_o             =  'h0                                       ;
assign       ed_tx_st1_vfactive             =  'h0                                       ;
assign       ed_tx_st1_vfnum                =  'h0                                       ;
assign       ed_tx_st1_pfnum                =  'h0                                       ;
assign       ed_tx_st1_chnum                =  'h0                                       ;
assign       ed_tx_st1_empty                =  'h0                                       ;
assign       ed_tx_st1_misc_parity          =  'h0                                       ;
assign       ed_tx_st2_dvalid_o             =  default_config_tx_st2_dvalid_i            ;
assign       ed_tx_st2_sop_o                =  default_config_tx_st2_sop_i               ;
assign       ed_tx_st2_eop_o                =  default_config_tx_st2_eop_i               ;
assign       ed_tx_st2_passthrough_o        =  'h0					 ;
assign       ed_tx_st2_payload_o            =  default_config_tx_st2_payload_i           ;
assign       ed_tx_st2_data_parity          =  'h0					 ;
assign       ed_tx_st2_header_o             =  default_config_tx_st2_header_i            ;
assign       ed_tx_st2_hdr_parity           =  'h0;
assign       ed_tx_st2_hvalid_o             =  default_config_tx_st2_hvalid_i            ;
assign       ed_tx_st2_prefix_o             =  'h0                                       ;
assign       ed_tx_st2_prefix_parity        =  'h0                                       ;
assign       ed_tx_st2_RSSAI_prefix         =  'h0                                       ;
assign       ed_tx_st2_RSSAI_prefix_parity  =  'h0                                       ;
assign       ed_tx_st2_pvalid_o             =  'h0                                       ;
assign       ed_tx_st2_vfactive             =  'h0                                       ;
assign       ed_tx_st2_vfnum                =  'h0                                       ;
assign       ed_tx_st2_pfnum                =  'h0                                       ;
assign       ed_tx_st2_chnum                =  'h0                                       ;
assign       ed_tx_st2_empty                =  'h0                                       ;
assign       ed_tx_st2_misc_parity          =  'h0                                       ;
assign       ed_tx_st3_dvalid_o             =  default_config_tx_st3_dvalid_i            ;
assign       ed_tx_st3_sop_o                =  default_config_tx_st3_sop_i               ;
assign       ed_tx_st3_eop_o                =  default_config_tx_st3_eop_i               ;
assign       ed_tx_st3_passthrough_o        =  'h0					 ;
assign       ed_tx_st3_payload_o            =  default_config_tx_st3_payload_i           ;
assign       ed_tx_st3_data_parity          =  'h0					 ;
assign       ed_tx_st3_header_o             =  default_config_tx_st3_header_i            ;
assign       ed_tx_st3_hdr_parity           =  'h0					 ;
assign       ed_tx_st3_hvalid_o             =  default_config_tx_st3_hvalid_i            ;
assign       ed_tx_st3_prefix_o             =  'h0                                       ;
assign       ed_tx_st3_prefix_parity        =  'h0                                       ;
assign       ed_tx_st3_RSSAI_prefix         =  'h0                                       ;
assign       ed_tx_st3_RSSAI_prefix_parity  =  'h0                                       ;
assign       ed_tx_st3_pvalid_o             =  'h0                                       ;
assign       ed_tx_st3_vfactive             =  'h0                                       ;
assign       ed_tx_st3_vfnum                =  'h0                                       ;
assign       ed_tx_st3_pfnum                =  'h0                                       ;
assign       ed_tx_st3_chnum                =  'h0                                       ;
assign       ed_tx_st3_empty                =  'h0                                       ;
assign       ed_tx_st3_misc_parity          =  'h0                                       ;
end
endgenerate

endmodule //intel_cxl_pio_ed_top
 
