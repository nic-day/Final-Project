module FSM (clk, reset, on, seed, display, keyout);

   input logic          clk;
   input logic          reset;
   input logic          on;
   input logic [255:0]   seed; //input seed possibly by a testbench or using vivado

   output logic [255:0]  display; //output of the display.

   output logic [255:0]  keyout;//value to change the seed.


   logic [255:0] evolution_stored; //variable to store the evolved grid
   logic [1:0] in; //for the mux 
   logic [255:0] in2;
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
        if (on) nextstate = S2;
        else nextstate = S0;
       end
         default: begin 	 
        in = 2'b00; 
	      nextstate <= S0;
         end
      endcase

/*this is for generating a new input if you would like to do that. 
Keyout is this output and it is posted in the output file so that you can copy paste the seed in the testbench for different kinds of tests*/


logic [255:0] hex_value;
logic [15:0] binary_array[16];
assign binary_array[0] = 16'b00000000_00000000;
assign binary_array[1] = 16'b00100000_00000000;
assign binary_array[2] = 16'b00100000_00000000;
assign binary_array[3] = 16'b00100000_00000000;
assign binary_array[4] = 16'b00000000_00000000;
assign binary_array[5] = 16'b00100000_00000000;
assign binary_array[6] = 16'b00100000_00000000;
assign binary_array[7] = 16'b00100000_00000000;
assign binary_array[8] = 16'b00000000_00000000;
assign binary_array[9] = 16'b00000000_00000000;
assign binary_array[10] = 16'b00000000_00000000;
assign binary_array[11] = 16'b00000000_00000000;
assign binary_array[12] = 16'b00000000_00010000;
assign binary_array[13] = 16'b00000000_00010000;
assign binary_array[14] = 16'b00000000_00010000;
assign binary_array[15] = 16'b00000000_00000000;
always_comb begin
    hex_value = {binary_array[0], binary_array[1], binary_array[2], binary_array[3],
                 binary_array[4], binary_array[5], binary_array[6], binary_array[7],
                 binary_array[8], binary_array[9], binary_array[10], binary_array[11],
                 binary_array[12], binary_array[13], binary_array[14], binary_array[15]};
  end
assign keyout = hex_value;

endmodule

