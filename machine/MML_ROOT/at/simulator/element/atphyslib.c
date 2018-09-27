/*   File: atphyslib.c
     Common physics functions for Accelerator Toolbox
     A. Terebilo   10/28/04
     Laurent S. Nadolski, April 8th, 2007
          add energy dependance in edge_fringe and edge
     April 29, 2011: According to note SSC-141 by E. Forest, energy dependance in only in V-plane
                     But series is diverging (close to mad8 results for LNLS)      
 */
	
#include "mex.h"
void edge(double* r, double inv_rho, double edge_angle)
{	/* Edge focusing in dipoles with hard-edge field */
    double psi = inv_rho*tan(edge_angle);

    /* r[1]+=r[0]*psi; */
    /* r[1]+=r[0]*psi/(1+r[4]); */
    r[1]+=r[0]*psi; 
	r[3]-=r[2]*psi/(1+r[4]);
}


void edge_fringe(double* r, double inv_rho, double edge_angle, double fint, double gap)
{   /* Edge focusing in dipoles with fringe field */
    double fx = inv_rho*tan(edge_angle);
    double psi_bar = edge_angle-inv_rho*gap*fint*(1+sin(edge_angle)*sin(edge_angle))/cos(edge_angle)/(1+r[4]);
    double fy = inv_rho*tan(psi_bar);
    /* r[1]+=r[0]*fx;
    r[3]-=r[2]*fy; */
    r[1]+=r[0]*fx;
    r[3]-=r[2]*fy/(1+r[4]);    
}

