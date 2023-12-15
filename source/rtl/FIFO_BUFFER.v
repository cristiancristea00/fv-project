module FIFO_BUFFER( 
    input clock,            // clock signal 
    input reset_n,          // active 0 reset signal
    input write_enable,     // write request
    input read_enable,      // read request
    input [7:0] data_in,    // input data
    input [5:0] full_tresh, // threshold for full
    output [7:0] data_out,  // output data
    output empty,           // empty status signal
    output full             // full status signal
 );
 
 wire rd_en_mem, wr_en_mem;
 reg [4:0] write_ptr_reg, read_ptr_reg;
 reg [5:0] fifo_counter;
 reg [7:0] memory [0:31];
 
//WRITE POINTER	
always@(posedge clock) begin
    if(reset_n == 0)
        write_ptr_reg <= 0;
    else if (wr_en_mem == 1)
        write_ptr_reg <= write_ptr_reg + 1;
end
 
//READ POINTER	
always@(posedge clock) begin
    if(reset_n == 0)
        read_ptr_reg <= 0;
    else if (rd_en_mem == 1)
        read_ptr_reg <= read_ptr_reg + 1;
end
 
//FIFO COUNTER
always@(posedge clock) begin
    if(reset_n == 0)
        fifo_counter <= 0;
    else if (rd_en_mem && !wr_en_mem)
        fifo_counter <= fifo_counter + 1;
    else if (!rd_en_mem && wr_en_mem)
        fifo_counter <= fifo_counter - 1;	
    end
 
//READ_ENABLE AND WRITE_ENABLE
assign wr_en_mem = write_enable & ~full;
assign rd_en_mem = read_enable & ~empty;
 
//FULL AND EMPTY
assign full  = (fifo_counter == full_tresh);
assign empty = (fifo_counter == 0);

always@(posedge clock) begin
    if(wr_en_mem)
        memory[write_ptr_reg] <= data_in;
end

assign data_out = memory[read_ptr_reg];
 
endmodule
