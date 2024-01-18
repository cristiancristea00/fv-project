class transmitter_output_agent extends uvm_agent;

    `uvm_component_utils(transmitter_output_agent)

    function new (string name = "transmitter_output_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new


    transmitter_output_monitor output_monitor;


    function void build_phase(uvm_phase phase);
        `uvm_info("STEP", "Starting build phase...", UVM_DEBUG)

        super.build_phase(phase);

        output_monitor = transmitter_output_monitor::type_id::create("output_monitor", this);
        `uvm_info("STEP", "Created output monitor", UVM_DEBUG)

        `uvm_info("STEP", "Finished build phase", UVM_DEBUG)
    endfunction : build_phase

 
endclass : transmitter_output_agent
