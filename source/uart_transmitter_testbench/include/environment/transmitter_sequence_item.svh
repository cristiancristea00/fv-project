class transmitter_sequence_item extends uvm_sequence_item;

    `uvm_object_utils(transmitter_sequence_item)

    function new(string name = "transmitter_sequence_item");
        super.new(name);

        this.write_enable          = 0;
        this.data                  = 0;
        this.buffer_full_threshold = 0;
        this.baudrate_select       = 0;
    endfunction


    bit            reset;
    rand bit       write_enable;
    rand bit [7:0] data;
    bit      [5:0] buffer_full_threshold;
    bit      [1:0] baudrate_select;


    function void kill();
        reset        = 1;
        write_enable = 0;
        data         = 0;
    endfunction: kill


    virtual function void do_print(uvm_printer printer);
        printer.print_int("baudrate_select", baudrate_select, $bits(baudrate_select), UVM_DEC, ".", "dec");
        printer.print_int("buffer_full_threshold", buffer_full_threshold, $bits(buffer_full_threshold), UVM_DEC, ".", "dec");
        printer.print_string("data", get_data_str());
        printer.print_string("uart_data", get_uart_data_str());
        printer.print_string("write_enable", write_enable ? "True" : "False");
        printer.print_string("reset", reset ? "True" : "False");
    endfunction: do_print


    function string get_data_str();
        string data_str = $sformatf("%h", data);

        return $sformatf("0x%s", data_str.toupper());
    endfunction: get_data_str


    function string get_uart_data_str();
        return $sformatf("%b", get_uart_data());
    endfunction: get_uart_data_str


    function bit[8:0] get_uart_data();
        return {data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7], ^data};
    endfunction: get_uart_data


endclass: transmitter_sequence_item
