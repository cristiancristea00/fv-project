class transmitter_sequence_item extends uvm_sequence_item;

    `uvm_object_utils(transmitter_sequence_item)

    function new(string name = "transmitter_sequence_item");
        super.new(name);
    endfunction


    rand bit       write_enable;
    rand bit [7:0] data;
    rand bit [5:0] buffer_full_threshold;
    rand bit [1:0] baudrate_select;


    function void kill();
        write_enable          = 0;
        data                  = 0;
        buffer_full_threshold = 0;
        baudrate_select       = 0;
    endfunction: kill


endclass: transmitter_sequence_item
