
namespace eval emif {
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    lappend memory_files "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/emif_altera_emif_arch_fm_191_uenu7qa_seq_params_synth.hex"
    return $memory_files
  }
  
  proc get_common_design_files {QSYS_SIMDIR} {
    set design_files [dict create]
    return $design_files
  }
  
  proc get_design_files {QSYS_SIMDIR} {
    set design_files [dict create]
    dict set design_files "emif_altera_emif_arch_fm_191_uenu7qa_top.sv" "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/emif_altera_emif_arch_fm_191_uenu7qa_top.sv"
    dict set design_files "altera_emif_arch_fm_bufs.sv"                 "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_bufs.sv"                
    dict set design_files "altera_emif_arch_fm_ufis.sv"                 "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_ufis.sv"                
    dict set design_files "altera_emif_arch_fm_ufi_wrapper.sv"          "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_ufi_wrapper.sv"         
    dict set design_files "altera_emif_arch_fm_buf_udir_se_i.sv"        "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_udir_se_i.sv"       
    dict set design_files "altera_emif_arch_fm_buf_udir_se_o.sv"        "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_udir_se_o.sv"       
    dict set design_files "altera_emif_arch_fm_buf_udir_df_i.sv"        "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_udir_df_i.sv"       
    dict set design_files "altera_emif_arch_fm_buf_udir_df_o.sv"        "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_udir_df_o.sv"       
    dict set design_files "altera_emif_arch_fm_buf_udir_cp_i.sv"        "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_udir_cp_i.sv"       
    dict set design_files "altera_emif_arch_fm_buf_bdir_df.sv"          "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_bdir_df.sv"         
    dict set design_files "altera_emif_arch_fm_buf_bdir_se.sv"          "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_bdir_se.sv"         
    dict set design_files "altera_emif_arch_fm_buf_unused.sv"           "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_unused.sv"          
    dict set design_files "altera_emif_arch_fm_cal_counter.sv"          "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_cal_counter.sv"         
    dict set design_files "altera_emif_arch_fm_pll.sv"                  "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_pll.sv"                 
    dict set design_files "altera_emif_arch_fm_pll_fast_sim.sv"         "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_pll_fast_sim.sv"        
    dict set design_files "altera_emif_arch_fm_pll_extra_clks.sv"       "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_pll_extra_clks.sv"      
    dict set design_files "altera_emif_arch_fm_oct.sv"                  "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_oct.sv"                 
    dict set design_files "altera_emif_arch_fm_core_clks_rsts.sv"       "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_core_clks_rsts.sv"      
    dict set design_files "altera_emif_arch_fm_hps_clks_rsts.sv"        "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hps_clks_rsts.sv"       
    dict set design_files "altera_emif_arch_fm_local_reset.sv"          "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_local_reset.sv"         
    dict set design_files "altera_emif_arch_fm_io_tiles_wrap.sv"        "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_io_tiles_wrap.sv"       
    dict set design_files "altera_emif_arch_fm_io_tiles.sv"             "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_io_tiles.sv"            
    dict set design_files "altera_emif_arch_fm_io_lane_remap.sv"        "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_io_lane_remap.sv"       
    dict set design_files "altera_emif_arch_fm_hmc_avl_if.sv"           "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hmc_avl_if.sv"          
    dict set design_files "altera_emif_arch_fm_hmc_sideband_if.sv"      "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hmc_sideband_if.sv"     
    dict set design_files "altera_emif_arch_fm_hmc_mmr_if.sv"           "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hmc_mmr_if.sv"          
    dict set design_files "altera_emif_arch_fm_hmc_amm_data_if.sv"      "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hmc_amm_data_if.sv"     
    dict set design_files "altera_emif_arch_fm_phylite_if.sv"           "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_phylite_if.sv"          
    dict set design_files "altera_emif_arch_fm_hmc_ast_data_if.sv"      "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hmc_ast_data_if.sv"     
    dict set design_files "altera_emif_arch_fm_afi_if.sv"               "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_afi_if.sv"              
    dict set design_files "altera_emif_arch_fm_seq_if.sv"               "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_seq_if.sv"              
    dict set design_files "altera_emif_arch_fm_regs.sv"                 "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_emif_arch_fm_regs.sv"                
    dict set design_files "altera_std_synchronizer_nocut.v"             "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/altera_std_synchronizer_nocut.v"            
    dict set design_files "emif_altera_emif_arch_fm_191_uenu7qa.sv"     "$QSYS_SIMDIR/../altera_emif_arch_fm_191/sim/emif_altera_emif_arch_fm_191_uenu7qa.sv"    
    dict set design_files "emif_altera_emif_fm_261_l3i6zza.v"           "$QSYS_SIMDIR/../altera_emif_fm_261/sim/emif_altera_emif_fm_261_l3i6zza.v"               
    dict set design_files "emif.v"                                      "$QSYS_SIMDIR/emif.v"                                                                    
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
