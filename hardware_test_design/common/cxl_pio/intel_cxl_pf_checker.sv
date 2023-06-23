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
//  Module Name :  intel_cxl_pf_checker                                 
//  Author      :  ochittur                                   
//  Date        :  Aug 22, 2022                                 
//  Description :  Parses TLP's between PIO and Default Config
//-----------------------------------------------------------------------------
import intel_cxl_pio_parameters :: *;
module intel_cxl_pf_checker (
     input			clk,
//--ed

     input [2:0]                ed_rx_st0_bar_i,      
     input [2:0]                ed_rx_st1_bar_i,      
     input [2:0]                ed_rx_st2_bar_i,      
     input [2:0]                ed_rx_st3_bar_i,      
     input 			ed_rx_st0_eop_i,      
     input                      ed_rx_st1_eop_i,      
     input                      ed_rx_st2_eop_i,      
     input                      ed_rx_st3_eop_i,      
     input [127:0]              ed_rx_st0_header_i,   
     input [127:0]              ed_rx_st1_header_i,   
     input [127:0]              ed_rx_st2_header_i,   
     input [127:0]              ed_rx_st3_header_i,   
     input [255:0]              ed_rx_st0_payload_i,  
     input [255:0]          	ed_rx_st1_payload_i,  
     input [255:0]          	ed_rx_st2_payload_i,  
     input [255:0]          	ed_rx_st3_payload_i,  
     input  		        ed_rx_st0_sop_i,      
     input                      ed_rx_st1_sop_i,      
     input                      ed_rx_st2_sop_i,      
     input                      ed_rx_st3_sop_i,      
     input 			ed_rx_st0_hvalid_i,   
     input                      ed_rx_st1_hvalid_i,   
     input                      ed_rx_st2_hvalid_i,   
     input                      ed_rx_st3_hvalid_i,   
     input                      ed_rx_st0_dvalid_i,   
     input                      ed_rx_st1_dvalid_i,   
     input                      ed_rx_st2_dvalid_i,   
     input                      ed_rx_st3_dvalid_i,   
     input                      ed_rx_st0_pvalid_i,   
     input                      ed_rx_st1_pvalid_i,   
     input                      ed_rx_st2_pvalid_i,   
     input                      ed_rx_st3_pvalid_i,   
     input [2:0]	        ed_rx_st0_empty_i,    
     input [2:0]                ed_rx_st1_empty_i,    
     input [2:0]                ed_rx_st2_empty_i,    
     input [2:0]                ed_rx_st3_empty_i,    
     input [PFNUM_WIDTH-1:0]    ed_rx_st0_pfnum_i,         
     input [PFNUM_WIDTH-1:0]    ed_rx_st1_pfnum_i,    
     input [PFNUM_WIDTH-1:0]    ed_rx_st2_pfnum_i,    
     input [PFNUM_WIDTH-1:0]    ed_rx_st3_pfnum_i,    
     input [31:0]               ed_rx_st0_tlp_prfx_i, 
     input [31:0]               ed_rx_st1_tlp_prfx_i, 
     input [31:0]               ed_rx_st2_tlp_prfx_i, 
     input [31:0]               ed_rx_st3_tlp_prfx_i, 
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
     input 		        ed_rx_st0_passthrough_i,
     input 		        ed_rx_st1_passthrough_i,
     input 		        ed_rx_st2_passthrough_i,
     input 		        ed_rx_st3_passthrough_i,
     output logic                      ed_rx_st_ready_o,     


//--default config

     output logic  [2:0]                default_config_rx_st0_bar_o,      
     output logic  [2:0]                default_config_rx_st1_bar_o,      
     output logic  [2:0]                default_config_rx_st2_bar_o,      
     output logic  [2:0]                default_config_rx_st3_bar_o,      
     output logic  			default_config_rx_st0_eop_o,      
     output logic                       default_config_rx_st1_eop_o,      
     output logic                       default_config_rx_st2_eop_o,      
     output logic                       default_config_rx_st3_eop_o,      
     output logic  [127:0]              default_config_rx_st0_header_o,   
     output logic  [127:0]              default_config_rx_st1_header_o,   
     output logic  [127:0]              default_config_rx_st2_header_o,   
     output logic  [127:0]              default_config_rx_st3_header_o,   
     output logic  [255:0]              default_config_rx_st0_payload_o,  
     output logic  [255:0]          	default_config_rx_st1_payload_o,  
     output logic  [255:0]          	default_config_rx_st2_payload_o,  
     output logic  [255:0]          	default_config_rx_st3_payload_o,  
     output logic   		        default_config_rx_st0_sop_o,      
     output logic                       default_config_rx_st1_sop_o,      
     output logic                       default_config_rx_st2_sop_o,      
     output logic                       default_config_rx_st3_sop_o,      
     output logic  			default_config_rx_st0_hvalid_o,   
     output logic                       default_config_rx_st1_hvalid_o,   
     output logic                       default_config_rx_st2_hvalid_o,   
     output logic                       default_config_rx_st3_hvalid_o,   
     output logic                       default_config_rx_st0_dvalid_o,   
     output logic                       default_config_rx_st1_dvalid_o,   
     output logic                       default_config_rx_st2_dvalid_o,   
     output logic                       default_config_rx_st3_dvalid_o,   
     output logic                       default_config_rx_st0_pvalid_o,   
     output logic                       default_config_rx_st1_pvalid_o,   
     output logic                       default_config_rx_st2_pvalid_o,   
     output logic                       default_config_rx_st3_pvalid_o,   
     output logic  [2:0]	        default_config_rx_st0_empty_o,    
     output logic  [2:0]                default_config_rx_st1_empty_o,    
     output logic  [2:0]                default_config_rx_st2_empty_o,    
     output logic  [2:0]                default_config_rx_st3_empty_o,    
     output logic  [PFNUM_WIDTH-1:0]    default_config_rx_st0_pfnum_o,         
     output logic  [PFNUM_WIDTH-1:0]    default_config_rx_st1_pfnum_o,    
     output logic  [PFNUM_WIDTH-1:0]    default_config_rx_st2_pfnum_o,    
     output logic  [PFNUM_WIDTH-1:0]    default_config_rx_st3_pfnum_o,    
     output logic  [31:0]               default_config_rx_st0_tlp_prfx_o, 
     output logic  [31:0]               default_config_rx_st1_tlp_prfx_o, 
     output logic  [31:0]               default_config_rx_st2_tlp_prfx_o, 
     output logic  [31:0]               default_config_rx_st3_tlp_prfx_o, 
     output logic  [7:0]		default_config_rx_st0_data_parity_o,
     output logic  [3:0]		default_config_rx_st0_hdr_parity_o,
     output logic  			default_config_rx_st0_tlp_prfx_parity_o,
     output logic  [11:0] 		default_config_rx_st0_rssai_prefix_o,
     output logic  			default_config_rx_st0_rssai_prefix_parity_o,
     output logic  			default_config_rx_st0_vfactive_o,
     output logic  [10:0] 		default_config_rx_st0_vfnum_o,
     output logic  [2:0]  		default_config_rx_st0_chnum_o,
     output logic  			default_config_rx_st0_misc_parity_o,
     output logic  [7:0]		default_config_rx_st1_data_parity_o,
     output logic  [3:0]		default_config_rx_st1_hdr_parity_o,
     output logic  			default_config_rx_st1_tlp_prfx_parity_o,
     output logic  [11:0] 		default_config_rx_st1_rssai_prefix_o,
     output logic  			default_config_rx_st1_rssai_prefix_parity_o,
     output logic  			default_config_rx_st1_vfactive_o,
     output logic  [10:0] 		default_config_rx_st1_vfnum_o,
     output logic  [2:0]  		default_config_rx_st1_chnum_o,
     output logic  			default_config_rx_st1_misc_parity_o,
     output logic  [7:0]		default_config_rx_st2_data_parity_o,
     output logic  [3:0]		default_config_rx_st2_hdr_parity_o,
     output logic  			default_config_rx_st2_tlp_prfx_parity_o,
     output logic  [11:0] 		default_config_rx_st2_rssai_prefix_o,
     output logic  			default_config_rx_st2_rssai_prefix_parity_o,
     output logic  			default_config_rx_st2_vfactive_o,
     output logic  [10:0] 		default_config_rx_st2_vfnum_o,
     output logic  [2:0]  		default_config_rx_st2_chnum_o,
     output logic  			default_config_rx_st2_misc_parity_o,
     output logic  [7:0]		default_config_rx_st3_data_parity_o,
     output logic  [3:0]		default_config_rx_st3_hdr_parity_o,
     output logic  			default_config_rx_st3_tlp_prfx_parity_o,
     output logic  [11:0] 		default_config_rx_st3_rssai_prefix_o,
     output logic  			default_config_rx_st3_rssai_prefix_parity_o,
     output logic  			default_config_rx_st3_vfactive_o,
     output logic  [10:0] 		default_config_rx_st3_vfnum_o,
     output logic  [2:0]  		default_config_rx_st3_chnum_o,
     output logic  			default_config_rx_st3_misc_parity_o,
     output logic  		        default_config_rx_st0_passthrough_o,
     output logic  		        default_config_rx_st1_passthrough_o,
     output logic  		        default_config_rx_st2_passthrough_o,
     output logic  		        default_config_rx_st3_passthrough_o,
     input                     default_config_rx_st_ready_i,     



//--pio

     output logic  [2:0]                pio_rx_st0_bar_o,      
     output logic  [2:0]                pio_rx_st1_bar_o,      
     output logic  [2:0]                pio_rx_st2_bar_o,      
     output logic  [2:0]                pio_rx_st3_bar_o,      
     output logic  			pio_rx_st0_eop_o,      
     output logic                       pio_rx_st1_eop_o,      
     output logic                       pio_rx_st2_eop_o,      
     output logic                       pio_rx_st3_eop_o,      
     output logic  [127:0]              pio_rx_st0_header_o,   
     output logic  [127:0]              pio_rx_st1_header_o,   
     output logic  [127:0]              pio_rx_st2_header_o,   
     output logic  [127:0]              pio_rx_st3_header_o,   
     output logic  [255:0]              pio_rx_st0_payload_o,  
     output logic  [255:0]          	pio_rx_st1_payload_o,  
     output logic  [255:0]          	pio_rx_st2_payload_o,  
     output logic  [255:0]          	pio_rx_st3_payload_o,  
     output logic   		        pio_rx_st0_sop_o,      
     output logic                       pio_rx_st1_sop_o,      
     output logic                       pio_rx_st2_sop_o,      
     output logic                       pio_rx_st3_sop_o,      
     output logic  			pio_rx_st0_hvalid_o,   
     output logic                       pio_rx_st1_hvalid_o,   
     output logic                       pio_rx_st2_hvalid_o,   
     output logic                       pio_rx_st3_hvalid_o,   
     output logic                       pio_rx_st0_dvalid_o,   
     output logic                       pio_rx_st1_dvalid_o,   
     output logic                       pio_rx_st2_dvalid_o,   
     output logic                       pio_rx_st3_dvalid_o,   
     output logic                       pio_rx_st0_pvalid_o,   
     output logic                       pio_rx_st1_pvalid_o,   
     output logic                       pio_rx_st2_pvalid_o,   
     output logic                       pio_rx_st3_pvalid_o,   
     output logic  [2:0]	        pio_rx_st0_empty_o,    
     output logic  [2:0]                pio_rx_st1_empty_o,    
     output logic  [2:0]                pio_rx_st2_empty_o,    
     output logic  [2:0]                pio_rx_st3_empty_o,    
     output logic  [PFNUM_WIDTH-1:0]    pio_rx_st0_pfnum_o,         
     output logic  [PFNUM_WIDTH-1:0]    pio_rx_st1_pfnum_o,    
     output logic  [PFNUM_WIDTH-1:0]    pio_rx_st2_pfnum_o,    
     output logic  [PFNUM_WIDTH-1:0]    pio_rx_st3_pfnum_o,    
     output logic  [31:0]               pio_rx_st0_tlp_prfx_o, 
     output logic  [31:0]               pio_rx_st1_tlp_prfx_o, 
     output logic  [31:0]               pio_rx_st2_tlp_prfx_o, 
     output logic  [31:0]               pio_rx_st3_tlp_prfx_o, 
     output logic  [7:0]		pio_rx_st0_data_parity_o,
     output logic  [3:0]		pio_rx_st0_hdr_parity_o,
     output logic  			pio_rx_st0_tlp_prfx_parity_o,
     output logic  [11:0] 		pio_rx_st0_rssai_prefix_o,
     output logic  			pio_rx_st0_rssai_prefix_parity_o,
     output logic  			pio_rx_st0_vfactive_o,
     output logic  [10:0] 		pio_rx_st0_vfnum_o,
     output logic  [2:0]  		pio_rx_st0_chnum_o,
     output logic  			pio_rx_st0_misc_parity_o,
     output logic  [7:0]		pio_rx_st1_data_parity_o,
     output logic  [3:0]		pio_rx_st1_hdr_parity_o,
     output logic  			pio_rx_st1_tlp_prfx_parity_o,
     output logic  [11:0] 		pio_rx_st1_rssai_prefix_o,
     output logic  			pio_rx_st1_rssai_prefix_parity_o,
     output logic  			pio_rx_st1_vfactive_o,
     output logic  [10:0] 		pio_rx_st1_vfnum_o,
     output logic  [2:0]  		pio_rx_st1_chnum_o,
     output logic  			pio_rx_st1_misc_parity_o,
     output logic  [7:0]		pio_rx_st2_data_parity_o,
     output logic  [3:0]		pio_rx_st2_hdr_parity_o,
     output logic  			pio_rx_st2_tlp_prfx_parity_o,
     output logic  [11:0] 		pio_rx_st2_rssai_prefix_o,
     output logic  			pio_rx_st2_rssai_prefix_parity_o,
     output logic  			pio_rx_st2_vfactive_o,
     output logic  [10:0] 		pio_rx_st2_vfnum_o,
     output logic  [2:0]  		pio_rx_st2_chnum_o,
     output logic  			pio_rx_st2_misc_parity_o,
     output logic  [7:0]		pio_rx_st3_data_parity_o,
     output logic  [3:0]		pio_rx_st3_hdr_parity_o,
     output logic  			pio_rx_st3_tlp_prfx_parity_o,
     output logic  [11:0] 		pio_rx_st3_rssai_prefix_o,
     output logic  			pio_rx_st3_rssai_prefix_parity_o,
     output logic  			pio_rx_st3_vfactive_o,
     output logic  [10:0] 		pio_rx_st3_vfnum_o,
     output logic  [2:0]  		pio_rx_st3_chnum_o,
     output logic  			pio_rx_st3_misc_parity_o,
     output logic  		        pio_rx_st0_passthrough_o,
     output logic  		        pio_rx_st1_passthrough_o,
     output logic  		        pio_rx_st2_passthrough_o,
     output logic  		        pio_rx_st3_passthrough_o,
     input                     pio_rx_st_ready_i,
     input			rstn
    
);

