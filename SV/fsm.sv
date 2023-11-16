module FSM (clk, reset, on, seed, display);

   input logic          clk;
   input logic          reset;
   input logic          on;
   input logic [63:0]   seed; //input seed possibly by a testbench or using vivado

   output logic [63:0]  display; //output of the display.

   logic [63:0] evolution_stored; //variable to store the evolved grid
   logic [1:0] in; //for the mux 
   logic [63:0] in2;
   typedef enum 	logic [3:0] {S0, S1, S2,S3} statetype;
   statetype state, nextstate;

   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;


    always @(*) begin
      if (in == 2'b01) begin
      in2 <= seed;
      end
      else if(in == 2'b10) begin
      in2 <= evolution_stored;
      end
      else begin
      in2 <= 64'h0000000000000000;
      end
    end

    always_ff @(posedge clk) begin
      evolution_stored <= display;
    end

    datapath start (in2, display);

   // next state logic
   always_comb
     case (state)
       S0: begin
        in  =2'b00;
      if (on) nextstate = S1;
      else nextstate = S0;
       end
       S1: begin
        in = 2'b01;
        if (on) nextstate = S2;
        else nextstate = S0;
       end
       S2: begin
        in = 2'b10;
        if (on) nextstate = S3;
        else nextstate = S0;
       end
       S3: begin
        nextstate = S2;
       end
       
         default: begin 	 
        in = 2'b00; 
	      nextstate <= S0;
         end
      endcase

endmodule
