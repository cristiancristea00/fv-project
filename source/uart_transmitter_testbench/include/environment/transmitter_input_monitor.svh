class transmitter_input_monitor extends uvm_monitor;

	`uvm_component_utils(transmitter_input_monitor)

	// uvm_analysis_port#(transmitter_sequence_item) mon_ap;


	virtual uart_transmitter_interface system_interface;

	local event rst_e;
	local event end_of_rst_e;

	function new(string name = "transmitter_input_monitor", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		// mon_ap= new("mon_ap", this);
		
	endfunction: build_phase

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		assert( uvm_config_db#(virtual uart_transmitter_interface)::get(this, "*", "system_interface", system_interface) );
	endfunction: connect_phase

	task run_phase(uvm_phase phase);
		
	endtask: run_phase

	protected task recover_data();



	endtask: recover_data

	
endclass: transmitter_input_monitor
