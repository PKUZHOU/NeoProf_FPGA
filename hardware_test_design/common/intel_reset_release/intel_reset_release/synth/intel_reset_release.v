// intel_reset_release.v

// Generated using ACDS version 22.3 104

`timescale 1 ps / 1 ps
module intel_reset_release (
		output wire  ninit_done  // ninit_done.ninit_done
	);

	altera_s10_user_rst_clkgate s10_user_rst_clkgate_0 (
		.ninit_done (ninit_done)  //  output,  width = 1, ninit_done.ninit_done
	);

endmodule
