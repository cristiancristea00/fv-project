typedef enum bit[1:0] {
    BAUD_CLK16  = 2'b00,
    BAUD_CLK32  = 2'b01,
    BAUD_CLK64  = 2'b10,
    BAUD_CLK128 = 2'b11
} baudrate_select_t;


function void print_transfer(uvm_sequence_item transfer, uvm_printer printer);
    if (uvm_top.get_report_verbosity_level() != UVM_DEBUG) begin
        return;
    end

    transfer.print(printer);
endfunction: print_transfer