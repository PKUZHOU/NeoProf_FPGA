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


    # Analysis & Synthesis Assignments
    # ================================
    set_global_assignment -name VERILOG_INPUT_VERSION SYSTEMVERILOG_2009
    set_global_assignment -name REMOVE_DUPLICATE_LOGIC ON
    set_global_assignment -name SYNTH_GATED_CLOCK_CONVERSION ON
    set_global_assignment -name REMOVE_DUPLICATE_REGISTERS OFF

    # Compiler Assignments
    # ====================
    set_global_assignment -name OPTIMIZATION_MODE "SUPERIOR PERFORMANCE WITH MAXIMUM PLACEMENT EFFORT"
    set_global_assignment -name ALLOW_REGISTER_RETIMING ON
    set_global_assignment -name ALLOW_RAM_RETIMING ON
    set_global_assignment -name ALLOW_DSP_RETIMING ON
    set_global_assignment -name STATE_MACHINE_PROCESSING "ONE-HOT"

    # Fitter Assignments
    # ==================
    set_global_assignment -name FINAL_PLACEMENT_OPTIMIZATION ALWAYS
    set_global_assignment -name ALM_REGISTER_PACKING_EFFORT LOW
    set_global_assignment -name QII_AUTO_PACKED_REGISTERS "NORMAL"

    set_global_assignment -name OPTIMIZATION_TECHNIQUE SPEED
    set_global_assignment -name ROUTER_TIMING_OPTIMIZATION_LEVEL MAXIMUM
    set_global_assignment -name MUX_RESTRUCTURE OFF
    set_global_assignment -name FLOW_ENABLE_HYPER_RETIMER_FAST_FORWARD ON
    set_global_assignment -name ADV_NETLIST_OPT_SYNTH_WYSIWYG_REMAP ON
  	set_global_assignment -name MAX_FANOUT 100
  	set_global_assignment -name SYNCHRONIZATION_REGISTER_CHAIN_LENGTH 2

    set_global_assignment -name SYNTH_TIMING_DRIVEN_SYNTHESIS ON
    set_global_assignment -name OPTIMIZE_POWER_DURING_SYNTHESIS OFF
    set_global_assignment -name OPTIMIZE_POWER_DURING_FITTING OFF
    set_global_assignment -name FITTER_EFFORT "STANDARD FIT"
    set_global_assignment -name PHYSICAL_SYNTHESIS ON
    set_global_assignment -name FITTER_AGGRESSIVE_ROUTABILITY_OPTIMIZATION ALWAYS
    

    # Classic Timing Assignments
    # ==========================
    set_global_assignment -name TAO_FILE myresults.tao
    set_global_assignment -name ENABLE_CLOCK_LATENCY ON
    set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
    set_global_assignment -name MAX_CORE_JUNCTION_TEMP 100
    set_global_assignment -name TIMING_ANALYZER_DO_REPORT_TIMING ON
    set_global_assignment -name TIMING_ANALYZER_MULTICORNER_ANALYSIS ON

    # Global Clock assignments
    # ========================

	
