

class transmitter_env extends uvm_env;
	`uvm_component_utils(transmitter_env)
   
   // Delcare any variable/object required here
    
    transmitter_scoreboard sb_inst;
	
	function new(string name= "transmitter_env", uvm_component parent= null);
		super.new(name, parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	  
     sb_inst    = transmitter_scoreboard::type_id::create("sb_inst", this);
	endfunction: build_phase
	
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
//      agent_inst.mon_in_inst.mon_ap.connect();
//      agent_inst.mon_out_inst.mon_ap.connect();
//      agent_inst.mon_out_inst.start_of_frame_ap.connect();
	endfunction: connect_phase

endclass: transmitter_env
