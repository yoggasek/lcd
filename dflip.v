module dflipflop(input DFF_CLOCK, D, output reg Q);
    always @ (posedge DFF_CLOCK) begin
        Q <= D;
    end

endmodule
