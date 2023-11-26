

class transmitter_agent extends uvm_agent;

  `uvm_component_utils(transmitter_agent)
  
  //Declare any variable/object below

  
//  transmitter_sequencer sequencer;  // Uncomment when we reach sequences
  
  function new (string name= "transmitter_agent", uvm_component parent= null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

//    sequencer   = transmitter_sequencer::type_id::create("sequencer", this); // Uncomment when we reach sequences
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // Connect driver seq_item port to sequencer seq_item_export
    
  endfunction : connect_phase
 
endclass : transmitter_agent
