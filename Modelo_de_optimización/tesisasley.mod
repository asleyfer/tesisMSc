/*********************************************
 * OPL 20.1.0.0 Model
 * Author: ASUS
 * Creation Date: 8/06/2023 at 12:15:37 p. m.
 *********************************************/

//clusters								
int c1 =...; 	/*Número de clusteres*/							
range clusters = 1..c1;		

//localizaciones potenciales							
int a1 =...; /*Número de equipamientos actuales*/
int p1 =...;  /*Número de potenciales ubicaciones para equipamientos*/									
range equipamientos_actuales = 1..a1;	
range equipamientos =1..a1+p1;

int distancia[clusters,equipamientos]=...; /*Distancia entre clusters a equipamientos*/
int h[clusters]=...; /*cantidad de habitantes agrupados en cada cluster*/
int MAX=2; /*Número total de equipamientos incluyendo los que ya están*/


dvar boolean y[clusters][equipamientos];/*Asignación de cluster i a equipamiento j*/;
dvar boolean x[equipamientos];/*1 si equipamiento i es abierto 0dlc*/;

dexpr float obj=sum(i in clusters, j in equipamientos)h[i]*y[i][j]*distancia[i][j];

minimize obj;

subject to{
  
//max number of facilities
sum(j in equipamientos)x[j]<=MAX;

forall (j in equipamientos_actuales)
x[j]==1;

forall (i in clusters)
sum(j in equipamientos)y[i][j]==1;

forall (i in clusters, j in equipamientos)
y[i][j]-x[j]<=0;
}
main{
	thisOplModel.generate();	
   if(cplex.solve()){							
   writeln(cplex.getObjValue());								
   for (var j in thisOplModel.equipamientos){								
  		 	if(thisOplModel.x[j]==1){					
			writeln("Base: ",j);				
				}   					
    }} else                                                                  
    {                                                           
     writeln("NO HAY SOLUCIÓN");                               
    } 	 		   
	} 
