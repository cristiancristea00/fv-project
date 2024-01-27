
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
        @ (posedge clock);
    endtask: wait_clock_pos


    task wait_clock_neg();
        @ (negedge clock);
    endtask: wait_clock_neg


    task wait_reset_trigger();
        forever begin
            @ (posedge clock);
            if (reset == 0) begin
                break;
            end
        end
    endtask: wait_reset_trigger


    task wait_reset_clear();
        @ (posedge reset);
    endtask: wait_reset_clear


    task wait_for_start_of_frame();
        @ (negedge data_out);
    endtask: wait_for_start_of_frame


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


    function void inputs_drive(bit reset_val, bit write_enable_val, bit [7:0] data_val, bit [5:0] buffer_full_threshold_val, bit [1:0] baudrate_select_val);
        reset                 = reset_val;
        write_enable          = write_enable_val;
        data                  = data_val;
        buffer_full_threshold = buffer_full_threshold_val;
        baudrate_select       = baudrate_select_val;
    endfunction: inputs_drive
   

endinterface: uart_transmitter_interface
