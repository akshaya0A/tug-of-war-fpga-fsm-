module victory_tb ();

  logic clk, reset;
  logic left_press, right_press;
  logic leftmost_light, rightmost_light;
  logic [6:0] hex_out;

  victory dut (.*);

  
  parameter CLOCK_PERIOD = 100;
  initial begin
    clk = 0;
    forever #(CLOCK_PERIOD/2) clk = ~clk;
  end

  
  initial begin
    reset = 1;
    left_press = 0;
    right_press = 0;
    leftmost_light = 0;
    rightmost_light = 0;
    @(posedge clk);
    reset = 0;
    @(posedge clk);   
    left_press = 1; @(posedge clk);
    left_press = 0; @(posedge clk);

    right_press = 1; @(posedge clk);
    right_press = 0; @(posedge clk);
    
    rightmost_light = 1;
    @(posedge clk);
    @(posedge clk);   
    
    rightmost_light = 0;
    @(posedge clk);
    @(posedge clk);   
    reset = 1;
    @(posedge clk);
    reset = 0;
    @(posedge clk);   
    leftmost_light = 1;
    @(posedge clk);
    @(posedge clk);     
    leftmost_light = 0;
    @(posedge clk);
    @(posedge clk);   
    reset = 1;
    @(posedge clk);
    reset = 0;
    @(posedge clk);

    $stop;
  end

endmodule
