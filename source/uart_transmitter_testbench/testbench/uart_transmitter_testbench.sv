import uvm_pkg::*; 

import test_pkg::*;

  
module uart_transmitter_testbench;

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
		uvm_config_db#(virtual uart_transmitter_interface)::set(null, "*", "system_interface", system_interface);
		
		run_test();
		$stop;
	end


endmodule
