// DESCRIPTION: Verilator: Verilog example module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2017 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0
//======================================================================
 
// Include common routines
#include <verilated.h>
 
// Include model header, generated from Verilating "top.v"
#include "Vneoprof_exp.h"
#include "verilated_vcd_c.h"
#include <stdio.h>

vluint64_t main_time = 0; 
#define MAX_SIM_TIME 100000

#define ADDR_TEST_REG 0x100
#define ADDR_RESET 0x200
#define ADDR_SET_THRESH 0x300
#define ADDR_NR_HP 0x200
#define ADDR_HP 0x300

#define ADDR_STATE_SAMPLE_INTERVAL 0x400
#define RD_STATE_RD_CNT 0x600
#define WR_PAGE_SAMPLE_INTERVAL 0x500

void memory_read(Vneoprof_exp * top, unsigned int addr){
    top->cxlip2iafu_address_eclk = addr;
    top->cxlip2iafu_read_eclk = 1;
    top->ddr_read_valid = 1;
}

void memory_write(Vneoprof_exp * top){
    top->ddr_write_valid = 1;
}

void set_threshold(Vneoprof_exp * top, unsigned int threshold){
    top->csr_avmm_writedata = threshold;
    top->csr_avmm_address = ADDR_SET_THRESH;
    top->csr_avmm_write = 1;
    top->csr_avmm_byteenable = 0xff;
}

void set_page_sample_interval(Vneoprof_exp * top, unsigned int interval){
    top->csr_avmm_writedata = interval;
    top->csr_avmm_address = WR_PAGE_SAMPLE_INTERVAL;
    top->csr_avmm_byteenable = 0xf;
    top->csr_avmm_write = 1;
}

void clear_state(Vneoprof_exp * top){
    top->csr_avmm_write = 0;
    top->csr_avmm_read = 0;
    top->afu_rstn = 1;
    top->csr_avmm_rstn = 1;
    top->cxlip2iafu_read_eclk = 0;
    top->ddr_read_valid = 0;
    top->cxlip2iafu_address_eclk = 0;
}

void read_out(Vneoprof_exp * top){
    top->csr_avmm_read = 1;
    top->csr_avmm_byteenable = 0xf;
    top->csr_avmm_address = ADDR_HP;
}

void reset(Vneoprof_exp * top){
    top->csr_avmm_write = 1;
    top->csr_avmm_address = ADDR_RESET;
}

void set_state_monitor_sample_interval(Vneoprof_exp * top, unsigned int interval){
    top->csr_avmm_writedata = interval;
    top->csr_avmm_address = ADDR_STATE_SAMPLE_INTERVAL;
    top->csr_avmm_byteenable = 0xf;
    top->csr_avmm_write = 1;
}

void read_out_sample_rd(Vneoprof_exp * top){
    top->csr_avmm_read = 1;
    top->csr_avmm_byteenable = 0xf;
    top->csr_avmm_address = RD_STATE_RD_CNT;
}

void write_hist_en(Vneoprof_exp * top){
    top->csr_avmm_writedata = 1;
    top->csr_avmm_address = 0x600;
    top->csr_avmm_byteenable = 0xf;
    top->csr_avmm_write = 1;
}

void rd_nr_hist(Vneoprof_exp * top){
    top->csr_avmm_read = 1;
    top->csr_avmm_byteenable = 0xf;
    top->csr_avmm_address = 0x900;
}

void rd_hist(Vneoprof_exp * top){
    top->csr_avmm_read = 1;
    top->csr_avmm_byteenable = 0xf;
    top->csr_avmm_address = 0x800;
}


double sc_time_stamp()
{
    return main_time;
}

