import java.io.*;




class GridChanger{
/*Okay so this file here is the java file that I wrote to rewrite the datapath file for the proper grid size.
 * remember that the input seed and display will need to be changed to the proper bit size but if you open the new datapath file after
 * running this you will be able to see the proper bit size. The places that you will need to change the bit size are in the fsm.sv,
 * fsm.tb and the top_demo.sv
 * fsm.sv
 *      in here you need to change the seed, display, in2, and evolution stored to properly run the new datapath file. The key out and hex key can 
 *      be ignored as they were used to debug the 16x16 grid when we wanted different, not random seeds.
 * fsm.tb
 *      in here you need to change the seed and display variables, Keyout can once again be ignored.
 *      NOTE: the display in the out file only works with the 16x16 grid but you can still see the current generation buy looking at the current
 *              gen in the out file.
 * top_demo.sv
 *      
 */
public static void main (String args[]) {
    
    //int that determines the length and width of the SQUARE grid you are trying to create.
    int size = 16;
    //the way we write to the proper file
    String outputPath = "datapath.sv";
    try{
        PrintWriter writer = new PrintWriter(new FileWriter(outputPath, false));
        //copys format inside the original datapath file.
    writer.write("/*\n\nConway's Game of Life modeled in SVerilog\n\n*/\n\nmodule datapath ( grid, grid_evolve );\n\n\n\toutput logic ["+((size*size)-1)+":0] grid_evolve;\n\tinput logic ["+((size*size)-1)+":0] grid;\n\n");

   //generates the proper evovlve lines
    for(int i = 0; i<size; i++){
        for(int j = 0; j<size; j++){
             if(i==0){
                if(j==0){
                    writer.write("evolve3 e"+(i)+"_"+j+" (grid_evolve["+(j+(size)*i)+"], grid["+(j+((size)*(i))+1)+"], grid["+(j+((size)*(i+1)))+"], grid["+(j+((size)*(i+1))+1)+"], grid["+(j+(size)*i)+"]);\n");
                }
                if(j>0 && j<(size-1)){
                    writer.write("evolve5 e"+(i)+"_"+j+" (grid_evolve["+(j+(size)*i)+"], grid["+(j+((size)*(i))-1)+"], grid["+(j+((size)*(i)+1))+"], grid["+(j+((size)*(i+1))-1)+"], grid["+(j+((size)*(i+1)))+"], grid["+(j+((size)*(i+1))+1)+"], grid["+(j+(size)*i)+"]);\n");
                }
                if(j==(size-1)){
                    writer.write("evolve3 e"+(i)+"_"+j+" (grid_evolve["+(j+(size)*i)+"], grid["+(j+((size)*(i))-1)+"], grid["+(j+((size)*(i+1)-1))+"], grid["+(j+((size)*i))+"], grid["+(j+(size)*i)+"]);\n\n");
                }
            }
            if(i>0 && i<(size-1)){
                if(j==0){
                    writer.write("evolve5 e"+(i)+"_"+j+" (grid_evolve["+(j+(size)*i)+"], grid["+(j+((size)*(i-1)))+"], grid["+(j+((size)*(i-1)+1))+"], grid["+(j+((size)*i)+1)+"], grid["+(j+((size)*(i+1)))+"], grid["+(j+((size)*(i+1))+1)+"], grid["+(j+(size)*i)+"]);\n");
                }
                if(j>0 && j<(size-1)){
                    writer.write("evolve8 e"+ (i) +"_"+ (j) +" (grid_evolve["+ (j+(size)*i) +"], grid["+((j-1)+((size)*(i-1)))+"], grid["+(j+((size)*(i-1)))+"], grid["+((j+1)+((size)*(i-1)))+"],"+ 
                     " grid["+(j+((size)*i)-1)+"], grid["+(j+((size)*i)+1)+"],"+
                     " grid["+(j+((size)*(i+1)-1))+"], grid["+(j+((size)*(i+1)))+"], grid["+(j+((size)*(i+1)+1))+"], grid["+(j+(size)*i)+"]);\n");
                }
                if(j==(size-1)){
                    writer.write("evolve5 e"+(i)+"_"+j+" (grid_evolve["+(j+(size)*i)+"], grid["+(j+((size)*(i-1)))+"], grid["+(j+((size)*(i-1)-1))+"], grid["+(j+((size)*i)-1)+"], grid["+(j+((size)*(i+1)))+"], grid["+(j+((size)*(i+1))-1)+"], grid["+(j+(size)*i)+"]);\n\n");
                }
            }
            if(i==(size-1)){
                if(j==0){
                    writer.write("evolve3 e"+(i)+"_"+j+" (grid_evolve["+(j+(size)*i)+"], grid["+(j+((size)*(i-1)))+"], grid["+(j+((size)*(i-1))+1)+"], grid["+(j+((size)*(i))+1)+"], grid["+(j+(size)*i)+"]);\n");
                }
                if(j>0 && j<(size-1)){
                    writer.write("evolve5 e"+(i)+"_"+j+" (grid_evolve["+(j+(size)*i)+"], grid["+(j+((size)*(i))-1)+"], grid["+(j+((size)*(i)+1))+"], grid["+(j+((size)*(i-1))-1)+"], grid["+(j+((size)*(i-1)))+"], grid["+(j+((size)*(i-1))+1)+"], grid["+(j+(size)*i)+"]);\n");
                }
                if(j==(size-1)){
                    writer.write("evolve3 e"+(i)+"_"+j+" (grid_evolve["+(j+(size)*i)+"], grid["+(j+((size)*(i-1))-1)+"], grid["+(j+((size)*(i-1)))+"], grid["+(j+((size)*i)-1)+"], grid["+(j+(size)*i)+"]);\n\n");
                }
            }
        }
    }
    writer.write("endmodule\n");

    //line that writes the rest of the original datapath file including the evolve functions.

    writer.write("module evolve3 #(parameter GRID_SIZE = 16) (next_state,  vector1, vector2, vector3, current_state);\n\n\tinput logic  vector1;\n\tinput logic  vector2;\n     input logic  vector3;\n     input logic  current_state;\n    output logic next_state;\n\n    logic [GRID_SIZE-1:0] 	sum;\n    assign sum = vector1 + vector2 + vector3;\n    rules r1 (sum, current_state, next_state);\n\nendmodule // evolve3\n\nmodule evolve5 #(parameter GRID_SIZE = 16) (next_state, vector1, vector2, vector3, vector4, vector5, current_state);\n\n    input logic   vector1;\n    input logic 	 vector2;\n    input logic 	 vector3;\n    input logic 	 vector4;\n    input logic 	 vector5;\n    input logic 	 current_state;\n    output logic  next_state;\n\n  logic [GRID_SIZE-1:0] 	 sum;\n\n   assign sum = vector1 + vector2 + vector3 + vector4 + vector5;\n    rules r1 (sum, current_state, next_state);\n\n endmodule // evolve5\n\n module evolve8 #(parameter GRID_SIZE = 16) (next_state, vector1, vector2, vector3, vector4, vector5, vector6, vector7, vector8, current_state);\n\n    input logic 	vector1;\n    input logic 	vector2;\n    input logic 	vector3;\n    input logic 	vector4;\n    input logic 	vector5;\n    input logic 	vector6;\n    input logic 	vector7;\n    input logic 	vector8;\n    input logic 	current_state;\n    output logic next_state;\n\n    logic [GRID_SIZE-1:0] 	sum;\n\n    assign sum = vector1 + vector2 + vector3 + vector4 + vector5 + vector6 + vector7 + vector8;\n    rules r1 (sum, current_state, next_state);\n\nendmodule // evolve8\n\n\n module rules #(parameter GRID_SIZE = 16) (pop_count, current_state, next_state);\n\n    input logic [GRID_SIZE-1:0] pop_count;\n    input logic 	     current_state;\n    output logic      next_state;\n\n    assign next_state = (pop_count == 2 & current_state) | pop_count == 3;\n\nendmodule // rules\n");

    writer.close();
    System.out.println("Output has been put into " + outputPath);
} catch (final IOException e){
    System.err.println("Error writing to file: " + e.getMessage());
    e.printStackTrace();
}
}
}