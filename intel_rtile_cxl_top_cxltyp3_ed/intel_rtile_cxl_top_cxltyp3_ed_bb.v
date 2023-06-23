module intel_rtile_cxl_top_cxltyp3_ed (
		input  wire         refclk4,                           //         refclk.clk
		input  wire         refclk0,                           //        refclk0.clk
		input  wire         refclk1,                           //        refclk1.clk
		input  wire         resetn,                            //         resetn.reset_n
		input  wire         nInit_done,                        //     ninit_done.ninit_done
		output wire         sip_warm_rstn_o,                   //      warm_rstn.reset_n
		input  wire         spi_MISO,                          //            spi.MISO
		output wire         spi_MOSI,                          //               .MOSI
		output wire         spi_SCLK,                          //               .SCLK
		output wire         spi_SS_n,                          //               .SS_n
		input  wire [15:0]  cxl_rx_n,                          //            cxl.rx_n
		input  wire [15:0]  cxl_rx_p,                          //               .rx_p
		output wire [15:0]  cxl_tx_n,                          //               .tx_n
		output wire [15:0]  cxl_tx_p,                          //               .tx_p
		input  wire [35:0]  hdm_size_256mb,                    //        memsize.hdm_size
		input  wire [63:0]  mc2ip_memsize,                     //               .mem_size
		output wire         ip2hdm_clk,                        //     ip2hdm_clk.clk
		output wire         ip2hdm_reset_n,                    // ip2hdm_reset_n.reset
		input  wire [4:0]   mc2ip_0_sr_status,                 //        mc2ip_0.sr_status
		input  wire         mc2ip_0_rspfifo_full,              //               .rspfifo_full
		input  wire         mc2ip_0_rspfifo_empty,             //               .rspfifo_empty
		input  wire [5:0]   mc2ip_0_rspfifo_fill_level,        //               .rspfifo_fill_level
		input  wire         mc2ip_0_reqfifo_full,              //               .reqfifo_full
		input  wire         mc2ip_0_reqfifo_empty,             //               .reqfifo_empty
		input  wire [5:0]   mc2ip_0_reqfifo_fill_level,        //               .reqfifo_fill_level
		input  wire         hdm2ip_avmm0_ready,                //   hdm2ip_avmm0.ready
		input  wire         hdm2ip_avmm0_cxlmem_ready,         //               .cxlmem_ready
		input  wire [511:0] hdm2ip_avmm0_readdata,             //               .readdata
		input  wire [13:0]  hdm2ip_avmm0_rsp_mdata,            //               .rsp_mdata
		input  wire         hdm2ip_avmm0_read_poison,          //               .read_poison
		input  wire         hdm2ip_avmm0_readdatavalid,        //               .readdatavalid
		input  wire [7:0]   hdm2ip_avmm0_ecc_err_corrected,    //               .ecc_err_corrected
		input  wire [7:0]   hdm2ip_avmm0_ecc_err_detected,     //               .ecc_err_detected
		input  wire [7:0]   hdm2ip_avmm0_ecc_err_fatal,        //               .ecc_err_fatal
		input  wire [7:0]   hdm2ip_avmm0_ecc_err_syn_e,        //               .ecc_err_syn_e
		input  wire         hdm2ip_avmm0_ecc_err_valid,        //               .ecc_err_valid
		output wire         ip2hdm_avmm0_read,                 //   ip2hdm_avmm0.read
		output wire         ip2hdm_avmm0_write,                //               .write
		output wire         ip2hdm_avmm0_write_poison,         //               .write_poison
		output wire         ip2hdm_avmm0_write_ras_sbe,        //               .write_ras_sbe
		output wire         ip2hdm_avmm0_write_ras_dbe,        //               .write_ras_dbe
		output wire [511:0] ip2hdm_avmm0_writedata,            //               .writedata
		output wire [63:0]  ip2hdm_avmm0_byteenable,           //               .byteenable
		output wire [45:0]  ip2hdm_avmm0_address,              //               .address
		output wire [13:0]  ip2hdm_avmm0_req_mdata,            //               .req_mdata
		input  wire [4:0]   mc2ip_1_sr_status,                 //        mc2ip_1.sr_status
		input  wire         mc2ip_1_rspfifo_full,              //               .rspfifo_full
		input  wire         mc2ip_1_rspfifo_empty,             //               .rspfifo_empty
		input  wire [5:0]   mc2ip_1_rspfifo_fill_level,        //               .rspfifo_fill_level
		input  wire         mc2ip_1_reqfifo_full,              //               .reqfifo_full
		input  wire         mc2ip_1_reqfifo_empty,             //               .reqfifo_empty
		input  wire [5:0]   mc2ip_1_reqfifo_fill_level,        //               .reqfifo_fill_level
		input  wire         hdm2ip_avmm1_ready,                //   hdm2ip_avmm1.ready
		input  wire         hdm2ip_avmm1_cxlmem_ready,         //               .cxlmem_ready
		input  wire [511:0] hdm2ip_avmm1_readdata,             //               .readdata
		input  wire [13:0]  hdm2ip_avmm1_rsp_mdata,            //               .rsp_mdata
		input  wire         hdm2ip_avmm1_read_poison,          //               .read_poison
		input  wire         hdm2ip_avmm1_readdatavalid,        //               .readdatavalid
		input  wire [7:0]   hdm2ip_avmm1_ecc_err_corrected,    //               .ecc_err_corrected
		input  wire [7:0]   hdm2ip_avmm1_ecc_err_detected,     //               .ecc_err_detected
		input  wire [7:0]   hdm2ip_avmm1_ecc_err_fatal,        //               .ecc_err_fatal
		input  wire [7:0]   hdm2ip_avmm1_ecc_err_syn_e,        //               .ecc_err_syn_e
		input  wire         hdm2ip_avmm1_ecc_err_valid,        //               .ecc_err_valid
		output wire         ip2hdm_avmm1_read,                 //   ip2hdm_avmm1.read
		output wire         ip2hdm_avmm1_write,                //               .write
		output wire         ip2hdm_avmm1_write_poison,         //               .write_poison
		output wire         ip2hdm_avmm1_write_ras_sbe,        //               .write_ras_sbe
		output wire         ip2hdm_avmm1_write_ras_dbe,        //               .write_ras_dbe
		output wire [511:0] ip2hdm_avmm1_writedata,            //               .writedata
		output wire [63:0]  ip2hdm_avmm1_byteenable,           //               .byteenable
		output wire [45:0]  ip2hdm_avmm1_address,              //               .address
		output wire [13:0]  ip2hdm_avmm1_req_mdata,            //               .req_mdata
		output wire         ip2csr_avmm_clk,                   //         ip2csr.clock
		output wire         ip2csr_avmm_rstn,                  //               .reset_n
		input  wire         csr2ip_avmm_waitrequest,           //               .waitrequest
		input  wire [31:0]  csr2ip_avmm_readdata,              //               .readdata
		input  wire         csr2ip_avmm_readdatavalid,         //               .readdatavalid
		output wire [31:0]  ip2csr_avmm_writedata,             //               .writedata
		output wire [21:0]  ip2csr_avmm_address,               //               .address
		output wire         ip2csr_avmm_write,                 //               .write
		output wire         ip2csr_avmm_read,                  //               .read
		output wire [3:0]   ip2csr_avmm_byteenable,            //               .byteenable
		output wire         ip2uio_tx_ready,                   //     usr_tx_st0.ready
		input  wire         uio2ip_tx_st0_dvalid,              //               .dvalid
		input  wire         uio2ip_tx_st0_sop,                 //               .sop
		input  wire         uio2ip_tx_st0_eop,                 //               .eop
		input  wire         uio2ip_tx_st0_passthrough,         //               .passthrough
		input  wire [255:0] uio2ip_tx_st0_data,                //               .data
		input  wire [7:0]   uio2ip_tx_st0_data_parity,         //               .data_parity
		input  wire [127:0] uio2ip_tx_st0_hdr,                 //               .hdr
		input  wire [3:0]   uio2ip_tx_st0_hdr_parity,          //               .hdr_parity
		input  wire         uio2ip_tx_st0_hvalid,              //               .hvalid
		input  wire [31:0]  uio2ip_tx_st0_prefix,              //               .prefix
		input  wire [0:0]   uio2ip_tx_st0_prefix_parity,       //               .prefix_parity
		input  wire [11:0]  uio2ip_tx_st0_RSSAI_prefix,        //               .RSSAI_prefix
		input  wire         uio2ip_tx_st0_RSSAI_prefix_parity, //               .RSSAI_prefix_parity
		input  wire [1:0]   uio2ip_tx_st0_pvalid,              //               .pvalid
		input  wire         uio2ip_tx_st0_vfactive,            //               .vfactive
		input  wire [10:0]  uio2ip_tx_st0_vfnum,               //               .vfnum
		input  wire [2:0]   uio2ip_tx_st0_pfnum,               //               .pfnum
		input  wire [0:0]   uio2ip_tx_st0_chnum,               //               .chnum
		input  wire [2:0]   uio2ip_tx_st0_empty,               //               .empty
		input  wire         uio2ip_tx_st0_misc_parity,         //               .misc_parity
		input  wire         uio2ip_tx_st1_dvalid,              //     usr_tx_st1.dvalid
		input  wire         uio2ip_tx_st1_sop,                 //               .sop
		input  wire         uio2ip_tx_st1_eop,                 //               .eop
		input  wire         uio2ip_tx_st1_passthrough,         //               .passthrough
		input  wire [255:0] uio2ip_tx_st1_data,                //               .data
		input  wire [7:0]   uio2ip_tx_st1_data_parity,         //               .data_parity
		input  wire [127:0] uio2ip_tx_st1_hdr,                 //               .hdr
		input  wire [3:0]   uio2ip_tx_st1_hdr_parity,          //               .hdr_parity
		input  wire         uio2ip_tx_st1_hvalid,              //               .hvalid
		input  wire [31:0]  uio2ip_tx_st1_prefix,              //               .prefix
		input  wire [0:0]   uio2ip_tx_st1_prefix_parity,       //               .prefix_parity
		input  wire [11:0]  uio2ip_tx_st1_RSSAI_prefix,        //               .RSSAI_prefix
		input  wire         uio2ip_tx_st1_RSSAI_prefix_parity, //               .RSSAI_prefix_parity
		input  wire [1:0]   uio2ip_tx_st1_pvalid,              //               .pvalid
		input  wire         uio2ip_tx_st1_vfactive,            //               .vfactive
		input  wire [10:0]  uio2ip_tx_st1_vfnum,               //               .vfnum
		input  wire [2:0]   uio2ip_tx_st1_pfnum,               //               .pfnum
		input  wire [0:0]   uio2ip_tx_st1_chnum,               //               .chnum
		input  wire [2:0]   uio2ip_tx_st1_empty,               //               .empty
		input  wire         uio2ip_tx_st1_misc_parity,         //               .misc_parity
		input  wire         uio2ip_tx_st2_dvalid,              //     usr_tx_st2.dvalid
		input  wire         uio2ip_tx_st2_sop,                 //               .sop
		input  wire         uio2ip_tx_st2_eop,                 //               .eop
		input  wire         uio2ip_tx_st2_passthrough,         //               .passthrough
		input  wire [255:0] uio2ip_tx_st2_data,                //               .data
		input  wire [7:0]   uio2ip_tx_st2_data_parity,         //               .data_parity
		input  wire [127:0] uio2ip_tx_st2_hdr,                 //               .hdr
		input  wire [3:0]   uio2ip_tx_st2_hdr_parity,          //               .hdr_parity
		input  wire         uio2ip_tx_st2_hvalid,              //               .hvalid
		input  wire [31:0]  uio2ip_tx_st2_prefix,              //               .prefix
		input  wire [0:0]   uio2ip_tx_st2_prefix_parity,       //               .prefix_parity
		input  wire [11:0]  uio2ip_tx_st2_RSSAI_prefix,        //               .RSSAI_prefix
		input  wire         uio2ip_tx_st2_RSSAI_prefix_parity, //               .RSSAI_prefix_parity
		input  wire [1:0]   uio2ip_tx_st2_pvalid,              //               .pvalid
		input  wire         uio2ip_tx_st2_vfactive,            //               .vfactive
		input  wire [10:0]  uio2ip_tx_st2_vfnum,               //               .vfnum
		input  wire [2:0]   uio2ip_tx_st2_pfnum,               //               .pfnum
		input  wire [0:0]   uio2ip_tx_st2_chnum,               //               .chnum
		input  wire [2:0]   uio2ip_tx_st2_empty,               //               .empty
		input  wire         uio2ip_tx_st2_misc_parity,         //               .misc_parity
		input  wire         uio2ip_tx_st3_dvalid,              //     usr_tx_st3.dvalid
		input  wire         uio2ip_tx_st3_sop,                 //               .sop
		input  wire         uio2ip_tx_st3_eop,                 //               .eop
		input  wire         uio2ip_tx_st3_passthrough,         //               .passthrough
		input  wire [255:0] uio2ip_tx_st3_data,                //               .data
		input  wire [7:0]   uio2ip_tx_st3_data_parity,         //               .data_parity
		input  wire [127:0] uio2ip_tx_st3_hdr,                 //               .hdr
		input  wire [3:0]   uio2ip_tx_st3_hdr_parity,          //               .hdr_parity
		input  wire         uio2ip_tx_st3_hvalid,              //               .hvalid
		input  wire [31:0]  uio2ip_tx_st3_prefix,              //               .prefix
		input  wire [0:0]   uio2ip_tx_st3_prefix_parity,       //               .prefix_parity
		input  wire [11:0]  uio2ip_tx_st3_RSSAI_prefix,        //               .RSSAI_prefix
		input  wire         uio2ip_tx_st3_RSSAI_prefix_parity, //               .RSSAI_prefix_parity
		input  wire [1:0]   uio2ip_tx_st3_pvalid,              //               .pvalid
		input  wire         uio2ip_tx_st3_vfactive,            //               .vfactive
		input  wire [10:0]  uio2ip_tx_st3_vfnum,               //               .vfnum
		input  wire [2:0]   uio2ip_tx_st3_pfnum,               //               .pfnum
		input  wire [0:0]   uio2ip_tx_st3_chnum,               //               .chnum
		input  wire [2:0]   uio2ip_tx_st3_empty,               //               .empty
		input  wire         uio2ip_tx_st3_misc_parity,         //               .misc_parity
		output wire [2:0]   ip2uio_tx_st_Hcrdt_update,         //      usr_tx_st.Hcrdt_update
		output wire [0:0]   ip2uio_tx_st_Hcrdt_ch,             //               .Hcrdt_ch
		output wire [5:0]   ip2uio_tx_st_Hcrdt_update_cnt,     //               .Hcrdt_update_cnt
		output wire [2:0]   ip2uio_tx_st_Hcrdt_init,           //               .Hcrdt_init
		input  wire [2:0]   uio2ip_tx_st_Hcrdt_init_ack,       //               .Hcrdt_init_ack
		output wire [2:0]   ip2uio_tx_st_Dcrdt_update,         //               .Dcrdt_update
		output wire [0:0]   ip2uio_tx_st_Dcrdt_ch,             //               .Dcrdt_ch
		output wire [11:0]  ip2uio_tx_st_Dcrdt_update_cnt,     //               .Dcrdt_update_cnt
		output wire [2:0]   ip2uio_tx_st_Dcrdt_init,           //               .Dcrdt_init
		input  wire [2:0]   uio2ip_tx_st_Dcrdt_init_ack,       //               .Dcrdt_init_ack
		output wire         ip2uio_rx_st0_dvalid,              //    usr_rx_st_0.dvalid
		output wire         ip2uio_rx_st0_sop,                 //               .sop
		output wire         ip2uio_rx_st0_eop,                 //               .eop
		output wire         ip2uio_rx_st0_passthrough,         //               .passthrough
		output wire [255:0] ip2uio_rx_st0_data,                //               .data
		output wire [7:0]   ip2uio_rx_st0_data_parity,         //               .data_parity
		output wire [127:0] ip2uio_rx_st0_hdr,                 //               .hdr
		output wire [3:0]   ip2uio_rx_st0_hdr_parity,          //               .hdr_parity
		output wire         ip2uio_rx_st0_hvalid,              //               .hvalid
		output wire [31:0]  ip2uio_rx_st0_prefix,              //               .prefix
		output wire [0:0]   ip2uio_rx_st0_prefix_parity,       //               .prefix_parity
		output wire [11:0]  ip2uio_rx_st0_RSSAI_prefix,        //               .RSSAI_prefix
		output wire         ip2uio_rx_st0_RSSAI_prefix_parity, //               .RSSAI_prefix_parity
		output wire [1:0]   ip2uio_rx_st0_pvalid,              //               .pvalid
		output wire [2:0]   ip2uio_rx_st0_bar,                 //               .bar
		output wire         ip2uio_rx_st0_vfactive,            //               .vfactive
		output wire [10:0]  ip2uio_rx_st0_vfnum,               //               .vfnum
		output wire [2:0]   ip2uio_rx_st0_pfnum,               //               .pfnum
		output wire [0:0]   ip2uio_rx_st0_chnum,               //               .chnum
		output wire         ip2uio_rx_st0_misc_parity,         //               .misc_parity
		output wire [2:0]   ip2uio_rx_st0_empty,               //               .empty
		output wire         ip2uio_rx_st1_dvalid,              //    usr_rx_st_1.dvalid
		output wire         ip2uio_rx_st1_sop,                 //               .sop
		output wire         ip2uio_rx_st1_eop,                 //               .eop
		output wire         ip2uio_rx_st1_passthrough,         //               .passthrough
		output wire [255:0] ip2uio_rx_st1_data,                //               .data
		output wire [7:0]   ip2uio_rx_st1_data_parity,         //               .data_parity
		output wire [127:0] ip2uio_rx_st1_hdr,                 //               .hdr
		output wire [3:0]   ip2uio_rx_st1_hdr_parity,          //               .hdr_parity
		output wire         ip2uio_rx_st1_hvalid,              //               .hvalid
		output wire [31:0]  ip2uio_rx_st1_prefix,              //               .prefix
		output wire [0:0]   ip2uio_rx_st1_prefix_parity,       //               .prefix_parity
		output wire [11:0]  ip2uio_rx_st1_RSSAI_prefix,        //               .RSSAI_prefix
		output wire         ip2uio_rx_st1_RSSAI_prefix_parity, //               .RSSAI_prefix_parity
		output wire [1:0]   ip2uio_rx_st1_pvalid,              //               .pvalid
		output wire [2:0]   ip2uio_rx_st1_bar,                 //               .bar
		output wire         ip2uio_rx_st1_vfactive,            //               .vfactive
		output wire [10:0]  ip2uio_rx_st1_vfnum,               //               .vfnum
		output wire [2:0]   ip2uio_rx_st1_pfnum,               //               .pfnum
		output wire [0:0]   ip2uio_rx_st1_chnum,               //               .chnum
		output wire         ip2uio_rx_st1_misc_parity,         //               .misc_parity
		output wire [2:0]   ip2uio_rx_st1_empty,               //               .empty
		output wire         ip2uio_rx_st2_dvalid,              //    usr_rx_st_2.dvalid
		output wire         ip2uio_rx_st2_sop,                 //               .sop
		output wire         ip2uio_rx_st2_eop,                 //               .eop
		output wire         ip2uio_rx_st2_passthrough,         //               .passthrough
		output wire [255:0] ip2uio_rx_st2_data,                //               .data
		output wire [7:0]   ip2uio_rx_st2_data_parity,         //               .data_parity
		output wire [127:0] ip2uio_rx_st2_hdr,                 //               .hdr
		output wire [3:0]   ip2uio_rx_st2_hdr_parity,          //               .hdr_parity
		output wire         ip2uio_rx_st2_hvalid,              //               .hvalid
		output wire [31:0]  ip2uio_rx_st2_prefix,              //               .prefix
		output wire [0:0]   ip2uio_rx_st2_prefix_parity,       //               .prefix_parity
		output wire [11:0]  ip2uio_rx_st2_RSSAI_prefix,        //               .RSSAI_prefix
		output wire         ip2uio_rx_st2_RSSAI_prefix_parity, //               .RSSAI_prefix_parity
		output wire [1:0]   ip2uio_rx_st2_pvalid,              //               .pvalid
		output wire [2:0]   ip2uio_rx_st2_bar,                 //               .bar
		output wire         ip2uio_rx_st2_vfactive,            //               .vfactive
		output wire [10:0]  ip2uio_rx_st2_vfnum,               //               .vfnum
		output wire [2:0]   ip2uio_rx_st2_pfnum,               //               .pfnum
		output wire [0:0]   ip2uio_rx_st2_chnum,               //               .chnum
		output wire         ip2uio_rx_st2_misc_parity,         //               .misc_parity
		output wire [2:0]   ip2uio_rx_st2_empty,               //               .empty
		output wire         ip2uio_rx_st3_dvalid,              //    usr_rx_st_3.dvalid
		output wire         ip2uio_rx_st3_sop,                 //               .sop
		output wire         ip2uio_rx_st3_eop,                 //               .eop
		output wire         ip2uio_rx_st3_passthrough,         //               .passthrough
		output wire [255:0] ip2uio_rx_st3_data,                //               .data
		output wire [7:0]   ip2uio_rx_st3_data_parity,         //               .data_parity
		output wire [127:0] ip2uio_rx_st3_hdr,                 //               .hdr
		output wire [3:0]   ip2uio_rx_st3_hdr_parity,          //               .hdr_parity
		output wire         ip2uio_rx_st3_hvalid,              //               .hvalid
		output wire [31:0]  ip2uio_rx_st3_prefix,              //               .prefix
		output wire [0:0]   ip2uio_rx_st3_prefix_parity,       //               .prefix_parity
		output wire [11:0]  ip2uio_rx_st3_RSSAI_prefix,        //               .RSSAI_prefix
		output wire         ip2uio_rx_st3_RSSAI_prefix_parity, //               .RSSAI_prefix_parity
		output wire [1:0]   ip2uio_rx_st3_pvalid,              //               .pvalid
		output wire [2:0]   ip2uio_rx_st3_bar,                 //               .bar
		output wire         ip2uio_rx_st3_vfactive,            //               .vfactive
		output wire [10:0]  ip2uio_rx_st3_vfnum,               //               .vfnum
		output wire [2:0]   ip2uio_rx_st3_pfnum,               //               .pfnum
		output wire [0:0]   ip2uio_rx_st3_chnum,               //               .chnum
		output wire         ip2uio_rx_st3_misc_parity,         //               .misc_parity
		output wire [2:0]   ip2uio_rx_st3_empty,               //               .empty
		input  wire [2:0]   uio2ip_rx_st_Hcrdt_update,         //      usr_rx_st.Hcrdt_update
		input  wire [0:0]   uio2ip_rx_st_Hcrdt_ch,             //               .Hcrdt_ch
		input  wire [5:0]   uio2ip_rx_st_Hcrdt_update_cnt,     //               .Hcrdt_update_cnt
		input  wire [2:0]   uio2ip_rx_st_Hcrdt_init,           //               .Hcrdt_init
		output wire [2:0]   ip2uio_rx_st_Hcrdt_init_ack,       //               .Hcrdt_init_ack
		input  wire [2:0]   uio2ip_rx_st_Dcrdt_update,         //               .Dcrdt_update
		input  wire [0:0]   uio2ip_rx_st_Dcrdt_ch,             //               .Dcrdt_ch
		input  wire [11:0]  uio2ip_rx_st_Dcrdt_update_cnt,     //               .Dcrdt_update_cnt
		input  wire [2:0]   uio2ip_rx_st_Dcrdt_init,           //               .Dcrdt_init
		output wire [2:0]   ip2uio_rx_st_Dcrdt_init_ack,       //               .Dcrdt_init_ack
		output wire [7:0]   ip2uio_bus_number,                 //            uio.usr_bus_number
		output wire [4:0]   ip2uio_device_number               //               .usr_device_number
	);
endmodule

