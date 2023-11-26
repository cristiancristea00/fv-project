

class transmitter_seq_item extends uvm_sequence_item;
   `uvm_object_utils(transmitter_seq_item)
   
   function new(string name= "transmitter_seq_item");
      super.new(name);
   endfunction

endclass: transmitter_seq_item
