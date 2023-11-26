`timescale 1ns / 1ps

module UART_TRANSMITTER_TB();

reg clock_i_tb, reset_n_i_tb;
reg [7:0] data_i_tb;
reg data_write_tb;
reg [5:0] data_buffer_full_tresh_i_tb;
reg [1:0] baudrate_select_i_tb;
wire data_buffer_full_o_tb;
wire uart_tx_o_tb;

integer idx;

initial begin
    clock_i_tb = 0;
    forever #1 clock_i_tb = ~clock_i_tb;
end

initial begin
    reset_n_i_tb = 0;
    data_buffer_full_tresh_i_tb = 32;
    baudrate_select_i_tb = 0;
    #2  reset_n_i_tb = 1;
    for(idx = 0; idx<= 2**5; idx = idx + 1) begin 
        @(posedge clock_i_tb)
        data_i_tb <= idx;
        data_write_tb <= 1;
    end
    
    @(posedge clock_i_tb)
    data_write_tb <= 0;
    
    repeat(10000) begin
        @(posedge clock_i_tb);
    end

    $stop();
end

UART_TRANSMITTER DUT(
    .clock_i(clock_i_tb),
    .reset_n_i(reset_n_i_tb),
    .data_i(data_i_tb),
    .data_write_i(data_write_tb),
    .data_buffer_full_tresh_i(data_buffer_full_tresh_i_tb),
    .baudrate_select_i(baudrate_select_i_tb),
    .data_buffer_full_o(data_buffer_full_o_tb),
    .uart_tx_o(uart_tx_o_tb)
    );

endmodule
