

class transmitter_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(transmitter_scoreboard)
   
   // Declare your variables/objects below
   
   function new(string name = "transmitter_scoreboard", uvm_component parent = null);
      super.new(name, parent);
   endfunction
   
   // Use this face to instantiate objects
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

   endfunction: build_phase
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
   endfunction: connect_phase


endclass: transmitter_scoreboard
