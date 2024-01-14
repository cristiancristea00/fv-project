class transmitter_basic_test extends transmitter_test_base;

	`uvm_component_utils(transmitter_basic_test)

	function new(string name = "transmitter_basic_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new


	transmitter_baud_sequence bus_baud_sequence;
	

	virtual function void build_phase(uvm_phase phase);
		uvm_report_info(get_name(), "Starting build phase...", UVM_DEBUG);
		super.build_phase(phase);

		bus_baud_sequence = new("bus_baud_sequence", `TRANSFERS_PER_BAUDRATE);
		uvm_report_info(get_name(), "Created bus sequence for baudrate select", UVM_DEBUG);

		uvm_report_info(get_name(), "Finished build phase", UVM_DEBUG);
	endfunction: build_phase


	virtual function void connect_phase(uvm_phase phase);
		uvm_report_info(get_name(), "Starting connect phase...", UVM_DEBUG);
		super.connect_phase(phase);
		uvm_report_info(get_name(), "Finished connect phase", UVM_DEBUG);
	endfunction: connect_phase


	virtual task run_phase(uvm_phase phase);
		uvm_report_info(get_name(), "Starting run phase...", UVM_DEBUG);
		phase.raise_objection(this);

		bus_baud_sequence.start(environment.agent.sequencer);

		phase.drop_objection(this);
		uvm_report_info(get_name(), "Finished run phase", UVM_DEBUG);
	endtask: run_phase


endclass: transmitter_basic_test
