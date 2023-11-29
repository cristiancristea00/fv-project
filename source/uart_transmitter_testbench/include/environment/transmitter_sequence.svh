class transmitter_sequence extends uvm_sequence#(transmitter_sequence_item);

   `uvm_object_utils(transmitter_sequence)

    function new(string name = "transmitter_sequence");
        super.new(name);
    endfunction

   
    rand int number_of_transfers;


    transmitter_sequence_item transfer;
    

    task body();
        transfer = transmitter_sequence_item::type_id::create("transfer");

        number_of_transfers = 1;

        repeat(number_of_transfers) begin
            start_item(transfer);
            transfer.randomize();
            finish_item(transfer);
        end

        start_item(transfer);
        transfer.write_enable = 0;
        transfer.data         = 0;
        finish_item(transfer);

    endtask: body


endclass: transmitter_sequence
