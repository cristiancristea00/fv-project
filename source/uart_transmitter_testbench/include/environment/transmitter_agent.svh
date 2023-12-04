class transmitter_agent extends uvm_agent;

    `uvm_component_utils(transmitter_agent)

    function new (string name = "transmitter_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new


    transmitter_sequencer sequencer;
    transmitter_driver driver;
    transmitter_input_monitor input_monitor;
    transmitter_output_monitor output_monitor;


    function void build_phase(uvm_phase phase);
        uvm_report_info(get_name(), "Starting build phase...", UVM_LOW);
        super.build_phase(phase);

        sequencer = transmitter_sequencer::type_id::create("sequencer", this);
        uvm_report_info(get_name(), "Created sequencer", UVM_LOW);

        driver = transmitter_driver::type_id::create("driver", this);
        uvm_report_info(get_name(), "Created driver", UVM_LOW);

        input_monitor = transmitter_input_monitor::type_id::create("input_monitor", this);
        uvm_report_info(get_name(), "Created input monitor", UVM_LOW);

        output_monitor = transmitter_output_monitor::type_id::create("output_monitor", this);
        uvm_report_info(get_name(), "Created output monitor", UVM_LOW);

        uvm_report_info(get_name(), "Finished build phase", UVM_LOW);
    endfunction : build_phase


    function void connect_phase(uvm_phase phase);
        uvm_report_info(get_name(), "Starting connect phase...", UVM_LOW);
        super.connect_phase(phase);

        driver.seq_item_port.connect(sequencer.seq_item_export);
        uvm_report_info(get_name(), "Connected driver to sequencer", UVM_LOW);

        uvm_report_info(get_name(), "Finished connect phase", UVM_LOW);
    endfunction : connect_phase

 
endclass : transmitter_agent