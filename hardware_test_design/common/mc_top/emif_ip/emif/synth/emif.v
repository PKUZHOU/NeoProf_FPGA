// emif.v

// Generated using ACDS version 22.3 104

`timescale 1 ps / 1 ps
module emif (
		input  wire          local_reset_req,      //    local_reset_req.local_reset_req,      Signal from user logic to request the memory interface to be reset and recalibrated. Reset request is sent by transitioning the local_reset_req signal from low to high, then keeping the signal at the high state for a minimum of 2 EMIF core clock cycles, then transitioning the signal from high to low. local_reset_req is asynchronous in that there is no setup/hold timing to meet, but it must meet the minimum pulse width requirement of 2 EMIF core clock cycles.
		output wire          local_reset_done,     // local_reset_status.local_reset_done,     Signal from memory interface to indicate whether it has completed a reset sequence, is currently out of reset, and is ready for a new reset request.  When local_reset_done is low, the memory interface is in reset.
		input  wire          pll_ref_clk,          //        pll_ref_clk.clk,                  PLL reference clock input
		output wire          pll_ref_clk_out,      //    pll_ref_clk_out.clk,                  PLL reference clock output
		output wire          pll_locked,           //         pll_locked.pll_locked,           PLL lock signal to indicate whether the PLL has locked
		input  wire          oct_rzqin,            //                oct.oct_rzqin,            Calibrated On-Chip Termination (OCT) RZQ input pin
		output wire [0:0]    mem_ck,               //                mem.mem_ck,               CK clock
		output wire [0:0]    mem_ck_n,             //                   .mem_ck_n,             CK clock (negative leg)
		output wire [16:0]   mem_a,                //                   .mem_a,                Address
		output wire [0:0]    mem_act_n,            //                   .mem_act_n,            Activation command
		output wire [1:0]    mem_ba,               //                   .mem_ba,               Bank address
		output wire [1:0]    mem_bg,               //                   .mem_bg,               Bank group
		output wire [0:0]    mem_cke,              //                   .mem_cke,              Clock enable
		output wire [0:0]    mem_cs_n,             //                   .mem_cs_n,             Chip select
		output wire [0:0]    mem_odt,              //                   .mem_odt,              On-die termination
		output wire [0:0]    mem_reset_n,          //                   .mem_reset_n,          Asynchronous reset
		output wire [0:0]    mem_par,              //                   .mem_par,              Command and address parity
		input  wire [0:0]    mem_alert_n,          //                   .mem_alert_n,          Alert flag
		inout  wire [8:0]    mem_dqs,              //                   .mem_dqs,              Data strobe
		inout  wire [8:0]    mem_dqs_n,            //                   .mem_dqs_n,            Data strobe (negative leg)
		inout  wire [71:0]   mem_dq,               //                   .mem_dq,               Read/write data
		inout  wire [8:0]    mem_dbi_n,            //                   .mem_dbi_n,            Acts as either the data bus inversion pin, or the data mask pin, depending on configuration.
		output wire          local_cal_success,    //             status.local_cal_success,    When high, indicates that PHY calibration was successful
		output wire          local_cal_fail,       //                   .local_cal_fail,       When high, indicates that PHY calibration failed
		output wire          emif_usr_reset_n,     //   emif_usr_reset_n.reset_n,              Reset for the user clock domain. Asynchronous assertion and synchronous deassertion
		output wire          emif_usr_clk,         //       emif_usr_clk.clk,                  User clock domain
		output wire          amm_ready_0,          //         ctrl_amm_0.waitrequest_n,        Wait-request is asserted when controller is busy
		input  wire          amm_read_0,           //                   .read,                 Read request signal
		input  wire          amm_write_0,          //                   .write,                Write request signal
		input  wire [26:0]   amm_address_0,        //                   .address,              Address for the read/write request
		output wire [575:0]  amm_readdata_0,       //                   .readdata,             Read data
		input  wire [575:0]  amm_writedata_0,      //                   .writedata,            Write data
		input  wire [6:0]    amm_burstcount_0,     //                   .burstcount,           Number of transfers in each read/write burst
		input  wire [71:0]   amm_byteenable_0,     //                   .byteenable,           Byte-enable for write data
		output wire          amm_readdatavalid_0,  //                   .readdatavalid,        Indicates whether read data is valid
		input  wire          calbus_read,          //        emif_calbus.calbus_read,          EMIF Calibration component bus for read
		input  wire          calbus_write,         //                   .calbus_write,         EMIF Calibration component bus for write
		input  wire [19:0]   calbus_address,       //                   .calbus_address,       EMIF Calibration component bus for address
		input  wire [31:0]   calbus_wdata,         //                   .calbus_wdata,         EMIF Calibration component bus for write data
		output wire [31:0]   calbus_rdata,         //                   .calbus_rdata,         EMIF Calibration component bus for read data
		output wire [4095:0] calbus_seq_param_tbl, //                   .calbus_seq_param_tbl, EMIF Calibration component bus for parameter table data
		input  wire          calbus_clk            //    emif_calbus_clk.clk,                  EMIF Calibration component bus for the clock
	);

	emif_altera_emif_fm_261_l3i6zza emif (
		.local_reset_req      (local_reset_req),      //   input,     width = 1,    local_reset_req.local_reset_req
		.local_reset_done     (local_reset_done),     //  output,     width = 1, local_reset_status.local_reset_done
		.pll_ref_clk          (pll_ref_clk),          //   input,     width = 1,        pll_ref_clk.clk
		.pll_ref_clk_out      (pll_ref_clk_out),      //  output,     width = 1,    pll_ref_clk_out.clk
		.pll_locked           (pll_locked),           //  output,     width = 1,         pll_locked.pll_locked
		.oct_rzqin            (oct_rzqin),            //   input,     width = 1,                oct.oct_rzqin
		.mem_ck               (mem_ck),               //  output,     width = 1,                mem.mem_ck
		.mem_ck_n             (mem_ck_n),             //  output,     width = 1,                   .mem_ck_n
		.mem_a                (mem_a),                //  output,    width = 17,                   .mem_a
		.mem_act_n            (mem_act_n),            //  output,     width = 1,                   .mem_act_n
		.mem_ba               (mem_ba),               //  output,     width = 2,                   .mem_ba
		.mem_bg               (mem_bg),               //  output,     width = 2,                   .mem_bg
		.mem_cke              (mem_cke),              //  output,     width = 1,                   .mem_cke
		.mem_cs_n             (mem_cs_n),             //  output,     width = 1,                   .mem_cs_n
		.mem_odt              (mem_odt),              //  output,     width = 1,                   .mem_odt
		.mem_reset_n          (mem_reset_n),          //  output,     width = 1,                   .mem_reset_n
		.mem_par              (mem_par),              //  output,     width = 1,                   .mem_par
		.mem_alert_n          (mem_alert_n),          //   input,     width = 1,                   .mem_alert_n
		.mem_dqs              (mem_dqs),              //   inout,     width = 9,                   .mem_dqs
		.mem_dqs_n            (mem_dqs_n),            //   inout,     width = 9,                   .mem_dqs_n
		.mem_dq               (mem_dq),               //   inout,    width = 72,                   .mem_dq
		.mem_dbi_n            (mem_dbi_n),            //   inout,     width = 9,                   .mem_dbi_n
		.local_cal_success    (local_cal_success),    //  output,     width = 1,             status.local_cal_success
		.local_cal_fail       (local_cal_fail),       //  output,     width = 1,                   .local_cal_fail
		.emif_usr_reset_n     (emif_usr_reset_n),     //  output,     width = 1,   emif_usr_reset_n.reset_n
		.emif_usr_clk         (emif_usr_clk),         //  output,     width = 1,       emif_usr_clk.clk
		.amm_ready_0          (amm_ready_0),          //  output,     width = 1,         ctrl_amm_0.waitrequest_n
		.amm_read_0           (amm_read_0),           //   input,     width = 1,                   .read
		.amm_write_0          (amm_write_0),          //   input,     width = 1,                   .write
		.amm_address_0        (amm_address_0),        //   input,    width = 27,                   .address
		.amm_readdata_0       (amm_readdata_0),       //  output,   width = 576,                   .readdata
		.amm_writedata_0      (amm_writedata_0),      //   input,   width = 576,                   .writedata
		.amm_burstcount_0     (amm_burstcount_0),     //   input,     width = 7,                   .burstcount
		.amm_byteenable_0     (amm_byteenable_0),     //   input,    width = 72,                   .byteenable
		.amm_readdatavalid_0  (amm_readdatavalid_0),  //  output,     width = 1,                   .readdatavalid
		.calbus_read          (calbus_read),          //   input,     width = 1,        emif_calbus.calbus_read
		.calbus_write         (calbus_write),         //   input,     width = 1,                   .calbus_write
		.calbus_address       (calbus_address),       //   input,    width = 20,                   .calbus_address
		.calbus_wdata         (calbus_wdata),         //   input,    width = 32,                   .calbus_wdata
		.calbus_rdata         (calbus_rdata),         //  output,    width = 32,                   .calbus_rdata
		.calbus_seq_param_tbl (calbus_seq_param_tbl), //  output,  width = 4096,                   .calbus_seq_param_tbl
		.calbus_clk           (calbus_clk)            //   input,     width = 1,    emif_calbus_clk.clk
	);

endmodule
