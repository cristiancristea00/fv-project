class transmitter_input_monitor extends uvm_monitor;

	`uvm_component_utils(transmitter_input_monitor)


	function new(string name = "transmitter_input_monitor", uvm_component parent = null);
		super.new(name, parent);
	endfunction


	uvm_analysis_port#(transmitter_sequence_item) input_monitor_ap;

	virtual uart_transmitter_interface system_interface;

	local uvm_printer printer;


	virtual function void build_phase(uvm_phase phase);
		uvm_report_info(get_name(), "Starting build phase...", UVM_DEBUG);
		super.build_phase(phase);

		input_monitor_ap = new("input_monitor_ap", this);
		uvm_report_info(get_name(), "Created input monitor analysis port", UVM_DEBUG);

		uvm_report_info(get_name(), "Finished build phase", UVM_DEBUG);
	endfunction: build_phase


	virtual function void connect_phase(uvm_phase phase);
		uvm_report_info(get_name(), "Starting connect phase...", UVM_DEBUG);
		super.connect_phase(phase);

		if (!uvm_config_db#(virtual uart_transmitter_interface)::get(null, "*", "system_interface", system_interface)) begin
			`uvm_fatal(get_name(), "Error in getting system interface from the UVM Configuration Database")
		end
        uvm_report_info(get_name(), "Got system interface from UVM Configuration Database", UVM_DEBUG);

		if (!uvm_config_db#(uvm_printer)::get(this, "*", "printer", printer)) begin
            `uvm_fatal(get_name(), "Error in getting printer from the UVM Configuration Database")
        end
        uvm_report_info(get_name(), "Got printer from UVM Configuration Database", UVM_DEBUG);

		uvm_report_info(get_name(), "Finished connect phase", UVM_DEBUG);
	endfunction: connect_phase


	task run_phase(uvm_phase phase);
		uvm_report_info(get_name(), "Starting run phase...", UVM_DEBUG);

		uvm_report_info(get_name(), "Started input monitoring thread", UVM_DEBUG);
		monitor_input();

		uvm_report_info(get_name(), "Finished run phase", UVM_DEBUG);
	endtask: run_phase


	protected task monitor_input();
		transmitter_sequence_item input_transfer;

		forever begin
			system_interface.wait_clock_pos();

			if (system_interface.reset == 0) begin
				system_interface.wait_until_reset_high();
				continue;
			end

			input_transfer = get_transfer();

			if (input_transfer.write_enable == 0 || system_interface.buffer_full == 1) begin
				continue;
			end

			uvm_report_info(get_name(), "Got new transfer on the input bus", UVM_DEBUG);
			print_transfer(input_transfer, printer);
			input_monitor_ap.write(input_transfer);
		end
	endtask: monitor_input


	protected function transmitter_sequence_item get_transfer();
		transmitter_sequence_item input_transfer = transmitter_sequence_item::type_id::create("input_transfer");

		input_transfer.data                  = system_interface.data;
		input_transfer.write_enable          = system_interface.write_enable;
		input_transfer.buffer_full_threshold = system_interface.buffer_full_threshold;
		input_transfer.baudrate_select       = system_interface.baudrate_select;

		return input_transfer;
	endfunction: get_transfer

	
endclass: transmitter_input_monitor
