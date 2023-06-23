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


// +-----------------------------------------------------------
// | Nadder LSM GPO
// +-----------------------------------------------------------

`timescale 1 ns / 1 ns
module altera_s10_user_rst_clkgate(
	output logic ninit_done
);

	localparam USER_RESET_DELAY = 20;
	
		altera_agilex_config_reset_release_endpoint config_reset_release_endpoint(
			.conf_reset(ninit_done)
		);	
endmodule

