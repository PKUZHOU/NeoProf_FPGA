# (C) 2001-2022 Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files from any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License Subscription 
# Agreement, Intel FPGA IP License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Intel and sold by 
# Intel or its authorized distributors.  Please refer to the applicable 
# agreement for further details.



set FAMILY                       "Agilex"
set source_ref_clk_period        1.250
### set side_clk_period              "4"
set topology                     "cxl_x16_up"

##### for multiple instance ####
if {[info exists inst]} {
    unset inst
}
set inst [get_current_instance]
set inst_name [lindex [split ${inst} "|"] end-1]
## csb2io
set csb2wire_en 1
#set csb_pll_en  0
set csb_pll_en "0" 
set csb_clk_div sideband_div8clk
set hip_is_rnrb     1
## set hip_is_rnrb         1

########### Note ######################################################################################################################
### Refclk and avmm clk only will be created when top level port matches QHIP port.  Else no refclk and avmm clk will be created. #####
### User need to aware of the port name used.  This SDC is for user reference for top level clk creation.                         #####
#######################################################################################################################################

############### clock ###############
#refclk 
create_clock -name refclk0       -period 10.000 [get_ports {refclk0}]
create_clock -name refclk1       -period 10.000 [get_ports {refclk1}]

if {[string match $topology "pipe_direct_cxl_x8"] == 1 } {
   create_clock -name ${inst_name}.ref_clock_ch4  -period ${source_ref_clk_period} [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch4_ref] -add
   create_clock -name ${inst_name}.ref_clock_ch15 -period ${source_ref_clk_period} [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch15_ref] -add

   create_clock -name ${inst_name}.ref_pipe_clock_ch15 -period ${source_ref_clk_period} [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch15_ref] -add
   create_clock -name ${inst_name}.ref_pipe_clock_ch16 -period ${source_ref_clk_period} [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch16_ref] -add
   create_clock -name ${inst_name}.ref_pipe_clock_ch17 -period ${source_ref_clk_period} [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch17_ref] -add
   create_clock -name ${inst_name}.ref_pipe_clock_ch18 -period ${source_ref_clk_period} [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch18_ref] -add
   create_clock -name ${inst_name}.ref_pipe_clock_ch19 -period ${source_ref_clk_period} [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch19_ref] -add
   create_clock -name ${inst_name}.ref_pipe_clock_ch20 -period ${source_ref_clk_period} [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch20_ref] -add
   create_clock -name ${inst_name}.ref_pipe_clock_ch21 -period ${source_ref_clk_period} [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch21_ref] -add
   create_clock -name ${inst_name}.ref_pipe_clock_ch22 -period ${source_ref_clk_period} [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch22_ref] -add
   
   create_generated_clock -name ${inst_name}.coreclkout_hip     -source [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch4_ref]  -master_clock ${inst_name}.ref_clock_ch4       -multiply_by 1 -divide_by 2 [get_registers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch4.reg] -add
   create_generated_clock -name ${inst_name}.pipe_direct_ctl    -source [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch15_ref] -master_clock ${inst_name}.ref_clock_ch15      -multiply_by 1 -divide_by 2 [get_registers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch15.reg] -add
   create_generated_clock -name ${inst_name}.pipe_direct_ln0    -source [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch15_ref] -master_clock ${inst_name}.ref_pipe_clock_ch15 -multiply_by 1 -divide_by 2 [get_registers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch15.reg] -add
   create_generated_clock -name ${inst_name}.pipe_direct_ln1    -source [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch16_ref] -master_clock ${inst_name}.ref_pipe_clock_ch16 -multiply_by 1 -divide_by 2 [get_registers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch16.reg] -add
   create_generated_clock -name ${inst_name}.pipe_direct_ln2    -source [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch17_ref] -master_clock ${inst_name}.ref_pipe_clock_ch17 -multiply_by 1 -divide_by 2 [get_registers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch17.reg] -add
   create_generated_clock -name ${inst_name}.pipe_direct_ln3    -source [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch18_ref] -master_clock ${inst_name}.ref_pipe_clock_ch18 -multiply_by 1 -divide_by 2 [get_registers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch18.reg] -add
   create_generated_clock -name ${inst_name}.pipe_direct_ln4    -source [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch19_ref] -master_clock ${inst_name}.ref_pipe_clock_ch19 -multiply_by 1 -divide_by 2 [get_registers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch19.reg] -add
   create_generated_clock -name ${inst_name}.pipe_direct_ln5    -source [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch20_ref] -master_clock ${inst_name}.ref_pipe_clock_ch20 -multiply_by 1 -divide_by 2 [get_registers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch20.reg] -add
   create_generated_clock -name ${inst_name}.pipe_direct_ln6    -source [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch21_ref] -master_clock ${inst_name}.ref_pipe_clock_ch21 -multiply_by 1 -divide_by 2 [get_registers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch21.reg] -add
   create_generated_clock -name ${inst_name}.pipe_direct_ln7    -source [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch22_ref] -master_clock ${inst_name}.ref_pipe_clock_ch22 -multiply_by 1 -divide_by 2 [get_registers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch22.reg] -add

   disable_min_pulse_width [get_clocks ${inst_name}.ref_clock_ch4]
   disable_min_pulse_width [get_clocks ${inst_name}.ref_pipe_clock_ch15]
   disable_min_pulse_width [get_clocks ${inst_name}.ref_pipe_clock_ch16]
   disable_min_pulse_width [get_clocks ${inst_name}.ref_pipe_clock_ch17]
   disable_min_pulse_width [get_clocks ${inst_name}.ref_pipe_clock_ch18]
   disable_min_pulse_width [get_clocks ${inst_name}.ref_pipe_clock_ch19]
   disable_min_pulse_width [get_clocks ${inst_name}.ref_pipe_clock_ch20]
   disable_min_pulse_width [get_clocks ${inst_name}.ref_pipe_clock_ch21]
   disable_min_pulse_width [get_clocks ${inst_name}.ref_pipe_clock_ch22]
   disable_min_pulse_width [get_clocks ${inst_name}.pipe_direct_ctl]
   disable_min_pulse_width [get_clocks ${inst_name}.pipe_direct_ln7]
   disable_min_pulse_width [get_clocks ${inst_name}.pipe_direct_ln1]
   disable_min_pulse_width [get_clocks ${inst_name}.pipe_direct_ln6]
   disable_min_pulse_width [get_clocks ${inst_name}.pipe_direct_ln4]
   disable_min_pulse_width [get_clocks ${inst_name}.pipe_direct_ln2]
   disable_min_pulse_width [get_clocks ${inst_name}.pipe_direct_ln3]
   disable_min_pulse_width [get_clocks ${inst_name}.pipe_direct_ln5]
   disable_min_pulse_width [get_clocks ${inst_name}.pipe_direct_ln0]
   ####  Async clk group ###############
   set_clock_groups -async -group ${inst_name}.coreclkout_hip -group ${inst_name}.pipe_direct_ctl -group ${inst_name}.pipe_direct_ln0 -group ${inst_name}.pipe_direct_ln1 -group ${inst_name}.pipe_direct_ln2 -group ${inst_name}.pipe_direct_ln3 -group ${inst_name}.pipe_direct_ln4 -group ${inst_name}.pipe_direct_ln5 -group ${inst_name}.pipe_direct_ln6 -group ${inst_name}.pipe_direct_ln7
} else {
   create_clock -name ${inst_name}.ref_clock_ch15 -period ${source_ref_clk_period} [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch15_ref] -add
   create_generated_clock -name ${inst_name}.coreclkout_hip     -source [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch15_ref] -master_clock ${inst_name}.ref_clock_ch15 -multiply_by 1 -divide_by 2 [get_registers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch15.reg] -add
###### slow clk
 if {$csb2wire_en == 1} {
  if {${hip_is_rnrb} == 1} {
   create_clock -name ${inst_name}.ref_clock_ch12 -period 4 [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch12_ref] -add
   create_generated_clock -name ${inst_name}.pld_clkout_slow -source [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch12_ref] -master_clock  ${inst_name}.ref_clock_ch12 -multiply_by 1 -divide_by 1 [get_registers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_rx_clk_out_ch12.reg] -add
##   create_generated_clock -name ${inst_name}.pld_clkout_slow -source [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch12_ref] -master_clock  ${inst_name}.ref_clock_ch12 -multiply_by 1 -divide_by 1 [get_ports ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|u_rnr_cxl_soft_rx_tx_wrapper|u_rnr_divclk|divclk] -add
   disable_min_pulse_width [get_clocks ${inst_name}.ref_clock_ch12]
  } else {    ## revA 
   if {$csb_pll_en == 1} {
      if {[string match $csb_clk_div "sideband_div8clk"] == 1 }  {
          create_generated_clock -name ${inst_name}.pld_clkout_slow -source [get_registers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch15.reg] -master_clock  ${inst_name}.coreclkout_hip -multiply_by 1 -divide_by 4 ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|u_rnr_cxl_soft_rx_tx_wrapper|u_rnr_divclk|clkdiv_inst|clock_div4  -add
      } else {
          create_generated_clock -name ${inst_name}.pld_clkout_slow -source [get_nodes ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch15_ref] -master_clock ${inst_name}.coreclkout_hip -multiply_by 1 -divide_by 2 [get_registers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|u_rnr_cxl_soft_rx_tx_wrapper|u_rnr_divclk|cnt[0]] -add
      }
   } else  {   ## no Pll , use counter to divide clock
     if {[string match $csb_clk_div "sideband_div8clk"] == 1 }  { 
        create_generated_clock -name ${inst_name}.pld_clkout_slow -source [get_registers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch15.reg] -master_clock  ${inst_name}.coreclkout_hip -multiply_by 1 -divide_by 4 [get_registers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|u_rnr_cxl_soft_rx_tx_wrapper|u_rnr_divclk|cnt[1]] -add
       } else {
         create_generated_clock -name ${inst_name}.pld_clkout_slow -source [get_registers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch15.reg] -master_clock  ${inst_name}.coreclkout_hip -multiply_by 1 -divide_by 2 [get_registers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|u_rnr_cxl_soft_rx_tx_wrapper|u_rnr_divclk|cnt[0]] -add
       }   
   }
  }
  set_clock_groups -async -group ${inst_name}.pld_clkout_slow -group ${inst_name}.coreclkout_hip
  disable_min_pulse_width [get_clocks ${inst_name}.pld_clkout_slow]
 }
}
 

