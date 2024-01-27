class transmitter_output_monitor extends uvm_monitor;
	
    `uvm_component_utils(transmitter_output_monitor)


    function new(string name = "transmitter_output_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction


    uvm_analysis_port#(uart_sequence_item) output_monitor_ap;

    virtual uart_transmitter_interface system_interface;

	local uvm_printer printer;


    virtual function void build_phase(uvm_phase phase);
        `uvm_info("STEP", "Starting build phase...", UVM_DEBUG)

		super.build_phase(phase);

		output_monitor_ap = new("output_monitor_ap", this);
		`uvm_info("STEP", "Created output monitor analysis port", UVM_DEBUG)

		`uvm_info("STEP", "Finished build phase", UVM_DEBUG)
    endfunction: build_phase


    virtual function void connect_phase(uvm_phase phase);
		`uvm_info("STEP", "Starting connect phase...", UVM_DEBUG)

		super.connect_phase(phase);

		if (!uvm_config_db#(virtual uart_transmitter_interface)::get(null, "*", "system_interface", system_interface)) begin
			`uvm_fatal("DATABASE", "Error in getting system interface from the UVM Configuration Database")
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

		`uvm_info("STEP", "Started output monitoring thread", UVM_DEBUG)
		monitor_output();

		`uvm_info("STEP", "Finished run phase", UVM_DEBUG)
    endtask: run_phase


    protected task monitor_output();
        uart_sequence_item output_transfer;

        forever begin
            fork
                begin: monitor_output_fork
                    system_interface.wait_for_start_of_frame();

                    get_transfer(output_transfer);
                    `uvm_info("TRANSFER", "Got new transfer on the output bus", UVM_DEBUG)
                    print_transfer(output_transfer, printer);
                    output_monitor_ap.write(output_transfer);
                end

                begin: monitor_reset_fork
                    system_interface.wait_reset_trigger();
                    `uvm_info("RESET", "Reset triggered, disabling current output transfer", UVM_DEBUG)
                    disable monitor_output_fork;
                end
            join_any

            disable fork;
        end
    endtask: monitor_output


    protected task get_transfer(output uart_sequence_item output_transfer);
        output_transfer = uart_sequence_item::type_id::create("output_transfer");

        wait_half_baud();

        for (int idx = 0; idx <= 9; ++idx) begin
            output_transfer.uart_data[idx] = system_interface.data_out;
            wait_one_baud();
        end

        output_transfer.uart_data[10] = system_interface.data_out;
    endtask: get_transfer


    protected task wait_one_baud();
        int baud_in_clocks = get_baud_in_clocks();
        repeat (baud_in_clocks) system_interface.wait_clock_pos();
    endtask: wait_one_baud


    protected task wait_half_baud();
        int baud_in_clocks = get_baud_in_clocks() / 2;
        repeat (baud_in_clocks) system_interface.wait_clock_pos();
    endtask: wait_half_baud


    local function int get_baud_in_clocks();
        case (system_interface.baudrate_select)
            BAUD_CLK16 : return 16;
            BAUD_CLK32 : return 32;
            BAUD_CLK64 : return 64;
            BAUD_CLK128: return 128;
        endcase
    endfunction: get_baud_in_clocks

    
endclass: transmitter_output_monitor
