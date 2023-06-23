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


///////////////////////////////////////////////////////////////////////////////
// UFI wrapper for FalconMesa EMIFs
///////////////////////////////////////////////////////////////////////////////

module altera_emif_arch_fm_ufi_wrapper #(
   parameter MODE   = "pin_ufi_use_in_direct_out_direct",
   parameter IS_HPS = 1,
   parameter IS_C2P = 1,
   parameter HIPI_DELAY= 225,
   parameter TIEOFF = 0
) (
   input logic                                       i_src_clk,
   input logic                                       i_dst_clk,

   input  logic                                      i_din,
   output logic                                      o_dout
);
   generate
     if (TIEOFF) begin
        assign o_dout = i_din;
     end else begin
        if (IS_HPS && !IS_C2P) begin : hps_p2c_ufi
           (* altera_attribute = {"-name FORCE_HYPER_REGISTER_FOR_PERIPHERY_CORE_TRANSFER ON; -name HYPER_REGISTER_DELAY_CHAIN 225; -name PRESERVE_FANOUT_FREE_WYSIWYG ON"} *)
           tennm_ufi #(
             .mode    (MODE),
             .datapath("p2c")
           ) preserved_ufi_inst (
             .srcclk (i_src_clk),
             .destclk(i_dst_clk),
             .d      (i_din),
             .dout   (o_dout)
           );
        end else begin
           if (!IS_C2P) begin : p2c_ufi
              (* altera_attribute = {"-name FORCE_HYPER_REGISTER_FOR_PERIPHERY_CORE_TRANSFER ON"} *)
              tennm_ufi #(
                .mode    (MODE),
                .datapath("p2c")
              ) ufi_inst (
                .srcclk (i_src_clk),
                .destclk(i_dst_clk),
                .d      (i_din),
                .dout   (o_dout)
              );
           end else if (HIPI_DELAY == 350) begin : c2p_350_ufi 
              (* altera_attribute = {"-name FORCE_HYPER_REGISTER_FOR_CORE_PERIPHERY_TRANSFER ON; -name HYPER_REGISTER_DELAY_CHAIN 350"} *)
              tennm_ufi #(
                .mode    (MODE),
                .datapath("c2p")
              ) ufi_inst (
                .srcclk (i_src_clk),
                .destclk(i_dst_clk),
                .d      (i_din),
                .dout   (o_dout)
              );
           end else if (HIPI_DELAY == 100) begin: c2p_100_ufi
              (* altera_attribute = {"-name FORCE_HYPER_REGISTER_FOR_CORE_PERIPHERY_TRANSFER ON; -name HYPER_REGISTER_DELAY_CHAIN 100"} *)
              tennm_ufi #(
                .mode    (MODE),
                .datapath("c2p")
              ) ufi_inst (
                .srcclk (i_src_clk),
                .destclk(i_dst_clk),
                .d      (i_din),
                .dout   (o_dout)
              );
           end else begin: c2p_225_ufi
              (* altera_attribute = {"-name FORCE_HYPER_REGISTER_FOR_CORE_PERIPHERY_TRANSFER ON; -name HYPER_REGISTER_DELAY_CHAIN 225"} *)
              tennm_ufi #(
                .mode    (MODE),
                .datapath("c2p")
              ) ufi_inst (
                .srcclk (i_src_clk),
                .destclk(i_dst_clk),
                .d      (i_din),
                .dout   (o_dout)
              );
           end

        end
     end
     
   endgenerate 
         

endmodule
