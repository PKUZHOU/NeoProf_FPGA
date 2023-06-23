	component altecc_dec_latency2 is
		port (
			data          : in  std_logic_vector(71 downto 0) := (others => 'X'); -- data
			q             : out std_logic_vector(63 downto 0);                    -- q
			err_corrected : out std_logic;                                        -- err_corrected
			err_detected  : out std_logic;                                        -- err_detected
			err_fatal     : out std_logic;                                        -- err_fatal
			syn_e         : out std_logic;                                        -- syn_e
			clock         : in  std_logic                     := 'X'              -- clock
		);
	end component altecc_dec_latency2;

	u0 : component altecc_dec_latency2
		port map (
			data          => CONNECTED_TO_data,          --          data.data
			q             => CONNECTED_TO_q,             --             q.q
			err_corrected => CONNECTED_TO_err_corrected, -- err_corrected.err_corrected
			err_detected  => CONNECTED_TO_err_detected,  --  err_detected.err_detected
			err_fatal     => CONNECTED_TO_err_fatal,     --     err_fatal.err_fatal
			syn_e         => CONNECTED_TO_syn_e,         --         syn_e.syn_e
			clock         => CONNECTED_TO_clock          --         clock.clock
		);

