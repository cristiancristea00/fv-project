class transmitter_sequencer extends uvm_sequencer#(transmitter_sequence_item);
   
    `uvm_component_utils(transmitter_sequencer)

    function new(string name = "transmitter_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass: transmitter_sequencer