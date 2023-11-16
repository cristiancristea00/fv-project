

class transmitter_sequence extends uvm_sequence#(transmitter_seq_item);
   `uvm_object_utils(transmitter_sequence)
   
   rand int        nr_of_transfers;
   rand bit [7:0]  data;
   rand bit        wen;
   
   transmitter_seq_item transfer;
   
   function new(string name= "transmitter_sequence");
      super.new(name);
   endfunction
   
   task body();
      transfer = transmitter_seq_item::type_id::create("transfer");
      repeat(nr_of_transfers) begin
         
         start_item(transfer);
         transfer.randomize() with { transfer.data         == data;
                                     transfer.full_thr     == 32;
                                     transfer.baud_sel     == 0;
                                     transfer.write_enable == wen; };
         finish_item(transfer);
      end
         start_item(transfer);
         transfer.write_enable = 0;
         finish_item(transfer);
   
   endtask: body


endclass: transmitter_seq_item
