module TX_BAUD_GEN(
    input clock,
    input reset_n,
    input [1:0] baudrate_select,
    output reg tx_baud
    );
    
reg [6:0] counter;

always@(posedge clock) begin
    if(~reset_n)
        counter <= 0;
    else 
        counter <= counter + 1;
end    

always@(*) begin
    case(baudrate_select)
        2'b00: tx_baud = counter[3:0] == 4'b1111;
        2'b01: tx_baud = counter[4:0] == 5'b11111;
        2'b10: tx_baud = counter[5:0] == 6'b111111;
        2'b11: tx_baud = counter[6:0] == 7'b1111111;
        default: tx_baud = counter[0]; 
    endcase
end    
    
endmodule
