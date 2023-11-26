class transmitter_sequence extends uvm_sequence#(transmitter_sequence_item);

   `uvm_object_utils(transmitter_sequence)

    function new(string name = "transmitter_sequence");
        super.new(name);
    endfunction

   
    rand int       number_of_transfers;
    rand bit [7:0] data;
    rand bit       write_enable;


    transmitter_sequence_item transfer;
    

    task body();
        transfer = transmitter_sequence_item::type_id::create("transfer");

        repeat(number_of_transfers) begin
            start_item(transfer);
            transfer.randomize() with {
                transfer.write_enable          == write_enable; 
                transfer.data                  == data;
                transfer.buffer_full_threshold == 32;
                transfer.baudrate_select       == 0;
            };
            finish_item(transfer);
        end

        start_item(transfer);
        transfer.write_enable = 0;
        finish_item(transfer);

    endtask: body


endclass: transmitter_sequence
