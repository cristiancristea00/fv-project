class transmitter_basic_test extends transmitter_test_base;

	`uvm_component_utils(transmitter_basic_test)

	function new(string name= "transmitter_basic_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new
	

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction: build_phase


	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	endfunction: connect_phase


	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);

		phase.raise_objection(this);

		this.system_interface.write_data(8'h55);
		#10000;
		this.system_interface.write_data(8'hAA);
		#10000;
		this.system_interface.write_data(8'h00);
		#10000;
		this.system_interface.write_data(8'hFF);
		#10000;
		this.system_interface.write_data(8'h10);
		#10000;

		phase.drop_objection(this);
	endtask: run_phase



endclass: transmitter_basic_test
