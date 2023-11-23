
interface sys_itf(input bit clock);

    logic reset_n_i;
    logic [7:0] data_i;
    logic data_write_i;
    logic [5:0] data_buffer_full_tresh_i;
    logic [1:0] baudrate_select_i;

    logic data_buffer_full_o;
    logic uart_tx_o;

    task nop();
        @(posedge clock);
    endtask: nop

    task init_inputs();
        reset_n_i                = 1;
        data_i                   = 0;
        data_write_i             = 0;
        data_buffer_full_tresh_i = 0;
        baudrate_select_i        = 0;
    endtask: init_inputs
 
    task reset(int length);
        reset_n_i = 0;
        repeat(length) nop();
        reset_n_i = 1;
    endtask: reset
   

endinterface
