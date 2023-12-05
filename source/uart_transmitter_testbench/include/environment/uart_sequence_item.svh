class uart_sequence_item extends uvm_sequence_item;

    `uvm_object_utils(uart_sequence_item)


    function new(string name = "uart_sequence_item");
        super.new(name);
    endfunction


    logic [10:0] uart_data;


    virtual function void do_print(uvm_printer printer);
        printer.print_string("initial_data", get_initial_data_str());
        printer.print_string("data", get_data_str());
        printer.print_int("start_bit", get_start_bit(), 1, UVM_DEC, ".", "dec");
        printer.print_int("stop_bit", get_stop_bit(), 1, UVM_DEC, ".", "dec");
    endfunction: do_print


    local function string get_initial_data_str();
        return $sformatf("%b", get_initial_data());
    endfunction: get_initial_data_str


    local function string get_data_str();
        string data_str = $sformatf("%h", get_data());

        return $sformatf("0x%s", data_str.toupper());
    endfunction: get_data_str


    local function logic [8:0] get_initial_data();
        return {uart_data[1], uart_data[2], uart_data[3], uart_data[4], uart_data[5], uart_data[6], uart_data[7], uart_data[8], uart_data[9]};
    endfunction: get_initial_data


    local function logic [7:0] get_data();
        return uart_data[8:1];
    endfunction: get_data


    local function logic get_start_bit();
        return uart_data[0];
    endfunction: get_start_bit


    local function logic get_stop_bit();
        return uart_data[10];
    endfunction: get_stop_bit


endclass: uart_sequence_item
