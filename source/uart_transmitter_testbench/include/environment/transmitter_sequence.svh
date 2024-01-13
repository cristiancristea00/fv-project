class transmitter_sequence extends uvm_sequence#(transmitter_sequence_item);

   `uvm_object_utils(transmitter_sequence)

    function new(string name = "transmitter_sequence", baudrate_select_t baud_select = BAUD_CLK16, int number_of_transfers = 1000);
        super.new(name);

        this.baud_select         = baud_select;
        this.number_of_transfers = number_of_transfers;
    endfunction


    local baudrate_select_t baud_select;

    local int number_of_transfers;
    

    task body();
        transmitter_sequence_item transfer =  transmitter_sequence_item::type_id::create("transfer");

        const bit [7:0] special_values[4] = '{8'h00, 8'h55, 8'hAA, 8'hFF};

        for (int idx = 0; idx < 4; ++idx) begin
                start_item(transfer);
                transfer.write_enable          = 1;
                transfer.data                  = special_values[idx];
                transfer.buffer_full_threshold = 32;
                transfer.baudrate_select       = baud_select;
                finish_item(transfer);
        end

        repeat(number_of_transfers) begin
            start_item(transfer);
            transfer.randomize();
            transfer.buffer_full_threshold = 32;
            transfer.baudrate_select       = baud_select;
            finish_item(transfer);
        end

        start_item(transfer);
        transfer.kill();
        finish_item(transfer);

    endtask: body


endclass: transmitter_sequence