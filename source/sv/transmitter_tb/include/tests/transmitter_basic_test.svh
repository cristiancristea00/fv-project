class transmitter_basic_test extends transmitter_test_base;

	`uvm_component_utils(transmitter_basic_test)

	function new(string name= "transmitter_basic_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new
	

	// Phase used to instantiate objects thorugh the UVM_FACTORY using the <class>::type_id::create(<name>, <parent>) method
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction: build_phase


	// Phase used to connect pointers inside the evnironment and to bring pointerss from the UVM_CONFIG_DB
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	endfunction: connect_phase

	// Phase used to run the test
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);

		phase.raise_objection(this);

		// TODO: Add test code here
		#10000;

		phase.drop_objection(this);
	endtask: run_phase



endclass: transmitter_basic_test
