class transmitter_sequence_item extends uvm_sequence_item;

    `uvm_object_utils(transmitter_sequence_item)

    function new(string name = "transmitter_sequence_item");
        super.new(name);
    endfunction


    rand  bit       write_enable;
    randc bit [7:0] data;
    rand  bit [5:0] buffer_full_threshold;
    rand  bit [1:0] baudrate_select;


    constraint buffer_full_threshold_constraint {
        buffer_full_threshold == 32;
    }

    constraint baudrate_select_constraint {
        baudrate_select == 0;
    }

    constraint write_enable_constraint {
        write_enable == 1;
    }


    function void kill();
        write_enable          = 0;
        data                  = 0;
        buffer_full_threshold = 32;
        baudrate_select       = 0;
    endfunction: kill


    virtual function void do_print(uvm_printer printer);
        bit [8:0] uart_data = {data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7], ^data};

        string uart_data_str = $sformatf("%b", uart_data);
        string data_str      = $sformatf("%h", data);
        data_str             = $sformatf("0x%s", data_str.toupper());

        printer.print_int("baudrate_select", baudrate_select, $bits(baudrate_select), UVM_DEC, ".", "dec");
        printer.print_int("buffer_full_threshold", buffer_full_threshold, $bits(buffer_full_threshold), UVM_DEC, ".", "dec");
        printer.print_string("data", data_str);
        printer.print_string("uart_data", uart_data_str);
        printer.print_string("write_enable", write_enable ? "True" : "False");
    endfunction: do_print


endclass: transmitter_sequence_item
