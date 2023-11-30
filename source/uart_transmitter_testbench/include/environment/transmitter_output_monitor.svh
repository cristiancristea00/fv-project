class transmitter_output_monitor extends uvm_monitor;
	
    `uvm_component_utils(transmitter_output_monitor)

    // uvm_analysis_port#(uart_sequence_item) mon_ap;
    // uvm_analysis_port#(bit) start_of_frame_ap;

    // uart_sequence_item data_pkg; 

    virtual uart_transmitter_interface system_interface;

    local event rst_e;
    local event end_of_reset_e;

    function new(string name = "transmitter_output_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // mon_ap= new("mon_ap", this);
        // start_of_frame_ap= new("start_of_frame_ap", this);
        // data_pkg= uart_sequence_item::type_id::create("data_pkg", this);
    endfunction: build_phase


    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        assert( uvm_config_db#(virtual uart_transmitter_interface)::get(this, "*", "system_interface", system_interface) );
    endfunction: connect_phase


    task run_phase(uvm_phase phase);

    endtask: run_phase

    // Task used to recover serial data from the TX wire
    protected task recover_data();
        

    endtask: recover_data

    // Task used to wait the length of 1 baud
    protected task wait_one_baud(bit [6:0] baud_sel);

    endtask: wait_one_baud

    // Task used to determine the length of 1 baud
    local function int get_divison_factor(bit [1:0] baud_sel);

    endfunction: get_divison_factor

    // Task used to check the length of 1 baud
    local task check_baud_len(bit [7:0] baud_len);


    endtask: check_baud_len

    
endclass: transmitter_output_monitor
