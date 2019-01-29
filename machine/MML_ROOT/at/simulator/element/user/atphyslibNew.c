/*   File: atphyslib.c
     Common physics functions for Accelerator Toolbox
(1)
     A. Terebilo   10/28/04
(2)  
   Laurent S. NAdolski, April 8th, 2007
          add energy dependance in edge_fringe and edge
(3)
Added flags to turn on dipole fringe field and edge effects
in dipoles.

Modified by Jianfeng Zhang @ LAL, 30/04/2013.


*/
	
#include "mex.h"
void edge(double* r, double inv_rho, double edge_angle)
{	/* Edge focusing in dipoles with hard-edge field */
  double psi = inv_rho*tan(edge_angle);
  
  /* r[1]+=r[0]*psi; */
  r[1]+=r[0]*psi/(1+r[4]); 
  r[3]-=r[2]*psi/(1+r[4]);
}


void edge_fringe(double* r, double inv_rho, double edge_angle, double fint, double gap, int entrance)
{   /* Edge focusing in dipoles with fringe field */
  double fx = inv_rho*tan(edge_angle);
  double fy = 0.0;
  /*  double psi_bar = edge_angle-inv_rho*gap*fint*(1+sin(edge_angle)*sin(edge_angle))/cos(edge_angle)/(1+r[4]); */

double psi_bar = edge_angle-inv_rho*gap*fint*(1+sin(edge_angle)*sin(edge_angle))/cos(edge_angle)/(1+r[4]*0);

  /*modification for ThomX; Loulergue's geometric correction */
 if(entrance == 1)
   fy = inv_rho*tan(psi_bar + r[1]/(1+r[4]));
 else
   fy = inv_rho*tan(psi_bar - r[1]/(1+r[4]));

  /* r[1]+=r[0]*fx;
     r[3]-=r[2]*fy; */
  /*  r[1]+=r[0]*fx/(1+r[4]);
      r[3]-=r[2]*fy/(1+r[4]); */

 /*geometric correction to py; Forest: SSC-141*/
  r[1]+=r[0]*fx/(1+r[4]*0);
  r[3]-=r[2]*fy/(1+r[4]);    
}

