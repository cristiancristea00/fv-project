module uart_transmitter_testbench;

	import uvm_pkg::*; 

	`include "uvm_macros.svh"

	import tests_pkg::*;
	

	bit clock;

	initial begin
		clock = 0;
		forever begin
			#10 clock = ~clock;
		end
	end

	uart_transmitter_interface system_interface(clock);

	uart_transmitter_dut dut(system_interface);

	
	initial begin
		`uvm_info("uart_transmitter_testbench", "########## Started testbench ##########", UVM_LOW)

		uvm_config_db#(virtual uart_transmitter_interface)::set(null, "*", "system_interface", system_interface);
		`uvm_info("uart_transmitter_testbench", "Set system interface in UVM_CONFIG_DB", UVM_LOW)
		
		run_test();
		$stop;
	end


endmodule: uart_transmitter_testbench
