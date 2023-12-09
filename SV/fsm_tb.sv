`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  reset;
   logic  on;

   logic  [255:0] display;
   logic  [255:0] seed = 256'h20b541957254c386f5459bda8eac32efa1ce23c28761dea7713acc2fab412b34;
   logic [255:0] keyout;

   integer handle3;
   integer desc3;
   integer desc2;
   
   // Instantiate DUT
   FSM dut (clk, reset, on, seed, display, keyout);   
   
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
	#1000000 $finish;		
     end
   
   always 
     begin
     desc2=handle3;
     #20 $fdisplay (desc2,"New Seed: %h", keyout);
     #100000000 $finish;
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
     %b
     %b
     %b
     %b
     %b
     %b
     %b
     %b 
     
     ||Reset: %b || On Switch: %b Seed: %h|| Current Generation: %h ",display[15:0], display[31:16], display[47:32], display[63:48], display[79:64], display[95:80], display[111:96], display[127:112],  display[143:128], display[159:144], display[175:160], display[191:176],  display[207:192],  display[223:208], display[239:224], display[255:240],
     reset, on, seed, display);
     end   
   
   initial 
     begin     
	#0        reset = 1'b0;
	#0        on = 1'b1;
     end

endmodule // FSM_tb