############### false path ###############
#set_false_path -from ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|hdpldadapt_rx_chnl_14~pld_sclk1_rowclk.reg -to ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|rnr_cxl_reset_ctrl_inst|cxl_pld_core_cold_rst_n_r

#### set_multicycle_path -setup 2 -from [get_keepers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch15.reg] -to [get_keepers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|rnr_cxl_reset_ctrl_inst|upi_pld_in_use_r]
#### set_multicycle_path -hold 1  -from [get_keepers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch15.reg] -to [get_keepers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|rnr_cxl_reset_ctrl_inst|upi_pld_in_use_r]

#### set_multicycle_path -setup 2 -from [get_keepers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|hdpldadapt_rx_chnl_1~pld_sclk1_rowclk.reg]  -to [get_keepers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|rnr_cxl_reset_ctrl_inst|upi_pld_in_use_r]
#### set_multicycle_path -hold 1  -from [get_keepers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|hdpldadapt_rx_chnl_1~pld_sclk1_rowclk.reg]  -to [get_keepers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|rnr_cxl_reset_ctrl_inst|upi_pld_in_use_r]

set_false_path -from [get_keepers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch15.reg] -to  [get_keepers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|rnr_cxl_reset_ctrl_inst|upi_pld_in_use_i_sync|din_s1]
set_false_path  -from [get_keepers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|hdpldadapt_rx_chnl_1~pld_sclk1_rowclk.reg] -to [get_keepers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|rnr_cxl_reset_ctrl_inst|upi_pld_in_use_i_sync|din_s1]
set_false_path -from [get_keepers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|z1578a~pld_pcs_tx_clk_out_ch15.reg] -to  [get_keepers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|rnr_cxl_reset_ctrl_inst|upi_pld_link_req_i_sync|din_s1]
set_false_path -from [get_keepers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|hdpldadapt_rx_chnl_1~pld_sclk1_rowclk.reg] -to  [get_keepers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|rnr_cxl_reset_ctrl_inst|upi_pld_link_req_i_sync|din_s1]

