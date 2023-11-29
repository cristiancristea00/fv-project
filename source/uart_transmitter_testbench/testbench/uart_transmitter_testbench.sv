module uart_transmitter_testbench;

	import uvm_pkg::*; 

	`include "uvm_macros.svh"

	import tests_pkg::*;


	uart_transmitter_interface system_interface();
	uart_transmitter_dut dut(system_interface);

	
	initial begin
		uvm_report_info("uart_transmitter_testbench", "########## Started testbench ##########", UVM_LOW);

		uvm_config_db#(virtual uart_transmitter_interface)::set(null, "*", "system_interface", system_interface);
		uvm_report_info("uart_transmitter_testbench", "Set system interface into UVM Configuration Database", UVM_LOW);
		
		run_test();
	end


endmodule: uart_transmitter_testbench
