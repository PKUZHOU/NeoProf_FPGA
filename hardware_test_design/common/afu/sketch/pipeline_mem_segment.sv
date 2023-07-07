module pipeline_mem_segment# 
(
    parameter MODE = "CNT",
    parameter ADDR_WIDTH_FULL = 16, 
    parameter ADDR_WIDTH = 15,
    parameter DATA_WIDTH = 16,
    parameter MEM_ID = 0,
    parameter PIPELINE_DEPTH = 1
)(
    input  clk,
    input  rst_n,
    // Read address and enable signal
    input  [ADDR_WIDTH_FULL-1:0] addr_in,
    output reg [ADDR_WIDTH_FULL-1:0] addr_out,
    input  rd_en_in,
    output reg rd_en_out,

    input [$clog2(PIPELINE_DEPTH)-1:0] dst_id_in, 
    output reg [$clog2(PIPELINE_DEPTH)-1:0] dst_id_out,
    // Read data and valid signal
    input  [DATA_WIDTH-1:0] rd_data_in,
    output reg [DATA_WIDTH-1:0] rd_data_out,
    input  reg rd_data_valid_in,
    output reg rd_data_valid_out,
    input  [ADDR_WIDTH_FULL-1:0] rd_addr_in,
    output reg [ADDR_WIDTH_FULL-1:0] rd_addr_out,

    // Read out counter
    input rd_cnt_in,
    output reg rd_cnt_out,
     /* verilator lint_off UNUSED */
    input rd_cnt_valid_in,
    /* verilator lint_off UNDRIVEN */
    output reg rd_cnt_valid_out
);

always @(posedge clk) begin 
    // Passing address and enable signals
    addr_out <= addr_in;
    rd_en_out <= rd_en_in; 
    rd_cnt_out <= rd_cnt_in;
    dst_id_out <= dst_id_in;
end 