##SJ 
set_false_path -to  [get_keepers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|u_rnr_cxl_soft_rx_tx_wrapper|u_cxl_pld_dskew_en_sync|din_s1]

##NEW 
set_false_path -to [get_keepers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|rnr_cxl_reset_ctrl_inst|upi_pld_core_rst_n_r]
set_false_path -to [get_keepers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|rnr_cxl_reset_ctrl_inst|cxl_pld_core_warm_rst_n_r]
set_false_path -through [get_nets ${inst}*|u_rtile_mdx1|*s0_112_1__core_periphery__data_to_core[99]*]


## backup  set_false_path -to  ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|rnr_cxl_reset_ctrl_inst|upi_pld_link_req_i_sync|din_s1*

####set_multicycle_path -setup 2 -from [get_keepers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|hdpldadapt_rx_chnl_14~pld_sclk1_rowclk.reg] -to [get_keepers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|rnr_cxl_reset_ctrl_inst|cxl_pld_core_cold_rst_n_r]
####set_multicycle_path -hold 1  -from [get_keepers ${inst}*|u_rtile_mdx1|u_z1578a_MD|inst_quartus|hdpldadapt_rx_chnl_14~pld_sclk1_rowclk.reg] -to [get_keepers ${inst}*|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|rnr_cxl_reset_ctrl_inst|cxl_pld_core_cold_rst_n_r]


