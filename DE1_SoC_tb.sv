

module DE1_SoC_tb ();

    logic        CLOCK_50;
    logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    logic [9:0]  LEDR;
    logic [3:0]  KEY;
    logic [9:0]  SW;

    DE1_SoC dut (.*);

    parameter CLOCK_PERIOD = 100;

    initial begin
        CLOCK_50 = 0;
        forever #(CLOCK_PERIOD/2) CLOCK_50 = ~CLOCK_50;
    end

    
    task press_right();
        begin
            KEY[0] = 0; @(posedge CLOCK_50);
            KEY[0] = 1; @(posedge CLOCK_50);
                        @(posedge CLOCK_50);
                        @(posedge CLOCK_50);
                        @(posedge CLOCK_50);
        end
    endtask

    
    task press_left();
        begin
            KEY[3] = 0; @(posedge CLOCK_50);
            KEY[3] = 1; @(posedge CLOCK_50);
                        @(posedge CLOCK_50);
                        @(posedge CLOCK_50);
                        @(posedge CLOCK_50);
        end
    endtask

    initial begin

        
        SW = 10'b0;
        KEY = 4'b1111;

        
        SW[9] = 1; @(posedge CLOCK_50);
        SW[9] = 0; @(posedge CLOCK_50);
                   @(posedge CLOCK_50);
                   @(posedge CLOCK_50);

        
        press_right();
        press_right();
        press_right();
        press_right();   
                    @(posedge CLOCK_50);
                    @(posedge CLOCK_50);

        
        SW[9] = 1; @(posedge CLOCK_50);
        SW[9] = 0; @(posedge CLOCK_50);
                   @(posedge CLOCK_50);

        
        press_left();
        press_left();
        press_left();
        press_left();   
                    @(posedge CLOCK_50);
                    @(posedge CLOCK_50);

        $stop;
    end

endmodule
