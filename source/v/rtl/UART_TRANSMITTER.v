module UART_TRANSMITTER(
    input clock_i,
    input reset_n_i,
    input [7:0] data_i,
    input data_write_i,
    input [5:0] data_buffer_full_tresh_i,
    input [1:0] baudrate_select_i,
    output data_buffer_full_o,
    output uart_tx_o
    );

wire read_from_fifo;
wire [7:0] data_from_fifo;
wire empty_status_fifo;
wire baud_tick;
        
FIFO_BUFFER fifo_buffer( 
    .clock(clock_i),            
    .reset_n(reset_n_i),         
    .write_enable(data_write_i),    
    .read_enable(read_from_fifo),     
    .data_in(data_i),   
    .full_tresh(data_buffer_full_tresh_i),
    .data_out(data_from_fifo),  
    .empty(empty_status_fifo),           
    .full(data_buffer_full_o)            
 ); 
 
TX_BAUD_GEN tx_baud_gen(
    .clock(clock_i),
    .reset_n(reset_n_i),
    .baudrate_select(baudrate_select_i),
    .tx_baud(baud_tick)
    ); 
    
UART_TX uart_tx(
    .clock(clock_i),
    .reset_n(reset_n_i),
    .tx_start(~empty_status_fifo),
    .tx_baud(baud_tick),
    .data_in(data_from_fifo),
    .tx_done(read_from_fifo),
    .tx(uart_tx_o)
    );      
    
endmodule
