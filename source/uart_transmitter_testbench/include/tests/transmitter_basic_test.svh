class transmitter_basic_test extends transmitter_test_base;

	`uvm_component_utils(transmitter_basic_test)

	function new(string name = "transmitter_basic_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new


	transmitter_sequence bus_sequence_clk16;
	transmitter_sequence bus_sequence_clk32;
	transmitter_sequence bus_sequence_clk64;
	transmitter_sequence bus_sequence_clk128;
	

	virtual function void build_phase(uvm_phase phase);
		uvm_report_info(get_name(), "Starting build phase...", UVM_DEBUG);
		super.build_phase(phase);

		bus_sequence_clk16 = new("bus_sequence_clk16", BAUD_CLK16, `TRANSFERS_PER_BAUDRATE);
		uvm_report_info(get_name(), "Created bus sequence for CLK/16 baudrate select", UVM_DEBUG);

		bus_sequence_clk32 = new("bus_sequence_clk32", BAUD_CLK32, `TRANSFERS_PER_BAUDRATE);
		uvm_report_info(get_name(), "Created bus sequence for CLK/32 baudrate select", UVM_DEBUG);

		bus_sequence_clk64 = new("bus_sequence_clk64", BAUD_CLK64, `TRANSFERS_PER_BAUDRATE);
		uvm_report_info(get_name(), "Created bus sequence for CLK/64 baudrate select", UVM_DEBUG);

		bus_sequence_clk128 = new("bus_sequence_clk128", BAUD_CLK128, `TRANSFERS_PER_BAUDRATE);
		uvm_report_info(get_name(), "Created bus sequence for CLK/128 baudrate select", UVM_DEBUG);

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

		bus_sequence_clk16.start(environment.agent.sequencer);
		#DELAY_CLK16;
		bus_sequence_clk32.start(environment.agent.sequencer);
		#DELAY_CLK32;
		bus_sequence_clk64.start(environment.agent.sequencer);
		#DELAY_CLK64;
		bus_sequence_clk128.start(environment.agent.sequencer);
		#DELAY_CLK128;

		phase.drop_objection(this);
		uvm_report_info(get_name(), "Finished run phase", UVM_DEBUG);
	endtask: run_phase


endclass: transmitter_basic_test