//-- taking one input on all channels - so ORing

logic ed_rx_passthrough;
generate if(ENABLE_ONLY_DEFAULT_CONFIG || ENABLE_BOTH_DEFAULT_CONFIG_PIO)

assign ed_rx_passthrough =      ed_rx_st0_passthrough_i   |  
      		       		ed_rx_st1_passthrough_i   |
      		        	ed_rx_st2_passthrough_i   |
      		        	ed_rx_st3_passthrough_i   ;
endgenerate

			
generate if(ENABLE_BOTH_DEFAULT_CONFIG_PIO)
begin: BOTH_DEF_PIO
always_ff@(posedge clk)
begin
if(!ed_rx_st0_passthrough_i)                     
begin
	pio_rx_st0_bar_o                             <=  ed_rx_st0_bar_i;
	pio_rx_st0_eop_o                             <=  ed_rx_st0_eop_i;
	pio_rx_st0_header_o                          <=  ed_rx_st0_header_i;
	pio_rx_st0_payload_o                         <=  ed_rx_st0_payload_i;
	pio_rx_st0_sop_o                             <=  ed_rx_st0_sop_i;
	pio_rx_st0_hvalid_o                          <=  ed_rx_st0_hvalid_i;
	pio_rx_st0_dvalid_o                          <=  ed_rx_st0_dvalid_i;
	pio_rx_st0_pvalid_o                          <=  ed_rx_st0_pvalid_i;
	pio_rx_st0_empty_o                           <=  ed_rx_st0_empty_i;
	pio_rx_st0_pfnum_o                           <=  ed_rx_st0_pfnum_i;
	pio_rx_st0_tlp_prfx_o                        <=  ed_rx_st0_tlp_prfx_i;
	pio_rx_st0_data_parity_o                     <=  ed_rx_st0_data_parity_i;
	pio_rx_st0_hdr_parity_o                      <=  ed_rx_st0_hdr_parity_i;
	pio_rx_st0_tlp_prfx_parity_o                 <=  ed_rx_st0_tlp_prfx_parity_i;
	pio_rx_st0_rssai_prefix_o                    <=  ed_rx_st0_rssai_prefix_i;
	pio_rx_st0_rssai_prefix_parity_o             <=  ed_rx_st0_rssai_prefix_parity_i;
	pio_rx_st0_vfactive_o                        <=  ed_rx_st0_vfactive_i;
	pio_rx_st0_vfnum_o                           <=  ed_rx_st0_vfnum_i;
	pio_rx_st0_chnum_o                           <=  ed_rx_st0_chnum_i;
	pio_rx_st0_misc_parity_o                     <=  ed_rx_st0_misc_parity_i;
	pio_rx_st0_passthrough_o                     <=  ed_rx_st0_passthrough_i;
	default_config_rx_st0_bar_o                  <=  'h0;
	default_config_rx_st0_eop_o                  <=  'h0;
	default_config_rx_st0_header_o               <=  'h0;
	default_config_rx_st0_payload_o              <=  'h0;
	default_config_rx_st0_sop_o                  <=  'h0;
	default_config_rx_st0_hvalid_o               <=  'h0;
	default_config_rx_st0_dvalid_o               <=  'h0;
	default_config_rx_st0_pvalid_o               <=  'h0;
	default_config_rx_st0_empty_o                <=  'h0;
	default_config_rx_st0_pfnum_o                <=  'h0;
	default_config_rx_st0_tlp_prfx_o             <=  'h0;
	default_config_rx_st0_data_parity_o          <=  'h0;
	default_config_rx_st0_hdr_parity_o           <=  'h0;
	default_config_rx_st0_tlp_prfx_parity_o      <=  'h0;
	default_config_rx_st0_rssai_prefix_o         <=  'h0;
	default_config_rx_st0_rssai_prefix_parity_o  <=  'h0;
	default_config_rx_st0_vfactive_o             <=  'h0;
	default_config_rx_st0_vfnum_o                <=  'h0;
	default_config_rx_st0_chnum_o                <=  'h0;
	default_config_rx_st0_misc_parity_o          <=  'h0;
	default_config_rx_st0_passthrough_o          <=  'h0;
