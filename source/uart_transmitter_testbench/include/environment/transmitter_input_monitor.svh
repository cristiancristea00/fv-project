class transmitter_input_monitor extends uvm_monitor;

	`uvm_component_utils(transmitter_input_monitor)


	function new(string name = "transmitter_input_monitor", uvm_component parent = null);
		super.new(name, parent);
	endfunction


	uvm_analysis_port#(transmitter_sequence_item) input_monitor_ap;

	virtual uart_transmitter_interface system_interface;

	local uvm_printer printer;


	virtual function void build_phase(uvm_phase phase);
		`uvm_info("STEP", "Starting build phase...", UVM_DEBUG)

		super.build_phase(phase);

		input_monitor_ap = new("input_monitor_ap", this);
		`uvm_info("STEP", "Created input monitor analysis port", UVM_DEBUG)

		`uvm_info("STEP", "Finished build phase", UVM_DEBUG)
	endfunction: build_phase


	virtual function void connect_phase(uvm_phase phase);
		`uvm_info("STEP", "Starting connect phase...", UVM_DEBUG)

		super.connect_phase(phase);

		if (!uvm_config_db#(virtual uart_transmitter_interface)::get(null, "*", "system_interface", system_interface)) begin
			`uvm_fatal("DATABSE", "Error in getting system interface from the UVM Configuration Database")
		end
        `uvm_info("STEP", "Got system interface from UVM Configuration Database", UVM_DEBUG)

		if (!uvm_config_db#(uvm_printer)::get(this, "*", "printer", printer)) begin
            `uvm_fatal("DATABASE", "Error in getting printer from the UVM Configuration Database")
        end
        `uvm_info("STEP", "Got printer from UVM Configuration Database", UVM_DEBUG)

		`uvm_info("STEP", "Finished connect phase", UVM_DEBUG)
	endfunction: connect_phase


	task run_phase(uvm_phase phase);
		`uvm_info("STEP", "Starting run phase...", UVM_DEBUG)

		`uvm_info("STEP", "Started input monitoring thread", UVM_DEBUG)
		monitor_input();

		`uvm_info("STEP", "Finished run phase", UVM_DEBUG)
	endtask: run_phase


	protected task monitor_input();
		transmitter_sequence_item input_transfer;

		forever begin
			system_interface.wait_clock_pos();

			input_transfer = get_transfer();

			if (input_transfer.reset == 0) begin
				process_transfer(input_transfer, "reset");
				system_interface.wait_reset_clear();
				continue;
			end

			if (input_transfer.write_enable == 0 || system_interface.buffer_full == 1) begin
				continue;
			end

			process_transfer(input_transfer);
		end
	endtask: monitor_input


	protected function process_transfer(transmitter_sequence_item transfer, string log_type = "transfer");
		if (log_type == "reset") begin
			`uvm_info("TRANSFER", "Got new reset transfer on the input bus", UVM_DEBUG)
		end 
		else if (log_type == "transfer") begin
			`uvm_info("TRANSFER", "Got new transfer on the input bus", UVM_DEBUG)
		end
		else begin
			`uvm_fatal("TRANSFER", "Unknown transfer type")
		end

		print_transfer(transfer, printer);
		input_monitor_ap.write(transfer);
	endfunction: process_transfer


	protected function transmitter_sequence_item get_transfer();
		transmitter_sequence_item input_transfer = transmitter_sequence_item::type_id::create("input_transfer");

		input_transfer.reset                 = system_interface.reset;
		input_transfer.data                  = system_interface.data;
		input_transfer.write_enable          = system_interface.write_enable;
		input_transfer.buffer_full_threshold = system_interface.buffer_full_threshold;
		input_transfer.baudrate_select       = system_interface.baudrate_select;

		return input_transfer;
	endfunction: get_transfer

	
endclass: transmitter_input_monitor
