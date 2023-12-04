class uart_sequence_item extends uvm_sequence_item;

   `uvm_object_utils(uart_sequence_item)
   
   
   function new(string name = "uart_sequence_item");
      super.new(name);
   endfunction


   logic [10:0] uart_data;


   virtual function void do_print(uvm_printer printer);
      logic [8:0] initial_data = {uart_data[1], uart_data[2], uart_data[3], uart_data[4], uart_data[5], uart_data[6], uart_data[7], uart_data[8], uart_data[9]};
      logic [7:0] data         = uart_data[8:1];
      logic       start_bit    = uart_data[0];
      logic       stop_bit     = uart_data[10];

      string initial_data_str = $sformatf("%b", initial_data);
      string data_str         = $sformatf("%h", data);
      data_str                = $sformatf("0x%s", data_str.toupper());

      printer.print_string("initial_data", initial_data_str);
      printer.print_string("data", data_str);
      printer.print_string("start_bit", start_bit ? "True" : "False");
      printer.print_string("stop_bit", stop_bit ? "True" : "False");
   endfunction: do_print


endclass: uart_sequence_item
