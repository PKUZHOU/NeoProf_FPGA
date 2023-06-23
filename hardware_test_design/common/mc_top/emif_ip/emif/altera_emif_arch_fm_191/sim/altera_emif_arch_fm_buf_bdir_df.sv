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


module altera_emif_arch_fm_buf_bdir_df #(
   parameter OCT_CONTROL_WIDTH = 1,
   parameter HPRX_CTLE_EN = "off",
   parameter HPRX_OFFSET_CAL = "false",
   parameter CALIBRATED_OCT = 1
) (
   inout  tri   io,
   inout  tri   iobar,
   output logic ibuf_o,
   input  logic obuf_i,
   input  logic obuf_ibar,
   input  logic obuf_oe,
   input  logic obuf_oebar,
   input  logic obuf_dtc,
   input  logic obuf_dtcbar,
   input  logic oct_termin
);
   timeunit 1ns;
   timeprecision 1ps;

   localparam DCCEN = "true";

   logic pdiff_out_o;
   logic pdiff_out_obar;
   logic pdiff_out_oe;
   logic pdiff_out_oebar;

   generate
      if (CALIBRATED_OCT)
      begin : cal_oct
         logic pdiff_out_dtc;
         logic pdiff_out_dtcbar;

         tennm_io_ibuf # (
            .hprx_ctle_en (HPRX_CTLE_EN),
            .hprx_offset_cal (HPRX_OFFSET_CAL),
            .differential_mode ("true")
         ) ibuf (
            .i(io),
            .ibar(iobar),
            .o(ibuf_o),
            .term_in(oct_termin),
            .seriesterminationcontrol(),
            .parallelterminationcontrol(),
            .dynamicterminationcontrol()
         );

         tennm_pseudo_diff_out # (
            .feedthrough ("true")
         ) pdiff_out (
            .i(obuf_i),
            .ibar(obuf_ibar),
            .oein(obuf_oe),
            .oebin(obuf_oebar),
            .dtcin(obuf_dtc),
            .dtcbarin(obuf_dtcbar),
            .o(pdiff_out_o),
            .obar(pdiff_out_obar),
            .oeout(pdiff_out_oe),
            .oebout(pdiff_out_oebar),
            .dtc(pdiff_out_dtc),
            .dtcbar(pdiff_out_dtcbar)
         );

         tennm_io_obuf # (
            .dccen(DCCEN)
         ) obuf (
            .i(pdiff_out_o),
            .o(io),
            .oe(pdiff_out_oe),
            .term_in(oct_termin),
            .dynamicterminationcontrol(pdiff_out_dtc),
            .seriesterminationcontrol(),
            .parallelterminationcontrol(),
            .obar(),
            .devoe()
         );

         tennm_io_obuf # (
            .dccen(DCCEN)
         ) obuf_bar (
            .i(pdiff_out_obar),
            .o(iobar),
            .oe(pdiff_out_oebar),
            .term_in(oct_termin),
            .dynamicterminationcontrol(pdiff_out_dtcbar),
            .seriesterminationcontrol(),
            .parallelterminationcontrol(),
            .obar(),
            .devoe()
         );
      end else
      begin : no_oct
         tennm_io_ibuf  # (
            .hprx_ctle_en (HPRX_CTLE_EN),
            .hprx_offset_cal (HPRX_OFFSET_CAL),
            .differential_mode ("true")
         ) ibuf (
            .i(io),
            .ibar(iobar),
            .o(ibuf_o),
            .seriesterminationcontrol(),
            .parallelterminationcontrol(),
            .dynamicterminationcontrol()
         );

         tennm_pseudo_diff_out # (
            .feedthrough ("true")
         ) pdiff_out (
            .i(obuf_i),
            .ibar(obuf_ibar),
            .oein(obuf_oe),
            .oebin(obuf_oebar),
            .dtcin(),
            .dtcbarin(),
            .o(pdiff_out_o),
            .obar(pdiff_out_obar),
            .oeout(pdiff_out_oe),
            .oebout(pdiff_out_oebar),
            .dtc(),
            .dtcbar()
         );

         tennm_io_obuf # (
            .dccen(DCCEN)
         ) obuf (
            .i(pdiff_out_o),
            .o(io),
            .oe(pdiff_out_oe),
            .dynamicterminationcontrol(),
            .seriesterminationcontrol(),
            .parallelterminationcontrol(),
            .obar(),
            .devoe()
         );

         tennm_io_obuf # (
            .dccen(DCCEN)
         ) obuf_bar (
            .i(pdiff_out_obar),
            .o(iobar),
            .oe(pdiff_out_oebar),
            .dynamicterminationcontrol(),
            .seriesterminationcontrol(),
            .parallelterminationcontrol(),
            .obar(),
            .devoe()
         );
      end
   endgenerate
endmodule

