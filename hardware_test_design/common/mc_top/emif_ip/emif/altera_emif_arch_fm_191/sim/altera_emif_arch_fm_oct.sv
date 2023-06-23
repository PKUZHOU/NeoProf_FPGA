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



module altera_emif_arch_fm_oct #(
   parameter PHY_CALIBRATED_OCT = 0
) (
   input  logic oct_rzqin, 
   output logic oct_termin 
);
   localparam OCT_USER_OCT = "A_OCT_USER_OCT_OFF";

   generate if (PHY_CALIBRATED_OCT == 1) begin
     tennm_termination term_inst (
       .req_recal (1'b0),
       .ack_recal (/*open*/),
       .rzqin     (oct_rzqin),
       .serdataout(oct_termin)
     );
   end
   endgenerate

endmodule
