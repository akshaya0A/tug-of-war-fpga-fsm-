module DE1_SoC ( 
  input  logic       CLOCK_50,
  output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
  output logic [9:0] LEDR,
  input  logic [3:0] KEY,
  input  logic [9:0] SW
);

  logic reset, keyLeft, keyRight;
  logic leftInput, rightInput;
  logic leftSync, rightSync;
  logic [6:0] winResult;
  logic [9:1] LEDS;

  assign reset    = SW[9];
  assign keyLeft  = ~KEY[3];
  assign keyRight = ~KEY[0];

  
  synch syncLeft  (.clk(CLOCK_50), .reset(reset), .in(keyLeft),  .out(leftSync));
  synch syncRight (.clk(CLOCK_50), .reset(reset), .in(keyRight), .out(rightSync));

  
  edgeDetect edgeLeft  (.clk(CLOCK_50), .reset(reset), .in(leftSync),  .out(leftInput));
  edgeDetect edgeRight (.clk(CLOCK_50), .reset(reset), .in(rightSync), .out(rightInput));

  
  normalLight light1 (.clk(CLOCK_50), .reset(reset), .left_press(leftInput), .right_press(rightInput), .left_neighbor(1'b0),    .right_neighbor(LEDS[2]), .light(LEDS[1]));
  normalLight light2 (.clk(CLOCK_50), .reset(reset), .left_press(leftInput), .right_press(rightInput), .left_neighbor(LEDS[1]), .right_neighbor(LEDS[3]), .light(LEDS[2]));
  normalLight light3 (.clk(CLOCK_50), .reset(reset), .left_press(leftInput), .right_press(rightInput), .left_neighbor(LEDS[2]), .right_neighbor(LEDS[4]), .light(LEDS[3]));
  normalLight light4 (.clk(CLOCK_50), .reset(reset), .left_press(leftInput), .right_press(rightInput), .left_neighbor(LEDS[3]), .right_neighbor(LEDS[5]), .light(LEDS[4]));
  centerLight light5 (.clk(CLOCK_50), .reset(reset), .left_press(leftInput), .right_press(rightInput), .left_neighbor(LEDS[4]), .right_neighbor(LEDS[6]), .light(LEDS[5]));
  normalLight light6 (.clk(CLOCK_50), .reset(reset), .left_press(leftInput), .right_press(rightInput), .left_neighbor(LEDS[5]), .right_neighbor(LEDS[7]), .light(LEDS[6]));
  normalLight light7 (.clk(CLOCK_50), .reset(reset), .left_press(leftInput), .right_press(rightInput), .left_neighbor(LEDS[6]), .right_neighbor(LEDS[8]), .light(LEDS[7]));
  normalLight light8 (.clk(CLOCK_50), .reset(reset), .left_press(leftInput), .right_press(rightInput), .left_neighbor(LEDS[7]), .right_neighbor(LEDS[9]), .light(LEDS[8]));
  normalLight light9 (.clk(CLOCK_50), .reset(reset), .left_press(leftInput), .right_press(rightInput), .left_neighbor(LEDS[8]), .right_neighbor(1'b0),    .light(LEDS[9]));

  assign LEDR[9:1] = LEDS;
  assign LEDR[0]   = 1'b0;

  
  victory win (
      .clk(CLOCK_50),
      .reset(reset),
      .left_press(leftInput),
      .right_press(rightInput),
      .leftmost_light(LEDS[1]),      
      .rightmost_light(LEDS[9]),     
      .hex_out(winResult)
  );

  assign HEX0 = winResult;

endmodule
