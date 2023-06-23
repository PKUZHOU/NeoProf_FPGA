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
# Create Input Clocks
#-----------------------------------------------

create_clock -period "30.303 ns" -name {altera_reserved_tck} {altera_reserved_tck}


#-----------------------------------------------
# Create generated clocks
#-----------------------------------------------

# Automatically derived from IP constraint file

set pld_clk [get_clocks cxl_ip.coreclkout_hip]
set side_hip_clk [get_clocks cxl_ip.pld_clkout_slow]
set cam_clk [get_clocks cam_clk]
set sbr_clk [get_clocks sbr_clk]
set emif_usr_clk_0 [get_clocks ed_top_wrapper_typ3_inst|MC_CHANNEL_INST[0].mc_top|GEN_CHAN_COUNT_EMIF[0].emif_inst|emif_core_usr_clk]
set emif_usr_clk_1 [get_clocks ed_top_wrapper_typ3_inst|MC_CHANNEL_INST[0].mc_top|GEN_CHAN_COUNT_EMIF[1].emif_inst|emif_core_usr_clk]
set tck [get_clocks altera_reserved_tck]

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

set_clock_groups -asynchronous -group $pld_clk -group $cam_clk -group $sbr_clk -group $emif_usr_clk_0 -group $emif_usr_clk_1 -group $side_hip_clk -group $tck


#-----------------------------------------------
# Set Exceptions
#-----------------------------------------------

# Reset gen
#set_false_path -to {cxl_type3_top|cxl_ip|io_pll_rstn*|clrn}
#set_false_path -to {cxl_type3_top|cxl_ip|io_pll_rstn[0]|d}
set_false_path -to intel_rtile_cxl_top_inst|intel_rtile_cxl_top_0|cxl_memexp_sip_top|gen_clkrst|sbr_rstn_pipe*|clrn
set_false_path -to intel_rtile_cxl_top_inst|intel_rtile_cxl_top_0|cxl_memexp_sip_top|gen_clkrst|cam_warm_rstn_pipe*|clrn
set_false_path -to intel_rtile_cxl_top_inst|intel_rtile_cxl_top_0|cxl_memexp_sip_top|gen_clkrst|cam_cold_rstn_pipe*|clrn
set_false_path -to intel_rtile_cxl_top_inst|intel_rtile_cxl_top_0|cxl_memexp_sip_top|gen_clkrst|sbr_rstn_pipe[0]|d
set_false_path -to intel_rtile_cxl_top_inst|intel_rtile_cxl_top_0|cxl_memexp_sip_top|gen_clkrst|cam_warm_rstn_pipe[0]|d
set_false_path -to intel_rtile_cxl_top_inst|intel_rtile_cxl_top_0|cxl_memexp_sip_top|gen_clkrst|cam_cold_rstn_pipe[0]|d

#-----------------------------------------------
# Overconstraint specific paths during Placement & Routing
#-----------------------------------------------

if {![is_post_route]} {
   # fitter; 15% 
   set_clock_uncertainty -setup -add -from $pld_clk 0.2ns

}

