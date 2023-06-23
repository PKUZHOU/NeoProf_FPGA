module reqfifo (
		input  wire [639:0] data,    //  fifo_input.datain
		input  wire         wrreq,   //            .wrreq
		input  wire         rdreq,   //            .rdreq
		input  wire         wrclk,   //            .wrclk
		input  wire         rdclk,   //            .rdclk
		input  wire         aclr,    //            .aclr
		output wire [639:0] q,       // fifo_output.dataout
		output wire [5:0]   wrusedw, //            .wrusedw
		output wire         rdempty, //            .rdempty
		output wire         wrfull,  //            .wrfull
		output wire         wrempty  //            .wrempty
	);
endmodule