/* verilator lint_off WIDTH */
if(MODE == "CNT") begin 
    // Memory
    (*ramstyle = "block"*) reg [DATA_WIDTH-1:0] mem [(2 ** ADDR_WIDTH)-1:0];
    (*ramstyle = "block"*) reg [31:0] valid_bitmap [(2 ** ADDR_WIDTH >> 5)-1:0];

    // Signal indicating wether the address is in the memory segment's range
    logic should_receive;
    /* verilator lint_off WIDTH */
    /* verilator lint_off UNSIGNED */
    /* verilator lint_off CMPCONST */
    assign should_receive = (MEM_ID == dst_id_in);

    // Local addr
    logic [ADDR_WIDTH-1:0] local_addr_in;
    assign local_addr_in = addr_in[ADDR_WIDTH-1:0];

    // Signal Buffering
    logic valid_tmp; 
    logic [31:0] valid_slice_tmp;
    logic [(2 ** ADDR_WIDTH >> 5)-1:0] valid_slice_idx_tmp; // the index of the slice
    logic [4:0] valid_slice_offset_tmp; // the offset of the valid bit in the slice

    logic rd_en_in_tmp;
    logic rd_cnt_in_tmp;
    logic [DATA_WIDTH-1:0] data_tmp; // store the data pointed by local_addr_in
    logic [ADDR_WIDTH-1:0] local_addr_in_tmp;
    logic [ADDR_WIDTH-1:0] local_addr_in_tmp_tmp;

    logic [ADDR_WIDTH_FULL-1:0] addr_in_tmp;
    logic should_receive_tmp = 0;

    // For storing valid bits in BRAMs
    enum int unsigned { RUN = 0, RESET = 2} state;
    reg [ADDR_WIDTH:0] rst_cnt = 0;
    reg validbit_write_en;
    reg [ADDR_WIDTH-1:0] validbit_write_offset = 0;
    reg [31:0] validbit_write_data;

    always @(posedge clk) begin
        if (validbit_write_en) begin 
            valid_bitmap[validbit_write_offset] <= validbit_write_data;
        end 
        if (!rst_n) begin
            rst_cnt <= 0;
            state <= RESET;
        end 
        // Reset 
        if (state == RESET) begin
            if (rst_cnt == 2 ** ADDR_WIDTH >> 5) begin
                state <= RUN;
                validbit_write_en <= 0;
            end else begin 
                validbit_write_offset <= rst_cnt;
                validbit_write_data <= 32'b0;
                validbit_write_en <= 1;
                rst_cnt <= rst_cnt + 1;
            end 
        end else if (state == RUN) begin
            if(!rd_en_in) begin
                rd_en_in_tmp <= 0;
                rd_cnt_in_tmp <= 0;
                local_addr_in_tmp <= 0;
                local_addr_in_tmp_tmp <= 0;
                addr_in_tmp <= 0;
                should_receive_tmp <= 0;
                data_tmp <= 0;
                // valid_tmp <= 0;
                valid_slice_tmp <= 0;
                valid_slice_offset_tmp <= 0;
                valid_slice_idx_tmp <= 0;
            end else begin
                rd_en_in_tmp <= rd_en_in;
                rd_cnt_in_tmp <= rd_cnt_in;
                local_addr_in_tmp <= local_addr_in;
                valid_slice_offset_tmp <= local_addr_in % 32;
                valid_slice_idx_tmp <= local_addr_in >> 5;
                local_addr_in_tmp_tmp <= local_addr_in_tmp;
                addr_in_tmp <= addr_in;
                should_receive_tmp <= should_receive;
            end 
            // here it delays for one cycle for reading data from BRAM
            if (rd_en_in_tmp && should_receive_tmp) begin
                if(valid_slice_tmp[valid_slice_offset_tmp] == 0) begin
                    if (!rd_cnt_in_tmp) begin 
                        // First time read
                        rd_data_out <= 1;   
                        mem[local_addr_in_tmp] <= 1; 

                        // update the valid bitmap                    
                        validbit_write_en <= 1;
                        validbit_write_data <= (valid_slice_tmp | (1 << valid_slice_offset_tmp));
                        validbit_write_offset <= valid_slice_idx_tmp;

                        if (local_addr_in == local_addr_in_tmp || local_addr_in == local_addr_in_tmp_tmp) begin  // forwarding
                            data_tmp <= 1;
                            valid_slice_tmp <= valid_slice_tmp | (1 << valid_slice_offset_tmp);
                        end else begin
                            data_tmp <= mem[local_addr_in]; // data may be invalid 
                            valid_slice_tmp <= valid_bitmap[local_addr_in >> 5];
                        end
                    end 
                    else begin 
                        // readout counter 
                        rd_data_out <= 0; 
                        validbit_write_en <= 0;
                        validbit_write_data <= 0;
                        validbit_write_offset <= 0;
                        valid_slice_tmp <= valid_bitmap[local_addr_in >> 5];
                        data_tmp <= mem[local_addr_in]; // data may be invalid 
                    end 
                end
                else begin
                    if (!rd_cnt_in_tmp) begin 
                        // mem stores sketch counters
                        // This entry has been record
                        rd_data_out <= data_tmp + 1;
                        mem[local_addr_in_tmp] <= data_tmp + 1; // forwarding?

                        if (local_addr_in == local_addr_in_tmp || local_addr_in == local_addr_in_tmp_tmp) begin // need forwarding
                            data_tmp <= data_tmp + 1;
                            valid_slice_tmp <= valid_slice_tmp;
                        end else begin
                            data_tmp <= mem[local_addr_in]; // data may be invalid 
                            valid_slice_tmp <= valid_bitmap[local_addr_in >> 5];
                        end 
                        validbit_write_data <= 0;
                        validbit_write_en <= 0;
                        validbit_write_offset <= 0;
                    end else begin 
                        // read out counter
                        rd_data_out <= data_tmp;
                        validbit_write_data <= 0;
                        validbit_write_en <= 0;
                        validbit_write_offset <= 0;
                        valid_slice_tmp <= valid_bitmap[local_addr_in >> 5];
                        valid_slice_offset_tmp <= local_addr_in % 32;
                        valid_slice_idx_tmp <= local_addr_in >> 5;
                        data_tmp <= mem[local_addr_in]; // data may be invalid
                    end 
                end 
                rd_data_valid_out <= 1;
                rd_addr_out <= addr_in_tmp;
                rd_cnt_valid_out <= rd_cnt_in_tmp;
            end else begin
                // this cycle no read
                rd_data_out <= rd_data_in;
                rd_data_valid_out <= rd_data_valid_in;
                rd_addr_out <= rd_addr_in;
                rd_cnt_valid_out <= rd_cnt_valid_in;
                
                data_tmp <= mem[local_addr_in]; // data may be invalid 
                valid_slice_offset_tmp <= local_addr_in % 32;
                valid_slice_idx_tmp <= local_addr_in >> 5;
                valid_slice_tmp <= valid_bitmap[local_addr_in >> 5];

                validbit_write_en <= 0;
                validbit_write_offset <= 0;
                validbit_write_data <= 0;
            end
        end
    end
