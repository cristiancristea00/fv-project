class transmitter_test_base extends uvm_test;

	`uvm_component_utils(transmitter_test_base)
	
	virtual sys_itf sys_if;
   

	function new(string name= "transmitter_test_base", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new


	// Phase used to instantiate objects thorugh the UVM_FACTORY using the <class>::type_id::create(<name>, <parent>) method
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction: build_phase


	// Phase used to connect pointers inside the evnironment and to bring pointerss from the UVM_CONFIG_DB
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		// Get the interface from the UVM_CONFIG_DB
		if (!uvm_config_db#(virtual sys_itf)::get(null, "*", "sys_if", sys_if)) begin
			`uvm_fatal("transmitter_basic_test", "Error in getting sys_if from UVM_CONFIG_DB")
		end
	endfunction: connect_phase

	// Phase used to run the test
	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);

		sys_if.init_inputs();
		sys_if.reset(5);

		phase.drop_objection(this);
	endtask: run_phase


endclass: transmitter_test_base
