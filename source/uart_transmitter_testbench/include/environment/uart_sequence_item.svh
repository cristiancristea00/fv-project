

class uart_sequence_item extends uvm_sequence_item;
   `uvm_object_utils(uart_sequence_item)
   
   
   function new(string name = "uart_sequence_item");
      super.new(name);
   endfunction


   logic [8:0] uart_data;



endclass: uart_sequence_item
