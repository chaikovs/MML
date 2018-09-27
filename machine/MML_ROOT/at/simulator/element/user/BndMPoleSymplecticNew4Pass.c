/*
  29/04/2013  Jianfeng Zhang @ LAL 

  Modified the original file "BndMpoleSymplectic4Pass.c"
  to fix the bug to trigger on dipole fringe field and 
  edge effects for sector dipoles. 
*/
#include "mex.h"
#include<math.h>
#include "elempass.h"
#include "atlalib.c"
#include "atphyslibNew.c"

#define DRIFT1    0.6756035959798286638
#define DRIFT2   -0.1756035959798286639
#define KICK1     1.351207191959657328
#define KICK2    -1.702414383919314656


#define SQR(X) ((X)*(X))



void bndthinkick(double* r, double* A, double* B, double L, double irho, int max_order)

/***************************************************************************** 
Calculate multipole kick in a curved element (bending magnet)
The reference coordinate system  has the curvature given by the inverse 
(design) radius irho.
IMPORTANT !!!
The magnetic field Bo that provides this curvature MUST NOT be included in the dipole term
PolynomB[1](MATLAB notation)(C: B[0] in this function) of the By field expansion

The kick is given by

           e L      L delta      L x
theta  = - --- B  + -------  -  -----  , 
     x     p    y     rho           2
            0                    rho

         e L
theta  = --- B
     y    p   x
           0


Note: in the US convention the transverse multipole field is written as:

                         max_order+1
                           ----
                           \                       n-1
	   (B + iB  )/ B rho  =  >   (ia  + b ) (x + iy)
         y    x            /       n    n
	                       ----
                          n=1
	is a polynomial in (x,y) with the highest order = MaxOrder
	

	Using different index notation 
   
                         max_order
                           ----
                           \                       n
	   (B + iB  )/ B rho  =  >   (iA  + B ) (x + iy)
             y    x        /            n    n
	                   ----
                          n=0

	A,B: i=0 ... max_order
   [0] - dipole, [1] - quadrupole, [2] - sextupole ...
   units for A,B[i] = 1/[m]^(i+1)
	Coeficients are stroed in the PolynomA, PolynomB field of the element
	structure in MATLAB

	A[i] (C++,C) =  PolynomA(i+1) (MATLAB) 
	B[i] (C++,C) =  PolynomB(i+1) (MATLAB) 
	i = 0 .. MaxOrder


Comments:
 (1) Add the kick map from the second order expended
     Hamitonian H2, this map is also used in Tracy3
     for THOMX ring; this map is not neccerary for 
     SOLEIL.
              
     Written by Jianfeng Zhang @ LAL 13/03/2013

*******************************************************************************/
{  int i;
   double ReSum = B[max_order];
   double ImSum = A[max_order];

   double ReSumTemp;
        
   double u, r0[6];

   for(i=0;i<6;i++){
     r0[i]=r[i];
    }
  	/* recursively calculate the local transvrese magnetic field
	   Bx = ReSum, By = ImSum
	*/
	for(i=max_order-1;i>=0;i--)
		{	ReSumTemp = ReSum*r[0] - ImSum*r[2] + B[i];
			ImSum = ImSum*r[0] +  ReSum*r[2] + A[i];
			ReSum = ReSumTemp;
		}
	
 
   /* kick map from first order expended 
      Hamitonian H1; works for SOLEIL*/ 	
   r[1] -=  L*(ReSum-(r0[4]-r0[0]*irho)*irho);/*px */
   r[3] +=  L*ImSum;/* py*/
   r[5] +=  L*irho*r0[0]; /* pathlength */

   /* secone order kick map from first order expended 
      Hamitonian H1; don't need for SOLEIL;
      but MUST trigger on for THOMX*/
   if(1){
   u = L * irho * r0[0] /(1.0+r0[4]);
   r[0] += u * r0[1];
   r[2] += u * r0[3];	
   r[5] += u*(r0[1]*r0[1]+r0[3]*r0[3])/(2.0*(1.0+r0[4]));
   }

}