end                                              
else                                             
begin                                            
	default_config_rx_st0_bar_o                  <=  ed_rx_st0_bar_i;
	default_config_rx_st0_eop_o                  <=  ed_rx_st0_eop_i;
	default_config_rx_st0_header_o               <=  ed_rx_st0_header_i;
	default_config_rx_st0_payload_o              <=  ed_rx_st0_payload_i;
	default_config_rx_st0_sop_o                  <=  ed_rx_st0_sop_i;
	default_config_rx_st0_hvalid_o               <=  ed_rx_st0_hvalid_i;
	default_config_rx_st0_dvalid_o               <=  ed_rx_st0_dvalid_i;
	default_config_rx_st0_pvalid_o               <=  ed_rx_st0_pvalid_i;
	default_config_rx_st0_empty_o                <=  ed_rx_st0_empty_i;
	default_config_rx_st0_pfnum_o                <=  ed_rx_st0_pfnum_i;
	default_config_rx_st0_tlp_prfx_o             <=  ed_rx_st0_tlp_prfx_i;
	default_config_rx_st0_data_parity_o          <=  ed_rx_st0_data_parity_i;
	default_config_rx_st0_hdr_parity_o           <=  ed_rx_st0_hdr_parity_i;
	default_config_rx_st0_tlp_prfx_parity_o      <=  ed_rx_st0_tlp_prfx_parity_i;
	default_config_rx_st0_rssai_prefix_o         <=  ed_rx_st0_rssai_prefix_i;
	default_config_rx_st0_rssai_prefix_parity_o  <=  ed_rx_st0_rssai_prefix_parity_i;
	default_config_rx_st0_vfactive_o             <=  ed_rx_st0_vfactive_i;
	default_config_rx_st0_vfnum_o                <=  ed_rx_st0_vfnum_i;
	default_config_rx_st0_chnum_o                <=  ed_rx_st0_chnum_i;
	default_config_rx_st0_misc_parity_o          <=  ed_rx_st0_misc_parity_i;
	default_config_rx_st0_passthrough_o          <=  ed_rx_st0_passthrough_i;
	pio_rx_st0_bar_o                             <=  'h0;
	pio_rx_st0_eop_o                             <=  'h0;
	pio_rx_st0_header_o                          <=  'h0;
	pio_rx_st0_payload_o                         <=  'h0;
	pio_rx_st0_sop_o                             <=  'h0;
	pio_rx_st0_hvalid_o                          <=  'h0;
	pio_rx_st0_dvalid_o                          <=  'h0;
	pio_rx_st0_pvalid_o                          <=  'h0;
	pio_rx_st0_empty_o                           <=  'h0;
	pio_rx_st0_pfnum_o                           <=  'h0;
	pio_rx_st0_tlp_prfx_o                        <=  'h0;
	pio_rx_st0_data_parity_o                     <=  'h0;
	pio_rx_st0_hdr_parity_o                      <=  'h0;
	pio_rx_st0_tlp_prfx_parity_o                 <=  'h0;
	pio_rx_st0_rssai_prefix_o                    <=  'h0;
	pio_rx_st0_rssai_prefix_parity_o             <=  'h0;
	pio_rx_st0_vfactive_o                        <=  'h0;
	pio_rx_st0_vfnum_o                           <=  'h0;
	pio_rx_st0_chnum_o                           <=  'h0;
	pio_rx_st0_misc_parity_o                     <=  'h0;
	pio_rx_st0_passthrough_o                     <=  'h0;
end  //--st0

