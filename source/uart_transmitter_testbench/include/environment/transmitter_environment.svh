class transmitter_environment extends uvm_env;

	`uvm_component_utils(transmitter_environment)

	function new(string name = "transmitter_environment", uvm_component parent = null);
		super.new(name, parent);
	endfunction


	transmitter_agent agent;

	transmitter_scoreboard scoreboard;


	virtual function void build_phase(uvm_phase phase);
		uvm_report_info(get_name(), "Starting build phase...", UVM_DEBUG);
		super.build_phase(phase);

		agent = transmitter_agent::type_id::create("agent", this);
		uvm_report_info(get_name(), "Created agent", UVM_DEBUG);

		scoreboard = transmitter_scoreboard::type_id::create("scoreboard", this);
		uvm_report_info(get_name(), "Created scoreboard", UVM_DEBUG);

		uvm_report_info(get_name(), "Finished build phase", UVM_DEBUG);
	endfunction: build_phase

	virtual function void connect_phase(uvm_phase phase);
		uvm_report_info(get_name(), "Starting connect phase...", UVM_DEBUG);
		super.connect_phase(phase);

		agent.input_monitor.input_monitor_ap.connect(scoreboard.transmitter_input_bus_ap);
		uvm_report_info(get_name(), "Connected input monitor to scoreboard", UVM_DEBUG);

		agent.output_monitor.output_monitor_ap.connect(scoreboard.transmitter_output_bus_ap);
		uvm_report_info(get_name(), "Connected output monitor to scoreboard", UVM_DEBUG);

		uvm_report_info(get_name(), "Finished connect phase", UVM_DEBUG);
	endfunction: connect_phase


endclass: transmitter_environment
