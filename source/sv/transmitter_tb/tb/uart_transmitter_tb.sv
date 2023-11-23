import uvm_pkg::*; 

import test_pkg::*;

  
module uart_transmitter_tb;

	bit clock;

	// Generate clock signal here or as a separate module
	initial begin
		clock = 0;
		forever begin
			#10 clock = ~clock;
		end
	end

	// Connect all the required signals below
	sys_itf sys_if(clock);

	uart_transmitter_dut dut(sys_if);

	// Upload the interface to the UVM_CONFIG_DB here
	initial begin
		uvm_config_db#(virtual sys_itf)::set(null, "*", "sys_if", sys_if);
		
		run_test();
		$stop;
	end


endmodule