if(!ed_rx_st1_passthrough_i)                     
begin	
	pio_rx_st1_bar_o                             <=  ed_rx_st1_bar_i;
	pio_rx_st1_eop_o                             <=  ed_rx_st1_eop_i;
	pio_rx_st1_header_o                          <=  ed_rx_st1_header_i;
	pio_rx_st1_payload_o                         <=  ed_rx_st1_payload_i;
	pio_rx_st1_sop_o                             <=  ed_rx_st1_sop_i;
	pio_rx_st1_hvalid_o                          <=  ed_rx_st1_hvalid_i;
	pio_rx_st1_dvalid_o                          <=  ed_rx_st1_dvalid_i;
	pio_rx_st1_pvalid_o                          <=  ed_rx_st1_pvalid_i;
	pio_rx_st1_empty_o                           <=  ed_rx_st1_empty_i;
	pio_rx_st1_pfnum_o                           <=  ed_rx_st1_pfnum_i;
	pio_rx_st1_tlp_prfx_o                        <=  ed_rx_st1_tlp_prfx_i;
	pio_rx_st1_data_parity_o                     <=  ed_rx_st1_data_parity_i;
	pio_rx_st1_hdr_parity_o                      <=  ed_rx_st1_hdr_parity_i;
	pio_rx_st1_tlp_prfx_parity_o                 <=  ed_rx_st1_tlp_prfx_parity_i;
	pio_rx_st1_rssai_prefix_o                    <=  ed_rx_st1_rssai_prefix_i;
	pio_rx_st1_rssai_prefix_parity_o             <=  ed_rx_st1_rssai_prefix_parity_i;
	pio_rx_st1_vfactive_o                        <=  ed_rx_st1_vfactive_i;
	pio_rx_st1_vfnum_o                           <=  ed_rx_st1_vfnum_i;
	pio_rx_st1_chnum_o                           <=  ed_rx_st1_chnum_i;
	pio_rx_st1_misc_parity_o                     <=  ed_rx_st1_misc_parity_i;
	pio_rx_st1_passthrough_o                     <=  ed_rx_st1_passthrough_i;
	default_config_rx_st1_bar_o                  <=  'h0;
	default_config_rx_st1_eop_o                  <=  'h0;
	default_config_rx_st1_header_o               <=  'h0;
	default_config_rx_st1_payload_o              <=  'h0;
	default_config_rx_st1_sop_o                  <=  'h0;
	default_config_rx_st1_hvalid_o               <=  'h0;
	default_config_rx_st1_dvalid_o               <=  'h0;
	default_config_rx_st1_pvalid_o               <=  'h0;
	default_config_rx_st1_empty_o                <=  'h0;
	default_config_rx_st1_pfnum_o                <=  'h0;
	default_config_rx_st1_tlp_prfx_o             <=  'h0;
	default_config_rx_st1_data_parity_o          <=  'h0;
	default_config_rx_st1_hdr_parity_o           <=  'h0;
	default_config_rx_st1_tlp_prfx_parity_o      <=  'h0;
	default_config_rx_st1_rssai_prefix_o         <=  'h0;
	default_config_rx_st1_rssai_prefix_parity_o  <=  'h0;
	default_config_rx_st1_vfactive_o             <=  'h0;
	default_config_rx_st1_vfnum_o                <=  'h0;
	default_config_rx_st1_chnum_o                <=  'h0;
	default_config_rx_st1_misc_parity_o          <=  'h0;
	default_config_rx_st1_passthrough_o          <=  'h0;
end                                              
else                                             
	begin                                            
	default_config_rx_st1_bar_o                  <=  ed_rx_st1_bar_i;
	default_config_rx_st1_eop_o                  <=  ed_rx_st1_eop_i;
	default_config_rx_st1_header_o               <=  ed_rx_st1_header_i;
	default_config_rx_st1_payload_o              <=  ed_rx_st1_payload_i;
	default_config_rx_st1_sop_o                  <=  ed_rx_st1_sop_i;
	default_config_rx_st1_hvalid_o               <=  ed_rx_st1_hvalid_i;
	default_config_rx_st1_dvalid_o               <=  ed_rx_st1_dvalid_i;
	default_config_rx_st1_pvalid_o               <=  ed_rx_st1_pvalid_i;
	default_config_rx_st1_empty_o                <=  ed_rx_st1_empty_i;
	default_config_rx_st1_pfnum_o                <=  ed_rx_st1_pfnum_i;
	default_config_rx_st1_tlp_prfx_o             <=  ed_rx_st1_tlp_prfx_i;
	default_config_rx_st1_data_parity_o          <=  ed_rx_st1_data_parity_i;
	default_config_rx_st1_hdr_parity_o           <=  ed_rx_st1_hdr_parity_i;
	default_config_rx_st1_tlp_prfx_parity_o      <=  ed_rx_st1_tlp_prfx_parity_i;
	default_config_rx_st1_rssai_prefix_o         <=  ed_rx_st1_rssai_prefix_i;
	default_config_rx_st1_rssai_prefix_parity_o  <=  ed_rx_st1_rssai_prefix_parity_i;
	default_config_rx_st1_vfactive_o             <=  ed_rx_st1_vfactive_i;
	default_config_rx_st1_vfnum_o                <=  ed_rx_st1_vfnum_i;
	default_config_rx_st1_chnum_o                <=  ed_rx_st1_chnum_i;
	default_config_rx_st1_misc_parity_o          <=  ed_rx_st1_misc_parity_i;
	default_config_rx_st1_passthrough_o          <=  ed_rx_st1_passthrough_i;
	pio_rx_st1_bar_o                             <=  'h0;
	pio_rx_st1_eop_o                             <=  'h0;
	pio_rx_st1_header_o                          <=  'h0;
	pio_rx_st1_payload_o                         <=  'h0;
	pio_rx_st1_sop_o                             <=  'h0;
	pio_rx_st1_hvalid_o                          <=  'h0;
	pio_rx_st1_dvalid_o                          <=  'h0;
	pio_rx_st1_pvalid_o                          <=  'h0;
	pio_rx_st1_empty_o                           <=  'h0;
	pio_rx_st1_pfnum_o                           <=  'h0;
	pio_rx_st1_tlp_prfx_o                        <=  'h0;
	pio_rx_st1_data_parity_o                     <=  'h0;
	pio_rx_st1_hdr_parity_o                      <=  'h0;
	pio_rx_st1_tlp_prfx_parity_o                 <=  'h0;
	pio_rx_st1_rssai_prefix_o                    <=  'h0;
	pio_rx_st1_rssai_prefix_parity_o             <=  'h0;
	pio_rx_st1_vfactive_o                        <=  'h0;
	pio_rx_st1_vfnum_o                           <=  'h0;
	pio_rx_st1_chnum_o                           <=  'h0;
	pio_rx_st1_misc_parity_o                     <=  'h0;
	pio_rx_st1_passthrough_o                     <=  'h0;
end    //--st1