end else begin  // hot page filtering 
    // Memory
    (*ramstyle = "block"*) reg [31:0] hot_bitmap [(2 ** ADDR_WIDTH >> 5)-1:0];
    // Signal indicating wether the address is in the memory segment's range
    logic should_receive;
    /* verilator lint_off WIDTH */
    /* verilator lint_off UNSIGNED */
    /* verilator lint_off CMPCONST */
    // assign should_receive = (addr_in >= LO) && (addr_in <= HI);
    assign should_receive = (MEM_ID == dst_id_in);

    // Local addr
    logic [ADDR_WIDTH-1:0] local_addr_in ;
    assign local_addr_in = addr_in[ADDR_WIDTH-1:0];

    // Signal Buffering
    logic hot_tmp;
    logic [31:0] hot_slice_tmp;
    logic [(2 ** ADDR_WIDTH >> 5)-1:0] hot_slice_idx_tmp; // the index of the slice
    logic [4:0] hot_slice_offset_tmp; // the offset of the valid bit in the slice

    logic rd_en_in_tmp;
    logic [ADDR_WIDTH-1:0] local_addr_in_tmp;
    logic [ADDR_WIDTH-1:0] local_addr_in_tmp_tmp;
    logic [ADDR_WIDTH_FULL-1:0] addr_in_tmp;
    logic should_receive_tmp = 0;

    // logic [DATA_WIDTH-1:0] rd_data_in_tmp;

    always @(posedge clk) begin 
        // Passing address and enable signals
        addr_out <= addr_in;
        rd_en_out <= rd_en_in; 
    end 

    enum int unsigned { RUN = 0, RESET = 2} state;
    reg [ADDR_WIDTH:0] rst_cnt = 0;
    reg hotbit_write_en;
    reg [ADDR_WIDTH-1:0] hotbit_write_offset;
    reg [31:0] hotbit_write_data;
    //Read and increment 
    always @(posedge clk) begin
        // Reset 
        if (hotbit_write_en) begin
            hot_bitmap[hotbit_write_offset] <= hotbit_write_data;
        end 

        if (!rst_n) begin
            rst_cnt <= 0;
            state <= RESET;
        end 

        if (state == RESET) begin
            rst_cnt <= rst_cnt + 1;
            if (rst_cnt == 2 ** ADDR_WIDTH >> 5) begin
                state <= RUN;
                hotbit_write_en <= 0;
            end else begin 
                hotbit_write_data <= 32'b0;
                hotbit_write_offset <= rst_cnt;
                hotbit_write_en <= 1;
                rst_cnt <= rst_cnt + 1;
            end 
        end else if (state == RUN) begin 
            if(!rd_en_in) begin
                rd_en_in_tmp <= 0;
                local_addr_in_tmp <= 0;
                local_addr_in_tmp_tmp <= 0;
                addr_in_tmp <= 0;
                should_receive_tmp <= 0;
                // hot_tmp <= 0;
                hot_slice_tmp <= 0;
                hot_slice_offset_tmp <= 0;
                hot_slice_idx_tmp <= 0;
            end else begin
                rd_en_in_tmp <= rd_en_in;
                local_addr_in_tmp <= local_addr_in;
                local_addr_in_tmp_tmp <= local_addr_in_tmp;
                addr_in_tmp <= addr_in;
                should_receive_tmp <= should_receive;
                hot_slice_offset_tmp <= local_addr_in % 32;
                hot_slice_idx_tmp <= local_addr_in >> 5;
            end 

            // here it delays for one cycle for reading data from BRAM
            if (rd_en_in_tmp && should_receive_tmp) begin
                if(hot_slice_tmp[hot_slice_offset_tmp] == 0) begin
                    // First time read
                    rd_data_out <= 0; // for hot bits, zero is the default value
                    // update the hot bitmap                    
                    hotbit_write_en <= 1;
                    hotbit_write_data <= (hot_slice_tmp | (1 << hot_slice_offset_tmp));
                    hotbit_write_offset <= hot_slice_idx_tmp;

                    if (local_addr_in == local_addr_in_tmp || local_addr_in == local_addr_in_tmp_tmp) begin  // forwarding
                        hot_slice_tmp <= hot_slice_tmp | (1 << hot_slice_offset_tmp);
                    end else begin 
                        hot_slice_tmp <= hot_bitmap[local_addr_in >> 5];
                    end
                end
                else begin
                    // mem stores the hotness bits
                    rd_data_out <= 1;
                    if (local_addr_in == local_addr_in_tmp || local_addr_in == local_addr_in_tmp_tmp) begin // need forwarding
                        hot_slice_tmp <= hot_slice_tmp;
                    end else begin
                        hot_slice_tmp <= hot_bitmap[local_addr_in >> 5];
                    end 
                    
                    hotbit_write_data <= 0;
                    hotbit_write_en <= 0;
                    hotbit_write_offset <= 0;
                end 
                rd_data_valid_out <= 1;
                rd_addr_out <= addr_in_tmp;
            end else begin
                // just passing
                rd_data_out <= rd_data_in;
                rd_data_valid_out <= rd_data_valid_in;
                rd_addr_out <= rd_addr_in;
                // hot_tmp <= hot_bitmap[local_addr_in];
                hot_slice_tmp <= hot_bitmap[local_addr_in >> 5];
                hot_slice_offset_tmp <= local_addr_in % 32;
                hot_slice_idx_tmp <= local_addr_in >> 5;
                hotbit_write_en <= 0;
                hotbit_write_offset <= 0;
                hotbit_write_data <= 0;
            end
        end 
    end
end  


endmodule