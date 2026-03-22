module centerLight (input logic clk, reset,
                    input logic left_press, right_press,
                    input logic left_neighbor, right_neighbor,
                    output logic light);
    
    enum logic {OFF, ON} ps, ns;
    always_comb begin
        case (ps)
            OFF: begin
                
                if ((left_neighbor && left_press) || (right_neighbor && right_press))
                    ns = ON;
                else
                    ns = OFF;
            end
            
            ON: begin
                
                if ((left_press && !left_neighbor) || (right_press && !right_neighbor))
                    ns = OFF;
                else
                    ns = ON;
            end
            
            default: ns = ON;
        endcase
    end
    
    always_ff @(posedge clk)
        ps <= reset ? ON : ns;
    
    assign light = (ps == ON);
    
endmodule 