if(!ed_rx_st2_passthrough_i)                     
begin
	pio_rx_st2_bar_o                             <=  ed_rx_st2_bar_i;
	pio_rx_st2_eop_o                             <=  ed_rx_st2_eop_i;
	pio_rx_st2_header_o                          <=  ed_rx_st2_header_i;
	pio_rx_st2_payload_o                         <=  ed_rx_st2_payload_i;
	pio_rx_st2_sop_o                             <=  ed_rx_st2_sop_i;
	pio_rx_st2_hvalid_o                          <=  ed_rx_st2_hvalid_i;
	pio_rx_st2_dvalid_o                          <=  ed_rx_st2_dvalid_i;
	pio_rx_st2_pvalid_o                          <=  ed_rx_st2_pvalid_i;
	pio_rx_st2_empty_o                           <=  ed_rx_st2_empty_i;
	pio_rx_st2_pfnum_o                           <=  ed_rx_st2_pfnum_i;
	pio_rx_st2_tlp_prfx_o                        <=  ed_rx_st2_tlp_prfx_i;
	pio_rx_st2_data_parity_o                     <=  ed_rx_st2_data_parity_i;
	pio_rx_st2_hdr_parity_o                      <=  ed_rx_st2_hdr_parity_i;
	pio_rx_st2_tlp_prfx_parity_o                 <=  ed_rx_st2_tlp_prfx_parity_i;
	pio_rx_st2_rssai_prefix_o                    <=  ed_rx_st2_rssai_prefix_i;
	pio_rx_st2_rssai_prefix_parity_o             <=  ed_rx_st2_rssai_prefix_parity_i;
	pio_rx_st2_vfactive_o                        <=  ed_rx_st2_vfactive_i;
	pio_rx_st2_vfnum_o                           <=  ed_rx_st2_vfnum_i;
	pio_rx_st2_chnum_o                           <=  ed_rx_st2_chnum_i;
	pio_rx_st2_misc_parity_o                     <=  ed_rx_st2_misc_parity_i;
	pio_rx_st2_passthrough_o                     <=  ed_rx_st2_passthrough_i;
	default_config_rx_st2_bar_o                  <=  'h0;
	default_config_rx_st2_eop_o                  <=  'h0;
	default_config_rx_st2_header_o               <=  'h0;
	default_config_rx_st2_payload_o              <=  'h0;
	default_config_rx_st2_sop_o                  <=  'h0;
	default_config_rx_st2_hvalid_o               <=  'h0;
	default_config_rx_st2_dvalid_o               <=  'h0;
	default_config_rx_st2_pvalid_o               <=  'h0;
	default_config_rx_st2_empty_o                <=  'h0;
	default_config_rx_st2_pfnum_o                <=  'h0;
	default_config_rx_st2_tlp_prfx_o             <=  'h0;
	default_config_rx_st2_data_parity_o          <=  'h0;
	default_config_rx_st2_hdr_parity_o           <=  'h0;
	default_config_rx_st2_tlp_prfx_parity_o      <=  'h0;
	default_config_rx_st2_rssai_prefix_o         <=  'h0;
	default_config_rx_st2_rssai_prefix_parity_o  <=  'h0;
	default_config_rx_st2_vfactive_o             <=  'h0;
	default_config_rx_st2_vfnum_o                <=  'h0;
	default_config_rx_st2_chnum_o                <=  'h0;
	default_config_rx_st2_misc_parity_o          <=  'h0;
	default_config_rx_st2_passthrough_o          <=  'h0;
end                                              
else                                             
	begin                                            
	default_config_rx_st2_bar_o                  <=  ed_rx_st2_bar_i;
	default_config_rx_st2_eop_o                  <=  ed_rx_st2_eop_i;
	default_config_rx_st2_header_o               <=  ed_rx_st2_header_i;
	default_config_rx_st2_payload_o              <=  ed_rx_st2_payload_i;
	default_config_rx_st2_sop_o                  <=  ed_rx_st2_sop_i;
	default_config_rx_st2_hvalid_o               <=  ed_rx_st2_hvalid_i;
	default_config_rx_st2_dvalid_o               <=  ed_rx_st2_dvalid_i;
	default_config_rx_st2_pvalid_o               <=  ed_rx_st2_pvalid_i;
	default_config_rx_st2_empty_o                <=  ed_rx_st2_empty_i;
	default_config_rx_st2_pfnum_o                <=  ed_rx_st2_pfnum_i;
	default_config_rx_st2_tlp_prfx_o             <=  ed_rx_st2_tlp_prfx_i;
	default_config_rx_st2_data_parity_o          <=  ed_rx_st2_data_parity_i;
	default_config_rx_st2_hdr_parity_o           <=  ed_rx_st2_hdr_parity_i;
	default_config_rx_st2_tlp_prfx_parity_o      <=  ed_rx_st2_tlp_prfx_parity_i;
	default_config_rx_st2_rssai_prefix_o         <=  ed_rx_st2_rssai_prefix_i;
	default_config_rx_st2_rssai_prefix_parity_o  <=  ed_rx_st2_rssai_prefix_parity_i;
	default_config_rx_st2_vfactive_o             <=  ed_rx_st2_vfactive_i;
	default_config_rx_st2_vfnum_o                <=  ed_rx_st2_vfnum_i;
	default_config_rx_st2_chnum_o                <=  ed_rx_st2_chnum_i;
	default_config_rx_st2_misc_parity_o          <=  ed_rx_st2_misc_parity_i;
	default_config_rx_st2_passthrough_o          <=  ed_rx_st2_passthrough_i;
	pio_rx_st2_bar_o                             <=  'h0;
	pio_rx_st2_eop_o                             <=  'h0;
	pio_rx_st2_header_o                          <=  'h0;
	pio_rx_st2_payload_o                         <=  'h0;
	pio_rx_st2_sop_o                             <=  'h0;
	pio_rx_st2_hvalid_o                          <=  'h0;
	pio_rx_st2_dvalid_o                          <=  'h0;
	pio_rx_st2_pvalid_o                          <=  'h0;
	pio_rx_st2_empty_o                           <=  'h0;
	pio_rx_st2_pfnum_o                           <=  'h0;
	pio_rx_st2_tlp_prfx_o                        <=  'h0;
	pio_rx_st2_data_parity_o                     <=  'h0;
	pio_rx_st2_hdr_parity_o                      <=  'h0;
	pio_rx_st2_tlp_prfx_parity_o                 <=  'h0;
	pio_rx_st2_rssai_prefix_o                    <=  'h0;
	pio_rx_st2_rssai_prefix_parity_o             <=  'h0;
	pio_rx_st2_vfactive_o                        <=  'h0;
	pio_rx_st2_vfnum_o                           <=  'h0;
	pio_rx_st2_chnum_o                           <=  'h0;
	pio_rx_st2_misc_parity_o                     <=  'h0;
	pio_rx_st2_passthrough_o                     <=  'h0;
end     //--st2

