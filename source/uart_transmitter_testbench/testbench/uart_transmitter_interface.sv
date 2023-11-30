
interface uart_transmitter_interface;

    // Inputs
    bit         clock;
    logic       reset;
    logic       write_enable;
    logic [7:0] data;
    logic [5:0] buffer_full_threshold;
    logic [1:0] baudrate_select;

    // Outputs
    logic buffer_full;
    logic data_out;


    task wait_clock_pos();
        @(posedge clock);
    endtask: wait_clock_pos


    task wait_clock_neg();
        @(negedge clock);
    endtask: wait_clock_neg


    task wait_reset_trigger();
        @(negedge reset);
    endtask: wait_reset_trigger


    task wait_reset_clear();
        @(posedge reset);
    endtask: wait_reset_clear


    task wait_until_reset_low();
        wait (reset == 0);
    endtask: wait_until_reset_low


    task wait_until_reset_high();
        wait (reset == 1);
    endtask: wait_until_reset_high


    task wait_for_bus_change();
        @(write_enable or data or buffer_full_threshold or baudrate_select);
    endtask: wait_for_bus_change


    task reset_module(int length = 5);
        reset <= 0;
        repeat(length) wait_clock_pos();
        wait_clock_neg();
        reset <= 1;
    endtask: reset_module


    function void inputs_init();
        inputs_reset();
        reset = 1;
    endfunction: inputs_init


     function void inputs_reset();
        data                  = 0;
        write_enable          = 0;
        buffer_full_threshold = 0;
        baudrate_select       = 0;
    endfunction: inputs_reset


    function void inputs_drive(logic write_enable_val, logic [7:0] data_val, logic [5:0] buffer_full_threshold_val, logic [1:0] baudrate_select_val);
        write_enable          = write_enable_val;
        data                  = data_val;
        buffer_full_threshold = buffer_full_threshold_val;
        baudrate_select       = baudrate_select_val;
    endfunction: inputs_drive
   

endinterface: uart_transmitter_interface
