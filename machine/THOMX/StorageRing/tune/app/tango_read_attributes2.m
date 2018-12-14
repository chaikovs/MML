function args = tango_read_attributes2(dev,var1)
    
   % args(1).value = linspace(0,1,400);
   
    thomx_ring=ThomX_017_064_r56_02_chro00;

    
    Z0=[0.001 0.0 0.0001 0 0 0]';
    Z1=[0.001 0 0.0001 0 0 0]';
    Nturns = 1026;

    [X1,lost_thomx]=ringpass(thomx_ring,Z0,Nturns); %(X, PX, Y, PY, DP, CT2 ) 
    BPMindex = family2atindex('BPMx',getlist('BPMx'));
    X2 = linepass(thomx_ring, X1, BPMindex);
    
    BPMx = reshape(X2(1,:), Nturns, length(BPMindex));
    BPMy = reshape(X2(3,:), Nturns, length(BPMindex));
    
   % Xnoise = X + 0.002*randn(size(X))
    %args(1).value = rand(400);
    args(1).value = 1000.*(BPMx(:,1)' + 0.001*randn(1,length(BPMx(:,1))));
    
    if var1{1,1}=='ZPosDD'
        args(1).value = 1000.*(BPMy(:,1)' + 0.0001*randn(1,length(BPMy(:,1))));
    end;
    
end
