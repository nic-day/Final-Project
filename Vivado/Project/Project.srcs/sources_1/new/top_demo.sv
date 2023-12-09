`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2021 06:40:11 PM
// Design Name: 
// Module Name: top_demo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_demo
(
  // input
  input  logic [7:0] sw,
  input  logic [3:0] btn,
  input  logic       sysclk_125mhz,
  input  logic       rst,
  
  // output  
  output logic [7:0] led,
  output logic       sseg_ca,
  output logic       sseg_cb,
  output logic       sseg_cc,
  output logic       sseg_cd,
  output logic       sseg_ce,
  output logic       sseg_cf,
  output logic       sseg_cg,
  output logic       sseg_dp,
  output logic [3:0] sseg_an,
  output logic [2:0] hdmi_d_p,  
  output logic [2:0] hdmi_d_n,   
  output logic       hdmi_clk_p,   
  output logic	     hdmi_clk_n,
   
  inout logic	     hdmi_cec,  
  inout logic	     hdmi_sda,   
  inout logic	     hdmi_scl,   
  input logic	     hdmi_hpd
);

  logic [16:0] CURRENT_COUNT;
  logic [16:0] NEXT_COUNT;
  logic        smol_clk;
  logic clkdiv;
  logic [255:0] seed;
  logic [255:0] display;
  logic [255:0] dutout;
  logic [255:0] keyout; //not important. Was used for the testing phase, is not needed here
  
  // Place Conway Game of Life instantiation here
  
  clk_div dut_1(sysclk_125mhz, btn[0], clkdiv);
  FSM dut(clkdiv,btn[1],sw[7],seed,display,keyout);
  
  //key selector
  always @(*) begin
  case(sw[6:5])
        2'b00   : seed = 255'h00001c1c380000000000000000000000000000004800040044003c0000000000;
        2'b01   : seed = 255'h0000200020002000000020002000200000000000000000000010001000100000;
        2'b10   : seed = 255'h0000381c000000000000381c000000000000381c000000000000381c00000000;
        2'b11   : seed = 255'h00006006600600000700038000000000000000000000700e0000000000000000;
    endcase
    end
  // HDMI
  // logic hdmi_out_en;
  //assign hdmi_out_en = 1'b0;
  hdmi_top test (display, sysclk_125mhz, hdmi_d_p, hdmi_d_n, hdmi_clk_p, 
		         hdmi_clk_n, hdmi_cec, hdmi_sda, hdmi_scl, hdmi_hpd);
  
  // 7-segment display
  segment_driver driver(
  .clk(smol_clk),
  .rst(btn[3]),
  .digit0(sw[3:0]),
  .digit1(4'b0111),
  .digit2(sw[7:4]),
  .digit3(4'b1111),
  .decimals({1'b0, btn[2:0]}),
  .segment_cathodes({sseg_dp, sseg_cg, sseg_cf, sseg_ce, sseg_cd, sseg_cc, sseg_cb, sseg_ca}),
  .digit_anodes(sseg_an)
  );

// Register logic storing clock counts
  always@(posedge sysclk_125mhz)
  begin
    if(btn[3])
      CURRENT_COUNT = 17'h00000;
    else
      CURRENT_COUNT = NEXT_COUNT;
  end
  
  // Increment logic
  assign NEXT_COUNT = CURRENT_COUNT == 17'd100000 ? 17'h00000 : CURRENT_COUNT + 1;

  // Creation of smaller clock signal from counters
  assign smol_clk = CURRENT_COUNT == 17'd100000 ? 1'b1 : 1'b0;

endmodule
