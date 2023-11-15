module FSM (clk, reset, on, seed, display);

   input logic          clk;
   input logic          reset;
   input logic          on;
   input logic [63:0]   seed; //input seed possibly by a testbench or using vivado

   output logic [63:0]  display; //output of the display.

   logic [63:0] evolution_stored; //variable to store the evolved grid

   typedef enum 	logic [3:0] {S0, S1, S2} statetype;
   statetype state, nextstate;

   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;


   // next state logic
   always_comb
     case (state)
       S0: begin
      if (on) nextstate = S1;
      else nextstate = S0;
       end
       S1: begin
        datapath start(seed, display);
        evolution_stored = display;
        if (on) nextstate = S2;
        else nextstate = S0;
       end
       S2: begin
        datapath on(evolution_stored , display);
        evolution_stored = display;
        if (on) nextstate = S2;
        else nextstate = S0;
       end
       
         default: begin 	  
	      nextstate <= S0;
         end
      endcase

endmodule
