verilator -Wall --cc --trace --exe -Mdir ./build ../neoprof_exp.sv ../sketch/histogram.sv ../neoprof_avmm_slave.sv ../async_fifo.sv ../sketch/hash_block.sv  ../sketch/sketch_lane.sv ../fifo_v3.sv ../sketch/cmsketch.sv ../sketch/pipeline_mem_segment.sv ../sketch/pipeline_mem_component.sv sim_main.cpp  -I../sketch -I../
make -j -C build -f Vneoprof_exp.mk Vneoprof_exp