if(!ed_rx_st3_passthrough_i)                     
begin
	pio_rx_st3_bar_o                             <=  ed_rx_st3_bar_i;
	pio_rx_st3_eop_o                             <=  ed_rx_st3_eop_i;
	pio_rx_st3_header_o                          <=  ed_rx_st3_header_i;
	pio_rx_st3_payload_o                         <=  ed_rx_st3_payload_i;
	pio_rx_st3_sop_o                             <=  ed_rx_st3_sop_i;
	pio_rx_st3_hvalid_o                          <=  ed_rx_st3_hvalid_i;
	pio_rx_st3_dvalid_o                          <=  ed_rx_st3_dvalid_i;
	pio_rx_st3_pvalid_o                          <=  ed_rx_st3_pvalid_i;
	pio_rx_st3_empty_o                           <=  ed_rx_st3_empty_i;
	pio_rx_st3_pfnum_o                           <=  ed_rx_st3_pfnum_i;
	pio_rx_st3_tlp_prfx_o                        <=  ed_rx_st3_tlp_prfx_i;
	pio_rx_st3_data_parity_o                     <=  ed_rx_st3_data_parity_i;
	pio_rx_st3_hdr_parity_o                      <=  ed_rx_st3_hdr_parity_i;
	pio_rx_st3_tlp_prfx_parity_o                 <=  ed_rx_st3_tlp_prfx_parity_i;
	pio_rx_st3_rssai_prefix_o                    <=  ed_rx_st3_rssai_prefix_i;
	pio_rx_st3_rssai_prefix_parity_o             <=  ed_rx_st3_rssai_prefix_parity_i;
	pio_rx_st3_vfactive_o                        <=  ed_rx_st3_vfactive_i;
	pio_rx_st3_vfnum_o                           <=  ed_rx_st3_vfnum_i;
	pio_rx_st3_chnum_o                           <=  ed_rx_st3_chnum_i;
	pio_rx_st3_misc_parity_o                     <=  ed_rx_st3_misc_parity_i;
	pio_rx_st3_passthrough_o                     <=  ed_rx_st3_passthrough_i;
	default_config_rx_st3_bar_o                  <=  'h0;
	default_config_rx_st3_eop_o                  <=  'h0;
	default_config_rx_st3_header_o               <=  'h0;
	default_config_rx_st3_payload_o              <=  'h0;
	default_config_rx_st3_sop_o                  <=  'h0;
	default_config_rx_st3_hvalid_o               <=  'h0;
	default_config_rx_st3_dvalid_o               <=  'h0;
	default_config_rx_st3_pvalid_o               <=  'h0;
	default_config_rx_st3_empty_o                <=  'h0;
	default_config_rx_st3_pfnum_o                <=  'h0;
	default_config_rx_st3_tlp_prfx_o             <=  'h0;
	default_config_rx_st3_data_parity_o          <=  'h0;
	default_config_rx_st3_hdr_parity_o           <=  'h0;
	default_config_rx_st3_tlp_prfx_parity_o      <=  'h0;
	default_config_rx_st3_rssai_prefix_o         <=  'h0;
	default_config_rx_st3_rssai_prefix_parity_o  <=  'h0;
	default_config_rx_st3_vfactive_o             <=  'h0;
	default_config_rx_st3_vfnum_o                <=  'h0;
	default_config_rx_st3_chnum_o                <=  'h0;
	default_config_rx_st3_misc_parity_o          <=  'h0;
	default_config_rx_st3_passthrough_o          <=  'h0;
end                                              
else                                             
	begin                                            
	default_config_rx_st3_bar_o                  <=  ed_rx_st3_bar_i;
	default_config_rx_st3_eop_o                  <=  ed_rx_st3_eop_i;
	default_config_rx_st3_header_o               <=  ed_rx_st3_header_i;
	default_config_rx_st3_payload_o              <=  ed_rx_st3_payload_i;
	default_config_rx_st3_sop_o                  <=  ed_rx_st3_sop_i;
	default_config_rx_st3_hvalid_o               <=  ed_rx_st3_hvalid_i;
	default_config_rx_st3_dvalid_o               <=  ed_rx_st3_dvalid_i;
	default_config_rx_st3_pvalid_o               <=  ed_rx_st3_pvalid_i;
	default_config_rx_st3_empty_o                <=  ed_rx_st3_empty_i;
	default_config_rx_st3_pfnum_o                <=  ed_rx_st3_pfnum_i;
	default_config_rx_st3_tlp_prfx_o             <=  ed_rx_st3_tlp_prfx_i;
	default_config_rx_st3_data_parity_o          <=  ed_rx_st3_data_parity_i;
	default_config_rx_st3_hdr_parity_o           <=  ed_rx_st3_hdr_parity_i;
	default_config_rx_st3_tlp_prfx_parity_o      <=  ed_rx_st3_tlp_prfx_parity_i;
	default_config_rx_st3_rssai_prefix_o         <=  ed_rx_st3_rssai_prefix_i;
	default_config_rx_st3_rssai_prefix_parity_o  <=  ed_rx_st3_rssai_prefix_parity_i;
	default_config_rx_st3_vfactive_o             <=  ed_rx_st3_vfactive_i;
	default_config_rx_st3_vfnum_o                <=  ed_rx_st3_vfnum_i;
	default_config_rx_st3_chnum_o                <=  ed_rx_st3_chnum_i;
	default_config_rx_st3_misc_parity_o          <=  ed_rx_st3_misc_parity_i;
	default_config_rx_st3_passthrough_o          <=  ed_rx_st3_passthrough_i;
	pio_rx_st3_bar_o                             <=  'h0;
	pio_rx_st3_eop_o                             <=  'h0;
	pio_rx_st3_header_o                          <=  'h0;
	pio_rx_st3_payload_o                         <=  'h0;
	pio_rx_st3_sop_o                             <=  'h0;
	pio_rx_st3_hvalid_o                          <=  'h0;
	pio_rx_st3_dvalid_o                          <=  'h0;
	pio_rx_st3_pvalid_o                          <=  'h0;
	pio_rx_st3_empty_o                           <=  'h0;
	pio_rx_st3_pfnum_o                           <=  'h0;
	pio_rx_st3_tlp_prfx_o                        <=  'h0;
	pio_rx_st3_data_parity_o                     <=  'h0;
	pio_rx_st3_hdr_parity_o                      <=  'h0;
	pio_rx_st3_tlp_prfx_parity_o                 <=  'h0;
	pio_rx_st3_rssai_prefix_o                    <=  'h0;
	pio_rx_st3_rssai_prefix_parity_o             <=  'h0;
	pio_rx_st3_vfactive_o                        <=  'h0;
	pio_rx_st3_vfnum_o                           <=  'h0;
	pio_rx_st3_chnum_o                           <=  'h0;
	pio_rx_st3_misc_parity_o                     <=  'h0;
	pio_rx_st3_passthrough_o                     <=  'h0;
end     //--st3                                             
end //always

assign ed_rx_st_ready_o =  default_config_rx_st_ready_i &  pio_rx_st_ready_i;
end
endgenerate


