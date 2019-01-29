function [M]=Transpot_M_z(z)
  if((z>0)&(z<d_0_M1))|(z==d_0_M1)|(z==0)
    M=drift_f(z);

elseif ((z>d_0_M1)&(z<d_0_M1+d_M1_M2))|(z==d_0_M1+d_M1_M2)
  dz=z-d_0_M1;
  M=drift_f(dz)*Flat_Mirror_f()*drift_f(d_0_M1);

  elseif ((z>d_0_M1+d_M1_M2)&(z<d_0_M1+d_M1_M2+d_L1_Ue))|(z==d_0_M1+d_M1_M2+d_L1_Ue) 
  dz=z-(d_0_M1+d_M1_M2);
  M=drift_f(dz)*Flat_Mirror_f()*drift_f(d_M1_M2)*Flat_Mirror_f()*drift_f(d_0_M1);

  elseif ((z>d_0_M1+d_M1_M2+d_M2_L1)&(z<d_0_M1+d_M1_M2+d_M2_L1+d_L1_Ue))|(z==d_0_M1+d_M1_M2+d_M2_L1+d_L1_Ue) 
  dz=z-(d_0_M1+d_M1_M2+d_M2_L1);
  M=drift_f(dz)*lens_f(f1)*drift_f(d_M2_L1)*Flat_Mirror_f()*drift_f(d_M1_M2)*Flat_Mirror_f()*drift_f(d_0_M1);
  
  elseif ((z>d_0_M1+d_M1_M2+d_M2_L1+d_L1_Ue)&(z<d_0_M1+d_M1_M2+d_M2_L1+d_L1_Ue+d_Ue_Uc))|(z==d_0_M1+d_M1_M2+d_M2_L1+d_L1_Ue+d_Ue_Uc) 
  dz=z-(d_0_M1+d_M1_M2+d_M2_L1+d_L1_Ue);
  M=drift_f(dz)*drift_f(d_L1_Ue)*lens_f(f1)*drift_f(d_M2_L1)*Flat_Mirror_f()*drift_f(d_M1_M2)*Flat_Mirror_f()*drift_f(d_0_M1);

  elseif ((z>d_0_M1+d_M1_M2+d_M2_L1+d_L1_Ue+d_Ue_Uc)&(z<d_0_M1+d_M1_M2+d_M2_L1+d_L1_Ue+d_Ue_Uc+d_Uc_Ux))|(z==d_0_M1+d_M1_M2+d_M2_L1+d_L1_Ue+d_Ue_Uc+d_Uc_Ux) 
  dz=z-(d_0_M1+d_M1_M2+d_M2_L1+d_L1_Ue+d_Ue_Uc);
  M=drift_f(dz)*drift_f(d_Ue_Uc)*drift_f(d_L1_Ue)*lens_f(f1)*drift_f(d_M2_L1)*Flat_Mirror_f()*drift_f(d_M1_M2)*Flat_Mirror_f()*drift_f(d_0_M1);

  else printf('out of modulator\n')
  M=[0,0;0,0];
  end