set_instance_assignment -name IGNORE_MAX_FANOUT_ASSIGNMENTS ON -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|gen_clkrst|sbr_rstn_fanout -entity intel_rtile_cxl_top
set_instance_assignment -name IGNORE_MAX_FANOUT_ASSIGNMENTS ON -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|gen_clkrst|cam_warm_rstn_fanout -entity intel_rtile_cxl_top
set_instance_assignment -name IGNORE_MAX_FANOUT_ASSIGNMENTS ON -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|gen_clkrst|cam_cold_rstn_fanout -entity intel_rtile_cxl_top
set_instance_assignment -name IGNORE_MAX_FANOUT_ASSIGNMENTS ON -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|gen_clkrst|side_rstn_hip_fanout -entity intel_rtile_cxl_top
set_instance_assignment -name IGNORE_MAX_FANOUT_ASSIGNMENTS ON -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|notfor_tbf_logic.bbs_rst_Q1 -entity intel_rtile_cxl_top
set_instance_assignment -name IGNORE_MAX_FANOUT_ASSIGNMENTS ON -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|notfor_tbf_logic.bbs_rst_Q2 -entity intel_rtile_cxl_top
set_instance_assignment -name IGNORE_MAX_FANOUT_ASSIGNMENTS ON -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|notfor_tbf_logic.bbs_rst_Q3 -entity intel_rtile_cxl_top
set_instance_assignment -name IGNORE_MAX_FANOUT_ASSIGNMENTS ON -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|bbs|notfor_real_logic.bbs_rst_slice_q4[0] -entity intel_rtile_cxl_top
set_instance_assignment -name IGNORE_MAX_FANOUT_ASSIGNMENTS ON -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|bbs|notfor_real_logic.bbs_rst_slice_q4[1] -entity intel_rtile_cxl_top
set_instance_assignment -name IGNORE_MAX_FANOUT_ASSIGNMENTS ON -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|cxl_io_wrapper_inst|sip_warm_rstnQ -entity intel_rtile_cxl_top
set_instance_assignment -name IGNORE_MAX_FANOUT_ASSIGNMENTS ON -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|cxl_io_wrapper_inst|sip_warm_rstnQQ -entity intel_rtile_cxl_top
set_instance_assignment -name IGNORE_MAX_FANOUT_ASSIGNMENTS ON -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|cxl_io_wrapper_inst|sip_cmb_rstn -entity intel_rtile_cxl_top
set_instance_assignment -name IGNORE_MAX_FANOUT_ASSIGNMENTS ON -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|cxl_io_wrapper_inst|cxl_io_top_inst|cmb_cores[0].cmb_core_inst|ckunit|devreset1|LUreset_b_i -entity intel_rtile_cxl_top
set_instance_assignment -name IGNORE_MAX_FANOUT_ASSIGNMENTS ON -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|cxl_io_wrapper_inst|cxl_io_top_inst|cmb_cores[0].cmb_core_inst|ckunit|devreset1|LUplrm_rst_b_i -entity intel_rtile_cxl_top
set_instance_assignment -name IGNORE_MAX_FANOUT_ASSIGNMENTS ON -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_ip|rnr_cxl_tlp_bypass|u_rtile_mdx1|u_rnr_cxl_soft_wrapper|u_rnr_cxl_soft_rx_tx_wrapper|u_rnr_cxl_ehp_wrapper|rst_n_d2* -entity intel_rtile_cxl_top
set_instance_assignment -name GLOBAL_SIGNAL OFF -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|gen_clkrst|sbr_rstn_fanout -entity intel_rtile_cxl_top
set_instance_assignment -name GLOBAL_SIGNAL OFF -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|cxl_io_wrapper_inst|sip_cmb_rstn* -entity intel_rtile_cxl_top
set_instance_assignment -name GLOBAL_SIGNAL OFF -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|cxl_io_wrapper_inst|cxl_io_top_inst|i_prim_pll_init_rst_cold_n_ff -entity intel_rtile_cxl_top
set_instance_assignment -name DUPLICATE_REGISTER 2 -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|bbs|notfor_real_logic.bbs_rst_slice_q4[1] -entity intel_rtile_cxl_top
set_instance_assignment -name DUPLICATE_REGISTER 2 -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|bbs|notfor_real_logic.bbs_rst_slice_q4[0] -entity intel_rtile_cxl_top
set_instance_assignment -name DUPLICATE_REGISTER 6 -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|bbs|GenBBSSlice[*].bbs_slice_wrap|bbs_slice|dfc_top|ddfc_top|dataflow|ddfc_mem_ctrl_Stg.WrAddr[*] -entity intel_rtile_cxl_top
set_instance_assignment -name DUPLICATE_REGISTER 6 -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|bbs|GenBBSSlice[*].bbs_slice_wrap|bbs_slice|dfc_top|ddfc_top|dataflow|ddfc_mem_ctrl_Stg.Wren -entity intel_rtile_cxl_top
set_instance_assignment -name DUPLICATE_REGISTER 6 -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|bbs|GenBBSSlice[*].bbs_slice_wrap|bbs_slice|dfc_top|ddfc_top|dataflow|ddfc_mem_ctrl_Stg.RdAddr[*] -entity intel_rtile_cxl_top
set_instance_assignment -name DUPLICATE_REGISTER 6 -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|bbs|GenBBSSlice[*].bbs_slice_wrap|bbs_slice|dfc_top|ddfc_top|dataflow|ddfc_mem_ctrl_Stg.Rden -entity intel_rtile_cxl_top
set_instance_assignment -name DUPLICATE_REGISTER 6 -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|bbs|GenBBSSlice[*].bbs_slice_wrap|bbs_slice|dfc_top|hdfc_top|dataflow|hdfc_hostcache_ctrl_Stg.Wren -entity intel_rtile_cxl_top
set_instance_assignment -name DUPLICATE_REGISTER 6 -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|bbs|GenBBSSlice[*].bbs_slice_wrap|bbs_slice|dfc_top|hdfc_top|dataflow|hdfc_hostcache_ctrl_Stg.WrAddr[*] -entity intel_rtile_cxl_top
set_instance_assignment -name DUPLICATE_REGISTER 2 -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|bbs|GenBBSSlice[3].bbs_slice_wrap|bbs_slice|ial_top|ddfc_d2hdh_pre_fifo|wr_addr[*]~SynDup -entity intel_rtile_cxl_top
set_instance_assignment -name DUPLICATE_REGISTER 10 -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|cxl_io_wrapper_inst|cxl_io_top_inst|cmb2avst_top_inst|pld_rst_n_cp1 -entity intel_rtile_cxl_top
set_instance_assignment -name HSSI_CLOCK_TOPOLOGY OFF -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_ip|rnr_cxl_tlp_bypass|u_rtile_mdx1|u_z1578a_MD|inst_quartus|m3_121_1__hssi_dcm__pld_pcs_tx_clk_out_dcm[0] -entity intel_rtile_cxl_top

set_instance_assignment -name DUPLICATE_REGISTER 2 -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|bbs|GenBBSSlice[0].bbs_slice_wrap|bbs_slice|ial_top|ial_s2mdrs_Q.Valid -entity intel_rtile_cxl_top
set_instance_assignment -name DUPLICATE_REGISTER 2 -to intel_rtile_cxl_top_0|ED_DISABLE.cxltyp3ddr|cxltyp3ddr|ED_DISABLE.cxltyp3ddr_inst|cxltyp3ddr_sub|sip_top|cxl_memexp_sip_top_inst|cxl_memexp_sip_inst|bbs|bbs|GenBBSSlice[1].bbs_slice_wrap|bbs_slice|ial_top|ial_s2mdrs_Q.Valid -entity intel_rtile_cxl_top