void evaluate_sketch(Vneoprof_exp* top,  VerilatedVcdC* tfp){
    int start_offset = 10;
    while (!Verilated::gotFinish() && main_time < MAX_SIM_TIME) {
        top->afu_clk = !top->afu_clk;     
        if ((main_time % 2) == 1) {
            top->csr_avmm_clk = !top->csr_avmm_clk;
        }
        // set the threshold
        if (main_time >= 4 && main_time <= 6){
            // set_threshold(top, 1);
            set_page_sample_interval(top, 0);
            // set_state_monitor_sample_interval(top, 2);
        }
        if (main_time == 7 || main_time == 8){
            clear_state(top);
        }
        if (main_time == start_offset + 9 || main_time == start_offset + 10){
            memory_read(top, 0x11111111 << 6);
        }
        if (main_time == start_offset + 11 || main_time == start_offset + 12){
            memory_read(top, 0x22222222 << 6);
        }
        if (main_time == start_offset + 13 || main_time == start_offset + 14){
            memory_read(top, 0x22222222 << 6);
        }
        if (main_time == start_offset + 15 || main_time == start_offset + 16){
            memory_read(top, 0x11111111 << 6);
        }
        if (main_time == start_offset + 17 || main_time == start_offset + 18){
            memory_read(top, 0x22222222 << 6);
        }
        if (main_time == start_offset + 19 || main_time == start_offset + 20){
            clear_state(top);
        }
        if (main_time == start_offset + 21 || main_time == start_offset + 22){
            memory_read(top, 0x33333333 << 6);
        }
        if (main_time == start_offset + 23 || main_time == start_offset + 24){
            memory_read(top, 0x11111111 << 6);
        }
        if (main_time == start_offset + 25 || main_time == start_offset + 26){
            memory_read(top, 0x33333333 << 6);
        }
        if (main_time == start_offset + 27 || main_time == start_offset + 28){
            clear_state(top);
        }
        if (main_time >= start_offset + 529 && main_time <= start_offset + 532){
            reset(top);
        }
        if (main_time == start_offset + 533 || main_time == start_offset + 534){
            clear_state(top);
        }
        if (main_time == start_offset + 1119 || main_time == start_offset + 1120){
            clear_state(top);
        }

        if (main_time == start_offset + 1123 || main_time == start_offset + 1124){
            clear_state(top);
        }
        if (main_time == start_offset + 1126 || main_time == start_offset + 1127){
            memory_read(top, 0x11111111 << 6);
        }
        if (main_time == start_offset + 1128 || main_time == start_offset + 1129){
            memory_read(top, 0x11111111 << 6);
        }
        if (main_time == start_offset + 1130 || main_time == start_offset + 1131){
            memory_read(top, 0x44444444 << 6);
        }
        if (main_time == start_offset + 1200 && main_time < 12000){
            read_out(top);
            read_out_sample_rd(top);
        }
        // Evaluate model
        top->eval();
        tfp->dump(main_time);
        main_time++;
        // printf("%d\n", main_time);
    }
}

void evaluate_hist(Vneoprof_exp* top, VerilatedVcdC* tfp){
    while (!Verilated::gotFinish() && main_time < MAX_SIM_TIME) {
        top->afu_clk = !top->afu_clk;     
        if ((main_time % 2) == 1) {
            top->csr_avmm_clk = !top->csr_avmm_clk;
        }
        if (main_time == 7 || main_time == 8){
            clear_state(top);
        }
        if (main_time <= 10000){
            memory_read(top, 0x11111111 << 6);
        }
        if (main_time == 10001 || main_time == 10002){
            write_hist_en(top);
        }
        if (main_time == 10003 || main_time == 10004){
            clear_state(top);
        }
        if (main_time == 24001 || main_time == 24002){
            rd_nr_hist(top);
        }
        if (main_time >= 24003 && main_time <= 25100){
            rd_hist(top);
        }
        if (main_time == 24101 || main_time == 24102){
            clear_state(top);
            // rd_nr_hist(top);
        }
        if (main_time >= 25109 && main_time <  30000){
            memory_read(top, main_time << 6);
        } 
        if (main_time == 30001 || main_time == 30002){
            write_hist_en(top);
        }
        if (main_time == 30003 || main_time == 30004){
            clear_state(top);
        }
        if (main_time == 40001 || main_time == 40002){
            rd_nr_hist(top);
        }
        if (main_time >= 40003 && main_time <= 40100){
            rd_hist(top);
        }
        // Evaluate model
        top->eval();
        tfp->dump(main_time);
        main_time++;
    }
}

int main(int argc, char** argv, char** env) {
    // See a similar example walkthrough in the verilator manpage.
 
    // This is intended to be a minimal example.  Before copying this to start a
    // real project, it is better to start with a more complete example,
    // e.g. examples/c_tracing.
    Verilated::commandArgs(argc,argv);
    Verilated::traceEverOn(true); 
    VerilatedVcdC* tfp = new VerilatedVcdC();

    // Construct the Verilated model, from Vtop.h generated from Verilating "top.v"
    Vneoprof_exp* top = new Vneoprof_exp;
    // set some init value
    top->csr_avmm_clk = 0;
    top->afu_clk = 1;

    top->afu_rstn = 1;
    top->csr_avmm_rstn = 1;

    top->trace(tfp, 0);
    tfp->open("wave.vcd");


    evaluate_hist(top, tfp);
    // evaluate_sketch(top, tfp);
 
    // Final model cleanup
    top->final();
    tfp->close();
    // Destroy model
    delete top;
    // Return good completion status
    return 0;
}