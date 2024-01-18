class transmitter_basic_test extends transmitter_base_test;

	`uvm_component_utils(transmitter_basic_test)

	function new(string name = "transmitter_basic_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new


	transmitter_baud_sequence bus_baud_sequence;
	transmitter_threshold_sequence bus_threshold_sequence;
	

	virtual function void build_phase(uvm_phase phase);
		`uvm_info("STEP", "Starting build phase...", UVM_DEBUG)

		super.build_phase(phase);

		bus_baud_sequence = transmitter_baud_sequence::type_id::create("bus_baud_sequence");
		`uvm_info("STEP", "Created bus sequence for baudrate select", UVM_DEBUG)

		bus_threshold_sequence = transmitter_threshold_sequence::type_id::create("bus_threshold_sequence");
		`uvm_info("STEP", "Created bus sequence for buffer full threshold", UVM_DEBUG)

		`uvm_info("STEP", "Finished build phase", UVM_DEBUG)
	endfunction: build_phase


	virtual function void connect_phase(uvm_phase phase);
		`uvm_info("STEP", "Starting connect phase...", UVM_DEBUG)

		super.connect_phase(phase);

		`uvm_info("STEP", "Finished connect phase", UVM_DEBUG)
	endfunction: connect_phase


	virtual task run_phase(uvm_phase phase);
		`uvm_info("STEP", "Starting run phase...", UVM_DEBUG)

		phase.raise_objection(this);

		`uvm_info("STEP", "Starting baudrate select sequence", UVM_DEBUG)
		bus_baud_sequence.start(environment.input_agent.sequencer);

		`uvm_info("STEP", "Starting buffer full threshold sequence", UVM_DEBUG)
		bus_threshold_sequence.start(environment.input_agent.sequencer);

		phase.drop_objection(this);
		
		`uvm_info("STEP", "Finished run phase", UVM_DEBUG)
	endtask: run_phase


endclass: transmitter_basic_test
