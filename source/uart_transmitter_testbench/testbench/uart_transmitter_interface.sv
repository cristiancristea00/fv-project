
interface uart_transmitter_interface(input bit clock);

    // Inputs
    logic       reset;
    logic [7:0] data_in;
    logic       write_enable;
    logic [5:0] buffer_full_threshold;
    logic [1:0] baudrate_select;

    // Outputs
    logic buffer_full;
    logic data_out;


    task pos_nop();
        @(posedge clock);
    endtask: pos_nop


    task neg_nop();
        @(negedge clock);
    endtask: neg_nop


    task init_inputs();
        reset                 = 1;
        data_in               = 0;
        write_enable          = 0;
        buffer_full_threshold = 32;
        baudrate_select       = 0;
    endtask: init_inputs
 

    task reset_module(int length);
        reset = 0;
        repeat(length) pos_nop();
        neg_nop();
        reset = 1;
    endtask: reset_module


    task write_data(logic [7:0] data);
        neg_nop();
        data_in      = data;
        write_enable = 1;
        neg_nop();
        write_enable = 0;
    endtask: write_data
   

endinterface: uart_transmitter_interface
