	component altecc_enc_latency0 is
		port (
			data : in  std_logic_vector(63 downto 0) := (others => 'X'); -- data
			q    : out std_logic_vector(71 downto 0)                     -- q
		);
	end component altecc_enc_latency0;

	u0 : component altecc_enc_latency0
		port map (
			data => CONNECTED_TO_data, -- data.data
			q    => CONNECTED_TO_q     --    q.q
		);

