

`uvm_analysis_imp_decl(_tx_sof_ap)
`uvm_analysis_imp_decl(_tx_bus_ap)
`uvm_analysis_imp_decl(_input_bus_ap)

class transmitter_model extends uvm_scoreboard;
   `uvm_component_utils(transmitter_model)
   
   uvm_analysis_imp_tx_sof_ap#(bit, transmitter_model) transmitter_tx_sof_ap_h;
   uvm_analysis_imp_tx_bus_ap#(uart_seq_item, transmitter_model) transmitter_tx_bus_ap_h;
   uvm_analysis_imp_input_bus_ap#(transmitter_sequence_item, transmitter_model) transmitter_input_bus_ap_h;
   
   virtual interface uart_transmitter_interface system_interface;
   

   bit [7:0] poped_val; 
   
   //Add cover groups below if you opt not to build transmitter_coverage class
   
   function new(string name = "transmitter_model", uvm_component parent = null);
      super.new(name, parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      transmitter_tx_sof_ap_h    = new("transmitter_tx_sof_ap_h", this);
      transmitter_tx_bus_ap_h    = new("transmitter_tx_bus_ap_h", this);
      transmitter_input_bus_ap_h = new("transmitter_input_bus_ap_h", this);
   endfunction: build_phase
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      assert( uvm_config_db#(virtual uart_transmitter_interface)::get(this, "*", "system_interface", system_interface) );
   endfunction: connect_phase
   
   task run_phase(uvm_phase phase);
   
   endtask: run_phase
   
   // Function used to model data getting into the fifo. Also used to check the value of "full_output"
   virtual function void write_input_bus_ap(transmitter_sequence_item transfer);
      uvm_report_info(get_name(), $sformatf("Input bus ap write triggered"), UVM_LOW );
      
   endfunction: write_input_bus_ap
   
   // Function used to model data getting of the FIFO. Also used to check the corecteness of parity bit of UART_DATA_PKG
   virtual function void write_tx_bus_ap(uart_seq_item transfer);
      uvm_report_info(get_name(), $sformatf("End of TX frame ap triggered"), UVM_LOW);
   endfunction: write_tx_bus_ap
   
   // Function used as hook for things that should happen at the start of UART_DATA_PKG
   virtual function void write_tx_sof_ap(bit start);
      uvm_report_info(get_name(), $sformatf("TX sof ap triggered"), UVM_LOW);
   endfunction: write_tx_sof_ap
   

endclass: transmitter_model
