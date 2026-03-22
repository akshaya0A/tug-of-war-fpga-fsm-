module victory (input logic clk, reset,
                input logic left_press, right_press,
                input logic leftmost_light, rightmost_light,
                output logic [6:0] hex_out);
    
    enum logic [1:0] {PLAY, PLAYER1_WINS, PLAYER2_WINS} ps, ns;
    
    always_comb begin
        case (ps)
            PLAY: begin
                if (rightmost_light & ~leftmost_light)
                    ns = PLAYER1_WINS;
                
                else if (leftmost_light & ~rightmost_light)
                    ns = PLAYER2_WINS;
                else
                    ns = PLAY;
            end
            PLAYER1_WINS: ns = PLAYER1_WINS;
            PLAYER2_WINS: ns = PLAYER2_WINS;
            default: ns = PLAY;
        endcase
    end
    
    always_ff @(posedge clk)
        ps <= reset ? PLAY : ns;
    
    always_comb begin
        case (ps)
            PLAYER1_WINS: hex_out = 7'b1111001; 
            PLAYER2_WINS: hex_out = 7'b0010010; 
            default:      hex_out = 7'b1111111; 
        endcase
    end

endmodule