/**************************************************************
23/09/2011   Jianfeng Zhang @ SOLEIL

Add flag to turn off rectangular dipole fringe field if the 
entrance/exit angle is zero, this modification is for the 
split of rectangular dipole into several pieces. 

Notes: 
  This modification may introduce a potential bug for sector dipoles. 

29/04/2013 Jianfeng Zhang @ LAL
Fix the bug to trigger on the dipole fringe field and edge effects
for sector dipoles, by adding
          the new flags "EdgeEffect1" and "EgeEffect2" in the dipole 
          difinition. 

**************************************************************** */
void BndMPoleSymplectic4Pass(double *r, double le, double irho, double *A, double *B,
			     int max_order, int num_int_steps, double entrance_angle, 
			     double exit_angle, double fint1, double fint2, double gap,
			     int EdgeEffect1, int EdgeEffect2, double *T1, double *T2,	
			     double *R1, double *R2, int num_particles)


{	int c,m;	
	double *r6;   
	double SL, L1, L2, K1, K2;
	bool useT1, useT2, useR1, useR2, useFringe1, useFringe2;
	
	SL = le/num_int_steps;
	L1 = SL*DRIFT1;
	L2 = SL*DRIFT2;
	K1 = SL*KICK1;
	K2 = SL*KICK2;
	
	
	if(T1==NULL)
	    useT1=false;
	else 
	    useT1=true;  
	    
    if(T2==NULL)
	    useT2=false; 
	else 
	    useT2=true;  
	
	if(R1==NULL)
	    useR1=false; 
	else 
	    useR1=true;  
	    
    if(R2==NULL)
	    useR2=false;
	else 
	    useR2=true;
	    
    /* if either is 0 - do not calculate fringe effects */    
    /*    if( fint1==0 || gap==0 || entrance_angle == 0) */
    if(EdgeEffect1 = 1) 
      useFringe1=true;  
    else 
      useFringe1 = false;
	
    /*	if( fint2==0 || gap==0 || exit_angle == 0 ) */
    if(EdgeEffect2 = 1) 
      useFringe2=true;  
    else 
      useFringe2 = false;    
	    
	for(c = 0;c<num_particles;c++)	/* Loop over particles  */
			{	r6 = r+c*6;	
			    if(!mxIsNaN(r6[0]))
			    {
					
					/*  misalignment at entrance  */
					if(useT1)
			            ATaddvv(r6,T1);
			        if(useR1)
			            ATmultmv(r6,R1);
					
					/* edge focus */				
				 	if(useFringe1)
					  edge_fringe(r6, irho, entrance_angle,fint1,gap,1);
			        else
			            edge(r6, irho, entrance_angle);
				 	
					/* integrator */
					for(m=0; m < num_int_steps; m++) /* Loop over slices*/			
						{		r6 = r+c*6;	
								

						  /*4-th order symplectic integrator*/
								ATdrift6(r6,L1);
           					    bndthinkick(r6, A, B, K1, irho, max_order);
								ATdrift6(r6,L2);
           					    bndthinkick(r6, A, B, K2, irho, max_order);
								ATdrift6(r6,L2);
		     					bndthinkick(r6, A, B,  K1, irho, max_order);
								ATdrift6(r6,L1);	
						}  
					
					if(useFringe2)
					  edge_fringe(r6, irho, exit_angle,fint2,gap,0);
			        else
			            edge(r6, irho, exit_angle);	
					/* edge focus */


					 /* Misalignment at exit */	
			        if(useR2)
			            ATmultmv(r6,R2);
		            if(useT2)   
			            ATaddvv(r6,T2);
				}


			}
}


    	



ExportMode int* passFunction(const mxArray *ElemData, int *FieldNumbers,
								double *r_in, int num_particles, int mode)

