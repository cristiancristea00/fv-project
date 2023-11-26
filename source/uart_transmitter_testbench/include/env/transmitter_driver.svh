

class transmitter_driver extends uvm_driver#(transmitter_seq_item);
	`uvm_component_utils(transmitter_driver)
   
   transmitter_seq_item transfer;
   
   virtual uart_transmitter_interface system_interface;
   
   local event rst_e;
   local event end_of_rst_e; 

   function new(string name= "transmitter_driver", uvm_component parent= null);
	   super.new(name, parent);
   endfunction : new
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction: build_phase
	
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
      assert( uvm_config_db#(virtual uart_transmitter_interface)::get(this, "*", "system_interface", system_interface) );
	endfunction: connect_phase
	
	task run_phase(uvm_phase phase);
   
      
	endtask: run_phase
   
   // Function used to drive the transaction values to the bus
   protected task drive_transfer(transmitter_seq_item transfer);

   endtask: drive_transfer
   
   // Function used to restore bus signal values to reset value
   function void reset_signals();

   endfunction: reset_signals

endclass : transmitter_driver
