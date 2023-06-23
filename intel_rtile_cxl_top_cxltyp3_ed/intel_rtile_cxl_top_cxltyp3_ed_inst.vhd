	component intel_rtile_cxl_top_cxltyp3_ed is
		port (
			refclk4                           : in  std_logic                      := 'X';             -- clk
			refclk0                           : in  std_logic                      := 'X';             -- clk
			refclk1                           : in  std_logic                      := 'X';             -- clk
			resetn                            : in  std_logic                      := 'X';             -- reset_n
			nInit_done                        : in  std_logic                      := 'X';             -- ninit_done
			sip_warm_rstn_o                   : out std_logic;                                         -- reset_n
			spi_MISO                          : in  std_logic                      := 'X';             -- MISO
			spi_MOSI                          : out std_logic;                                         -- MOSI
			spi_SCLK                          : out std_logic;                                         -- SCLK
			spi_SS_n                          : out std_logic;                                         -- SS_n
			cxl_rx_n                          : in  std_logic_vector(15 downto 0)  := (others => 'X'); -- rx_n
			cxl_rx_p                          : in  std_logic_vector(15 downto 0)  := (others => 'X'); -- rx_p
			cxl_tx_n                          : out std_logic_vector(15 downto 0);                     -- tx_n
			cxl_tx_p                          : out std_logic_vector(15 downto 0);                     -- tx_p
			hdm_size_256mb                    : in  std_logic_vector(35 downto 0)  := (others => 'X'); -- hdm_size
			mc2ip_memsize                     : in  std_logic_vector(63 downto 0)  := (others => 'X'); -- mem_size
			ip2hdm_clk                        : out std_logic;                                         -- clk
			ip2hdm_reset_n                    : out std_logic;                                         -- reset
			mc2ip_0_sr_status                 : in  std_logic_vector(4 downto 0)   := (others => 'X'); -- sr_status
			mc2ip_0_rspfifo_full              : in  std_logic                      := 'X';             -- rspfifo_full
			mc2ip_0_rspfifo_empty             : in  std_logic                      := 'X';             -- rspfifo_empty
			mc2ip_0_rspfifo_fill_level        : in  std_logic_vector(5 downto 0)   := (others => 'X'); -- rspfifo_fill_level
			mc2ip_0_reqfifo_full              : in  std_logic                      := 'X';             -- reqfifo_full
			mc2ip_0_reqfifo_empty             : in  std_logic                      := 'X';             -- reqfifo_empty
			mc2ip_0_reqfifo_fill_level        : in  std_logic_vector(5 downto 0)   := (others => 'X'); -- reqfifo_fill_level
			hdm2ip_avmm0_ready                : in  std_logic                      := 'X';             -- ready
			hdm2ip_avmm0_cxlmem_ready         : in  std_logic                      := 'X';             -- cxlmem_ready
			hdm2ip_avmm0_readdata             : in  std_logic_vector(511 downto 0) := (others => 'X'); -- readdata
			hdm2ip_avmm0_rsp_mdata            : in  std_logic_vector(13 downto 0)  := (others => 'X'); -- rsp_mdata
			hdm2ip_avmm0_read_poison          : in  std_logic                      := 'X';             -- read_poison
			hdm2ip_avmm0_readdatavalid        : in  std_logic                      := 'X';             -- readdatavalid
			hdm2ip_avmm0_ecc_err_corrected    : in  std_logic_vector(7 downto 0)   := (others => 'X'); -- ecc_err_corrected
			hdm2ip_avmm0_ecc_err_detected     : in  std_logic_vector(7 downto 0)   := (others => 'X'); -- ecc_err_detected
			hdm2ip_avmm0_ecc_err_fatal        : in  std_logic_vector(7 downto 0)   := (others => 'X'); -- ecc_err_fatal
			hdm2ip_avmm0_ecc_err_syn_e        : in  std_logic_vector(7 downto 0)   := (others => 'X'); -- ecc_err_syn_e
			hdm2ip_avmm0_ecc_err_valid        : in  std_logic                      := 'X';             -- ecc_err_valid
			ip2hdm_avmm0_read                 : out std_logic;                                         -- read
			ip2hdm_avmm0_write                : out std_logic;                                         -- write
			ip2hdm_avmm0_write_poison         : out std_logic;                                         -- write_poison
			ip2hdm_avmm0_write_ras_sbe        : out std_logic;                                         -- write_ras_sbe
			ip2hdm_avmm0_write_ras_dbe        : out std_logic;                                         -- write_ras_dbe
			ip2hdm_avmm0_writedata            : out std_logic_vector(511 downto 0);                    -- writedata
			ip2hdm_avmm0_byteenable           : out std_logic_vector(63 downto 0);                     -- byteenable
			ip2hdm_avmm0_address              : out std_logic_vector(45 downto 0);                     -- address
			ip2hdm_avmm0_req_mdata            : out std_logic_vector(13 downto 0);                     -- req_mdata
			mc2ip_1_sr_status                 : in  std_logic_vector(4 downto 0)   := (others => 'X'); -- sr_status
			mc2ip_1_rspfifo_full              : in  std_logic                      := 'X';             -- rspfifo_full
			mc2ip_1_rspfifo_empty             : in  std_logic                      := 'X';             -- rspfifo_empty
			mc2ip_1_rspfifo_fill_level        : in  std_logic_vector(5 downto 0)   := (others => 'X'); -- rspfifo_fill_level
			mc2ip_1_reqfifo_full              : in  std_logic                      := 'X';             -- reqfifo_full
			mc2ip_1_reqfifo_empty             : in  std_logic                      := 'X';             -- reqfifo_empty
			mc2ip_1_reqfifo_fill_level        : in  std_logic_vector(5 downto 0)   := (others => 'X'); -- reqfifo_fill_level
			hdm2ip_avmm1_ready                : in  std_logic                      := 'X';             -- ready
			hdm2ip_avmm1_cxlmem_ready         : in  std_logic                      := 'X';             -- cxlmem_ready
			hdm2ip_avmm1_readdata             : in  std_logic_vector(511 downto 0) := (others => 'X'); -- readdata
			hdm2ip_avmm1_rsp_mdata            : in  std_logic_vector(13 downto 0)  := (others => 'X'); -- rsp_mdata
			hdm2ip_avmm1_read_poison          : in  std_logic                      := 'X';             -- read_poison
			hdm2ip_avmm1_readdatavalid        : in  std_logic                      := 'X';             -- readdatavalid
			hdm2ip_avmm1_ecc_err_corrected    : in  std_logic_vector(7 downto 0)   := (others => 'X'); -- ecc_err_corrected
			hdm2ip_avmm1_ecc_err_detected     : in  std_logic_vector(7 downto 0)   := (others => 'X'); -- ecc_err_detected
			hdm2ip_avmm1_ecc_err_fatal        : in  std_logic_vector(7 downto 0)   := (others => 'X'); -- ecc_err_fatal
			hdm2ip_avmm1_ecc_err_syn_e        : in  std_logic_vector(7 downto 0)   := (others => 'X'); -- ecc_err_syn_e
			hdm2ip_avmm1_ecc_err_valid        : in  std_logic                      := 'X';             -- ecc_err_valid
			ip2hdm_avmm1_read                 : out std_logic;                                         -- read
			ip2hdm_avmm1_write                : out std_logic;                                         -- write
			ip2hdm_avmm1_write_poison         : out std_logic;                                         -- write_poison
			ip2hdm_avmm1_write_ras_sbe        : out std_logic;                                         -- write_ras_sbe
			ip2hdm_avmm1_write_ras_dbe        : out std_logic;                                         -- write_ras_dbe
			ip2hdm_avmm1_writedata            : out std_logic_vector(511 downto 0);                    -- writedata
			ip2hdm_avmm1_byteenable           : out std_logic_vector(63 downto 0);                     -- byteenable
			ip2hdm_avmm1_address              : out std_logic_vector(45 downto 0);                     -- address
			ip2hdm_avmm1_req_mdata            : out std_logic_vector(13 downto 0);                     -- req_mdata
			ip2csr_avmm_clk                   : out std_logic;                                         -- clock
			ip2csr_avmm_rstn                  : out std_logic;                                         -- reset_n
			csr2ip_avmm_waitrequest           : in  std_logic                      := 'X';             -- waitrequest
			csr2ip_avmm_readdata              : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- readdata
			csr2ip_avmm_readdatavalid         : in  std_logic                      := 'X';             -- readdatavalid
			ip2csr_avmm_writedata             : out std_logic_vector(31 downto 0);                     -- writedata
			ip2csr_avmm_address               : out std_logic_vector(21 downto 0);                     -- address
			ip2csr_avmm_write                 : out std_logic;                                         -- write
			ip2csr_avmm_read                  : out std_logic;                                         -- read
			ip2csr_avmm_byteenable            : out std_logic_vector(3 downto 0);                      -- byteenable
			ip2uio_tx_ready                   : out std_logic;                                         -- ready
			uio2ip_tx_st0_dvalid              : in  std_logic                      := 'X';             -- dvalid
			uio2ip_tx_st0_sop                 : in  std_logic                      := 'X';             -- sop
			uio2ip_tx_st0_eop                 : in  std_logic                      := 'X';             -- eop
			uio2ip_tx_st0_passthrough         : in  std_logic                      := 'X';             -- passthrough
			uio2ip_tx_st0_data                : in  std_logic_vector(255 downto 0) := (others => 'X'); -- data
			uio2ip_tx_st0_data_parity         : in  std_logic_vector(7 downto 0)   := (others => 'X'); -- data_parity
			uio2ip_tx_st0_hdr                 : in  std_logic_vector(127 downto 0) := (others => 'X'); -- hdr
			uio2ip_tx_st0_hdr_parity          : in  std_logic_vector(3 downto 0)   := (others => 'X'); -- hdr_parity
			uio2ip_tx_st0_hvalid              : in  std_logic                      := 'X';             -- hvalid
			uio2ip_tx_st0_prefix              : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- prefix
			uio2ip_tx_st0_prefix_parity       : in  std_logic_vector(0 downto 0)   := (others => 'X'); -- prefix_parity
			uio2ip_tx_st0_RSSAI_prefix        : in  std_logic_vector(11 downto 0)  := (others => 'X'); -- RSSAI_prefix
			uio2ip_tx_st0_RSSAI_prefix_parity : in  std_logic                      := 'X';             -- RSSAI_prefix_parity
			uio2ip_tx_st0_pvalid              : in  std_logic_vector(1 downto 0)   := (others => 'X'); -- pvalid
			uio2ip_tx_st0_vfactive            : in  std_logic                      := 'X';             -- vfactive
			uio2ip_tx_st0_vfnum               : in  std_logic_vector(10 downto 0)  := (others => 'X'); -- vfnum
			uio2ip_tx_st0_pfnum               : in  std_logic_vector(2 downto 0)   := (others => 'X'); -- pfnum
			uio2ip_tx_st0_chnum               : in  std_logic_vector(0 downto 0)   := (others => 'X'); -- chnum
			uio2ip_tx_st0_empty               : in  std_logic_vector(2 downto 0)   := (others => 'X'); -- empty
			uio2ip_tx_st0_misc_parity         : in  std_logic                      := 'X';             -- misc_parity
			uio2ip_tx_st1_dvalid              : in  std_logic                      := 'X';             -- dvalid
			uio2ip_tx_st1_sop                 : in  std_logic                      := 'X';             -- sop
			uio2ip_tx_st1_eop                 : in  std_logic                      := 'X';             -- eop
			uio2ip_tx_st1_passthrough         : in  std_logic                      := 'X';             -- passthrough
			uio2ip_tx_st1_data                : in  std_logic_vector(255 downto 0) := (others => 'X'); -- data
			uio2ip_tx_st1_data_parity         : in  std_logic_vector(7 downto 0)   := (others => 'X'); -- data_parity
			uio2ip_tx_st1_hdr                 : in  std_logic_vector(127 downto 0) := (others => 'X'); -- hdr
			uio2ip_tx_st1_hdr_parity          : in  std_logic_vector(3 downto 0)   := (others => 'X'); -- hdr_parity
			uio2ip_tx_st1_hvalid              : in  std_logic                      := 'X';             -- hvalid
			uio2ip_tx_st1_prefix              : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- prefix
			uio2ip_tx_st1_prefix_parity       : in  std_logic_vector(0 downto 0)   := (others => 'X'); -- prefix_parity
			uio2ip_tx_st1_RSSAI_prefix        : in  std_logic_vector(11 downto 0)  := (others => 'X'); -- RSSAI_prefix
			uio2ip_tx_st1_RSSAI_prefix_parity : in  std_logic                      := 'X';             -- RSSAI_prefix_parity
			uio2ip_tx_st1_pvalid              : in  std_logic_vector(1 downto 0)   := (others => 'X'); -- pvalid
			uio2ip_tx_st1_vfactive            : in  std_logic                      := 'X';             -- vfactive
			uio2ip_tx_st1_vfnum               : in  std_logic_vector(10 downto 0)  := (others => 'X'); -- vfnum
			uio2ip_tx_st1_pfnum               : in  std_logic_vector(2 downto 0)   := (others => 'X'); -- pfnum
			uio2ip_tx_st1_chnum               : in  std_logic_vector(0 downto 0)   := (others => 'X'); -- chnum
			uio2ip_tx_st1_empty               : in  std_logic_vector(2 downto 0)   := (others => 'X'); -- empty
			uio2ip_tx_st1_misc_parity         : in  std_logic                      := 'X';             -- misc_parity
			uio2ip_tx_st2_dvalid              : in  std_logic                      := 'X';             -- dvalid
			uio2ip_tx_st2_sop                 : in  std_logic                      := 'X';             -- sop
			uio2ip_tx_st2_eop                 : in  std_logic                      := 'X';             -- eop
			uio2ip_tx_st2_passthrough         : in  std_logic                      := 'X';             -- passthrough
			uio2ip_tx_st2_data                : in  std_logic_vector(255 downto 0) := (others => 'X'); -- data
			uio2ip_tx_st2_data_parity         : in  std_logic_vector(7 downto 0)   := (others => 'X'); -- data_parity
			uio2ip_tx_st2_hdr                 : in  std_logic_vector(127 downto 0) := (others => 'X'); -- hdr
			uio2ip_tx_st2_hdr_parity          : in  std_logic_vector(3 downto 0)   := (others => 'X'); -- hdr_parity
			uio2ip_tx_st2_hvalid              : in  std_logic                      := 'X';             -- hvalid
			uio2ip_tx_st2_prefix              : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- prefix
			uio2ip_tx_st2_prefix_parity       : in  std_logic_vector(0 downto 0)   := (others => 'X'); -- prefix_parity
			uio2ip_tx_st2_RSSAI_prefix        : in  std_logic_vector(11 downto 0)  := (others => 'X'); -- RSSAI_prefix
			uio2ip_tx_st2_RSSAI_prefix_parity : in  std_logic                      := 'X';             -- RSSAI_prefix_parity
			uio2ip_tx_st2_pvalid              : in  std_logic_vector(1 downto 0)   := (others => 'X'); -- pvalid
			uio2ip_tx_st2_vfactive            : in  std_logic                      := 'X';             -- vfactive
			uio2ip_tx_st2_vfnum               : in  std_logic_vector(10 downto 0)  := (others => 'X'); -- vfnum
			uio2ip_tx_st2_pfnum               : in  std_logic_vector(2 downto 0)   := (others => 'X'); -- pfnum
			uio2ip_tx_st2_chnum               : in  std_logic_vector(0 downto 0)   := (others => 'X'); -- chnum
			uio2ip_tx_st2_empty               : in  std_logic_vector(2 downto 0)   := (others => 'X'); -- empty
			uio2ip_tx_st2_misc_parity         : in  std_logic                      := 'X';             -- misc_parity
			uio2ip_tx_st3_dvalid              : in  std_logic                      := 'X';             -- dvalid
			uio2ip_tx_st3_sop                 : in  std_logic                      := 'X';             -- sop
			uio2ip_tx_st3_eop                 : in  std_logic                      := 'X';             -- eop
			uio2ip_tx_st3_passthrough         : in  std_logic                      := 'X';             -- passthrough
			uio2ip_tx_st3_data                : in  std_logic_vector(255 downto 0) := (others => 'X'); -- data
			uio2ip_tx_st3_data_parity         : in  std_logic_vector(7 downto 0)   := (others => 'X'); -- data_parity
			uio2ip_tx_st3_hdr                 : in  std_logic_vector(127 downto 0) := (others => 'X'); -- hdr
			uio2ip_tx_st3_hdr_parity          : in  std_logic_vector(3 downto 0)   := (others => 'X'); -- hdr_parity
			uio2ip_tx_st3_hvalid              : in  std_logic                      := 'X';             -- hvalid
			uio2ip_tx_st3_prefix              : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- prefix
			uio2ip_tx_st3_prefix_parity       : in  std_logic_vector(0 downto 0)   := (others => 'X'); -- prefix_parity
			uio2ip_tx_st3_RSSAI_prefix        : in  std_logic_vector(11 downto 0)  := (others => 'X'); -- RSSAI_prefix
			uio2ip_tx_st3_RSSAI_prefix_parity : in  std_logic                      := 'X';             -- RSSAI_prefix_parity
			uio2ip_tx_st3_pvalid              : in  std_logic_vector(1 downto 0)   := (others => 'X'); -- pvalid
			uio2ip_tx_st3_vfactive            : in  std_logic                      := 'X';             -- vfactive
			uio2ip_tx_st3_vfnum               : in  std_logic_vector(10 downto 0)  := (others => 'X'); -- vfnum
			uio2ip_tx_st3_pfnum               : in  std_logic_vector(2 downto 0)   := (others => 'X'); -- pfnum
			uio2ip_tx_st3_chnum               : in  std_logic_vector(0 downto 0)   := (others => 'X'); -- chnum
			uio2ip_tx_st3_empty               : in  std_logic_vector(2 downto 0)   := (others => 'X'); -- empty
			uio2ip_tx_st3_misc_parity         : in  std_logic                      := 'X';             -- misc_parity
			ip2uio_tx_st_Hcrdt_update         : out std_logic_vector(2 downto 0);                      -- Hcrdt_update
			ip2uio_tx_st_Hcrdt_ch             : out std_logic_vector(0 downto 0);                      -- Hcrdt_ch
			ip2uio_tx_st_Hcrdt_update_cnt     : out std_logic_vector(5 downto 0);                      -- Hcrdt_update_cnt
			ip2uio_tx_st_Hcrdt_init           : out std_logic_vector(2 downto 0);                      -- Hcrdt_init
			uio2ip_tx_st_Hcrdt_init_ack       : in  std_logic_vector(2 downto 0)   := (others => 'X'); -- Hcrdt_init_ack
			ip2uio_tx_st_Dcrdt_update         : out std_logic_vector(2 downto 0);                      -- Dcrdt_update
			ip2uio_tx_st_Dcrdt_ch             : out std_logic_vector(0 downto 0);                      -- Dcrdt_ch
			ip2uio_tx_st_Dcrdt_update_cnt     : out std_logic_vector(11 downto 0);                     -- Dcrdt_update_cnt
			ip2uio_tx_st_Dcrdt_init           : out std_logic_vector(2 downto 0);                      -- Dcrdt_init
			uio2ip_tx_st_Dcrdt_init_ack       : in  std_logic_vector(2 downto 0)   := (others => 'X'); -- Dcrdt_init_ack
			ip2uio_rx_st0_dvalid              : out std_logic;                                         -- dvalid
			ip2uio_rx_st0_sop                 : out std_logic;                                         -- sop
			ip2uio_rx_st0_eop                 : out std_logic;                                         -- eop
			ip2uio_rx_st0_passthrough         : out std_logic;                                         -- passthrough
			ip2uio_rx_st0_data                : out std_logic_vector(255 downto 0);                    -- data
			ip2uio_rx_st0_data_parity         : out std_logic_vector(7 downto 0);                      -- data_parity
			ip2uio_rx_st0_hdr                 : out std_logic_vector(127 downto 0);                    -- hdr
			ip2uio_rx_st0_hdr_parity          : out std_logic_vector(3 downto 0);                      -- hdr_parity
			ip2uio_rx_st0_hvalid              : out std_logic;                                         -- hvalid
			ip2uio_rx_st0_prefix              : out std_logic_vector(31 downto 0);                     -- prefix
			ip2uio_rx_st0_prefix_parity       : out std_logic_vector(0 downto 0);                      -- prefix_parity
			ip2uio_rx_st0_RSSAI_prefix        : out std_logic_vector(11 downto 0);                     -- RSSAI_prefix
			ip2uio_rx_st0_RSSAI_prefix_parity : out std_logic;                                         -- RSSAI_prefix_parity
			ip2uio_rx_st0_pvalid              : out std_logic_vector(1 downto 0);                      -- pvalid
			ip2uio_rx_st0_bar                 : out std_logic_vector(2 downto 0);                      -- bar
			ip2uio_rx_st0_vfactive            : out std_logic;                                         -- vfactive
			ip2uio_rx_st0_vfnum               : out std_logic_vector(10 downto 0);                     -- vfnum
			ip2uio_rx_st0_pfnum               : out std_logic_vector(2 downto 0);                      -- pfnum
			ip2uio_rx_st0_chnum               : out std_logic_vector(0 downto 0);                      -- chnum
			ip2uio_rx_st0_misc_parity         : out std_logic;                                         -- misc_parity
			ip2uio_rx_st0_empty               : out std_logic_vector(2 downto 0);                      -- empty
			ip2uio_rx_st1_dvalid              : out std_logic;                                         -- dvalid
			ip2uio_rx_st1_sop                 : out std_logic;                                         -- sop
			ip2uio_rx_st1_eop                 : out std_logic;                                         -- eop
			ip2uio_rx_st1_passthrough         : out std_logic;                                         -- passthrough
			ip2uio_rx_st1_data                : out std_logic_vector(255 downto 0);                    -- data
			ip2uio_rx_st1_data_parity         : out std_logic_vector(7 downto 0);                      -- data_parity
			ip2uio_rx_st1_hdr                 : out std_logic_vector(127 downto 0);                    -- hdr
			ip2uio_rx_st1_hdr_parity          : out std_logic_vector(3 downto 0);                      -- hdr_parity
			ip2uio_rx_st1_hvalid              : out std_logic;                                         -- hvalid
			ip2uio_rx_st1_prefix              : out std_logic_vector(31 downto 0);                     -- prefix
			ip2uio_rx_st1_prefix_parity       : out std_logic_vector(0 downto 0);                      -- prefix_parity
			ip2uio_rx_st1_RSSAI_prefix        : out std_logic_vector(11 downto 0);                     -- RSSAI_prefix
			ip2uio_rx_st1_RSSAI_prefix_parity : out std_logic;                                         -- RSSAI_prefix_parity
			ip2uio_rx_st1_pvalid              : out std_logic_vector(1 downto 0);                      -- pvalid
			ip2uio_rx_st1_bar                 : out std_logic_vector(2 downto 0);                      -- bar
			ip2uio_rx_st1_vfactive            : out std_logic;                                         -- vfactive
			ip2uio_rx_st1_vfnum               : out std_logic_vector(10 downto 0);                     -- vfnum
			ip2uio_rx_st1_pfnum               : out std_logic_vector(2 downto 0);                      -- pfnum
			ip2uio_rx_st1_chnum               : out std_logic_vector(0 downto 0);                      -- chnum
			ip2uio_rx_st1_misc_parity         : out std_logic;                                         -- misc_parity
			ip2uio_rx_st1_empty               : out std_logic_vector(2 downto 0);                      -- empty
			ip2uio_rx_st2_dvalid              : out std_logic;                                         -- dvalid
			ip2uio_rx_st2_sop                 : out std_logic;                                         -- sop
			ip2uio_rx_st2_eop                 : out std_logic;                                         -- eop
			ip2uio_rx_st2_passthrough         : out std_logic;                                         -- passthrough
			ip2uio_rx_st2_data                : out std_logic_vector(255 downto 0);                    -- data
			ip2uio_rx_st2_data_parity         : out std_logic_vector(7 downto 0);                      -- data_parity
			ip2uio_rx_st2_hdr                 : out std_logic_vector(127 downto 0);                    -- hdr
			ip2uio_rx_st2_hdr_parity          : out std_logic_vector(3 downto 0);                      -- hdr_parity
			ip2uio_rx_st2_hvalid              : out std_logic;                                         -- hvalid
			ip2uio_rx_st2_prefix              : out std_logic_vector(31 downto 0);                     -- prefix
			ip2uio_rx_st2_prefix_parity       : out std_logic_vector(0 downto 0);                      -- prefix_parity
			ip2uio_rx_st2_RSSAI_prefix        : out std_logic_vector(11 downto 0);                     -- RSSAI_prefix
			ip2uio_rx_st2_RSSAI_prefix_parity : out std_logic;                                         -- RSSAI_prefix_parity
			ip2uio_rx_st2_pvalid              : out std_logic_vector(1 downto 0);                      -- pvalid
			ip2uio_rx_st2_bar                 : out std_logic_vector(2 downto 0);                      -- bar
			ip2uio_rx_st2_vfactive            : out std_logic;                                         -- vfactive
			ip2uio_rx_st2_vfnum               : out std_logic_vector(10 downto 0);                     -- vfnum
			ip2uio_rx_st2_pfnum               : out std_logic_vector(2 downto 0);                      -- pfnum
			ip2uio_rx_st2_chnum               : out std_logic_vector(0 downto 0);                      -- chnum
			ip2uio_rx_st2_misc_parity         : out std_logic;                                         -- misc_parity
			ip2uio_rx_st2_empty               : out std_logic_vector(2 downto 0);                      -- empty
			ip2uio_rx_st3_dvalid              : out std_logic;                                         -- dvalid
			ip2uio_rx_st3_sop                 : out std_logic;                                         -- sop
			ip2uio_rx_st3_eop                 : out std_logic;                                         -- eop
			ip2uio_rx_st3_passthrough         : out std_logic;                                         -- passthrough
			ip2uio_rx_st3_data                : out std_logic_vector(255 downto 0);                    -- data
			ip2uio_rx_st3_data_parity         : out std_logic_vector(7 downto 0);                      -- data_parity
			ip2uio_rx_st3_hdr                 : out std_logic_vector(127 downto 0);                    -- hdr
			ip2uio_rx_st3_hdr_parity          : out std_logic_vector(3 downto 0);                      -- hdr_parity
			ip2uio_rx_st3_hvalid              : out std_logic;                                         -- hvalid
			ip2uio_rx_st3_prefix              : out std_logic_vector(31 downto 0);                     -- prefix
			ip2uio_rx_st3_prefix_parity       : out std_logic_vector(0 downto 0);                      -- prefix_parity
			ip2uio_rx_st3_RSSAI_prefix        : out std_logic_vector(11 downto 0);                     -- RSSAI_prefix
			ip2uio_rx_st3_RSSAI_prefix_parity : out std_logic;                                         -- RSSAI_prefix_parity
			ip2uio_rx_st3_pvalid              : out std_logic_vector(1 downto 0);                      -- pvalid
			ip2uio_rx_st3_bar                 : out std_logic_vector(2 downto 0);                      -- bar
			ip2uio_rx_st3_vfactive            : out std_logic;                                         -- vfactive
			ip2uio_rx_st3_vfnum               : out std_logic_vector(10 downto 0);                     -- vfnum
			ip2uio_rx_st3_pfnum               : out std_logic_vector(2 downto 0);                      -- pfnum
			ip2uio_rx_st3_chnum               : out std_logic_vector(0 downto 0);                      -- chnum
			ip2uio_rx_st3_misc_parity         : out std_logic;                                         -- misc_parity
			ip2uio_rx_st3_empty               : out std_logic_vector(2 downto 0);                      -- empty
			uio2ip_rx_st_Hcrdt_update         : in  std_logic_vector(2 downto 0)   := (others => 'X'); -- Hcrdt_update
			uio2ip_rx_st_Hcrdt_ch             : in  std_logic_vector(0 downto 0)   := (others => 'X'); -- Hcrdt_ch
			uio2ip_rx_st_Hcrdt_update_cnt     : in  std_logic_vector(5 downto 0)   := (others => 'X'); -- Hcrdt_update_cnt
			uio2ip_rx_st_Hcrdt_init           : in  std_logic_vector(2 downto 0)   := (others => 'X'); -- Hcrdt_init
			ip2uio_rx_st_Hcrdt_init_ack       : out std_logic_vector(2 downto 0);                      -- Hcrdt_init_ack
			uio2ip_rx_st_Dcrdt_update         : in  std_logic_vector(2 downto 0)   := (others => 'X'); -- Dcrdt_update
			uio2ip_rx_st_Dcrdt_ch             : in  std_logic_vector(0 downto 0)   := (others => 'X'); -- Dcrdt_ch
			uio2ip_rx_st_Dcrdt_update_cnt     : in  std_logic_vector(11 downto 0)  := (others => 'X'); -- Dcrdt_update_cnt
			uio2ip_rx_st_Dcrdt_init           : in  std_logic_vector(2 downto 0)   := (others => 'X'); -- Dcrdt_init
			ip2uio_rx_st_Dcrdt_init_ack       : out std_logic_vector(2 downto 0);                      -- Dcrdt_init_ack
			ip2uio_bus_number                 : out std_logic_vector(7 downto 0);                      -- usr_bus_number
			ip2uio_device_number              : out std_logic_vector(4 downto 0)                       -- usr_device_number
		);
	end component intel_rtile_cxl_top_cxltyp3_ed;

	u0 : component intel_rtile_cxl_top_cxltyp3_ed
		port map (
			refclk4                           => CONNECTED_TO_refclk4,                           --         refclk.clk
			refclk0                           => CONNECTED_TO_refclk0,                           --        refclk0.clk
			refclk1                           => CONNECTED_TO_refclk1,                           --        refclk1.clk
			resetn                            => CONNECTED_TO_resetn,                            --         resetn.reset_n
			nInit_done                        => CONNECTED_TO_nInit_done,                        --     ninit_done.ninit_done
			sip_warm_rstn_o                   => CONNECTED_TO_sip_warm_rstn_o,                   --      warm_rstn.reset_n
			spi_MISO                          => CONNECTED_TO_spi_MISO,                          --            spi.MISO
			spi_MOSI                          => CONNECTED_TO_spi_MOSI,                          --               .MOSI
			spi_SCLK                          => CONNECTED_TO_spi_SCLK,                          --               .SCLK
			spi_SS_n                          => CONNECTED_TO_spi_SS_n,                          --               .SS_n
			cxl_rx_n                          => CONNECTED_TO_cxl_rx_n,                          --            cxl.rx_n
			cxl_rx_p                          => CONNECTED_TO_cxl_rx_p,                          --               .rx_p
			cxl_tx_n                          => CONNECTED_TO_cxl_tx_n,                          --               .tx_n
			cxl_tx_p                          => CONNECTED_TO_cxl_tx_p,                          --               .tx_p
			hdm_size_256mb                    => CONNECTED_TO_hdm_size_256mb,                    --        memsize.hdm_size
			mc2ip_memsize                     => CONNECTED_TO_mc2ip_memsize,                     --               .mem_size
			ip2hdm_clk                        => CONNECTED_TO_ip2hdm_clk,                        --     ip2hdm_clk.clk
			ip2hdm_reset_n                    => CONNECTED_TO_ip2hdm_reset_n,                    -- ip2hdm_reset_n.reset
			mc2ip_0_sr_status                 => CONNECTED_TO_mc2ip_0_sr_status,                 --        mc2ip_0.sr_status
			mc2ip_0_rspfifo_full              => CONNECTED_TO_mc2ip_0_rspfifo_full,              --               .rspfifo_full
			mc2ip_0_rspfifo_empty             => CONNECTED_TO_mc2ip_0_rspfifo_empty,             --               .rspfifo_empty
			mc2ip_0_rspfifo_fill_level        => CONNECTED_TO_mc2ip_0_rspfifo_fill_level,        --               .rspfifo_fill_level
			mc2ip_0_reqfifo_full              => CONNECTED_TO_mc2ip_0_reqfifo_full,              --               .reqfifo_full
			mc2ip_0_reqfifo_empty             => CONNECTED_TO_mc2ip_0_reqfifo_empty,             --               .reqfifo_empty
			mc2ip_0_reqfifo_fill_level        => CONNECTED_TO_mc2ip_0_reqfifo_fill_level,        --               .reqfifo_fill_level
			hdm2ip_avmm0_ready                => CONNECTED_TO_hdm2ip_avmm0_ready,                --   hdm2ip_avmm0.ready
			hdm2ip_avmm0_cxlmem_ready         => CONNECTED_TO_hdm2ip_avmm0_cxlmem_ready,         --               .cxlmem_ready
			hdm2ip_avmm0_readdata             => CONNECTED_TO_hdm2ip_avmm0_readdata,             --               .readdata
			hdm2ip_avmm0_rsp_mdata            => CONNECTED_TO_hdm2ip_avmm0_rsp_mdata,            --               .rsp_mdata
			hdm2ip_avmm0_read_poison          => CONNECTED_TO_hdm2ip_avmm0_read_poison,          --               .read_poison
			hdm2ip_avmm0_readdatavalid        => CONNECTED_TO_hdm2ip_avmm0_readdatavalid,        --               .readdatavalid
			hdm2ip_avmm0_ecc_err_corrected    => CONNECTED_TO_hdm2ip_avmm0_ecc_err_corrected,    --               .ecc_err_corrected
			hdm2ip_avmm0_ecc_err_detected     => CONNECTED_TO_hdm2ip_avmm0_ecc_err_detected,     --               .ecc_err_detected
			hdm2ip_avmm0_ecc_err_fatal        => CONNECTED_TO_hdm2ip_avmm0_ecc_err_fatal,        --               .ecc_err_fatal
			hdm2ip_avmm0_ecc_err_syn_e        => CONNECTED_TO_hdm2ip_avmm0_ecc_err_syn_e,        --               .ecc_err_syn_e
			hdm2ip_avmm0_ecc_err_valid        => CONNECTED_TO_hdm2ip_avmm0_ecc_err_valid,        --               .ecc_err_valid
			ip2hdm_avmm0_read                 => CONNECTED_TO_ip2hdm_avmm0_read,                 --   ip2hdm_avmm0.read
			ip2hdm_avmm0_write                => CONNECTED_TO_ip2hdm_avmm0_write,                --               .write
			ip2hdm_avmm0_write_poison         => CONNECTED_TO_ip2hdm_avmm0_write_poison,         --               .write_poison
			ip2hdm_avmm0_write_ras_sbe        => CONNECTED_TO_ip2hdm_avmm0_write_ras_sbe,        --               .write_ras_sbe
			ip2hdm_avmm0_write_ras_dbe        => CONNECTED_TO_ip2hdm_avmm0_write_ras_dbe,        --               .write_ras_dbe
			ip2hdm_avmm0_writedata            => CONNECTED_TO_ip2hdm_avmm0_writedata,            --               .writedata
			ip2hdm_avmm0_byteenable           => CONNECTED_TO_ip2hdm_avmm0_byteenable,           --               .byteenable
			ip2hdm_avmm0_address              => CONNECTED_TO_ip2hdm_avmm0_address,              --               .address
			ip2hdm_avmm0_req_mdata            => CONNECTED_TO_ip2hdm_avmm0_req_mdata,            --               .req_mdata
			mc2ip_1_sr_status                 => CONNECTED_TO_mc2ip_1_sr_status,                 --        mc2ip_1.sr_status
			mc2ip_1_rspfifo_full              => CONNECTED_TO_mc2ip_1_rspfifo_full,              --               .rspfifo_full
			mc2ip_1_rspfifo_empty             => CONNECTED_TO_mc2ip_1_rspfifo_empty,             --               .rspfifo_empty
			mc2ip_1_rspfifo_fill_level        => CONNECTED_TO_mc2ip_1_rspfifo_fill_level,        --               .rspfifo_fill_level
			mc2ip_1_reqfifo_full              => CONNECTED_TO_mc2ip_1_reqfifo_full,              --               .reqfifo_full
			mc2ip_1_reqfifo_empty             => CONNECTED_TO_mc2ip_1_reqfifo_empty,             --               .reqfifo_empty
			mc2ip_1_reqfifo_fill_level        => CONNECTED_TO_mc2ip_1_reqfifo_fill_level,        --               .reqfifo_fill_level
			hdm2ip_avmm1_ready                => CONNECTED_TO_hdm2ip_avmm1_ready,                --   hdm2ip_avmm1.ready
			hdm2ip_avmm1_cxlmem_ready         => CONNECTED_TO_hdm2ip_avmm1_cxlmem_ready,         --               .cxlmem_ready
			hdm2ip_avmm1_readdata             => CONNECTED_TO_hdm2ip_avmm1_readdata,             --               .readdata
			hdm2ip_avmm1_rsp_mdata            => CONNECTED_TO_hdm2ip_avmm1_rsp_mdata,            --               .rsp_mdata
			hdm2ip_avmm1_read_poison          => CONNECTED_TO_hdm2ip_avmm1_read_poison,          --               .read_poison
			hdm2ip_avmm1_readdatavalid        => CONNECTED_TO_hdm2ip_avmm1_readdatavalid,        --               .readdatavalid
			hdm2ip_avmm1_ecc_err_corrected    => CONNECTED_TO_hdm2ip_avmm1_ecc_err_corrected,    --               .ecc_err_corrected
			hdm2ip_avmm1_ecc_err_detected     => CONNECTED_TO_hdm2ip_avmm1_ecc_err_detected,     --               .ecc_err_detected
			hdm2ip_avmm1_ecc_err_fatal        => CONNECTED_TO_hdm2ip_avmm1_ecc_err_fatal,        --               .ecc_err_fatal
			hdm2ip_avmm1_ecc_err_syn_e        => CONNECTED_TO_hdm2ip_avmm1_ecc_err_syn_e,        --               .ecc_err_syn_e
			hdm2ip_avmm1_ecc_err_valid        => CONNECTED_TO_hdm2ip_avmm1_ecc_err_valid,        --               .ecc_err_valid
			ip2hdm_avmm1_read                 => CONNECTED_TO_ip2hdm_avmm1_read,                 --   ip2hdm_avmm1.read
			ip2hdm_avmm1_write                => CONNECTED_TO_ip2hdm_avmm1_write,                --               .write
			ip2hdm_avmm1_write_poison         => CONNECTED_TO_ip2hdm_avmm1_write_poison,         --               .write_poison
			ip2hdm_avmm1_write_ras_sbe        => CONNECTED_TO_ip2hdm_avmm1_write_ras_sbe,        --               .write_ras_sbe
			ip2hdm_avmm1_write_ras_dbe        => CONNECTED_TO_ip2hdm_avmm1_write_ras_dbe,        --               .write_ras_dbe
			ip2hdm_avmm1_writedata            => CONNECTED_TO_ip2hdm_avmm1_writedata,            --               .writedata
			ip2hdm_avmm1_byteenable           => CONNECTED_TO_ip2hdm_avmm1_byteenable,           --               .byteenable
			ip2hdm_avmm1_address              => CONNECTED_TO_ip2hdm_avmm1_address,              --               .address
			ip2hdm_avmm1_req_mdata            => CONNECTED_TO_ip2hdm_avmm1_req_mdata,            --               .req_mdata
			ip2csr_avmm_clk                   => CONNECTED_TO_ip2csr_avmm_clk,                   --         ip2csr.clock
			ip2csr_avmm_rstn                  => CONNECTED_TO_ip2csr_avmm_rstn,                  --               .reset_n
			csr2ip_avmm_waitrequest           => CONNECTED_TO_csr2ip_avmm_waitrequest,           --               .waitrequest
			csr2ip_avmm_readdata              => CONNECTED_TO_csr2ip_avmm_readdata,              --               .readdata
			csr2ip_avmm_readdatavalid         => CONNECTED_TO_csr2ip_avmm_readdatavalid,         --               .readdatavalid
			ip2csr_avmm_writedata             => CONNECTED_TO_ip2csr_avmm_writedata,             --               .writedata
			ip2csr_avmm_address               => CONNECTED_TO_ip2csr_avmm_address,               --               .address
			ip2csr_avmm_write                 => CONNECTED_TO_ip2csr_avmm_write,                 --               .write
			ip2csr_avmm_read                  => CONNECTED_TO_ip2csr_avmm_read,                  --               .read
			ip2csr_avmm_byteenable            => CONNECTED_TO_ip2csr_avmm_byteenable,            --               .byteenable
			ip2uio_tx_ready                   => CONNECTED_TO_ip2uio_tx_ready,                   --     usr_tx_st0.ready
			uio2ip_tx_st0_dvalid              => CONNECTED_TO_uio2ip_tx_st0_dvalid,              --               .dvalid
			uio2ip_tx_st0_sop                 => CONNECTED_TO_uio2ip_tx_st0_sop,                 --               .sop
			uio2ip_tx_st0_eop                 => CONNECTED_TO_uio2ip_tx_st0_eop,                 --               .eop
			uio2ip_tx_st0_passthrough         => CONNECTED_TO_uio2ip_tx_st0_passthrough,         --               .passthrough
			uio2ip_tx_st0_data                => CONNECTED_TO_uio2ip_tx_st0_data,                --               .data
			uio2ip_tx_st0_data_parity         => CONNECTED_TO_uio2ip_tx_st0_data_parity,         --               .data_parity
			uio2ip_tx_st0_hdr                 => CONNECTED_TO_uio2ip_tx_st0_hdr,                 --               .hdr
			uio2ip_tx_st0_hdr_parity          => CONNECTED_TO_uio2ip_tx_st0_hdr_parity,          --               .hdr_parity
			uio2ip_tx_st0_hvalid              => CONNECTED_TO_uio2ip_tx_st0_hvalid,              --               .hvalid
			uio2ip_tx_st0_prefix              => CONNECTED_TO_uio2ip_tx_st0_prefix,              --               .prefix
			uio2ip_tx_st0_prefix_parity       => CONNECTED_TO_uio2ip_tx_st0_prefix_parity,       --               .prefix_parity
			uio2ip_tx_st0_RSSAI_prefix        => CONNECTED_TO_uio2ip_tx_st0_RSSAI_prefix,        --               .RSSAI_prefix
			uio2ip_tx_st0_RSSAI_prefix_parity => CONNECTED_TO_uio2ip_tx_st0_RSSAI_prefix_parity, --               .RSSAI_prefix_parity
			uio2ip_tx_st0_pvalid              => CONNECTED_TO_uio2ip_tx_st0_pvalid,              --               .pvalid
			uio2ip_tx_st0_vfactive            => CONNECTED_TO_uio2ip_tx_st0_vfactive,            --               .vfactive
			uio2ip_tx_st0_vfnum               => CONNECTED_TO_uio2ip_tx_st0_vfnum,               --               .vfnum
			uio2ip_tx_st0_pfnum               => CONNECTED_TO_uio2ip_tx_st0_pfnum,               --               .pfnum
			uio2ip_tx_st0_chnum               => CONNECTED_TO_uio2ip_tx_st0_chnum,               --               .chnum
			uio2ip_tx_st0_empty               => CONNECTED_TO_uio2ip_tx_st0_empty,               --               .empty
			uio2ip_tx_st0_misc_parity         => CONNECTED_TO_uio2ip_tx_st0_misc_parity,         --               .misc_parity
			uio2ip_tx_st1_dvalid              => CONNECTED_TO_uio2ip_tx_st1_dvalid,              --     usr_tx_st1.dvalid
			uio2ip_tx_st1_sop                 => CONNECTED_TO_uio2ip_tx_st1_sop,                 --               .sop
			uio2ip_tx_st1_eop                 => CONNECTED_TO_uio2ip_tx_st1_eop,                 --               .eop
			uio2ip_tx_st1_passthrough         => CONNECTED_TO_uio2ip_tx_st1_passthrough,         --               .passthrough
			uio2ip_tx_st1_data                => CONNECTED_TO_uio2ip_tx_st1_data,                --               .data
			uio2ip_tx_st1_data_parity         => CONNECTED_TO_uio2ip_tx_st1_data_parity,         --               .data_parity
			uio2ip_tx_st1_hdr                 => CONNECTED_TO_uio2ip_tx_st1_hdr,                 --               .hdr
			uio2ip_tx_st1_hdr_parity          => CONNECTED_TO_uio2ip_tx_st1_hdr_parity,          --               .hdr_parity
			uio2ip_tx_st1_hvalid              => CONNECTED_TO_uio2ip_tx_st1_hvalid,              --               .hvalid
			uio2ip_tx_st1_prefix              => CONNECTED_TO_uio2ip_tx_st1_prefix,              --               .prefix
			uio2ip_tx_st1_prefix_parity       => CONNECTED_TO_uio2ip_tx_st1_prefix_parity,       --               .prefix_parity
			uio2ip_tx_st1_RSSAI_prefix        => CONNECTED_TO_uio2ip_tx_st1_RSSAI_prefix,        --               .RSSAI_prefix
			uio2ip_tx_st1_RSSAI_prefix_parity => CONNECTED_TO_uio2ip_tx_st1_RSSAI_prefix_parity, --               .RSSAI_prefix_parity
			uio2ip_tx_st1_pvalid              => CONNECTED_TO_uio2ip_tx_st1_pvalid,              --               .pvalid
			uio2ip_tx_st1_vfactive            => CONNECTED_TO_uio2ip_tx_st1_vfactive,            --               .vfactive
			uio2ip_tx_st1_vfnum               => CONNECTED_TO_uio2ip_tx_st1_vfnum,               --               .vfnum
			uio2ip_tx_st1_pfnum               => CONNECTED_TO_uio2ip_tx_st1_pfnum,               --               .pfnum
			uio2ip_tx_st1_chnum               => CONNECTED_TO_uio2ip_tx_st1_chnum,               --               .chnum
			uio2ip_tx_st1_empty               => CONNECTED_TO_uio2ip_tx_st1_empty,               --               .empty
			uio2ip_tx_st1_misc_parity         => CONNECTED_TO_uio2ip_tx_st1_misc_parity,         --               .misc_parity
			uio2ip_tx_st2_dvalid              => CONNECTED_TO_uio2ip_tx_st2_dvalid,              --     usr_tx_st2.dvalid
			uio2ip_tx_st2_sop                 => CONNECTED_TO_uio2ip_tx_st2_sop,                 --               .sop
			uio2ip_tx_st2_eop                 => CONNECTED_TO_uio2ip_tx_st2_eop,                 --               .eop
			uio2ip_tx_st2_passthrough         => CONNECTED_TO_uio2ip_tx_st2_passthrough,         --               .passthrough
			uio2ip_tx_st2_data                => CONNECTED_TO_uio2ip_tx_st2_data,                --               .data
			uio2ip_tx_st2_data_parity         => CONNECTED_TO_uio2ip_tx_st2_data_parity,         --               .data_parity
			uio2ip_tx_st2_hdr                 => CONNECTED_TO_uio2ip_tx_st2_hdr,                 --               .hdr
			uio2ip_tx_st2_hdr_parity          => CONNECTED_TO_uio2ip_tx_st2_hdr_parity,          --               .hdr_parity
			uio2ip_tx_st2_hvalid              => CONNECTED_TO_uio2ip_tx_st2_hvalid,              --               .hvalid
			uio2ip_tx_st2_prefix              => CONNECTED_TO_uio2ip_tx_st2_prefix,              --               .prefix
			uio2ip_tx_st2_prefix_parity       => CONNECTED_TO_uio2ip_tx_st2_prefix_parity,       --               .prefix_parity
			uio2ip_tx_st2_RSSAI_prefix        => CONNECTED_TO_uio2ip_tx_st2_RSSAI_prefix,        --               .RSSAI_prefix
			uio2ip_tx_st2_RSSAI_prefix_parity => CONNECTED_TO_uio2ip_tx_st2_RSSAI_prefix_parity, --               .RSSAI_prefix_parity
			uio2ip_tx_st2_pvalid              => CONNECTED_TO_uio2ip_tx_st2_pvalid,              --               .pvalid
			uio2ip_tx_st2_vfactive            => CONNECTED_TO_uio2ip_tx_st2_vfactive,            --               .vfactive
			uio2ip_tx_st2_vfnum               => CONNECTED_TO_uio2ip_tx_st2_vfnum,               --               .vfnum
			uio2ip_tx_st2_pfnum               => CONNECTED_TO_uio2ip_tx_st2_pfnum,               --               .pfnum
			uio2ip_tx_st2_chnum               => CONNECTED_TO_uio2ip_tx_st2_chnum,               --               .chnum
			uio2ip_tx_st2_empty               => CONNECTED_TO_uio2ip_tx_st2_empty,               --               .empty
			uio2ip_tx_st2_misc_parity         => CONNECTED_TO_uio2ip_tx_st2_misc_parity,         --               .misc_parity
			uio2ip_tx_st3_dvalid              => CONNECTED_TO_uio2ip_tx_st3_dvalid,              --     usr_tx_st3.dvalid
			uio2ip_tx_st3_sop                 => CONNECTED_TO_uio2ip_tx_st3_sop,                 --               .sop
			uio2ip_tx_st3_eop                 => CONNECTED_TO_uio2ip_tx_st3_eop,                 --               .eop
			uio2ip_tx_st3_passthrough         => CONNECTED_TO_uio2ip_tx_st3_passthrough,         --               .passthrough
			uio2ip_tx_st3_data                => CONNECTED_TO_uio2ip_tx_st3_data,                --               .data
			uio2ip_tx_st3_data_parity         => CONNECTED_TO_uio2ip_tx_st3_data_parity,         --               .data_parity
			uio2ip_tx_st3_hdr                 => CONNECTED_TO_uio2ip_tx_st3_hdr,                 --               .hdr
			uio2ip_tx_st3_hdr_parity          => CONNECTED_TO_uio2ip_tx_st3_hdr_parity,          --               .hdr_parity
			uio2ip_tx_st3_hvalid              => CONNECTED_TO_uio2ip_tx_st3_hvalid,              --               .hvalid
			uio2ip_tx_st3_prefix              => CONNECTED_TO_uio2ip_tx_st3_prefix,              --               .prefix
			uio2ip_tx_st3_prefix_parity       => CONNECTED_TO_uio2ip_tx_st3_prefix_parity,       --               .prefix_parity
			uio2ip_tx_st3_RSSAI_prefix        => CONNECTED_TO_uio2ip_tx_st3_RSSAI_prefix,        --               .RSSAI_prefix
			uio2ip_tx_st3_RSSAI_prefix_parity => CONNECTED_TO_uio2ip_tx_st3_RSSAI_prefix_parity, --               .RSSAI_prefix_parity
			uio2ip_tx_st3_pvalid              => CONNECTED_TO_uio2ip_tx_st3_pvalid,              --               .pvalid
			uio2ip_tx_st3_vfactive            => CONNECTED_TO_uio2ip_tx_st3_vfactive,            --               .vfactive
			uio2ip_tx_st3_vfnum               => CONNECTED_TO_uio2ip_tx_st3_vfnum,               --               .vfnum
			uio2ip_tx_st3_pfnum               => CONNECTED_TO_uio2ip_tx_st3_pfnum,               --               .pfnum
			uio2ip_tx_st3_chnum               => CONNECTED_TO_uio2ip_tx_st3_chnum,               --               .chnum
			uio2ip_tx_st3_empty               => CONNECTED_TO_uio2ip_tx_st3_empty,               --               .empty
			uio2ip_tx_st3_misc_parity         => CONNECTED_TO_uio2ip_tx_st3_misc_parity,         --               .misc_parity
			ip2uio_tx_st_Hcrdt_update         => CONNECTED_TO_ip2uio_tx_st_Hcrdt_update,         --      usr_tx_st.Hcrdt_update
			ip2uio_tx_st_Hcrdt_ch             => CONNECTED_TO_ip2uio_tx_st_Hcrdt_ch,             --               .Hcrdt_ch
			ip2uio_tx_st_Hcrdt_update_cnt     => CONNECTED_TO_ip2uio_tx_st_Hcrdt_update_cnt,     --               .Hcrdt_update_cnt
			ip2uio_tx_st_Hcrdt_init           => CONNECTED_TO_ip2uio_tx_st_Hcrdt_init,           --               .Hcrdt_init
			uio2ip_tx_st_Hcrdt_init_ack       => CONNECTED_TO_uio2ip_tx_st_Hcrdt_init_ack,       --               .Hcrdt_init_ack
			ip2uio_tx_st_Dcrdt_update         => CONNECTED_TO_ip2uio_tx_st_Dcrdt_update,         --               .Dcrdt_update
			ip2uio_tx_st_Dcrdt_ch             => CONNECTED_TO_ip2uio_tx_st_Dcrdt_ch,             --               .Dcrdt_ch
			ip2uio_tx_st_Dcrdt_update_cnt     => CONNECTED_TO_ip2uio_tx_st_Dcrdt_update_cnt,     --               .Dcrdt_update_cnt
			ip2uio_tx_st_Dcrdt_init           => CONNECTED_TO_ip2uio_tx_st_Dcrdt_init,           --               .Dcrdt_init
			uio2ip_tx_st_Dcrdt_init_ack       => CONNECTED_TO_uio2ip_tx_st_Dcrdt_init_ack,       --               .Dcrdt_init_ack
			ip2uio_rx_st0_dvalid              => CONNECTED_TO_ip2uio_rx_st0_dvalid,              --    usr_rx_st_0.dvalid
			ip2uio_rx_st0_sop                 => CONNECTED_TO_ip2uio_rx_st0_sop,                 --               .sop
			ip2uio_rx_st0_eop                 => CONNECTED_TO_ip2uio_rx_st0_eop,                 --               .eop
			ip2uio_rx_st0_passthrough         => CONNECTED_TO_ip2uio_rx_st0_passthrough,         --               .passthrough
			ip2uio_rx_st0_data                => CONNECTED_TO_ip2uio_rx_st0_data,                --               .data
			ip2uio_rx_st0_data_parity         => CONNECTED_TO_ip2uio_rx_st0_data_parity,         --               .data_parity
			ip2uio_rx_st0_hdr                 => CONNECTED_TO_ip2uio_rx_st0_hdr,                 --               .hdr
			ip2uio_rx_st0_hdr_parity          => CONNECTED_TO_ip2uio_rx_st0_hdr_parity,          --               .hdr_parity
			ip2uio_rx_st0_hvalid              => CONNECTED_TO_ip2uio_rx_st0_hvalid,              --               .hvalid
			ip2uio_rx_st0_prefix              => CONNECTED_TO_ip2uio_rx_st0_prefix,              --               .prefix
			ip2uio_rx_st0_prefix_parity       => CONNECTED_TO_ip2uio_rx_st0_prefix_parity,       --               .prefix_parity
			ip2uio_rx_st0_RSSAI_prefix        => CONNECTED_TO_ip2uio_rx_st0_RSSAI_prefix,        --               .RSSAI_prefix
			ip2uio_rx_st0_RSSAI_prefix_parity => CONNECTED_TO_ip2uio_rx_st0_RSSAI_prefix_parity, --               .RSSAI_prefix_parity
			ip2uio_rx_st0_pvalid              => CONNECTED_TO_ip2uio_rx_st0_pvalid,              --               .pvalid
			ip2uio_rx_st0_bar                 => CONNECTED_TO_ip2uio_rx_st0_bar,                 --               .bar
			ip2uio_rx_st0_vfactive            => CONNECTED_TO_ip2uio_rx_st0_vfactive,            --               .vfactive
			ip2uio_rx_st0_vfnum               => CONNECTED_TO_ip2uio_rx_st0_vfnum,               --               .vfnum
			ip2uio_rx_st0_pfnum               => CONNECTED_TO_ip2uio_rx_st0_pfnum,               --               .pfnum
			ip2uio_rx_st0_chnum               => CONNECTED_TO_ip2uio_rx_st0_chnum,               --               .chnum
			ip2uio_rx_st0_misc_parity         => CONNECTED_TO_ip2uio_rx_st0_misc_parity,         --               .misc_parity
			ip2uio_rx_st0_empty               => CONNECTED_TO_ip2uio_rx_st0_empty,               --               .empty
			ip2uio_rx_st1_dvalid              => CONNECTED_TO_ip2uio_rx_st1_dvalid,              --    usr_rx_st_1.dvalid
			ip2uio_rx_st1_sop                 => CONNECTED_TO_ip2uio_rx_st1_sop,                 --               .sop
			ip2uio_rx_st1_eop                 => CONNECTED_TO_ip2uio_rx_st1_eop,                 --               .eop
			ip2uio_rx_st1_passthrough         => CONNECTED_TO_ip2uio_rx_st1_passthrough,         --               .passthrough
			ip2uio_rx_st1_data                => CONNECTED_TO_ip2uio_rx_st1_data,                --               .data
			ip2uio_rx_st1_data_parity         => CONNECTED_TO_ip2uio_rx_st1_data_parity,         --               .data_parity
			ip2uio_rx_st1_hdr                 => CONNECTED_TO_ip2uio_rx_st1_hdr,                 --               .hdr
			ip2uio_rx_st1_hdr_parity          => CONNECTED_TO_ip2uio_rx_st1_hdr_parity,          --               .hdr_parity
			ip2uio_rx_st1_hvalid              => CONNECTED_TO_ip2uio_rx_st1_hvalid,              --               .hvalid
			ip2uio_rx_st1_prefix              => CONNECTED_TO_ip2uio_rx_st1_prefix,              --               .prefix
			ip2uio_rx_st1_prefix_parity       => CONNECTED_TO_ip2uio_rx_st1_prefix_parity,       --               .prefix_parity
			ip2uio_rx_st1_RSSAI_prefix        => CONNECTED_TO_ip2uio_rx_st1_RSSAI_prefix,        --               .RSSAI_prefix
			ip2uio_rx_st1_RSSAI_prefix_parity => CONNECTED_TO_ip2uio_rx_st1_RSSAI_prefix_parity, --               .RSSAI_prefix_parity
			ip2uio_rx_st1_pvalid              => CONNECTED_TO_ip2uio_rx_st1_pvalid,              --               .pvalid
			ip2uio_rx_st1_bar                 => CONNECTED_TO_ip2uio_rx_st1_bar,                 --               .bar
			ip2uio_rx_st1_vfactive            => CONNECTED_TO_ip2uio_rx_st1_vfactive,            --               .vfactive
			ip2uio_rx_st1_vfnum               => CONNECTED_TO_ip2uio_rx_st1_vfnum,               --               .vfnum
			ip2uio_rx_st1_pfnum               => CONNECTED_TO_ip2uio_rx_st1_pfnum,               --               .pfnum
			ip2uio_rx_st1_chnum               => CONNECTED_TO_ip2uio_rx_st1_chnum,               --               .chnum
			ip2uio_rx_st1_misc_parity         => CONNECTED_TO_ip2uio_rx_st1_misc_parity,         --               .misc_parity
			ip2uio_rx_st1_empty               => CONNECTED_TO_ip2uio_rx_st1_empty,               --               .empty
			ip2uio_rx_st2_dvalid              => CONNECTED_TO_ip2uio_rx_st2_dvalid,              --    usr_rx_st_2.dvalid
			ip2uio_rx_st2_sop                 => CONNECTED_TO_ip2uio_rx_st2_sop,                 --               .sop
			ip2uio_rx_st2_eop                 => CONNECTED_TO_ip2uio_rx_st2_eop,                 --               .eop
			ip2uio_rx_st2_passthrough         => CONNECTED_TO_ip2uio_rx_st2_passthrough,         --               .passthrough
			ip2uio_rx_st2_data                => CONNECTED_TO_ip2uio_rx_st2_data,                --               .data
			ip2uio_rx_st2_data_parity         => CONNECTED_TO_ip2uio_rx_st2_data_parity,         --               .data_parity
			ip2uio_rx_st2_hdr                 => CONNECTED_TO_ip2uio_rx_st2_hdr,                 --               .hdr
			ip2uio_rx_st2_hdr_parity          => CONNECTED_TO_ip2uio_rx_st2_hdr_parity,          --               .hdr_parity
			ip2uio_rx_st2_hvalid              => CONNECTED_TO_ip2uio_rx_st2_hvalid,              --               .hvalid
			ip2uio_rx_st2_prefix              => CONNECTED_TO_ip2uio_rx_st2_prefix,              --               .prefix
			ip2uio_rx_st2_prefix_parity       => CONNECTED_TO_ip2uio_rx_st2_prefix_parity,       --               .prefix_parity
			ip2uio_rx_st2_RSSAI_prefix        => CONNECTED_TO_ip2uio_rx_st2_RSSAI_prefix,        --               .RSSAI_prefix
			ip2uio_rx_st2_RSSAI_prefix_parity => CONNECTED_TO_ip2uio_rx_st2_RSSAI_prefix_parity, --               .RSSAI_prefix_parity
			ip2uio_rx_st2_pvalid              => CONNECTED_TO_ip2uio_rx_st2_pvalid,              --               .pvalid
			ip2uio_rx_st2_bar                 => CONNECTED_TO_ip2uio_rx_st2_bar,                 --               .bar
			ip2uio_rx_st2_vfactive            => CONNECTED_TO_ip2uio_rx_st2_vfactive,            --               .vfactive
			ip2uio_rx_st2_vfnum               => CONNECTED_TO_ip2uio_rx_st2_vfnum,               --               .vfnum
			ip2uio_rx_st2_pfnum               => CONNECTED_TO_ip2uio_rx_st2_pfnum,               --               .pfnum
			ip2uio_rx_st2_chnum               => CONNECTED_TO_ip2uio_rx_st2_chnum,               --               .chnum
			ip2uio_rx_st2_misc_parity         => CONNECTED_TO_ip2uio_rx_st2_misc_parity,         --               .misc_parity
			ip2uio_rx_st2_empty               => CONNECTED_TO_ip2uio_rx_st2_empty,               --               .empty
			ip2uio_rx_st3_dvalid              => CONNECTED_TO_ip2uio_rx_st3_dvalid,              --    usr_rx_st_3.dvalid
			ip2uio_rx_st3_sop                 => CONNECTED_TO_ip2uio_rx_st3_sop,                 --               .sop
			ip2uio_rx_st3_eop                 => CONNECTED_TO_ip2uio_rx_st3_eop,                 --               .eop
			ip2uio_rx_st3_passthrough         => CONNECTED_TO_ip2uio_rx_st3_passthrough,         --               .passthrough
			ip2uio_rx_st3_data                => CONNECTED_TO_ip2uio_rx_st3_data,                --               .data
			ip2uio_rx_st3_data_parity         => CONNECTED_TO_ip2uio_rx_st3_data_parity,         --               .data_parity
			ip2uio_rx_st3_hdr                 => CONNECTED_TO_ip2uio_rx_st3_hdr,                 --               .hdr
			ip2uio_rx_st3_hdr_parity          => CONNECTED_TO_ip2uio_rx_st3_hdr_parity,          --               .hdr_parity
			ip2uio_rx_st3_hvalid              => CONNECTED_TO_ip2uio_rx_st3_hvalid,              --               .hvalid
			ip2uio_rx_st3_prefix              => CONNECTED_TO_ip2uio_rx_st3_prefix,              --               .prefix
			ip2uio_rx_st3_prefix_parity       => CONNECTED_TO_ip2uio_rx_st3_prefix_parity,       --               .prefix_parity
			ip2uio_rx_st3_RSSAI_prefix        => CONNECTED_TO_ip2uio_rx_st3_RSSAI_prefix,        --               .RSSAI_prefix
			ip2uio_rx_st3_RSSAI_prefix_parity => CONNECTED_TO_ip2uio_rx_st3_RSSAI_prefix_parity, --               .RSSAI_prefix_parity
			ip2uio_rx_st3_pvalid              => CONNECTED_TO_ip2uio_rx_st3_pvalid,              --               .pvalid
			ip2uio_rx_st3_bar                 => CONNECTED_TO_ip2uio_rx_st3_bar,                 --               .bar
			ip2uio_rx_st3_vfactive            => CONNECTED_TO_ip2uio_rx_st3_vfactive,            --               .vfactive
			ip2uio_rx_st3_vfnum               => CONNECTED_TO_ip2uio_rx_st3_vfnum,               --               .vfnum
			ip2uio_rx_st3_pfnum               => CONNECTED_TO_ip2uio_rx_st3_pfnum,               --               .pfnum
			ip2uio_rx_st3_chnum               => CONNECTED_TO_ip2uio_rx_st3_chnum,               --               .chnum
			ip2uio_rx_st3_misc_parity         => CONNECTED_TO_ip2uio_rx_st3_misc_parity,         --               .misc_parity
			ip2uio_rx_st3_empty               => CONNECTED_TO_ip2uio_rx_st3_empty,               --               .empty
			uio2ip_rx_st_Hcrdt_update         => CONNECTED_TO_uio2ip_rx_st_Hcrdt_update,         --      usr_rx_st.Hcrdt_update
			uio2ip_rx_st_Hcrdt_ch             => CONNECTED_TO_uio2ip_rx_st_Hcrdt_ch,             --               .Hcrdt_ch
			uio2ip_rx_st_Hcrdt_update_cnt     => CONNECTED_TO_uio2ip_rx_st_Hcrdt_update_cnt,     --               .Hcrdt_update_cnt
			uio2ip_rx_st_Hcrdt_init           => CONNECTED_TO_uio2ip_rx_st_Hcrdt_init,           --               .Hcrdt_init
			ip2uio_rx_st_Hcrdt_init_ack       => CONNECTED_TO_ip2uio_rx_st_Hcrdt_init_ack,       --               .Hcrdt_init_ack
			uio2ip_rx_st_Dcrdt_update         => CONNECTED_TO_uio2ip_rx_st_Dcrdt_update,         --               .Dcrdt_update
			uio2ip_rx_st_Dcrdt_ch             => CONNECTED_TO_uio2ip_rx_st_Dcrdt_ch,             --               .Dcrdt_ch
			uio2ip_rx_st_Dcrdt_update_cnt     => CONNECTED_TO_uio2ip_rx_st_Dcrdt_update_cnt,     --               .Dcrdt_update_cnt
			uio2ip_rx_st_Dcrdt_init           => CONNECTED_TO_uio2ip_rx_st_Dcrdt_init,           --               .Dcrdt_init
			ip2uio_rx_st_Dcrdt_init_ack       => CONNECTED_TO_ip2uio_rx_st_Dcrdt_init_ack,       --               .Dcrdt_init_ack
			ip2uio_bus_number                 => CONNECTED_TO_ip2uio_bus_number,                 --            uio.usr_bus_number
			ip2uio_device_number              => CONNECTED_TO_ip2uio_device_number               --               .usr_device_number
		);

