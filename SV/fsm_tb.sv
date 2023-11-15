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
	#500 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#5 $fdisplay(desc3,"Reset: %b || On Switch: %b Seed: %b", 
		     reset, on, seed);
     end   
   
   initial 
     begin     
	#0        reset = 1'b0;
	#0        on = 1'b1;
     end

endmodule // FSM_tb

