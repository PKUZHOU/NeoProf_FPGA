
namespace eval emif {
  proc get_design_libraries {} {
    set libraries [dict create]
    dict set libraries altera_emif_arch_fm_191 1
    dict set libraries altera_emif_fm_261      1
    dict set libraries emif                    1
    return $libraries
  }
  
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    lappend memory_files "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/emif_altera_emif_arch_fm_191_uenu7qa_seq_params_synth.hex"
    return $memory_files
  }
  
  proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [dict create]
    return $design_files
  }
  
  proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [list]
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/emif_altera_emif_arch_fm_191_uenu7qa_top.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_bufs.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"                
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_ufis.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"                
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_ufi_wrapper.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"         
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_udir_se_i.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"       
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_udir_se_o.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"       
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_udir_df_i.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"       
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_udir_df_o.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"       
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_udir_cp_i.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"       
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_bdir_df.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"         
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_bdir_se.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"         
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_unused.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"          
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_cal_counter.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"         
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_pll.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"                 
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_pll_fast_sim.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"        
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_pll_extra_clks.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"      
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_oct.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"                 
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_core_clks_rsts.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"      
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hps_clks_rsts.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"       
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_local_reset.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"         
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_io_tiles_wrap.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"       
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_io_tiles.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"            
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_io_lane_remap.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"       
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hmc_avl_if.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"          
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hmc_sideband_if.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"     
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hmc_mmr_if.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"          
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hmc_amm_data_if.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"     
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_phylite_if.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"          
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hmc_ast_data_if.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"     
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_afi_if.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"              
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_seq_if.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"              
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_regs.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"                
    lappend design_files "xmvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_std_synchronizer_nocut.v\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"                
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/emif_altera_emif_arch_fm_191_uenu7qa.sv\"  -work altera_emif_arch_fm_191 -cdslib  ./cds_libs/altera_emif_arch_fm_191.cds.lib"    
    lappend design_files "xmvlog -compcnfg $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_fm_261/sim/emif_altera_emif_fm_261_l3i6zza.v\"  -work altera_emif_fm_261"                                                                  
    lappend design_files "xmvlog -compcnfg $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/emif.v\"  -work emif"                                                                                                                                     
    return $design_files
  }
  
  proc get_elab_options {SIMULATOR_TOOL_BITNESS} {
    set ELAB_OPTIONS ""
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ELAB_OPTIONS
  }
  
  
  proc get_sim_options {SIMULATOR_TOOL_BITNESS} {
    set SIM_OPTIONS ""
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $SIM_OPTIONS
  }
  
  
  proc get_env_variables {SIMULATOR_TOOL_BITNESS} {
    set ENV_VARIABLES [dict create]
    set LD_LIBRARY_PATH [dict create]
    dict set ENV_VARIABLES "LD_LIBRARY_PATH" $LD_LIBRARY_PATH
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ENV_VARIABLES
  }
  
  
}
