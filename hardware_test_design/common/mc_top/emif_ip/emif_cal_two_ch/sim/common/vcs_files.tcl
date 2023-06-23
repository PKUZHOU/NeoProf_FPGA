
namespace eval emif_cal_two_ch {
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    lappend memory_files "$QSYS_SIMDIR/../altera_emif_cal_iossm_261/sim/emif_cal_two_ch_altera_emif_cal_iossm_261_blvn6sy_code.hex"
    lappend memory_files "$QSYS_SIMDIR/../altera_emif_cal_iossm_261/sim/emif_cal_two_ch_altera_emif_cal_iossm_261_blvn6sy_sim_global_param_tbl.hex"
    lappend memory_files "$QSYS_SIMDIR/../altera_emif_cal_iossm_261/sim/emif_cal_two_ch_altera_emif_cal_iossm_261_blvn6sy_synth_global_param_tbl.hex"
    return $memory_files
  }
  
  proc get_common_design_files {QSYS_SIMDIR} {
    set design_files [dict create]
    return $design_files
  }
  
  proc get_design_files {QSYS_SIMDIR} {
    set design_files [dict create]
    dict set design_files "altera_emif_cal_iossm.sv"                                  "$QSYS_SIMDIR/../altera_emif_cal_iossm_261/sim/altera_emif_cal_iossm.sv"                                 
    dict set design_files "altera_emif_f2c_gearbox.sv"                                "$QSYS_SIMDIR/../altera_emif_cal_iossm_261/sim/altera_emif_f2c_gearbox.sv"                               
    dict set design_files "emif_cal_two_ch_altera_emif_cal_iossm_261_blvn6sy_arch.sv" "$QSYS_SIMDIR/../altera_emif_cal_iossm_261/sim/emif_cal_two_ch_altera_emif_cal_iossm_261_blvn6sy_arch.sv"
    dict set design_files "emif_cal_two_ch_altera_emif_cal_iossm_261_blvn6sy.sv"      "$QSYS_SIMDIR/../altera_emif_cal_iossm_261/sim/emif_cal_two_ch_altera_emif_cal_iossm_261_blvn6sy.sv"     
    dict set design_files "emif_cal_two_ch_altera_emif_cal_261_yvjgaei.v"             "$QSYS_SIMDIR/../altera_emif_cal_261/sim/emif_cal_two_ch_altera_emif_cal_261_yvjgaei.v"                  
    dict set design_files "emif_cal_two_ch.v"                                         "$QSYS_SIMDIR/emif_cal_two_ch.v"                                                                         
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
