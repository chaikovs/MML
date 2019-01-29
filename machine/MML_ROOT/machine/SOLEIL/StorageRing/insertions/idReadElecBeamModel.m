function outModelData = idReadElecBeamModel(dir)
% - dir=nan => model is read from actual values in used in control room
%   (through soleilinit)
% - dir ='id' => model is read from saved data in id default directory 
%   (i.e. '/home/GrpGMI/HU36_SIRIUS')
% - dir='AnotherDirectory' => model is read from saved data in
%   'AnotherDirectory')
% - dir='' => model is read from current directory (which should be 
%   '/home/production/matlab/matlabML/machine/SOLEIL/StorageRing/insertions')
oldDirectory=pwd;
if  ~isnan(dir)
    if strcmp(dir, 'id')
        ModelDirectory=getfamilyData('Directory', idName);
    elseif strcmp(dir, '')
        ModelDirectory=pwd;
    else
        ModelDirectory=dir;
    end
    cd(ModelDirectory);
    load('BtX');
    load('BtZ');
    load('AlpX');
    load('AlpZ');
    load('EtaX');
    load('EtaZ');
    load('PhX');
    load('PhZ');
    load('NuXZ');
    Lring = 354.0968;
    MCF=4.4976e-4;
    NRJ=2.7391;
    cd(oldDirectory);
else
    % recalculate (?) or extract data from Laurent's functions
    % assuming you're in Control Room and soleilinit was executed
    [Btx, Btz] = modelbeta('BPMx');
    [Alpx, Alpz] = modeltwiss('alpha', 'BPMx');
    [Etax, Etaz] = modeldisp('BPMx');
    [Phx, Phz] = modelphase('BPMx');
    Nuxz = modeltune;
    Lring = getcircumference;
    MCF=getmcf;
    NRJ=getenergymodel;
end

outModelData.Btx = Btx;
outModelData.Btz = Btz;
outModelData.Alpx = Alpx;
outModelData.Alpz = Alpz;
outModelData.Etax = Etax;
outModelData.Etaz = Etaz;
outModelData.Phx = Phx;
outModelData.Phz = Phz;
outModelData.Nuxz = Nuxz;

outModelData.circ = 354.0968;  %how to read this from the model?
outModelData.alp1 = 4.4976e-4;
outModelData.E = 2.7391; 