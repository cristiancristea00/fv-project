`uvm_analysis_imp_decl(_input_bus_ap)
`uvm_analysis_imp_decl(_output_bus_ap)

class transmitter_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(transmitter_scoreboard)

    function new(string name = "transmitter_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction


    uvm_analysis_imp_input_bus_ap#(transmitter_sequence_item, transmitter_scoreboard) transmitter_input_bus_ap;

    uvm_analysis_imp_output_bus_ap#(uart_sequence_item, transmitter_scoreboard) transmitter_output_bus_ap;

    transmitter_sequence_item buffer[$];

    int fail_count = 0;


    virtual function void build_phase(uvm_phase phase);
        `uvm_info("STEP", "Starting build phase...", UVM_DEBUG)

        super.build_phase(phase);

        transmitter_input_bus_ap  = new("transmitter_input_bus_ap", this);
        transmitter_output_bus_ap = new("transmitter_output_bus_ap", this);

        `uvm_info("STEP", "Finished build phase", UVM_DEBUG)
    endfunction: build_phase


    virtual function void connect_phase(uvm_phase phase);
        `uvm_info("STEP", "Starting connect phase...", UVM_DEBUG)

        super.connect_phase(phase);

        `uvm_info("STEP", "Finished connect phase", UVM_DEBUG)
    endfunction: connect_phase


    virtual function void report_phase(uvm_phase phase);
        `uvm_info("STEP", "Starting report phase...", UVM_DEBUG)

        super.report_phase(phase);

        if (fail_count == 0) begin
            `uvm_info("RESULT", "########## PASSED: No errors detected ##########", UVM_LOW)
        end
        else begin
            `uvm_error("RESULT", $sformatf("########## FAILED: %0d errors detected ##########", fail_count))
        end

        `uvm_info("STEP", "Finished report phase", UVM_DEBUG)
    endfunction: report_phase


    virtual function void write_input_bus_ap(transmitter_sequence_item transfer);
        if (transfer.reset == 0) begin
            buffer.delete();
        end
        else begin
            buffer.push_back(transfer);
        end
    endfunction: write_input_bus_ap


    virtual function void write_output_bus_ap(uart_sequence_item transfer);
        if (buffer.size() == 0) begin
            `uvm_error("CHECK", "No data in buffer")
        end
        else begin
            transmitter_sequence_item expected = buffer.pop_front();

            if (transfer.get_initial_data() == expected.get_uart_data()) begin
                `uvm_info("CHECK", $sformatf("PASSED: Expected %s, got %s", expected.get_data_str(), transfer.get_data_str()), UVM_MEDIUM)
            end
            else begin
                `uvm_error("CHECK", $sformatf("FAILED: Expected %s, got %s", expected.get_data_str(), transfer.get_data_str()))
                ++fail_count;
            end
        end
    endfunction: write_output_bus_ap


endclass: transmitter_scoreboard
