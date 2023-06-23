module altecc_dec_latency2 (
		input  wire [71:0] data,          //          data.data
		output wire [63:0] q,             //             q.q
		output wire        err_corrected, // err_corrected.err_corrected
		output wire        err_detected,  //  err_detected.err_detected
		output wire        err_fatal,     //     err_fatal.err_fatal
		output wire        syn_e,         //         syn_e.syn_e
		input  wire        clock          //         clock.clock
	);
endmodule