//--default config
generate if(ENABLE_ONLY_DEFAULT_CONFIG)
begin: ONLY_DEF
always_ff@(posedge clk)
begin
	     default_config_rx_st0_bar_o                 <=    ed_rx_st0_bar_i;                          
	     default_config_rx_st1_bar_o                 <=    ed_rx_st1_bar_i;      
	     default_config_rx_st2_bar_o                 <=    ed_rx_st2_bar_i;      
	     default_config_rx_st3_bar_o                 <=    ed_rx_st3_bar_i;      
	     default_config_rx_st0_eop_o                 <=    ed_rx_st0_eop_i;      
	     default_config_rx_st1_eop_o                 <=    ed_rx_st1_eop_i;      
	     default_config_rx_st2_eop_o                 <=    ed_rx_st2_eop_i;      
	     default_config_rx_st3_eop_o                 <=    ed_rx_st3_eop_i;      
	     default_config_rx_st0_header_o              <=    ed_rx_st0_header_i;   
	     default_config_rx_st1_header_o              <=    ed_rx_st1_header_i;   
	     default_config_rx_st2_header_o              <=    ed_rx_st2_header_i;   
	     default_config_rx_st3_header_o              <=    ed_rx_st3_header_i;   
	     default_config_rx_st0_payload_o             <=    ed_rx_st0_payload_i;  
	     default_config_rx_st1_payload_o             <=    ed_rx_st1_payload_i;  
	     default_config_rx_st2_payload_o             <=    ed_rx_st2_payload_i;  
	     default_config_rx_st3_payload_o             <=    ed_rx_st3_payload_i;  
	     default_config_rx_st0_sop_o                 <=    ed_rx_st0_sop_i;      
	     default_config_rx_st1_sop_o                 <=    ed_rx_st1_sop_i;      
	     default_config_rx_st2_sop_o                 <=    ed_rx_st2_sop_i;      
	     default_config_rx_st3_sop_o                 <=    ed_rx_st3_sop_i;      
	     default_config_rx_st0_hvalid_o              <=    ed_rx_st0_hvalid_i;   
	     default_config_rx_st1_hvalid_o              <=    ed_rx_st1_hvalid_i;   
	     default_config_rx_st2_hvalid_o              <=    ed_rx_st2_hvalid_i;   
	     default_config_rx_st3_hvalid_o              <=    ed_rx_st3_hvalid_i;   
	     default_config_rx_st0_dvalid_o              <=    ed_rx_st0_dvalid_i;   
	     default_config_rx_st1_dvalid_o              <=    ed_rx_st1_dvalid_i;   
	     default_config_rx_st2_dvalid_o              <=    ed_rx_st2_dvalid_i;   
	     default_config_rx_st3_dvalid_o              <=    ed_rx_st3_dvalid_i;   
	     default_config_rx_st0_pvalid_o              <=    ed_rx_st0_pvalid_i;   
	     default_config_rx_st1_pvalid_o              <=    ed_rx_st1_pvalid_i;   
	     default_config_rx_st2_pvalid_o              <=    ed_rx_st2_pvalid_i;   
	     default_config_rx_st3_pvalid_o              <=    ed_rx_st3_pvalid_i;   
	     default_config_rx_st0_empty_o               <=    ed_rx_st0_empty_i;    
	     default_config_rx_st1_empty_o               <=    ed_rx_st1_empty_i;    
	     default_config_rx_st2_empty_o               <=    ed_rx_st2_empty_i;    
	     default_config_rx_st3_empty_o               <=    ed_rx_st3_empty_i;    
	     default_config_rx_st0_pfnum_o               <=    ed_rx_st0_pfnum_i;         
	     default_config_rx_st1_pfnum_o               <=    ed_rx_st1_pfnum_i;    
	     default_config_rx_st2_pfnum_o               <=    ed_rx_st2_pfnum_i;    
	     default_config_rx_st3_pfnum_o               <=    ed_rx_st3_pfnum_i;    
	     default_config_rx_st0_tlp_prfx_o            <=    ed_rx_st0_tlp_prfx_i; 
	     default_config_rx_st1_tlp_prfx_o            <=    ed_rx_st1_tlp_prfx_i; 
	     default_config_rx_st2_tlp_prfx_o            <=    ed_rx_st2_tlp_prfx_i; 
	     default_config_rx_st3_tlp_prfx_o            <=    ed_rx_st3_tlp_prfx_i; 
	     default_config_rx_st0_data_parity_o         <=    ed_rx_st0_data_parity_i;
	     default_config_rx_st0_hdr_parity_o          <=    ed_rx_st0_hdr_parity_i;
	     default_config_rx_st0_tlp_prfx_parity_o     <=    ed_rx_st0_tlp_prfx_parity_i;
	     default_config_rx_st0_rssai_prefix_o        <=    ed_rx_st0_rssai_prefix_i;
	     default_config_rx_st0_rssai_prefix_parity_o <=    ed_rx_st0_rssai_prefix_parity_i;
	     default_config_rx_st0_vfactive_o            <=    ed_rx_st0_vfactive_i;
	     default_config_rx_st0_vfnum_o               <=    ed_rx_st0_vfnum_i;
	     default_config_rx_st0_chnum_o               <=    ed_rx_st0_chnum_i;
	     default_config_rx_st0_misc_parity_o         <=    ed_rx_st0_misc_parity_i;
	     default_config_rx_st1_data_parity_o         <=    ed_rx_st1_data_parity_i;
	     default_config_rx_st1_hdr_parity_o          <=    ed_rx_st1_hdr_parity_i;
	     default_config_rx_st1_tlp_prfx_parity_o     <=    ed_rx_st1_tlp_prfx_parity_i;
	     default_config_rx_st1_rssai_prefix_o        <=    ed_rx_st1_rssai_prefix_i;
	     default_config_rx_st1_rssai_prefix_parity_o <=    ed_rx_st1_rssai_prefix_parity_i;
	     default_config_rx_st1_vfactive_o            <=    ed_rx_st1_vfactive_i;
	     default_config_rx_st1_vfnum_o               <=    ed_rx_st1_vfnum_i;
	     default_config_rx_st1_chnum_o               <=    ed_rx_st1_chnum_i;
	     default_config_rx_st1_misc_parity_o         <=    ed_rx_st1_misc_parity_i;
	     default_config_rx_st2_data_parity_o         <=    ed_rx_st2_data_parity_i;
	     default_config_rx_st2_hdr_parity_o          <=    ed_rx_st2_hdr_parity_i;
	     default_config_rx_st2_tlp_prfx_parity_o     <=    ed_rx_st2_tlp_prfx_parity_i;
	     default_config_rx_st2_rssai_prefix_o        <=    ed_rx_st2_rssai_prefix_i;
	     default_config_rx_st2_rssai_prefix_parity_o <=    ed_rx_st2_rssai_prefix_parity_i;
	     default_config_rx_st2_vfactive_o            <=    ed_rx_st2_vfactive_i;
	     default_config_rx_st2_vfnum_o               <=    ed_rx_st2_vfnum_i;
	     default_config_rx_st2_chnum_o               <=    ed_rx_st2_chnum_i;
	     default_config_rx_st2_misc_parity_o         <=    ed_rx_st2_misc_parity_i;
	     default_config_rx_st3_data_parity_o         <=    ed_rx_st3_data_parity_i;
	     default_config_rx_st3_hdr_parity_o          <=    ed_rx_st3_hdr_parity_i;
	     default_config_rx_st3_tlp_prfx_parity_o     <=    ed_rx_st3_tlp_prfx_parity_i;
	     default_config_rx_st3_rssai_prefix_o        <=    ed_rx_st3_rssai_prefix_i;
	     default_config_rx_st3_rssai_prefix_parity_o <=    ed_rx_st3_rssai_prefix_parity_i;
	     default_config_rx_st3_vfactive_o            <=    ed_rx_st3_vfactive_i;
	     default_config_rx_st3_vfnum_o               <=    ed_rx_st3_vfnum_i;
	     default_config_rx_st3_chnum_o               <=    ed_rx_st3_chnum_i;
	     default_config_rx_st3_misc_parity_o         <=    ed_rx_st3_misc_parity_i;
	     default_config_rx_st0_passthrough_o         <=    ed_rx_st0_passthrough_i;
	     default_config_rx_st1_passthrough_o         <=    ed_rx_st1_passthrough_i;
	     default_config_rx_st2_passthrough_o         <=    ed_rx_st2_passthrough_i;
	     default_config_rx_st3_passthrough_o         <=    ed_rx_st3_passthrough_i;
end //always

assign ed_rx_st_ready_o =  default_config_rx_st_ready_i ;
end
endgenerate



//--pio

