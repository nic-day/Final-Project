import java.util.*;


class GridChanger{

public static void main (String args[]) {
    for(int i = 0; i<16; i++){
        for(int j = 0; j<16; j++){
             if(i==0){
                if(j==0){
                    System.out.println("evolve3 e"+(i)+"_"+j+" (grid_evolve["+(j+16*i)+"], grid["+(j+(16*(i))+1)+"], grid["+(j+(16*(i+1)))+"], grid["+(j+(16*(i+1))+1)+"], grid["+(j+16*i)+"]);");
                }
                if(j>0 && j<15){
                    System.out.println("evolve5 e"+(i)+"_"+j+" (grid_evolve["+(j+16*i)+"], grid["+(j+(16*(i))-1)+"], grid["+(j+(16*(i)+1))+"], grid["+(j+(16*(i+1))-1)+"], grid["+(j+(16*(i+1)))+"], grid["+(j+(16*(i+1))+1)+"], grid["+(j+16*i)+"]);");
                }
                if(j==15){
                    System.out.println("evolve3 e"+(i)+"_"+j+" (grid_evolve["+(j+16*i)+"], grid["+(j+(16*(i))-1)+"], grid["+(j+(16*(i+1)-1))+"], grid["+(j+(16*i))+"], grid["+(j+16*i)+"]);\n");
                }
            }
            if(i>0 && i<15){
                if(j==0){
                    System.out.println("evolve5 e"+(i)+"_"+j+" (grid_evolve["+(j+16*i)+"], grid["+(j+(16*(i-1)))+"], grid["+(j+(16*(i-1)+1))+"], grid["+(j+(16*i)+1)+"], grid["+(j+(16*(i+1)))+"], grid["+(j+(16*(i+1))+1)+"], grid["+(j+16*i)+"]);");
                }
                if(j>0 && j<15){
                    System.out.println("evolve8 e"+ (i) +"_"+ (j) +" (grid_evolve["+ (j+16*i) +"], grid["+((j-1)+(16*(i-1)))+"], grid["+(j+(16*(i-1)))+"], grid["+((j+1)+(16*(i-1)))+"],"+ 
                     " grid["+(j+(16*i)-1)+"], grid["+(j+(16*i)+1)+"],"+
                     " grid["+(j+(16*(i+1)-1))+"], grid["+(j+(16*(i+1)))+"], grid["+(j+(16*(i+1)+1))+"], grid["+(j+16*i)+"]);");
                }
                if(j==15){
                    System.out.println("evolve5 e"+(i)+"_"+j+" (grid_evolve["+(j+16*i)+"], grid["+(j+(16*(i-1)))+"], grid["+(j+(16*(i-1)-1))+"], grid["+(j+(16*i)-1)+"], grid["+(j+(16*(i+1)))+"], grid["+(j+(16*(i+1))-1)+"], grid["+(j+16*i)+"]);\n");
                }
            }
            if(i==15){
                if(j==0){
                    System.out.println("evolve3 e"+(i)+"_"+j+" (grid_evolve["+(j+16*i)+"], grid["+(j+(16*(i-1)))+"], grid["+(j+(16*(i-1))+1)+"], grid["+(j+(16*(i))+1)+"], grid["+(j+16*i)+"]);");
                }
                if(j>0 && j<15){
                    System.out.println("evolve5 e"+(i)+"_"+j+" (grid_evolve["+(j+16*i)+"], grid["+(j+(16*(i))-1)+"], grid["+(j+(16*(i)+1))+"], grid["+(j+(16*(i-1))-1)+"], grid["+(j+(16*(i-1)))+"], grid["+(j+(16*(i-1))+1)+"], grid["+(j+16*i)+"]);");
                }
                if(j==15){
                    System.out.println("evolve3 e"+(i)+"_"+j+" (grid_evolve["+(j+16*i)+"], grid["+(j+(16*(i-1))-1)+"], grid["+(j+(16*(i-1)))+"], grid["+(j+(16*i)-1)+"], grid["+(j+16*i)+"]);\n");
                }
            }
        }
    }
}
}