class transmitter_threshold_sequence extends uvm_sequence#(transmitter_sequence_item);

   `uvm_object_utils(transmitter_threshold_sequence)

    function new(string name = "transmitter_threshold_sequence", int number_of_transfers = `TRANSFERS_PER_ELEMENT);
        super.new(name);

        this.number_of_transfers = number_of_transfers;
    endfunction

    local int number_of_transfers;
    

    task body();
        transmitter_sequence_item transfer =  transmitter_sequence_item::type_id::create("transfer");

        for (int threshold = 0; threshold < 64; ++threshold) begin
    
            const bit [7:0] special_values[4] = '{8'h00, 8'h55, 8'hAA, 8'hFF};

            `uvm_info("THRESHOLD", $sformatf("Starting threshold select %0d", threshold), UVM_INFO)

            for (int idx = 0; idx < 4; ++idx) begin
                    start_item(transfer);
                    transfer.write_enable          = 1;
                    transfer.data                  = special_values[idx];
                    transfer.buffer_full_threshold = threshold;
                    transfer.baudrate_select       = BAUD_CLK16;
                    finish_item(transfer);
            end

            repeat(number_of_transfers) begin
                start_item(transfer);
                if (!transfer.randomize()) begin
                    `uvm_fatal("RANDOM", "Failed to randomize transfer")
                end
                transfer.buffer_full_threshold = threshold;
                transfer.baudrate_select       = BAUD_CLK16;
                finish_item(transfer);
            end

            start_item(transfer);
            transfer.kill();
            finish_item(transfer);

            #DELAY_CLK16;

        end

    endtask: body


endclass: transmitter_threshold_sequence