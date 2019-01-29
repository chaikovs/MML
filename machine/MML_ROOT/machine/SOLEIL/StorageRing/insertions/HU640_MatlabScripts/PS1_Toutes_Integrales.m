function PS1_Toutes_Integrales(SESSION,MinCur,MaxCur,StepCur,Xmin,Xmax,Step)
 fprintf ('%s\n','')
 fprintf ('%s\n','Courant[A]        Bump[mm]        IXe[G.m]        IXs[G.m]        IZe[G.m]        IZs[G.m]')
for PS1=MaxCur:-StepCur:MinCur
    for X=Xmin:Step:Xmax
        PS1_Integrales(SESSION,PS1,X)
    end
    fprintf ('%s\n','--------------------------------------------------------------------------------------------')
end