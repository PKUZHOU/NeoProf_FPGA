	component emif_cal_two_ch is
		port (
			calbus_read_0          : out std_logic;                                          -- calbus_read
			calbus_write_0         : out std_logic;                                          -- calbus_write
			calbus_address_0       : out std_logic_vector(19 downto 0);                      -- calbus_address
			calbus_wdata_0         : out std_logic_vector(31 downto 0);                      -- calbus_wdata
			calbus_rdata_0         : in  std_logic_vector(31 downto 0)   := (others => 'X'); -- calbus_rdata
			calbus_seq_param_tbl_0 : in  std_logic_vector(4095 downto 0) := (others => 'X'); -- calbus_seq_param_tbl
			calbus_read_1          : out std_logic;                                          -- calbus_read
			calbus_write_1         : out std_logic;                                          -- calbus_write
			calbus_address_1       : out std_logic_vector(19 downto 0);                      -- calbus_address
			calbus_wdata_1         : out std_logic_vector(31 downto 0);                      -- calbus_wdata
			calbus_rdata_1         : in  std_logic_vector(31 downto 0)   := (others => 'X'); -- calbus_rdata
			calbus_seq_param_tbl_1 : in  std_logic_vector(4095 downto 0) := (others => 'X'); -- calbus_seq_param_tbl
			calbus_clk             : out std_logic                                           -- clk
		);
	end component emif_cal_two_ch;

	u0 : component emif_cal_two_ch
		port map (
			calbus_read_0          => CONNECTED_TO_calbus_read_0,          --   emif_calbus_0.calbus_read
			calbus_write_0         => CONNECTED_TO_calbus_write_0,         --                .calbus_write
			calbus_address_0       => CONNECTED_TO_calbus_address_0,       --                .calbus_address
			calbus_wdata_0         => CONNECTED_TO_calbus_wdata_0,         --                .calbus_wdata
			calbus_rdata_0         => CONNECTED_TO_calbus_rdata_0,         --                .calbus_rdata
			calbus_seq_param_tbl_0 => CONNECTED_TO_calbus_seq_param_tbl_0, --                .calbus_seq_param_tbl
			calbus_read_1          => CONNECTED_TO_calbus_read_1,          --   emif_calbus_1.calbus_read
			calbus_write_1         => CONNECTED_TO_calbus_write_1,         --                .calbus_write
			calbus_address_1       => CONNECTED_TO_calbus_address_1,       --                .calbus_address
			calbus_wdata_1         => CONNECTED_TO_calbus_wdata_1,         --                .calbus_wdata
			calbus_rdata_1         => CONNECTED_TO_calbus_rdata_1,         --                .calbus_rdata
			calbus_seq_param_tbl_1 => CONNECTED_TO_calbus_seq_param_tbl_1, --                .calbus_seq_param_tbl
			calbus_clk             => CONNECTED_TO_calbus_clk              -- emif_calbus_clk.clk
		);

