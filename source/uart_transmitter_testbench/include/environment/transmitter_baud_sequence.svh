class transmitter_baud_sequence extends uvm_sequence#(transmitter_sequence_item);

   `uvm_object_utils(transmitter_baud_sequence)

    function new(string name = "transmitter_baud_sequence", int number_of_transfers = `TRANSFERS_PER_ELEMENT);
        super.new(name);

        this.number_of_transfers = number_of_transfers;
    endfunction

    local int number_of_transfers;
    

    task body();
        transmitter_sequence_item transfer =  transmitter_sequence_item::type_id::create("transfer");

        delay_t delay;

        baudrate_select_t bauds[4] = '{BAUD_CLK16, BAUD_CLK32, BAUD_CLK64, BAUD_CLK128};

        for (int baud = 0; baud < 4; ++baud) begin
    
            const bit [7:0] special_values[4] = '{8'h00, 8'h55, 8'hAA, 8'hFF};

            uvm_report_info(get_name(), $sformatf("Starting baudrate select %s", bauds[baud].name()), UVM_INFO);

            for (int idx = 0; idx < 4; ++idx) begin
                    start_item(transfer);
                    transfer.write_enable          = 1;
                    transfer.data                  = special_values[idx];
                    transfer.buffer_full_threshold = 32;
                    transfer.baudrate_select       = bauds[baud];
                    finish_item(transfer);
            end

            repeat(number_of_transfers) begin
                start_item(transfer);
                transfer.randomize();
                transfer.buffer_full_threshold = 32;
                transfer.baudrate_select       = bauds[baud];
                finish_item(transfer);
            end

            start_item(transfer);
            transfer.kill();
            finish_item(transfer);

            delay = get_delay(bauds[baud]);

            #delay;

        end

    endtask: body


endclass: transmitter_baud_sequence