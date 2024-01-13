class transmitter_input_coverage extends uvm_subscriber#(transmitter_sequence_item);

    `uvm_component_utils(transmitter_input_coverage)


    covergroup input_covergroup with function sample(transmitter_sequence_item transfer);
        option.name = "input_covergroup";

        data : coverpoint transfer.data {
            wildcard bins bit0_7 = {8'b0???_????};
            wildcard bins bit0_6 = {8'b?0??_????};
            wildcard bins bit0_5 = {8'b??0?_????};
            wildcard bins bit0_4 = {8'b???0_????};
            wildcard bins bit0_3 = {8'b????_0???};
            wildcard bins bit0_2 = {8'b????_?0??};
            wildcard bins bit0_1 = {8'b????_??0?};
            wildcard bins bit0_0 = {8'b????_???0};
            wildcard bins bit1_7 = {8'b1???_????};
            wildcard bins bit1_6 = {8'b?1??_????};
            wildcard bins bit1_5 = {8'b??1?_????};
            wildcard bins bit1_4 = {8'b???1_????};
            wildcard bins bit1_3 = {8'b????_1???};
            wildcard bins bit1_2 = {8'b????_?1??};
            wildcard bins bit1_1 = {8'b????_??1?};
            wildcard bins bit1_0 = {8'b????_???1};

            bins data_0x00 = {8'h00};
            bins data_0x55 = {8'h55};
            bins data_0xAA = {8'hAA};
            bins data_0xFF = {8'hFF};
        }

        write_enable : coverpoint transfer.write_enable {
            bins write_enable_0 = {1'b0};
            bins write_enable_1 = {1'b1};
        }

        baudrate_select : coverpoint transfer.baudrate_select {
            bins baudrate_select_CLK16  = {BAUD_CLK16};
            bins baudrate_select_CLK32  = {BAUD_CLK32};
            bins baudrate_select_CLK64  = {BAUD_CLK64};
            bins baudrate_select_CLK128 = {BAUD_CLK128};
        }

        buffer_full_threshold : coverpoint transfer.buffer_full_threshold {
            bins buffer_full_threshold_all = {[6'd0 : 6'd63]};
        }

    endgroup: input_covergroup


    function new(string name = "transmitter_input_coverage", uvm_component parent = null);
        super.new(name, parent);

        input_covergroup = new();
    endfunction


    virtual function void write(transmitter_sequence_item t);
        input_covergroup.sample(t);
    endfunction: write


    virtual function void report_phase(uvm_phase phase);
        uvm_report_info(get_name(), "Starting report phase...", UVM_DEBUG);
        super.report_phase(phase);

        uvm_report_info(get_name(), $sformatf("########## COVERAGE: Input - %.2f%% ##########", input_covergroup.get_inst_coverage()), UVM_LOW);

        uvm_report_info(get_name(), "Finished report phase", UVM_DEBUG);
    endfunction: report_phase


endclass: transmitter_input_coverage