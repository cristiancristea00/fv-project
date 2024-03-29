class transmitter_base_test extends uvm_test;

	`uvm_component_utils(transmitter_base_test)
   
	function new(string name = "transmitter_base_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new


	transmitter_environment environment;

	uvm_table_printer printer;


	virtual function void build_phase(uvm_phase phase);
		`uvm_info("STEP", "Starting build phase...", UVM_DEBUG)

		super.build_phase(phase);

		environment = transmitter_environment::type_id::create("environment", this);
		`uvm_info("STEP", "Created environment", UVM_DEBUG)

		printer = new();
		printer.knobs.type_name      = 0;
		printer.knobs.size           = 0;
		printer.knobs.indent         = 4;
		printer.knobs.dec_radix      = "";
		printer.knobs.unsigned_radix = "";
		printer.knobs.bin_radix      = "";
		printer.knobs.hex_radix      = "0x";

		uvm_config_db#(uvm_printer)::set(this, "*", "printer", printer);
		`uvm_info("STEP", "Set printer into UVM Configuration Database", UVM_DEBUG)

		`uvm_info("STEP", "Finished build phase", UVM_DEBUG)
	endfunction: build_phase


	virtual function void connect_phase(uvm_phase phase);
		`uvm_info("STEP", "Starting connect phase...", UVM_DEBUG)

		super.connect_phase(phase);
		
		`uvm_info("STEP", "Finished connect phase", UVM_DEBUG)
	endfunction: connect_phase


endclass: transmitter_base_test
