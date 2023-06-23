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


// $File: //acds/rel/22.3/ip/iconnect/avalon_st/altera_avalon_dc_fifo/altera_dcfifo_synchronizer_bundle.v $
// $Revision: #1 $
// $Date: 2022/07/28 $
// $Author: psgswbuild $
//-------------------------------------------------------------------------------

`timescale 1 ns / 1 ns
module altera_dcfifo_synchronizer_bundle(
                                     clk,
                                     reset_n,
                                     din,
                                     dout
                                     );
   parameter WIDTH = 1;
   parameter DEPTH = 3;   
   
   input clk;
   input reset_n;
   input [WIDTH-1:0] din;
   output [WIDTH-1:0] dout;
   
   genvar i;
   
   generate
      for (i=0; i<WIDTH; i=i+1)
        begin : sync
           altera_std_synchronizer_nocut #(.depth(DEPTH))
                                   u (
                                      .clk(clk), 
                                      .reset_n(reset_n), 
                                      .din(din[i]), 
                                      .dout(dout[i])
                                      );
        end
   endgenerate
   
endmodule 