#define NUM_FIELDS_2_REMEMBER 15
{	double *A , *B;
	double  *pr1, *pr2, *pt1, *pt2, fint1, fint2, gap;   
	double entrance_angle, exit_angle;
        int edge_effect1, edge_effect2;
 
	int max_order, num_int_steps;
	double le,ba,irho;
	int *returnptr;
	int *NewFieldNumbers, fnum;

	
	switch(mode)
		{   case MAKE_LOCAL_COPY: 	/* Find field numbers first
						   Save a list of field number in an array
						   and make returnptr point to that array
									*/
				{	
					/* Allocate memory for integer array of 
					   field numbers for faster future reference
					*/
		
					NewFieldNumbers = (int*)mxCalloc(NUM_FIELDS_2_REMEMBER,sizeof(int));

					/* Populate */
					
					fnum = mxGetFieldNumber(ElemData,"PolynomA");
					if(fnum<0) 
					    mexErrMsgTxt("Required field 'PolynomA' was not found in the element data structure"); 
					NewFieldNumbers[0] = fnum;
					A = mxGetPr(mxGetFieldByNumber(ElemData,0,fnum));
					
					
					fnum = mxGetFieldNumber(ElemData,"PolynomB");
					if(fnum<0) 
					    mexErrMsgTxt("Required field 'PolynomB' was not found in the element data structure"); 
					NewFieldNumbers[1] = fnum;
					B = mxGetPr(mxGetFieldByNumber(ElemData,0,fnum));
					
					
					
					fnum = mxGetFieldNumber(ElemData,"MaxOrder");
					if(fnum<0) 
					    mexErrMsgTxt("Required field 'MaxOrder' was not found in the element data structure"); 
					NewFieldNumbers[2] = fnum;
					max_order = (int)mxGetScalar(mxGetFieldByNumber(ElemData,0,fnum));
					
					fnum = mxGetFieldNumber(ElemData,"NumIntSteps");
					if(fnum<0) 
					    mexErrMsgTxt("Required field 'NumIntSteps' was not found in the element data structure"); 
					NewFieldNumbers[3] = fnum;
					num_int_steps = (int)mxGetScalar(mxGetFieldByNumber(ElemData,0,fnum));
					
					
					fnum = mxGetFieldNumber(ElemData,"Length");
					if(fnum<0) 
					    mexErrMsgTxt("Required field 'Length' was not found in the element data structure"); 
					NewFieldNumbers[4] = fnum;
					le = mxGetScalar(mxGetFieldByNumber(ElemData,0,fnum));
					
					
					fnum = mxGetFieldNumber(ElemData,"BendingAngle");
					if(fnum<0) 
					    mexErrMsgTxt("Required field 'BendingAngle' was not found in the element data structure"); 
					NewFieldNumbers[5] = fnum;
					ba = mxGetScalar(mxGetFieldByNumber(ElemData,0,fnum));
					
					
					
					
					
	                fnum = mxGetFieldNumber(ElemData,"EntranceAngle");
					if(fnum<0) 
					    mexErrMsgTxt("Required field 'EntranceAngle' was not found in the element data structure"); 
					NewFieldNumbers[6] = fnum;
					entrance_angle = mxGetScalar(mxGetFieldByNumber(ElemData,0,fnum));
	                
	                fnum = mxGetFieldNumber(ElemData,"ExitAngle");
					if(fnum<0) 
					    mexErrMsgTxt("Required field 'ExitAngle' was not found in the element data structure"); 
					NewFieldNumbers[7] = fnum;
					exit_angle = mxGetScalar(mxGetFieldByNumber(ElemData,0,fnum));
					
					
					
					fnum = mxGetFieldNumber(ElemData,"FringeInt1");/* Optional field FringeInt */
                    NewFieldNumbers[8] = fnum;
					if(fnum<0) 
					    fint1 = 0;
					else
					    fint1 = mxGetScalar(mxGetFieldByNumber(ElemData,0,fnum));
					    
					    
					fnum = mxGetFieldNumber(ElemData,"FringeInt2");/* Optional field FringeInt */
                    NewFieldNumbers[9] = fnum;
					if(fnum<0) 
					    fint2 = 0;
					else
					    fint2 = mxGetScalar(mxGetFieldByNumber(ElemData,0,fnum));
					
					fnum = mxGetFieldNumber(ElemData,"FullGap");
					NewFieldNumbers[10] = fnum;
					if(fnum<0) 
					    gap = 0;
					else
					    gap = mxGetScalar(mxGetFieldByNumber(ElemData,0,fnum));					
				
                    fnum = mxGetFieldNumber(ElemData,"R1");
					NewFieldNumbers[11] = fnum;
					if(fnum<0)
					    pr1 = NULL;
					else
					    pr1 = mxGetPr(mxGetFieldByNumber(ElemData,0,fnum));
					

					fnum = mxGetFieldNumber(ElemData,"R2");
					NewFieldNumbers[12] = fnum;
					if(fnum<0)
					    pr2 = NULL;
					else
					    pr2 = mxGetPr(mxGetFieldByNumber(ElemData,0,fnum));
					
					
                    fnum = mxGetFieldNumber(ElemData,"T1");
	                NewFieldNumbers[13] = fnum;
					if(fnum<0)
					    pt1 = NULL;
					else
					    pt1 = mxGetPr(mxGetFieldByNumber(ElemData,0,fnum));
					
	                
	                fnum = mxGetFieldNumber(ElemData,"T2");
	                NewFieldNumbers[14] = fnum;
					if(fnum<0)
					    pt2 = NULL;
					else
					    pt2 = mxGetPr(mxGetFieldByNumber(ElemData,0,fnum));
					/*Added by Jianfeng Zhang @ LAL, 29/04/2013 
                                          to fix the bugs to trigger on dipole FF and Edge effect
					  for sector dipoles*/					
					fnum = mxGetFieldNumber(ElemData,"EdgeEffect1");
					NewFieldNumbers[15] = fnum;
					if(fnum<0) 
					    edge_effect1 = 0;
					else
					    edge_effect1 = (int)mxGetScalar(mxGetFieldByNumber(ElemData,0,fnum));

					fnum = mxGetFieldNumber(ElemData,"EdgeEffect2");
					NewFieldNumbers[16] = fnum;
					if(fnum<0) 
					    edge_effect2 = 0;
					else
					    edge_effect2 = (int)mxGetScalar(mxGetFieldByNumber(ElemData,0,fnum));
				
					returnptr = NewFieldNumbers;

				}	break;

			case	USE_LOCAL_COPY:	/* Get fields from MATLAB using field numbers
									    The second argument pointer to the array of field 
									    numbers is previously created with 
										QuadLinPass( ..., MAKE_LOCAL_COPY)
									*/	
				{	A = mxGetPr(mxGetFieldByNumber(ElemData,0,FieldNumbers[0]));
					B = mxGetPr(mxGetFieldByNumber(ElemData,0,FieldNumbers[1]));
					max_order = (int)mxGetScalar(mxGetFieldByNumber(ElemData,0,FieldNumbers[2]));
					num_int_steps = (int)mxGetScalar(mxGetFieldByNumber(ElemData,0,FieldNumbers[3]));
					le = mxGetScalar(mxGetFieldByNumber(ElemData,0,FieldNumbers[4]));
					ba = mxGetScalar(mxGetFieldByNumber(ElemData,0,FieldNumbers[5]));
					entrance_angle = mxGetScalar(mxGetFieldByNumber(ElemData,0,FieldNumbers[6]));
					exit_angle = mxGetScalar(mxGetFieldByNumber(ElemData,0,FieldNumbers[7]));
					
					/* Optional fields */
					
					if(FieldNumbers[8]<0) 
					    fint1 = 0;
					else
					    fint1 = mxGetScalar(mxGetFieldByNumber(ElemData,0,FieldNumbers[8]));
					
					    
					if(FieldNumbers[9]<0) 
					    fint2 = 0;
					else
					    fint2 = mxGetScalar(mxGetFieldByNumber(ElemData,0,FieldNumbers[9]));
					    
					if(FieldNumbers[10]<0) 
					    gap = 0;
					else
					gap = mxGetScalar(mxGetFieldByNumber(ElemData,0,FieldNumbers[10]));
					
					/* Optional fields */
					if(FieldNumbers[11]<0)
					    pr1 = NULL;
					else
					    pr1 = mxGetPr(mxGetFieldByNumber(ElemData,0,FieldNumbers[11]));
					
					if(FieldNumbers[12]<0)
					    pr2 = NULL;
					else
					    pr2 = mxGetPr(mxGetFieldByNumber(ElemData,0,FieldNumbers[12]));
					
					    
					if(FieldNumbers[13]<0)
					    pt1 = NULL;
					else    
					    pt1 = mxGetPr(mxGetFieldByNumber(ElemData,0,FieldNumbers[13]));
					    
					if(FieldNumbers[14]<0)
					    pt2 = NULL;
					else 
					    pt2 = mxGetPr(mxGetFieldByNumber(ElemData,0,FieldNumbers[14]));

					if(FieldNumbers[15]<0)
					    edge_effect1 = 0;
					else 
					    edge_effect1=(int)mxGetScalar(mxGetFieldByNumber(ElemData,0,FieldNumbers[15]));

					if(FieldNumbers[16]<0)
					    edge_effect2 = 0;
					else 
					    edge_effect2 = (int)mxGetScalar(mxGetFieldByNumber(ElemData,0,FieldNumbers[16]));
					
					returnptr = FieldNumbers;
				}	break;
			default:
				{	mexErrMsgTxt("No match for calling mode in function BndMPoleSymplectic4Pass\n");
				}
		}


	irho = ba/le;
	
	BndMPoleSymplectic4Pass(r_in, le, irho, A, B, max_order, num_int_steps,entrance_angle, 
				exit_angle, fint1, fint2, gap, edge_effect1,edge_effect2,pt1, pt2, pr1, pr2, num_particles);
	

	
	return(returnptr);

}


 






