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
//  Module Name :  intel_cxl_default_config                                 
//  Author      :  ochittur                                   
//  Date        :  Aug 22, 2022                                 
//  Description :  Generation of UR for incoming TLP's
//-----------------------------------------------------------------------------

import intel_cxl_pio_parameters :: *;

module intel_cxl_default_config (
     input                                clk,
     input				  rst_n,
     input  logic [2:0]                   default_config_rx_bar,
     input  logic                         default_config_rx_sop_i,
     input  logic                         default_config_rx_eop_i,
     input  logic [127:0]                 default_config_rx_header_i,
     input  logic [BAM_DATAWIDTH-1:0]     default_config_rx_payload_i,
     input  logic                         default_config_rx_valid_i,
     input  logic [7:0]			  default_config_rx_bus_number,
     input  logic [4:0]			  default_config_rx_device_number,
     input  logic [2:0]			  default_config_rx_function_number,
     output logic			  default_config_rx_st_ready_o,
     input  logic			  default_config_tx_st_ready_i,
     output logic                         default_config_txc_eop,
     output logic [127:0]                 default_config_txc_header,
     output logic [BAM_DATAWIDTH-1:0]     default_config_txc_payload,
     output logic                         default_config_txc_sop,
     output logic                         default_config_txc_valid,
     //-- passthrough signals
     output logic  		        ed_tx_st0_passthrough_o,
     output logic  		        ed_tx_st1_passthrough_o,
     output logic  		        ed_tx_st2_passthrough_o,
     output logic  		        ed_tx_st3_passthrough_o,

     //--to credit module
     output logic [9:0]        dc_hdr_len_o,
     output logic 	       dc_hdr_valid_o,
     output logic 	       dc_hdr_is_rd_o,
     output logic	       dc_hdr_is_rd_with_data_o,
     output logic  	       dc_hdr_is_wr_no_data_o, 
     output logic  	       dc_hdr_is_cpl_no_data_o, 
     output logic  	       dc_hdr_is_cpl_o, 
     output logic  	       dc_hdr_is_wr_o, 
     output logic 	       dc_bam_rx_signal_ready_o,
     output logic 	       dc_tx_hdr_valid_o  // signal to tell the header is valid. Connect to bam_txc_valid_o
);



logic                         default_config_rx_sop;
logic                         default_config_rx_eop;
logic [127:0]                 default_config_rx_header;
logic [BAM_DATAWIDTH-1:0]     default_config_rx_payload;
logic                         default_config_rx_valid;

//completions should not be sentt for Mem_Wr,Msg,MsgD
//

logic Mem_Wr_tlp;
logic Msg_tlp;
logic MsgD_tlp;
logic drop_tlp;

