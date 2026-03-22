module synch (input logic clk, reset, in, output logic out);
    logic mid; 
    
    always_ff @(posedge clk)
        if (reset)
            {mid, out} <= 2'b00;
        else
            {mid, out} <= {in, mid};
endmodule 