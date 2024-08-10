
# FPGA Implementation of  NeoProf (NeoMem, MICRO 2024)

NeoProf is a device-side profiler for hot-page detection in CXL-based memory tiering systems. It identifies hot pages via Sketch units and reports to the host through MMIO interfaces. NeoProf is  implemented on top of Intel's CXL Type3 (memory expander) demo. 

Here lists the key components of NeoProf:

```
├── hardware_test_design
│   ├── common
│   │   ├── afu
│   │   │   ├── afu_top.sv                      # User logic (NeoProf) is hooked here 
│   │   │   ├── async_fifo.sv           
│   │   │   ├── fifo_v3.sv              
│   │   │   ├── neoprof_avmm_slave.sv           # NeoProf's interface, instructions and main modules.
│   │   │   ├── neoprof_exp.sv                  # Used for verification
│   │   │   ├── registers.svh           
│   │   │   ├── sketch
│   │   │   │   ├── cmsketch.sv                 # The top module of sketch unit used in NeoProf    
│   │   │   │   ├── hash_block.sv               # The hash unit used in sketch
│   │   │   │   ├── histogram.sv                # The histogram unit used for sketch error estimation
│   │   │   │   ├── pipeline_mem_buffer.sv      # For NeoProf pipeline implementation
│   │   │   │   ├── pipeline_mem_component.sv   # For NeoProf pipeline implementation
│   │   │   │   ├── pipeline_mem_segment.sv     # For NeoProf pipeline implementation
│   │   │   │   ├── seeds_table.hv              # Pre-generated hash seeds 
│   │   │   │   └── sketch_lane.sv              # Implementation of a sketch lane
│   │   │   └── verilator
│   │   │       ├── compiler.sh
│   │   │       └── sim_main.cpp                # Used for DV
│   │   └── mc_top                              # Memory controller
│   ├── constraints
│   ├── cxltyp3_memexp_ddr4_top.sv              # CXL IP to DDR
│   ├── ed_top_wrapper_typ3.sv                  # The top module of this Type3 demo
```

This project is compatible with Quartus 22.3. Other quartus versions have not been tested and may have potential issues. 