generate if(ENABLE_ONLY_PIO)
begin: ONLY_PIO
always_ff@(posedge clk)
begin
	     pio_rx_st0_bar_o                 <=    ed_rx_st0_bar_i;                          
	     pio_rx_st1_bar_o                 <=    ed_rx_st1_bar_i;      
	     pio_rx_st2_bar_o                 <=    ed_rx_st2_bar_i;      
	     pio_rx_st3_bar_o                 <=    ed_rx_st3_bar_i;      
	     pio_rx_st0_eop_o                 <=    ed_rx_st0_eop_i;      
	     pio_rx_st1_eop_o                 <=    ed_rx_st1_eop_i;      
	     pio_rx_st2_eop_o                 <=    ed_rx_st2_eop_i;      
	     pio_rx_st3_eop_o                 <=    ed_rx_st3_eop_i;      
	     pio_rx_st0_header_o              <=    ed_rx_st0_header_i;   
	     pio_rx_st1_header_o              <=    ed_rx_st1_header_i;   
	     pio_rx_st2_header_o              <=    ed_rx_st2_header_i;   
	     pio_rx_st3_header_o              <=    ed_rx_st3_header_i;   
	     pio_rx_st0_payload_o             <=    ed_rx_st0_payload_i;  
	     pio_rx_st1_payload_o             <=    ed_rx_st1_payload_i;  
	     pio_rx_st2_payload_o             <=    ed_rx_st2_payload_i;  
	     pio_rx_st3_payload_o             <=    ed_rx_st3_payload_i;  
	     pio_rx_st0_sop_o                 <=    ed_rx_st0_sop_i;      
	     pio_rx_st1_sop_o                 <=    ed_rx_st1_sop_i;      
	     pio_rx_st2_sop_o                 <=    ed_rx_st2_sop_i;      
	     pio_rx_st3_sop_o                 <=    ed_rx_st3_sop_i;      
	     pio_rx_st0_hvalid_o              <=    ed_rx_st0_hvalid_i;   
	     pio_rx_st1_hvalid_o              <=    ed_rx_st1_hvalid_i;   
	     pio_rx_st2_hvalid_o              <=    ed_rx_st2_hvalid_i;   
	     pio_rx_st3_hvalid_o              <=    ed_rx_st3_hvalid_i;   
	     pio_rx_st0_dvalid_o              <=    ed_rx_st0_dvalid_i;   
	     pio_rx_st1_dvalid_o              <=    ed_rx_st1_dvalid_i;   
	     pio_rx_st2_dvalid_o              <=    ed_rx_st2_dvalid_i;   
	     pio_rx_st3_dvalid_o              <=    ed_rx_st3_dvalid_i;   
	     pio_rx_st0_pvalid_o              <=    ed_rx_st0_pvalid_i;   
	     pio_rx_st1_pvalid_o              <=    ed_rx_st1_pvalid_i;   
	     pio_rx_st2_pvalid_o              <=    ed_rx_st2_pvalid_i;   
	     pio_rx_st3_pvalid_o              <=    ed_rx_st3_pvalid_i;   
	     pio_rx_st0_empty_o               <=    ed_rx_st0_empty_i;    
	     pio_rx_st1_empty_o               <=    ed_rx_st1_empty_i;    
	     pio_rx_st2_empty_o               <=    ed_rx_st2_empty_i;    
	     pio_rx_st3_empty_o               <=    ed_rx_st3_empty_i;    
	     pio_rx_st0_pfnum_o               <=    ed_rx_st0_pfnum_i;         
	     pio_rx_st1_pfnum_o               <=    ed_rx_st1_pfnum_i;    
	     pio_rx_st2_pfnum_o               <=    ed_rx_st2_pfnum_i;    
	     pio_rx_st3_pfnum_o               <=    ed_rx_st3_pfnum_i;    
	     pio_rx_st0_tlp_prfx_o            <=    ed_rx_st0_tlp_prfx_i; 
	     pio_rx_st1_tlp_prfx_o            <=    ed_rx_st1_tlp_prfx_i; 
	     pio_rx_st2_tlp_prfx_o            <=    ed_rx_st2_tlp_prfx_i; 
	     pio_rx_st3_tlp_prfx_o            <=    ed_rx_st3_tlp_prfx_i; 
	     pio_rx_st0_data_parity_o         <=    ed_rx_st0_data_parity_i;
	     pio_rx_st0_hdr_parity_o          <=    ed_rx_st0_hdr_parity_i;
	     pio_rx_st0_tlp_prfx_parity_o     <=    ed_rx_st0_tlp_prfx_parity_i;
	     pio_rx_st0_rssai_prefix_o        <=    ed_rx_st0_rssai_prefix_i;
	     pio_rx_st0_rssai_prefix_parity_o <=    ed_rx_st0_rssai_prefix_parity_i;
	     pio_rx_st0_vfactive_o            <=    ed_rx_st0_vfactive_i;
	     pio_rx_st0_vfnum_o               <=    ed_rx_st0_vfnum_i;
	     pio_rx_st0_chnum_o               <=    ed_rx_st0_chnum_i;
	     pio_rx_st0_misc_parity_o         <=    ed_rx_st0_misc_parity_i;
	     pio_rx_st1_data_parity_o         <=    ed_rx_st1_data_parity_i;
	     pio_rx_st1_hdr_parity_o          <=    ed_rx_st1_hdr_parity_i;
	     pio_rx_st1_tlp_prfx_parity_o     <=    ed_rx_st1_tlp_prfx_parity_i;
	     pio_rx_st1_rssai_prefix_o        <=    ed_rx_st1_rssai_prefix_i;
	     pio_rx_st1_rssai_prefix_parity_o <=    ed_rx_st1_rssai_prefix_parity_i;
	     pio_rx_st1_vfactive_o            <=    ed_rx_st1_vfactive_i;
	     pio_rx_st1_vfnum_o               <=    ed_rx_st1_vfnum_i;
	     pio_rx_st1_chnum_o               <=    ed_rx_st1_chnum_i;
	     pio_rx_st1_misc_parity_o         <=    ed_rx_st1_misc_parity_i;
	     pio_rx_st2_data_parity_o         <=    ed_rx_st2_data_parity_i;
	     pio_rx_st2_hdr_parity_o          <=    ed_rx_st2_hdr_parity_i;
	     pio_rx_st2_tlp_prfx_parity_o     <=    ed_rx_st2_tlp_prfx_parity_i;
	     pio_rx_st2_rssai_prefix_o        <=    ed_rx_st2_rssai_prefix_i;
	     pio_rx_st2_rssai_prefix_parity_o <=    ed_rx_st2_rssai_prefix_parity_i;
	     pio_rx_st2_vfactive_o            <=    ed_rx_st2_vfactive_i;
	     pio_rx_st2_vfnum_o               <=    ed_rx_st2_vfnum_i;
	     pio_rx_st2_chnum_o               <=    ed_rx_st2_chnum_i;
	     pio_rx_st2_misc_parity_o         <=    ed_rx_st2_misc_parity_i;
	     pio_rx_st3_data_parity_o         <=    ed_rx_st3_data_parity_i;
	     pio_rx_st3_hdr_parity_o          <=    ed_rx_st3_hdr_parity_i;
	     pio_rx_st3_tlp_prfx_parity_o     <=    ed_rx_st3_tlp_prfx_parity_i;
	     pio_rx_st3_rssai_prefix_o        <=    ed_rx_st3_rssai_prefix_i;
	     pio_rx_st3_rssai_prefix_parity_o <=    ed_rx_st3_rssai_prefix_parity_i;
	     pio_rx_st3_vfactive_o            <=    ed_rx_st3_vfactive_i;
	     pio_rx_st3_vfnum_o               <=    ed_rx_st3_vfnum_i;
	     pio_rx_st3_chnum_o               <=    ed_rx_st3_chnum_i;
	     pio_rx_st3_misc_parity_o         <=    ed_rx_st3_misc_parity_i;
	     pio_rx_st0_passthrough_o         <=    ed_rx_st0_passthrough_i;
	     pio_rx_st1_passthrough_o         <=    ed_rx_st1_passthrough_i;
	     pio_rx_st2_passthrough_o         <=    ed_rx_st2_passthrough_i;
	     pio_rx_st3_passthrough_o         <=    ed_rx_st3_passthrough_i;
end //always

assign ed_rx_st_ready_o =  pio_rx_st_ready_i ;
end
endgenerate

endmodule //intel_cxl_pf_checker