void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{	int m,n;
	double *r_in;
	double le, ba, *A, *B;  
	double irho;
	int max_order, num_int_steps;
	int edge_effect1,edge_effect2;
	double entrance_angle, exit_angle ;
	double  *pr1, *pr2, *pt1, *pt2, fint1, fint2, gap;  
    mxArray *tmpmxptr;

    if(nrhs)
    {
    /* ALLOCATE memory for the output array of the same size as the input */
	m = mxGetM(prhs[1]);
	n = mxGetN(prhs[1]);
	if(m!=6) 
		mexErrMsgTxt("Second argument must be a 6 x N matrix");
	
	
	
    tmpmxptr =mxGetField(prhs[0],0,"PolynomA");
	if(tmpmxptr)
		A = mxGetPr(tmpmxptr);
	else
		mexErrMsgTxt("Required field 'PolynomA' was not found in the element data structure"); 
				    
	tmpmxptr =mxGetField(prhs[0],0,"PolynomB");
	if(tmpmxptr)   
		B = mxGetPr(tmpmxptr);
	else
		mexErrMsgTxt("Required field 'PolynomB' was not found in the element data structure");
					    
	tmpmxptr = mxGetField(prhs[0],0,"MaxOrder");
	if(tmpmxptr)
		max_order = (int)mxGetScalar(tmpmxptr);
	else
		mexErrMsgTxt("Required field 'MaxOrder' was not found in the element data structure");
				        
	tmpmxptr = mxGetField(prhs[0],0,"NumIntSteps");
	if(tmpmxptr)   
		num_int_steps = (int)mxGetScalar(tmpmxptr);
	else
		mexErrMsgTxt("Required field 'NumIntSteps' was not found in the element data structure");    
				    
	tmpmxptr = mxGetField(prhs[0],0,"Length");
	if(tmpmxptr)
	    le = mxGetScalar(tmpmxptr);
	else
		mexErrMsgTxt("Required field 'Length' was not found in the element data structure");    
					    
	tmpmxptr = mxGetField(prhs[0],0,"BendingAngle");
	if(tmpmxptr)
		ba = mxGetScalar(tmpmxptr);
	else
		mexErrMsgTxt("Required field 'BendingAngle' was not found in the element data structure"); 
				
				
	tmpmxptr = mxGetField(prhs[0],0,"EntranceAngle");
	if(tmpmxptr)
	    entrance_angle = mxGetScalar(tmpmxptr);
	else
		mexErrMsgTxt("Required field 'EntranceAngle' was not found in the element data structure"); 
				
				
	tmpmxptr = mxGetField(prhs[0],0,"ExitAngle");
	if(tmpmxptr)
		exit_angle = mxGetScalar(tmpmxptr);
	else
		mexErrMsgTxt("Required field 'ExitAngle' was not found in the element data structure");	

	tmpmxptr = mxGetField(prhs[0],0,"FringeInt1");
	    if(tmpmxptr)
	        fint1 = mxGetScalar(tmpmxptr);
	    else
	        fint1 = 0;
	        
	tmpmxptr = mxGetField(prhs[0],0,"FringeInt2");
	    if(tmpmxptr)
	        fint2 = mxGetScalar(tmpmxptr);
	    else
	        fint2 = 0;
	    
	    tmpmxptr = mxGetField(prhs[0],0,"FullGap");
	    if(tmpmxptr)
	        gap = mxGetScalar(tmpmxptr);
	    else
	        gap = 0;
	    
	    tmpmxptr = mxGetField(prhs[0],0,"R1");
	    if(tmpmxptr)
	        pr1 = mxGetPr(tmpmxptr);
	    else
	        pr1=NULL; 
	    
	    tmpmxptr = mxGetField(prhs[0],0,"R2");
	    if(tmpmxptr)
	        pr2 = mxGetPr(tmpmxptr);
	    else
	        pr2=NULL; 
	    
	    
	    tmpmxptr = mxGetField(prhs[0],0,"T1");
	    
	    
	    if(tmpmxptr)
	        pt1=mxGetPr(tmpmxptr);
	    else
	        pt1=NULL;
	    
	    tmpmxptr = mxGetField(prhs[0],0,"T2");
	    if(tmpmxptr)
	        pt2=mxGetPr(tmpmxptr);
	    else
	        pt2=NULL;  
		
		
    irho = ba/le;
    plhs[0] = mxDuplicateArray(prhs[1]);
	r_in = mxGetPr(plhs[0]);
	BndMPoleSymplectic4Pass(r_in, le, irho, A, B, max_order, num_int_steps, 
				entrance_angle, exit_angle, fint1, fint2, gap, 
				edge_effect1, edge_effect2,pt1, pt2, pr1, pr2, n);

	}
	else
	{   /* return list of required fields */
	    plhs[0] = mxCreateCellMatrix(8,1);
	    
	    mxSetCell(plhs[0],0,mxCreateString("Length"));
	    mxSetCell(plhs[0],1,mxCreateString("BendingAngle"));
	    mxSetCell(plhs[0],2,mxCreateString("EntranceAngle"));
	    mxSetCell(plhs[0],3,mxCreateString("ExitAngle"));
          mxSetCell(plhs[0],4,mxCreateString("PolynomA"));
	    mxSetCell(plhs[0],5,mxCreateString("PolynomB"));
	    mxSetCell(plhs[0],6,mxCreateString("MaxOrder"));
	    mxSetCell(plhs[0],7,mxCreateString("NumIntSteps"));	 	    
	    
	    if(nlhs>1) /* Required and optional fields */ 
	    {   plhs[1] = mxCreateCellMatrix(9,1);
	        mxSetCell(plhs[1],0,mxCreateString("FullGap"));
	        mxSetCell(plhs[1],1,mxCreateString("FringeInt1"));
	        mxSetCell(plhs[1],2,mxCreateString("FringeInt2"));
	        mxSetCell(plhs[1],3,mxCreateString("T1"));
	        mxSetCell(plhs[1],4,mxCreateString("T2"));
	        mxSetCell(plhs[1],5,mxCreateString("R1"));
	        mxSetCell(plhs[1],6,mxCreateString("R2"));
	        mxSetCell(plhs[1],7,mxCreateString("EdgeEffect1"));
	        mxSetCell(plhs[1],8,mxCreateString("EdgeEffect2"));
	    }
	}



}



