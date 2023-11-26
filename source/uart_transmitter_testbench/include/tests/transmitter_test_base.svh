class transmitter_test_base extends uvm_test;

	`uvm_component_utils(transmitter_test_base)
   
	function new(string name= "transmitter_test_base", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new


	virtual uart_transmitter_interface system_interface;


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction: build_phase


	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		if (!uvm_config_db#(virtual uart_transmitter_interface)::get(null, "*", "system_interface", system_interface)) begin
			`uvm_fatal("transmitter_test_base", "Error in getting system_interface from UVM_CONFIG_DB")
		end
	endfunction: connect_phase


	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);

		system_interface.init_inputs();
		system_interface.reset_module(5);

		phase.drop_objection(this);
	endtask: run_phase


endclass: transmitter_test_base
