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


module altera_emif_arch_fm_buf_bdir_se #(
   parameter OCT_CONTROL_WIDTH = 1,
   parameter HPRX_CTLE_EN = "off",
   parameter HPRX_OFFSET_CAL = "false",
   parameter CALIBRATED_OCT = 1
) (
   inout  tri   io,
   output logic ibuf_o,
   input  logic obuf_i,
   input  logic obuf_oe,
   input  logic obuf_dtc,
   input  logic oct_termin
);
   timeunit 1ns;
   timeprecision 1ps;
   
   generate
      if (CALIBRATED_OCT) 
      begin : cal_oct
         tennm_io_ibuf # (
            .hprx_ctle_en (HPRX_CTLE_EN),
            .hprx_offset_cal (HPRX_OFFSET_CAL)
         ) ibuf (
            .i(io),
            .o(ibuf_o),
            .term_in(oct_termin),
            .seriesterminationcontrol(),
            .parallelterminationcontrol(),
            .dynamicterminationcontrol(),
            .ibar()
            );
            
         tennm_io_obuf obuf (
            .i(obuf_i),
            .o(io),
            .oe(obuf_oe),
            .term_in(oct_termin),
            .dynamicterminationcontrol(obuf_dtc),
            .seriesterminationcontrol(),
            .parallelterminationcontrol(),
            .obar(),
            .devoe()
            );
      end else 
      begin : no_oct
         tennm_io_ibuf # (
            .hprx_ctle_en (HPRX_CTLE_EN),
            .hprx_offset_cal (HPRX_OFFSET_CAL)
         ) ibuf (
            .i(io),
            .o(ibuf_o),
            .seriesterminationcontrol(),
            .parallelterminationcontrol(),
            .dynamicterminationcontrol(),
            .ibar()
         );
            
         tennm_io_obuf obuf (
            .i(obuf_i),
            .o(io),
            .oe(obuf_oe),
            .dynamicterminationcontrol(),
            .seriesterminationcontrol(),
            .parallelterminationcontrol(),
            .obar(),
            .devoe()
            );      
      end
   endgenerate            
endmodule