set_multicycle_path -setup 2 -from [get_keepers ${inst}*|rnr_cxl_reset_ctrl_inst|pld_adapter_rx_pld_rst_n_r_ch[*]] -to [get_keepers ${inst}*|hdpldadapt_rx_chnl_*~pld_rx_clk1_dcm.reg]
set_multicycle_path -hold  1 -from [get_keepers ${inst}*|rnr_cxl_reset_ctrl_inst|pld_adapter_rx_pld_rst_n_r_ch[*]] -to [get_keepers ${inst}*|hdpldadapt_rx_chnl_*~pld_rx_clk1_dcm.reg]

set_multicycle_path -setup 2 -from [get_keepers ${inst}*|rnr_cxl_reset_ctrl_inst|pld_adapter_tx_pld_rst_n_r_ch[*]] -to [get_keepers ${inst}*|hdpldadapt_tx_chnl_*~pld_tx_clk1_dcm.reg]
set_multicycle_path -hold  1 -from [get_keepers ${inst}*|rnr_cxl_reset_ctrl_inst|pld_adapter_tx_pld_rst_n_r_ch[*]] -to [get_keepers ${inst}*|hdpldadapt_tx_chnl_*~pld_tx_clk1_dcm.reg]

disable_min_pulse_width [get_clocks ${inst_name}.ref_clock_ch15]
disable_min_pulse_width [get_clocks ${inst_name}.coreclkout_hip]
disable_min_pulse_width [get_clocks {refclk0}]
disable_min_pulse_width [get_clocks {refclk1}]

