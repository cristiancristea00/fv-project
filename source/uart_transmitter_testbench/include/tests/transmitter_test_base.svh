class transmitter_test_base extends uvm_test;

	`uvm_component_utils(transmitter_test_base)
   
	function new(string name = "transmitter_test_base", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new


	transmitter_environment environment;


	virtual function void build_phase(uvm_phase phase);
		`uvm_info("transmitter_test_base", "Starting build phase...", UVM_LOW)
		super.build_phase(phase);

		environment = transmitter_environment::type_id::create("environment", this);
		`uvm_info("transmitter_test_base", "Created environment", UVM_LOW)

		`uvm_info("transmitter_test_base", "Finished build phase", UVM_LOW)
	endfunction: build_phase


	virtual function void connect_phase(uvm_phase phase);
		`uvm_info("transmitter_test_base", "Starting connect phase...", UVM_LOW)
		super.connect_phase(phase);
		`uvm_info("transmitter_test_base", "Finished connect phase", UVM_LOW)
	endfunction: connect_phase


endclass: transmitter_test_base
