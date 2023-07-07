module histogram#(
   parameter int unsigned N_BINs = 64,
   parameter int unsigned INTERVAL = 2,
   parameter int unsigned INPUT_BITS = 16,
   parameter int unsigned OUTPUT_BITS = 32 
)(
    input clk,
    input rst_n, 
    input rd_out_en,
    input [INPUT_BITS-1:0] data_i,
    input valid_i, 
    output reg [OUTPUT_BITS-1:0] data_o,
    output reg valid_o
);

logic [OUTPUT_BITS-1:0] hist_bins [N_BINs-1:0];
logic [$clog2(N_BINs)-1:0] bin_index;
logic update_bin_en = 0;
logic [$clog2(N_BINs)-1:0] rd_out_idx = 0;
logic reading_out = 0;

always@(posedge clk) begin
    // readout
    if (rd_out_en) begin 
        reading_out <= 1; 
        rd_out_idx <= 0;
    end else if (rst_n && reading_out) begin
        data_o <= hist_bins[rd_out_idx];
        valid_o <= 1;
        /* verilator lint_off WIDTH */
        if (rd_out_idx == N_BINs-1) begin
            reading_out <= 0;
        end else begin
            rd_out_idx <= rd_out_idx + 1;
        end
    end else if (!rst_n) begin 
        // reset 
        for (int i = 0; i < N_BINs; i++) begin
            hist_bins[i] <= 0;
        end
        bin_index <= 0;
        update_bin_en <= 0;
        data_o <= 0;
        valid_o <= 0;
    end else begin
        valid_o <= 0;
    end
    // record
    if (valid_i) begin
        if (data_i < 8) begin
            bin_index <= data_i;
        end else if (data_i < 24) begin 
            bin_index <= 8 + ((data_i - 8) >> 1);
        end else if (data_i < 56) begin 
            bin_index <= 16 + ((data_i - 24) >> 2);
        end else if (data_i < 120) begin 
            bin_index <= 24 + ((data_i - 56) >> 3);
        end else if (data_i < 248) begin 
            bin_index <= 32 + ((data_i - 120) >> 4);
        end else if (data_i < 504) begin 
            bin_index <= 40 + ((data_i - 248) >> 5);
        end else if (data_i < 1016) begin 
            bin_index <= 48 + ((data_i - 504) >> 6);
        end else if (data_i < 2040) begin 
            bin_index <= 56 + ((data_i - 1016) >> 7);
        end else begin
            bin_index <= N_BINs-1;
        end

        update_bin_en <= 1;
    end  else begin
        update_bin_en <= 0;
    end
    if(update_bin_en) begin
        hist_bins[bin_index] <= hist_bins[bin_index] + 1;
    end
end 

endmodule
