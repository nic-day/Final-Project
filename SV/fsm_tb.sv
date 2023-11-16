`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  reset;
   logic  on;

   logic  [63:0] display;
   logic  [63:0] seed = 64'h0405_0600_0000_000;


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
	#20 $fdisplay(desc3,"OUTPUT: 
     %b
     %b
     %b
     %b
     %b
     %b
     %b
     %b 
     ||Reset: %b || On Switch: %b Seed: %h || ",seed[63:56], seed[55:48], seed[47:40], seed[39:32], seed[31:24], seed[23:16], seed[15:8], seed[7:0], reset, on, seed);
     end   
   
   initial 
     begin     
	#0        reset = 1'b0;
	#0        on = 1'b1;
     end

endmodule // FSM_tb

