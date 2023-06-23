	component intel_reset_release is
		port (
			ninit_done : out std_logic   -- ninit_done
		);
	end component intel_reset_release;

	u0 : component intel_reset_release
		port map (
			ninit_done => CONNECTED_TO_ninit_done  -- ninit_done.ninit_done
		);

