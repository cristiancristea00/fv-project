class transmitter_environment extends uvm_env;

	`uvm_component_utils(transmitter_environment)

	function new(string name = "transmitter_environment", uvm_component parent = null);
		super.new(name, parent);
	endfunction


	transmitter_input_agent input_agent;
	transmitter_output_agent output_agent;

	transmitter_scoreboard scoreboard;

	transmitter_input_coverage input_coverage;
	transmitter_output_coverage output_coverage;


	virtual function void build_phase(uvm_phase phase);
		`uvm_info("STEP", "Starting build phase...", UVM_DEBUG)

		super.build_phase(phase);

		input_agent = transmitter_input_agent::type_id::create("input_agent", this);
		`uvm_info("STEP", "Created input agent", UVM_DEBUG)

		output_agent = transmitter_output_agent::type_id::create("output_agent", this);
		`uvm_info("STEP", "Created output agent", UVM_DEBUG)

		scoreboard = transmitter_scoreboard::type_id::create("scoreboard", this);
		`uvm_info("STEP", "Created scoreboard", UVM_DEBUG)

		input_coverage = transmitter_input_coverage::type_id::create("input_coverage", this);
		`uvm_info("STEP", "Created input coverage", UVM_DEBUG)

		output_coverage = transmitter_output_coverage::type_id::create("output_coverage", this);
		`uvm_info("STEP", "Created output coverage", UVM_DEBUG)

		`uvm_info("STEP", "Finished build phase", UVM_DEBUG)
	endfunction: build_phase


	virtual function void connect_phase(uvm_phase phase);
		`uvm_info("STEP", "Starting connect phase...", UVM_DEBUG)

		super.connect_phase(phase);

		input_agent.input_monitor.input_monitor_ap.connect(scoreboard.transmitter_input_bus_ap);
		`uvm_info("STEP", "Connected input monitor to scoreboard", UVM_DEBUG)

		input_agent.input_monitor.input_monitor_ap.connect(input_coverage.analysis_export);
		`uvm_info("STEP", "Connected input monitor to input coverage", UVM_DEBUG)

		output_agent.output_monitor.output_monitor_ap.connect(scoreboard.transmitter_output_bus_ap);
		`uvm_info("STEP", "Connected output monitor to scoreboard", UVM_DEBUG)

		output_agent.output_monitor.output_monitor_ap.connect(output_coverage.analysis_export);
		`uvm_info("STEP", "Connected output monitor to output coverage", UVM_DEBUG)

		`uvm_info("STEP", "Finished connect phase", UVM_DEBUG)
	endfunction: connect_phase


endclass: transmitter_environment
