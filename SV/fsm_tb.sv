`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  reset;
   logic  on;

   logic  [63:0] display;
   logic  [63:0] seed = 64'h0412_6424_0034_3C28;


   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   FSM dut (clk, reset, on, seed, display);   
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("fsm.out");
	// Tells when to finish simulation
	#1000 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#10 $fdisplay(desc3,"OUTPUT: 
     %b
     %b
     %b
     %b
     %b
     %b
     %b
     %b 
     ||Reset: %b || On Switch: %b Seed: %h Output: %h|| ",display[63:56], display[55:48], display[47:40], display[39:32], display[31:24], display[23:16], display[15:8], display[7:0], 
     reset, on, seed, display);
     end   
   
   initial 
     begin     
	#0        reset = 1'b0;
	#0        on = 1'b1;
     end

endmodule // FSM_tb