assign Mem_Wr_tlp = (default_config_rx_header_i[31:29]==3'b010 || default_config_rx_header_i[31:29]==3'b011) && (default_config_rx_header_i[28:24] == 5'h0);
assign Msg_tlp  = (default_config_rx_header_i[31:29] == 3'b001) && (default_config_rx_header_i[28:27] == 2'b10);
assign MsgD_tlp = (default_config_rx_header_i[31:29] == 3'b011) && (default_config_rx_header_i[28:27] == 2'b10);
assign drop_tlp = Mem_Wr_tlp || Msg_tlp || MsgD_tlp ;

always_ff@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		default_config_rx_sop 	<= 1'b0; 
		default_config_rx_eop 	<= 1'b0;
		default_config_rx_header<= 128'h0;
		default_config_rx_valid <= 1'h0;
	end
	else
	begin
		default_config_rx_sop 	<=  drop_tlp ? 1'h0   : default_config_rx_sop_i ; 	
		default_config_rx_eop 	<=  drop_tlp ? 1'h0   : default_config_rx_eop_i ; 	
		default_config_rx_header<=  drop_tlp ? 128'h0 : default_config_rx_header_i ;
		default_config_rx_valid <=  drop_tlp ? 1'h0   : default_config_rx_valid_i ; 
	end
end


//decode header
logic [31:0] rx_first_dword ;
logic [31:0] rx_second_dword;
logic [31:0] rx_third_dword ;
logic [31:0] rx_fourth_dword;


assign rx_first_dword 	= default_config_rx_header[31:0] ;
assign rx_second_dword	= default_config_rx_header[63:32] ;
assign rx_third_dword	= default_config_rx_header[95:64] ;
assign rx_fourth_dword	= default_config_rx_header[127:96] ;

//send UR

logic [31:0] tx_first_dword ;	
logic [31:0] tx_second_dword;	
logic [31:0] tx_third_dword ;    
logic [31:0] tx_fourth_dword;	


logic [2:0] fmt = 3'b0;
logic [4:0] type_field = 5'hA; //A
logic [9:0] length = 10'd0;
logic [13:0] first_dword_misc ;

assign first_dword_misc = rx_first_dword[23:10];

logic [15:0] completer_id ; 

assign completer_id = {default_config_rx_bus_number,default_config_rx_device_number,3'h0};   //--here we should write the {bus,device,func} numbers {8,5,3}

logic [2:0] cpl_status = 3'b001;
logic bcm = 1'b0;
logic [11:0] byte_count = 12'h4;

logic [15:0] requester_id ;
logic [7:0] tag ;

assign  requester_id = rx_second_dword[31:16];
assign  tag = rx_second_dword[15:8];

logic reserved = 1'b0;
//logic [6:0] lower_address = 7'd0;
logic [6:0] lower_address;
//assign lower_address = ((default_config_rx_header[31:24] == 8'h0) ||  (default_config_rx_header[31:24] == 8'b0010_0000)) ? {default_config_rx_header[102:98],2'h0} :7'd0;
assign lower_address = (default_config_rx_header[31:24] == 8'h0)         ? {rx_third_dword[6:2],2'h0}  :
                       (default_config_rx_header[31:24] == 8'b0010_0000) ? {rx_fourth_dword[6:2],2'h0} :7'd0;


//assign dc_hdr_len_o   = rx_first_dword[9:0];
//assign dc_hdr_valid_o = default_config_rx_valid;
//assign dc_hdr_is_wr_o = rx_first_dword[30] & (rx_first_dword[28:24] == 5'h0) ; 
//assign dc_hdr_is_rd_o = ~rx_first_dword[30] & (rx_first_dword[28:26] == 3'h0) ;
//--
//TLP_TYPE [31:24]  TYPE  HEADER  DATA
//MRd 	 0000000 	NP	y	y
//MRd 	 0100000 	NP	y	y
//MRdLk 	 0000001 	NP	y	y
//MRdLk 	 0100001 	NP	y	y
//IORd 	 0000010 	NP	y	y
//IOWr 	 1000010 	NP	y	y
//CfgRd0 	 0000100 	NP	y	y
//CfgWr0 	 1000100 	NP	y	y
//CfgRd1 	 0000101 	NP	y	y
//CfgWr1 	 1000101 	NP	y	y
//MWr 	 1000000 	P	y	y
//MWr 	 1100000 	P	y	y
//Msg 	 0110xxx 	p	y	n
//MsgD 	 1110xxx 	p	y	Y
//------------------------
//Cpl 	0001010	        C	y	n
//CplD 	1001010 	C	y	y
//CplLk 	0001011 	C	y	y
//CplDLk 	1001011 	C	y	y

always_comb
begin
	case(default_config_rx_header_i[31:24])
		8'b00000000: dc_hdr_is_rd_o 		= 1'b1;
		8'b00100000: dc_hdr_is_rd_o 		= 1'b1;
		8'b00000001: dc_hdr_is_rd_o 		= 1'b1;
		8'b00100001: dc_hdr_is_rd_o 		= 1'b1;
		8'b00000010: dc_hdr_is_rd_o 		= 1'b1;
		8'b00000100: dc_hdr_is_rd_o 		= 1'b1;
		8'b00000101: dc_hdr_is_rd_o 		= 1'b1;
		default   : dc_hdr_is_rd_o		= 1'b0;
	endcase
end

always_comb
begin
	case(default_config_rx_header_i[31:24])
		8'b01000010: dc_hdr_is_rd_with_data_o 	= 1'b1;
		8'b01000100: dc_hdr_is_rd_with_data_o	= 1'b1;
		8'b01000101: dc_hdr_is_rd_with_data_o	= 1'b1;
		default    : dc_hdr_is_rd_with_data_o   = 1'b0;
	endcase
end

assign dc_hdr_len_o   = default_config_rx_header_i[9:0];
assign dc_hdr_valid_o = default_config_rx_valid_i;
assign dc_hdr_is_wr_o = (default_config_rx_header_i[30] & (default_config_rx_header_i[28:24] == 5'h0)) ||
       			(default_config_rx_header_i[31:29] == 3'b011) ; 
assign dc_hdr_is_wr_no_data_o = (default_config_rx_header_i[31:27] == 5'b00110 ) ;
assign dc_hdr_is_cpl_no_data_o = (default_config_rx_header_i[31:24] == 8'b0000_1010) ;
assign dc_hdr_is_cpl_o = (default_config_rx_header_i[31:27]==5'b01001) || (default_config_rx_header_i[31:24]==8'b0000_1011) ;


//--
assign tx_first_dword  = {fmt,type_field,first_dword_misc,length};
assign tx_second_dword = {completer_id,cpl_status,bcm,byte_count};
assign tx_third_dword  = {requester_id,tag,reserved,lower_address};
assign tx_fourth_dword = 32'b0;

logic [127:0] UR_header ;
assign UR_header = {tx_fourth_dword,tx_third_dword,tx_second_dword,tx_first_dword};
//assign UR_header = {tx_first_dword,tx_second_dword,tx_third_dword,tx_fourth_dword}; //reorder


//store in fifo and read
logic [133:0] rx_tlp_fifo_indata ;
assign rx_tlp_fifo_indata = {default_config_rx_bar,default_config_rx_sop,default_config_rx_eop,UR_header,default_config_rx_valid};
logic [133:0] rx_tlp_fifo_outdata;
logic rx_tlp_fifo_wr_req;
logic rx_tlp_fifo_rd_req;
logic rx_tlp_fifo_almost_full;
logic rx_tlp_fifo_empty;

assign rx_tlp_fifo_rd_req = default_config_tx_st_ready_i & (!rx_tlp_fifo_empty) ;
assign rx_tlp_fifo_wr_req = default_config_rx_valid;
/*
scfifo  rx_tlp_fifo (
      .clock                            (clk),
      .data                             (rx_tlp_fifo_indata),
      .rdreq                            (rx_tlp_fifo_rd_req),
      .wrreq                            (rx_tlp_fifo_wr_req),
      .almost_full                      (rx_tlp_fifo_almost_full),
      .full                             (),
      .q                                (rx_tlp_fifo_outdata),
      .aclr                             (1'b0),
      .almost_empty                     (),
      .eccstatus                        (),
      .empty                            (rx_tlp_fifo_empty),
      .sclr                             (rst_n),
      .usedw                            ());
  defparam
      rx_tlp_fifo.add_ram_output_register  = "ON",
      rx_tlp_fifo.almost_full_value  = 16,
      rx_tlp_fifo.enable_ecc  = "FALSE",
      rx_tlp_fifo.intended_device_family  = "Agilex",
      rx_tlp_fifo.lpm_hint  = "AUTO",
      rx_tlp_fifo.lpm_numwords  = 32,
      rx_tlp_fifo.lpm_showahead  = "ON",
      rx_tlp_fifo.lpm_type  = "scfifo",
      rx_tlp_fifo.lpm_width  = (134),
      rx_tlp_fifo.lpm_widthu  = 5,
      rx_tlp_fifo.overflow_checking  = "OFF",
      rx_tlp_fifo.underflow_checking  = "OFF",
      rx_tlp_fifo.use_eab  = "ON";
*/
//send fifo output


//logic [133:0] rx_tlp_fifo_indata = {default_config_rx_bar,default_config_rx_sop,default_config_rx_eop,default_config_rx_header,default_config_rx_valid};

//     assign     default_config_txc_sop	= rx_tlp_fifo_outdata[130] ;
//     assign     default_config_txc_eop	= rx_tlp_fifo_outdata[129] ;
//     assign     default_config_txc_header	= rx_tlp_fifo_outdata[128:1] ;
//     assign     default_config_txc_payload	= 1024'h0;//BAM_DATAWIDTH'b0;
//     assign     default_config_txc_valid	= rx_tlp_fifo_outdata[0] ;



     assign     default_config_txc_sop		= rx_tlp_fifo_indata[130] ;
     assign     default_config_txc_eop		= rx_tlp_fifo_indata[129] ;
     assign     default_config_txc_payload	= 1024'h0;//BAM_DATAWIDTH'b0;
     assign     default_config_txc_valid	= rx_tlp_fifo_indata[0] ;
     assign     default_config_txc_header	= default_config_txc_valid ? rx_tlp_fifo_indata[128:1] : 128'h0;


always_ff@(posedge clk)
begin
	if(!rst_n) default_config_rx_st_ready_o <= 1'b0;
	//else default_config_rx_st_ready_o <= rx_tlp_fifo_almost_full ? 1'b0 : 1'b1;
	else default_config_rx_st_ready_o <= 1'b1;
end //always_ff


            assign dc_bam_rx_signal_ready_o = default_config_rx_st_ready_o;
            assign dc_tx_hdr_valid_o = default_config_rx_valid_i;//default_config_txc_valid;

     assign   ed_tx_st0_passthrough_o  = default_config_txc_valid ? 1'b1 : 1'b0 ;
     assign   ed_tx_st1_passthrough_o  =  1'b0 ;  //sending output only only 0 channel 
     assign   ed_tx_st2_passthrough_o  =  1'b0 ;
     assign   ed_tx_st3_passthrough_o  =  1'b0 ;
	   
endmodule //intel_cxl_default_config
