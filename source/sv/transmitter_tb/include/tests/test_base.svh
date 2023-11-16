

class test_base extends uvm_test;
	`uvm_component_utils(test_base)
	
  // Declare any required variable/object here
   

	function new(string name= "test_base", uvm_component parent= null);
		super.new(name, parent);
	endfunction
	
  // Phase used to instantiate objects thorugh the UVM_FACTORY using the <class>::type_id::create(<name>, <parent>) method
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

	endfunction: build_phase
	
  // Phase used to connect pointers inside the evnironment and to bring pointerss from the UVM_CONFIG_DB
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
      
	endfunction: connect_phase

endclass: test_base
