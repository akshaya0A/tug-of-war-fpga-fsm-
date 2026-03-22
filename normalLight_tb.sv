module normalLight_tb ();

    logic clk, reset;
    logic left_press, right_press;
    logic left_neighbor, right_neighbor;
    logic light;

    
    normalLight dut (.*);

    parameter CLOCK_PERIOD = 100;

    initial begin
        clk = 0;
        forever #(CLOCK_PERIOD/2) clk = ~clk;
    end

    initial begin
        reset = 1;
        left_press = 0;
        right_press = 0;
        left_neighbor = 0;
        right_neighbor = 0;
        @(posedge clk);
        reset = 0;
        @(posedge clk);
        right_press = 1;@(posedge clk);
        right_press = 0;@(posedge clk);
        left_neighbor = 1;
        right_press = 1;@(posedge clk);
        right_press = 0;@(posedge clk);
        @(posedge clk);
        @(posedge clk);
        left_press = 1;
        right_press = 1;@(posedge clk);
        left_press = 0;
        right_press = 0;@(posedge clk);
        left_neighbor = 0;
        right_press = 1;@(posedge clk);
        right_press = 0;@(posedge clk);
        right_neighbor = 1;
        left_press = 1;@(posedge clk);
        left_press = 0;@(posedge clk);
        right_neighbor = 0;
        left_press = 1;@(posedge clk);
        left_press = 0;@(posedge clk);
        left_neighbor = 1;
        right_press = 1;@(posedge clk);
        right_press = 0;@(posedge clk);
        reset = 1;@(posedge clk);
        reset = 0;@(posedge clk);
        left_neighbor = 0;
        @(posedge clk);
        $stop;
    end

endmodule
