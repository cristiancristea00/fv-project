class transmitter_driver extends uvm_driver#(transmitter_sequence_item);
	
    `uvm_component_utils(transmitter_driver)

    function new(string name = "transmitter_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new


    virtual uart_transmitter_interface system_interface;

    transmitter_sequence_item transfer;


    virtual function void build_phase(uvm_phase phase);
        `uvm_info("STEP", "Starting build phase...", UVM_DEBUG)

        super.build_phase(phase);

        `uvm_info("STEP", "Finished build phase", UVM_DEBUG)
    endfunction: build_phase


    virtual function void connect_phase(uvm_phase phase);
        `uvm_info("STEP", "Starting connect phase...", UVM_DEBUG)

        super.connect_phase(phase);

        if (!uvm_config_db#(virtual uart_transmitter_interface)::get(null, "*", "system_interface", system_interface)) begin
			`uvm_fatal("DATABASE", "Error in getting system interface from the UVM Configuration Database")
		end
        `uvm_info("STEP", "Got system interface from UVM Configuration Database", UVM_DEBUG)

        `uvm_info("STEP", "Finished connect phase", UVM_DEBUG)
    endfunction: connect_phase


    task run_phase(uvm_phase phase);
        `uvm_info("STEP", "Starting run phase...", UVM_DEBUG)

        system_interface.inputs_init();
        system_interface.reset_module();

        `uvm_info("STEP", "Started driver thread", UVM_DEBUG)
        drive();

        `uvm_info("STEP", "Finished run phase", UVM_DEBUG)
    endtask: run_phase


    protected task drive();
        forever begin
            seq_item_port.get_next_item(transfer);
            drive_transfer(transfer);
            seq_item_port.item_done();
        end
    endtask: drive


    protected task drive_transfer(transmitter_sequence_item transfer);
        `uvm_info("STEP", "Starting drive transfer...", UVM_DEBUG)

        system_interface.wait_clock_neg();
        system_interface.inputs_drive(transfer.reset, transfer.write_enable, transfer.data, transfer.buffer_full_threshold, transfer.baudrate_select);

        `uvm_info("STEP", "Finished drive transfer", UVM_DEBUG)
    endtask: drive_transfer

    
endclass : transmitter_driver
