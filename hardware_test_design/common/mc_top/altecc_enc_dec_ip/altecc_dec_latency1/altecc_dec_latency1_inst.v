	altecc_dec_latency1 u0 (
		.data          (_connected_to_data_),          //   input,  width = 72,          data.data
		.q             (_connected_to_q_),             //  output,  width = 64,             q.q
		.err_corrected (_connected_to_err_corrected_), //  output,   width = 1, err_corrected.err_corrected
		.err_detected  (_connected_to_err_detected_),  //  output,   width = 1,  err_detected.err_detected
		.err_fatal     (_connected_to_err_fatal_),     //  output,   width = 1,     err_fatal.err_fatal
		.syn_e         (_connected_to_syn_e_),         //  output,   width = 1,         syn_e.syn_e
		.clock         (_connected_to_clock_)          //   input,   width = 1,         clock.clock
	);

