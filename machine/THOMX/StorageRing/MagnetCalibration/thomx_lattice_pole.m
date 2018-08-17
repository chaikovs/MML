function ring=thomx_lattice_pole()
ring={...
       atmarker('DEBUT');...
       atmarker('SEPT');...
        atdrift('SD5B',0.74,'Energy',50000000);...
       atmarker('BPMx');...
       atmarker('BPMz');...
        atdrift('SD5',0.06,'Energy',50000000);...
   atquadrupole('QP1',0.15,-5.197395,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD2',0.21,'Energy',50000000);...
   atquadrupole('QP2',0.15,9.962261,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD31',0.7438635,'Energy',50000000);...
        atsbend('BEND',0.296233,0.785398,0,'BndMPoleSymplectic4Pass','EntranceAngle',0.0332,'ExitAngle',0.0332,'FullGap',0.02784,'FringeInt1',0.5,'FringeInt2',0.5,'FringeBendEntrance',3,'FringeBendExit',3,'FringeQuadEntrance',0,'FringeQuadExit',0,'Energy',50000000);...
        atdrift('SD3S2',0.1151135,'Energy',50000000);...
    atsextupole('SX1',1e-06,-6415727,'Energy',50000000);...
    atcorrector('HCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
    atcorrector('VCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
        atdrift('SD3S',0.075,'Energy',50000000);...
   atquadrupole('QP31',0.15,-10.33062,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD3S',0.075,'Energy',50000000);...
    atsextupole('SX3',1e-06,-3289547,'Energy',50000000);...
    atcorrector('HCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
    atcorrector('VCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
        atdrift('SD3S1',0.135,'Energy',50000000);...
   atquadrupole('QP41',0.15,6.888317,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD1S1B',0.06,'Energy',50000000);...
       atmarker('BPMx');...
       atmarker('BPMz');...
        atdrift('SD1S1',0.19,'Energy',50000000);...
    atsextupole('SX2',1e-06,2445860,'Energy',50000000);...
    atcorrector('HCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
    atcorrector('VCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
        atdrift('SD1S',0.075,'Energy',50000000);...
   atquadrupole('QP4',0.15,16.14904,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD2',0.21,'Energy',50000000);...
   atquadrupole('QP3',0.15,-17.91292,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD2SB',0.04,'Energy',50000000);...
       atmarker('BPMx');...
       atmarker('BPMz');...
        atdrift('SD2S',0.1851135,'Energy',50000000);...
        atsbend('BEND',0.296233,0.785398,0,'BndMPoleSymplectic4Pass','EntranceAngle',0.0332,'ExitAngle',0.0332,'FullGap',0.02784,'FringeInt1',0.5,'FringeInt2',0.5,'FringeBendEntrance',3,'FringeBendExit',3,'FringeQuadEntrance',0,'FringeQuadExit',0,'Energy',50000000);...
        atdrift('SD0',0.0901135,'Energy',50000000);...
       atmarker('IP');...
        atdrift('SD0',0.0901135,'Energy',50000000);...
        atsbend('BEND',0.296233,0.785398,0,'BndMPoleSymplectic4Pass','EntranceAngle',0.0332,'ExitAngle',0.0332,'FullGap',0.02784,'FringeInt1',0.5,'FringeInt2',0.5,'FringeBendEntrance',3,'FringeBendExit',3,'FringeQuadEntrance',0,'FringeQuadExit',0,'Energy',50000000);...
        atdrift('SD2S',0.1851135,'Energy',50000000);...
       atmarker('BPMx');...
       atmarker('BPMz');...
        atdrift('SD2SB',0.04,'Energy',50000000);...
   atquadrupole('QP3',0.15,-17.91292,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD2',0.21,'Energy',50000000);...
   atquadrupole('QP4',0.15,16.14904,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD1S',0.075,'Energy',50000000);...
    atsextupole('SX2',1e-06,2445860,'Energy',50000000);...
    atcorrector('HCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
    atcorrector('VCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
        atdrift('SD1S1',0.19,'Energy',50000000);...
       atmarker('BPMx');...
       atmarker('BPMz');...
        atdrift('SD1S1B',0.06,'Energy',50000000);...
   atquadrupole('QP41',0.15,6.888317,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD3S1',0.135,'Energy',50000000);...
    atsextupole('SX3',1e-06,-3289547,'Energy',50000000);...
    atcorrector('HCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
    atcorrector('VCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
        atdrift('SD3S',0.075,'Energy',50000000);...
   atquadrupole('QP31',0.15,-10.33062,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD3S',0.075,'Energy',50000000);...
    atsextupole('SX1',1e-06,-6415727,'Energy',50000000);...
    atcorrector('HCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
    atcorrector('VCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
        atdrift('SD3S2',0.1151135,'Energy',50000000);...
        atsbend('BEND',0.296233,0.785398,0,'BndMPoleSymplectic4Pass','EntranceAngle',0.0332,'ExitAngle',0.0332,'FullGap',0.02784,'FringeInt1',0.5,'FringeInt2',0.5,'FringeBendEntrance',3,'FringeBendExit',3,'FringeQuadEntrance',0,'FringeQuadExit',0,'Energy',50000000);...
        atdrift('SD31',0.7438635,'Energy',50000000);...
   atquadrupole('QP2',0.15,9.962261,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD2',0.21,'Energy',50000000);...
   atquadrupole('QP1',0.15,-5.197395,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD5',0.06,'Energy',50000000);...
       atmarker('BPMx');...
       atmarker('BPMz');...
        atdrift('SD5B',0.74,'Energy',50000000);...
     atrfcavity('RF',0,300000,500023113.724596,30,50000000);...
        atdrift('SD5B',0.74,'Energy',50000000);...
       atmarker('BPMx');...
       atmarker('BPMz');...
        atdrift('SD5',0.06,'Energy',50000000);...
   atquadrupole('QP1',0.15,-5.197395,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD2',0.21,'Energy',50000000);...
   atquadrupole('QP2',0.15,9.962261,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD31',0.7438635,'Energy',50000000);...
        atsbend('BEND',0.296233,0.785398,0,'BndMPoleSymplectic4Pass','EntranceAngle',0.0332,'ExitAngle',0.0332,'FullGap',0.02784,'FringeInt1',0.5,'FringeInt2',0.5,'FringeBendEntrance',3,'FringeBendExit',3,'FringeQuadEntrance',0,'FringeQuadExit',0,'Energy',50000000);...
        atdrift('SD3S2',0.1151135,'Energy',50000000);...
    atsextupole('SX1',1e-06,-6415727,'Energy',50000000);...
    atcorrector('HCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
    atcorrector('VCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
        atdrift('SD3S',0.075,'Energy',50000000);...
   atquadrupole('QP31',0.15,-10.33062,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD3S',0.075,'Energy',50000000);...
    atsextupole('SX3',1e-06,-3289547,'Energy',50000000);...
    atcorrector('HCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
    atcorrector('VCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
        atdrift('SD3S1',0.135,'Energy',50000000);...
   atquadrupole('QP41',0.15,6.888317,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD1S1B',0.06,'Energy',50000000);...
       atmarker('BPMx');...
       atmarker('BPMz');...
        atdrift('SD1S1',0.19,'Energy',50000000);...
    atsextupole('SX2',1e-06,2445860,'Energy',50000000);...
    atcorrector('HCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
    atcorrector('VCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
        atdrift('SD1S',0.075,'Energy',50000000);...
   atquadrupole('QP4',0.15,16.14904,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD2',0.21,'Energy',50000000);...
   atquadrupole('QP3',0.15,-17.91292,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD2SB',0.04,'Energy',50000000);...
       atmarker('BPMx');...
       atmarker('BPMz');...
        atdrift('SD2S',0.1851135,'Energy',50000000);...
        atsbend('BEND',0.296233,0.785398,0,'BndMPoleSymplectic4Pass','EntranceAngle',0.0332,'ExitAngle',0.0332,'FullGap',0.02784,'FringeInt1',0.5,'FringeInt2',0.5,'FringeBendEntrance',3,'FringeBendExit',3,'FringeQuadEntrance',0,'FringeQuadExit',0,'Energy',50000000);...
        atdrift('SD0',0.0901135,'Energy',50000000);...
        atdrift('SD0',0.0901135,'Energy',50000000);...
        atsbend('BEND',0.296233,0.785398,0,'BndMPoleSymplectic4Pass','EntranceAngle',0.0332,'ExitAngle',0.0332,'FullGap',0.02784,'FringeInt1',0.5,'FringeInt2',0.5,'FringeBendEntrance',3,'FringeBendExit',3,'FringeQuadEntrance',0,'FringeQuadExit',0,'Energy',50000000);...
        atdrift('SD2S',0.1851135,'Energy',50000000);...
       atmarker('BPMx');...
       atmarker('BPMz');...
        atdrift('SD2SB',0.04,'Energy',50000000);...
   atquadrupole('QP3',0.15,-17.91292,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD2',0.21,'Energy',50000000);...
   atquadrupole('QP4',0.15,16.14904,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD1S',0.075,'Energy',50000000);...
    atsextupole('SX2',1e-06,2445860,'Energy',50000000);...
    atcorrector('HCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
    atcorrector('VCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
        atdrift('SD1S1',0.19,'Energy',50000000);...
       atmarker('BPMx');...
       atmarker('BPMz');...
        atdrift('SD1S1B',0.06,'Energy',50000000);...
   atquadrupole('QP41',0.15,6.888317,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD3S1',0.135,'Energy',50000000);...
    atsextupole('SX3',1e-06,-3289547,'Energy',50000000);...
    atcorrector('HCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
    atcorrector('VCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
        atdrift('SD3S',0.075,'Energy',50000000);...
   atquadrupole('QP31',0.15,-10.33062,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD3S',0.075,'Energy',50000000);...
    atsextupole('SX1',1e-06,-6415727,'Energy',50000000);...
    atcorrector('HCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
    atcorrector('VCOR',1e-06,[0 0],'PolynomA',0,'PolynomB',0,'NumIntSteps',1,'MaxOrder',1,'Energy',50000000);...
        atdrift('SD3S2',0.1151135,'Energy',50000000);...
        atsbend('BEND',0.296233,0.785398,0,'BndMPoleSymplectic4Pass','EntranceAngle',0.0332,'ExitAngle',0.0332,'FullGap',0.02784,'FringeInt1',0.5,'FringeInt2',0.5,'FringeBendEntrance',3,'FringeBendExit',3,'FringeQuadEntrance',0,'FringeQuadExit',0,'Energy',50000000);...
        atdrift('SD31',0.7438635,'Energy',50000000);...
   atquadrupole('QP2',0.15,9.962261,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD2',0.21,'Energy',50000000);...
   atquadrupole('QP1',0.15,-5.197395,'StrMPoleSymplectic4Pass','Energy',50000000);...
        atdrift('SD5',0.06,'Energy',50000000);...
       atmarker('BPMx');...
       atmarker('BPMz');...
        atdrift('SD5B',0.74,'Energy',50000000);...
       atmarker('FIN');...
};
end
