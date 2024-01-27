class transmitter_reset_sequence extends uvm_sequence#(transmitter_sequence_item);

   `uvm_object_utils(transmitter_reset_sequence)

    function new(string name = "transmitter_reset_sequence", int number_of_transfers = `TRANSFERS_PER_ELEMENT);
        super.new(name);

        this.number_of_transfers = number_of_transfers;
    endfunction

    local int number_of_transfers;
    

    task body();
        transmitter_sequence_item transfer = transmitter_sequence_item::type_id::create("transfer");
        
        process_half(transfer);

        start_item(transfer);
        transfer.reset = 0;
        finish_item(transfer);

        start_item(transfer);
        transfer.kill();
        finish_item(transfer);

        process_half(transfer);

        start_item(transfer);
        transfer.kill();
        finish_item(transfer);

        #DELAY_CLK16;

    endtask: body


    protected task process_half(transmitter_sequence_item transfer);
        repeat(number_of_transfers / 2) begin
            start_item(transfer);
            if (!transfer.randomize()) begin
                `uvm_fatal("RANDOM", "Failed to randomize transfer")
            end
            transfer.reset                 = 1;
            transfer.buffer_full_threshold = 32;
            transfer.baudrate_select       = BAUD_CLK16;
            finish_item(transfer);
        end
    endtask: process_half


endclass: transmitter_reset_sequence