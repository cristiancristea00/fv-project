class transmitter_input_agent extends uvm_agent;

    `uvm_component_utils(transmitter_input_agent)

    function new (string name = "transmitter_input_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new


    transmitter_sequencer sequencer;
    transmitter_driver driver;
    transmitter_input_monitor input_monitor;


    function void build_phase(uvm_phase phase);
        `uvm_info("STEP", "Starting build phase...", UVM_DEBUG)

        super.build_phase(phase);

        sequencer = transmitter_sequencer::type_id::create("sequencer", this);
        `uvm_info("STEP", "Created sequencer", UVM_DEBUG)

        driver = transmitter_driver::type_id::create("driver", this);
        `uvm_info("STEP", "Created driver", UVM_DEBUG)

        input_monitor = transmitter_input_monitor::type_id::create("input_monitor", this);
        `uvm_info("STEP", "Created input monitor", UVM_DEBUG)

        `uvm_info("STEP", "Finished build phase", UVM_DEBUG)
    endfunction : build_phase


    function void connect_phase(uvm_phase phase);
        `uvm_info("STEP", "Starting connect phase...", UVM_DEBUG)
        
        super.connect_phase(phase);

        driver.seq_item_port.connect(sequencer.seq_item_export);
        `uvm_info("STEP", "Connected driver to sequencer", UVM_DEBUG)

        `uvm_info("STEP", "Finished connect phase", UVM_DEBUG)
    endfunction : connect_phase

 
endclass : transmitter_input_agent
