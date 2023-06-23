	component reqfifo is
		port (
			data    : in  std_logic_vector(639 downto 0) := (others => 'X'); -- datain
			wrreq   : in  std_logic                      := 'X';             -- wrreq
			rdreq   : in  std_logic                      := 'X';             -- rdreq
			wrclk   : in  std_logic                      := 'X';             -- wrclk
			rdclk   : in  std_logic                      := 'X';             -- rdclk
			aclr    : in  std_logic                      := 'X';             -- aclr
			q       : out std_logic_vector(639 downto 0);                    -- dataout
			wrusedw : out std_logic_vector(5 downto 0);                      -- wrusedw
			rdempty : out std_logic;                                         -- rdempty
			wrfull  : out std_logic;                                         -- wrfull
			wrempty : out std_logic                                          -- wrempty
		);
	end component reqfifo;

	u0 : component reqfifo
		port map (
			data    => CONNECTED_TO_data,    --  fifo_input.datain
			wrreq   => CONNECTED_TO_wrreq,   --            .wrreq
			rdreq   => CONNECTED_TO_rdreq,   --            .rdreq
			wrclk   => CONNECTED_TO_wrclk,   --            .wrclk
			rdclk   => CONNECTED_TO_rdclk,   --            .rdclk
			aclr    => CONNECTED_TO_aclr,    --            .aclr
			q       => CONNECTED_TO_q,       -- fifo_output.dataout
			wrusedw => CONNECTED_TO_wrusedw, --            .wrusedw
			rdempty => CONNECTED_TO_rdempty, --            .rdempty
			wrfull  => CONNECTED_TO_wrfull,  --            .wrfull
			wrempty => CONNECTED_TO_wrempty  --            .wrempty
		);

