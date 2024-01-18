class transmitter_driver extends uvm_driver#(transmitter_sequence_item);
	
    `uvm_component_utils(transmitter_driver)

    function new(string name = "transmitter_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new


    virtual uart_transmitter_interface system_interface;

    transmitter_sequence_item transfer;

    local uvm_printer printer;


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

        if (!uvm_config_db#(uvm_printer)::get(this, "*", "printer", printer)) begin
            `uvm_fatal("DATABASE", "Error in getting printer from the UVM Configuration Database")
        end
        `uvm_info("STEP", "Got printer from UVM Configuration Database", UVM_DEBUG)

        `uvm_info("STEP", "Finished connect phase", UVM_DEBUG)
    endfunction: connect_phase


    task run_phase(uvm_phase phase);
        `uvm_info("STEP", "Starting run phase...", UVM_DEBUG)

        init_inputs();
        reset_module();

        fork
            begin : reset_monitor_thread
                `uvm_info("STEP", "Started reset monitoring thread", UVM_DEBUG)
                wait_for_reset();
            end

            begin : drive_thread
                `uvm_info("STEP", "Started drive thread", UVM_DEBUG)
                drive();
            end
        join

        `uvm_info("STEP", "Finished run phase", UVM_DEBUG)
    endtask: run_phase


    protected task drive();
        forever begin
            seq_item_port.get_next_item(transfer);

            drive_transfer(transfer);

            seq_item_port.item_done();

            system_interface.wait_until_reset_high();
        end
    endtask: drive


    protected task drive_transfer(transmitter_sequence_item transfer);
        `uvm_info("STEP", "Starting drive transfer...", UVM_DEBUG)

        system_interface.wait_clock_neg();
        system_interface.inputs_drive(transfer.write_enable, transfer.data, transfer.buffer_full_threshold, transfer.baudrate_select);

        `uvm_info("STEP", "Finished drive transfer", UVM_DEBUG)
    endtask: drive_transfer


    protected task wait_for_reset();
        forever begin
            system_interface.wait_reset_trigger();
            transfer.kill();
            reset_inputs();
        end
    endtask: wait_for_reset


    protected function void init_inputs();
        `uvm_info("STEP", "Starting inputs init...", UVM_DEBUG)

        system_interface.inputs_init();

        `uvm_info("STEP", "Finished inputs init", UVM_DEBUG)
    endfunction: init_inputs


    protected function void reset_inputs();
        `uvm_info("STEP", "Starting inputs reset...", UVM_DEBUG)

        system_interface.inputs_reset();

        `uvm_info("STEP", "Finished inputs reset", UVM_DEBUG)
    endfunction: reset_inputs

    
    protected task reset_module();
        `uvm_info("STEP", "Starting reset module...", UVM_DEBUG)

        system_interface.reset_module();

        `uvm_info("STEP", "Finished reset module", UVM_DEBUG)
    endtask: reset_module

    
endclass : transmitter_driver
