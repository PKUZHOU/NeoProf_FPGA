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


set PERIOD_SIP  1.83
set PERIOD_CAM  $PERIOD_SIP*2
set PERIOD_SBR  $PERIOD_SIP*4
set PERIOD_REF  10.0
set TOP 1


#-----------------------------------------------
# Create generated clocks
#-----------------------------------------------

# Automatically derived from IP constraint file

set pld_clk [get_clocks cxl_ip.coreclkout_hip]
set side_hip_clk [get_clocks cxl_ip.pld_clkout_slow]
set cam_clk [get_clocks cam_clk]
set sbr_clk [get_clocks sbr_clk]
#set emif_usr_clk_0 [get_clocks cxltyp3ddr_0|cxltyp3ddr_inst|cxl_ip|cxl_mc_top|emif_inst_0_core_usr_clk]
#set emif_usr_clk_1 [get_clocks cxltyp3ddr_0|cxltyp3ddr_inst|cxl_ip|cxl_mc_top|emif_inst_1_core_usr_clk]

#-----------------------------------------------
# synchroniser 
#-----------------------------------------------
proc apply_sdc_synchronizer_nocut__to_node {to_node_list} {
   set num_to_node_list [get_collection_size $to_node_list]
   if { $num_to_node_list > 0} {
      # relax setup and hold calculation
      set_max_delay -to $to_node_list 100
      set_min_delay -to $to_node_list -100
   }
}

proc apply_sdc_pre_synchronizer_nocut_data__din_s1 {entity_name} {
   foreach each_inst [get_entity_instances $entity_name] {
      set to_node_list [get_keepers -nowarn $each_inst|din_s1]
      apply_sdc_synchronizer_nocut__to_node $to_node_list
      }
   }

apply_sdc_pre_synchronizer_nocut_data__din_s1 *synchronizer_nocut

#-----------------------------------------------
# Set Clock uncertainity
#-----------------------------------------------
derive_clock_uncertainty

#-----------------------------------------------
# Set Clock groups
#-----------------------------------------------

set_clock_groups -asynchronous -group $pld_clk -group $cam_clk -group $sbr_clk -group $side_hip_clk 
#set_clock_groups -asynchronous -group $pld_clk -group $cam_clk -group $sbr_clk -group $emif_usr_clk_0 -group $emif_usr_clk_1 -group $side_hip_clk 


#-----------------------------------------------
# Set Exceptions
#-----------------------------------------------

# Reset gen
#set_false_path -to cxl_memexp_sip_top|gen_clkrst|sbr_rstn_pipe*|clrn
#set_false_path -to cxl_memexp_sip_top|gen_clkrst|cam_warm_rstn_pipe*|clrn
#set_false_path -to cxl_memexp_sip_top|gen_clkrst|cam_cold_rstn_pipe*|clrn
#set_false_path -to cxl_memexp_sip_top|gen_clkrst|sbr_rstn_pipe[0]|d
#set_false_path -to cxl_memexp_sip_top|gen_clkrst|cam_warm_rstn_pipe[0]|d
#set_false_path -to cxl_memexp_sip_top|gen_clkrst|cam_cold_rstn_pipe[0]|d

#-----------------------------------------------
# Overconstraint specific paths during Placement & Routing
#-----------------------------------------------

if {![is_post_route]} {
   # fitter; 15% 
   set_clock_uncertainty -setup -add -from $pld_clk 0.2ns

}

