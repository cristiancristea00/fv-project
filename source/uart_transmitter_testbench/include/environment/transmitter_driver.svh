class transmitter_driver extends uvm_driver#(transmitter_sequence_item);
	
    `uvm_component_utils(transmitter_driver)

    function new(string name = "transmitter_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new


    virtual uart_transmitter_interface system_interface;


    local event reset_enabled;
    local event end_of_reset; 


    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_name(), "Starting build phase...", UVM_LOW)
        super.build_phase(phase);
        `uvm_info(get_name(), "Finished build phase", UVM_LOW)
    endfunction: build_phase


    virtual function void connect_phase(uvm_phase phase);
        `uvm_info(get_name(), "Starting connect phase...", UVM_LOW)
        super.connect_phase(phase);

        if (!uvm_config_db#(virtual uart_transmitter_interface)::get(null, "*", "system_interface", system_interface)) begin
			`uvm_fatal(get_name(), "Error in getting system_interface from UVM_CONFIG_DB")
		end
        `uvm_info(get_name(), "Got system interface from UVM_CONFIG_DB", UVM_LOW)

        `uvm_info(get_name(), "Finished connect phase", UVM_LOW)
    endfunction: connect_phase


    task run_phase(uvm_phase phase);
        `uvm_info(get_name(), "Starting run phase...", UVM_LOW)

        reset_module();
        reset_inputs();

        fork
            drive();
            wait_for_reset();
        join_any

        `uvm_info(get_name(), "Finished run phase", UVM_LOW)
    endtask: run_phase


    protected task drive();
        transmitter_sequence_item transfer;

        forever begin
            seq_item_port.get_next_item(transfer);
            `uvm_info(get_name(), "Got next item from sequencer", UVM_LOW)

            drive_transfer(transfer);

            seq_item_port.item_done();

            if (reset_enabled.triggered) begin
                transfer.kill();

                reset_inputs();

                wait(end_of_reset.triggered);
            end
        end
    endtask: drive


    protected task drive_transfer(transmitter_sequence_item transfer);
        `uvm_info(get_name(), "Starting drive transfer...", UVM_LOW)

        system_interface.wait_clock_neg();
        system_interface.inputs_drive(transfer.write_enable, transfer.data, transfer.buffer_full_threshold, transfer.baudrate_select);

        `uvm_info(get_name(), "Finished drive transfer", UVM_LOW)
    endtask: drive_transfer


    protected task wait_for_reset();
        forever begin
            system_interface.wait_reset_trigger();
            -> reset_enabled;

            system_interface.wait_reset_clear();
            -> end_of_reset;
        end
    endtask: wait_for_reset


    protected function void reset_inputs();
        `uvm_info(get_name(), "Starting inputs reset...", UVM_LOW)

        system_interface.inputs_reset();

        `uvm_info(get_name(), "Finished inputs reset", UVM_LOW)
    endfunction: reset_inputs

    protected task reset_module();
        `uvm_info(get_name(), "Starting reset module...", UVM_LOW)

        system_interface.reset_module();

        `uvm_info(get_name(), "Finished reset module", UVM_LOW)
    endtask: reset_module

    
endclass : transmitter_driver
