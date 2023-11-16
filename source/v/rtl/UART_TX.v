module UART_TX(
    input clock,
    input reset_n,
    input tx_start,
    input tx_baud,
    input [7:0] data_in,
    output reg tx_done,
    output reg tx
    );
    
localparam IDLE = 2'b00;
localparam START = 2'b01;
localparam DATA = 2'b10;
localparam STOP = 2'b11;  

reg [1:0] state, state_next;
reg tx_next;
reg [8:0] buffer_in, buffer_in_next;
wire control;
reg [3:0] bit_counter, bit_counter_next;

assign control = &data_in;

always@(posedge clock) begin
    if(~reset_n) begin
        state <= IDLE;
        tx <= 1'b1;
        buffer_in <= 0;
        bit_counter <= 0;
    end else begin
        state <= state_next;
        tx <= tx_next;
        buffer_in <= buffer_in_next;
        bit_counter <= bit_counter_next;
    end
end

always@(*) begin
    tx_next = tx;
    tx_done = 1'b0;
    buffer_in_next = buffer_in;
    case(state)
        IDLE:   begin
                    tx_next = 1'b1;
                    if(tx_start) begin  
                        buffer_in_next = {control, data_in};
                    end
                end
        START:  begin
                    tx_next = 1'b0;       
                end
        DATA:   begin
                    tx_next = buffer_in[0];
                    if(tx_baud) begin
                        buffer_in_next = buffer_in >> 2;     
                    end        
                end
        STOP:   begin
                    tx_next = 1'b1;
                    if(tx_baud) begin
                        tx_done = 1'b1;   
                    end        
                end
    endcase
end

always@(*) begin
    state_next = state;
    bit_counter_next = bit_counter;
    case(state)
        IDLE:   begin
                    if(tx_start & tx_baud) begin  
                        state_next = START;
                    end
                end
        START:  begin
                    if(tx_baud) begin
                        state_next = DATA;
                        bit_counter_next = 1'b0;        
                    end        
                end
        DATA:   begin
                    if(tx_baud) begin
                        if(bit_counter == 8)
                            state_next = STOP;
                        bit_counter_next = bit_counter + 1;        
                    end        
                end
        STOP:   begin
                    if(tx_baud) begin
                        state_next = IDLE;
                    end        
                end
    endcase
end
  
endmodule
