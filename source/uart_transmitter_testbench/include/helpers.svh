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


`define TRANSFERS_PER_BAUDRATE    10000
`define BASE_DELAY                50
`define TOTAL_DELAY               `BASE_DELAY * `TRANSFERS_PER_BAUDRATE


typedef enum longint {
    DELAY_CLK16  = `TOTAL_DELAY * 1,
    DELAY_CLK32  = `TOTAL_DELAY * 2,
    DELAY_CLK64  = `TOTAL_DELAY * 4,
    DELAY_CLK128 = `TOTAL_DELAY * 8
} delay_t;


function delay_t get_delay(baudrate_select_t baudrate_select);
    case (baudrate_select)
        BAUD_CLK16 : return DELAY_CLK16;
        BAUD_CLK32 : return DELAY_CLK32;
        BAUD_CLK64 : return DELAY_CLK64;
        BAUD_CLK128: return DELAY_CLK128;
    endcase
endfunction: get_delay 