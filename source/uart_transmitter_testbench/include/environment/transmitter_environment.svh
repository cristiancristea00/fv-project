class transmitter_environment extends uvm_env;

	`uvm_component_utils(transmitter_environment)

	function new(string name = "transmitter_environment", uvm_component parent = null);
		super.new(name, parent);
	endfunction


	transmitter_agent agent;


	virtual function void build_phase(uvm_phase phase);
		uvm_report_info(get_name(), "Starting build phase...", UVM_LOW);
		super.build_phase(phase);

		agent = transmitter_agent::type_id::create("agent", this);
		uvm_report_info(get_name(), "Created agent", UVM_LOW);

		uvm_report_info(get_name(), "Finished build phase", UVM_LOW);
	endfunction: build_phase

	virtual function void connect_phase(uvm_phase phase);
		uvm_report_info(get_name(), "Starting connect phase...", UVM_LOW);
		super.connect_phase(phase);
		uvm_report_info(get_name(), "Finished connect phase", UVM_LOW);
	endfunction: connect_phase


endclass: transmitter_environment
