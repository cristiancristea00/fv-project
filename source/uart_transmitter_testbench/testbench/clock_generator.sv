module clock_generator(
    output bit clock
);

    initial begin
        clock = 0;
        forever begin
            #10 clock = ~clock;
        end
    end

endmodule: clock_generator