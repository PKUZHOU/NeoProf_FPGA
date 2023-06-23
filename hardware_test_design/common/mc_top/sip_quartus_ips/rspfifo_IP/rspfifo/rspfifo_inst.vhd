	component rspfifo is
		port (
			data    : in  std_logic_vector(559 downto 0) := (others => 'X'); -- datain
			wrreq   : in  std_logic                      := 'X';             -- wrreq
			rdreq   : in  std_logic                      := 'X';             -- rdreq
			wrclk   : in  std_logic                      := 'X';             -- wrclk
			rdclk   : in  std_logic                      := 'X';             -- rdclk
			aclr    : in  std_logic                      := 'X';             -- aclr
			q       : out std_logic_vector(559 downto 0);                    -- dataout
			rdusedw : out std_logic_vector(5 downto 0);                      -- rdusedw
			rdfull  : out std_logic;                                         -- rdfull
			rdempty : out std_logic;                                         -- rdempty
			wrfull  : out std_logic                                          -- wrfull
		);
	end component rspfifo;

	u0 : component rspfifo
		port map (
			data    => CONNECTED_TO_data,    --  fifo_input.datain
			wrreq   => CONNECTED_TO_wrreq,   --            .wrreq
			rdreq   => CONNECTED_TO_rdreq,   --            .rdreq
			wrclk   => CONNECTED_TO_wrclk,   --            .wrclk
			rdclk   => CONNECTED_TO_rdclk,   --            .rdclk
			aclr    => CONNECTED_TO_aclr,    --            .aclr
			q       => CONNECTED_TO_q,       -- fifo_output.dataout
			rdusedw => CONNECTED_TO_rdusedw, --            .rdusedw
			rdfull  => CONNECTED_TO_rdfull,  --            .rdfull
			rdempty => CONNECTED_TO_rdempty, --            .rdempty
			wrfull  => CONNECTED_TO_wrfull   --            .wrfull
		);

