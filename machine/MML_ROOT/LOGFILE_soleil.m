% Logfile for modification of the MML

%June 29th 2007

1/ getcod : THERING -> RING
   orbit = findorbit4(THERING,DP,1:length(RING)+1);
   
2/ monbpm : Added Summary FLag to sort BPM by STD decreasing values.

% August 29th, 2007

1/ aoinit and setoperational mode changed with SOLEIL path (case + path updated)

2/ save_boo.m modified to use generic command for path 

3/ gethbpmgroup : error message display better formated

% September 1th, 2007
4/ checklimits.m
MinPV = minpv(Family, Field, UnitsFlagCell{:});
MaxPV = maxpv(Family, Field, UnitsFlagCell{:});
becomes
MinPV = minpv(Family, DeviceList, Field, UnitsFlagCell{:});
MaxPV = maxpv(Family, DeviceList, Field, UnitsFlagCell{:});

5/ measbpmresp Modified Message before measurement

6/ bba_last.m BBAgui_last.m
Bug discovered after summer shutdown. Ugly Patch applied
Increased speed for reading bpm and correctors.

7/getdipolesourcepoint.
Added new beamlines. SMIS, AILES, DISCO, METRO, MARS

8/ getdisp.m 
Added See Also section

September 5th, 2007

9/ getdipolesourcepoint. : correction for SMIS, AILES and MARS

10/ Ajout points sources dans soleilinit

11/ Monbpm - option summary

12/ monbpmhistory - Format similar to monbpm (not yet fully operational)

September 10th, 2007

13/ plotfamily
- bar/Line switch from G. Portmann
- Possibility to compare to file (buttons File2 added)
- Disabled Setpoitchange from G. Portmann
- plotfamilystartup (Arc, straigth section, superperiods)

September 11th, 2007

14/ Configgui Get/SetFileConfig : write Filename in logging window

15/ MagnetCycle, RingCycling 
Configure HCOR and VCOR for ANS
Plot cycling curves

September 17th, 2007

16/ buildlocofitparameters: new weigth after reduction of noise of BPM 1e-3

17/ analoco: analysis of data results

18/ setpathsoleil: reduction of window size

October 1st, 2007

19/ setoperationmode and aoinit modified. Now Opsdata is located in the directorytree of measdata (instead of machione).

October 21st, 2007

20/ Modications for HU640
a/ new version of lattices with HU640 correctors
solamor2linb.m
solamor2linb_HU640.m
All other lattices have to be modified !!! (TODO)

b/ switchHU640Cor.m
Switch the status to 1 or 0 for HU640 correctors

c/ setoperationalmode.m
New mode for HU640 and use of new strucutre per Machine mode (subdirectory) and setmmldirectory

d/ soleilinit.m
HU640 correctors added as extra correctors in HCOR and VCOR families
New and better way to define devices without usinf the TANGO staticDB
If success, has to be extened to other families

e/ orbitcontrol
- integration of HU640 as an experimental mode
- list of VCM and HCM depends now on SOLEILeilinit and status flag

f/ setmmldirectories : 
- Opsadata in measdata instead of Opsdata ???
- GoldenConfig becomes GoldenLattice   

g/ solorbit
New version. Switch by hand between HU640 and normal operation
See files solobrit.m and soleilrestore.m
To be cleaned later on

October 28th, 2007
    
21/orbitcontrol: add weight for BPM and correctors
  
22/setorbitdefault: comments 

23/orbitcorrectionmethods.m
Default weights are ones and not based en Rmat

October 28th, 2007
21/orbitcontrol: add weight for BPM and correctors
It was not working when removing BPM and correctors

November 1st, 2007
22/ for low alpha run
setoperationalmode + magnet_coefficient_alpha1by20 call
new lattice lowalpha1by20_maher.m
Kvalue.m
test_lowalpha.m
soleilinit (range quad)

23/ physics_mcf - Computes momentum compaction factor up to 3rd order  

November 4th, 2007
24/ restoreorbit patched: dispersion no read from Golden lattice
Warning vertical dispersion set to zero!

December 5th, 2007
25/ new functions for kickerEM: softtrigger, switchsynchro, KEMgui, switchbpm

February 18th, 2008
26/ orbitcontrol modified by 
Try catch mechanism added when TANGO error on masterclock. Try thrice before stopping the SOFB

February 29th, 2008
27/ measbpmresp4FOFB and getbpmresp4FOFB : program for FOFB Rmatrix

July 22th, 2008
getattribut modified for accepting attribute with a point in the name

September 2nd, 2008
Compilation and deployement: mml_cc_appli
getbpmBBAoffsets: read BBA offsets from TANGO

November 4th, 2008
solamor2linc.m modified to fit tunes and chromaticities (2.0 in both planes)
new loco version. Used of symbolic links bothe for the application and for the buildlocofitparameters
Correction of bug of standalone application. Wrong path since RUN6 (due to update of TANGO librairies).

January, 26th, 2009
LT1cycling modified. 'Config' instead of 'NoConfig' flag activated for 'Load command'. (it was not working)

January, 29th, 2009
Modified files: getsnifferorbit, getsnifferoffset, getsnifferorbit, getsnifferorbit

March 1st-4th, 2009
Meas data now store on Active Circle
New command getmmldataroot   /nfs/ruche-rcm/rcm-data/data4mml/

New standard lattice with steerer [1 1] lat_2020_3170a put in production

measbpmresp: minor correction ModeFlag was missing in a few areas

March 24, 2009
new function analocodata for plotting some useful information from LOCO
locogui modified to to plot QT 

Coupling and GAIN of BPM
Add new function family2coupling return coupling matrix for each BPM
plotdisp and measdisp modified for Online to take into acoount coupling measurement
setmmldirrectory modified to set Goldenmatrix for Gain and couling of the BPM

March 30 2009
Summer time in tango_shift_time

June 16, 2009
New lattice and magnetcoefficient modele June 2009
copybpmresp4FOFBfile.m
lattice_prep.m File for preparation of matrices for a new lattice

August 2009
BBA
quad2bpm.m        quadcenter.m     quadgetstepPS.m  quadsetup.m
quadcalcoffset.m  quaderrors.m     quadplotall.m    
quadcenterinit.m  quadgetbetaKL.m  quadplot.m quadgetdata.m

Modifed functions
getsigma, plotoffsetorbit for BBA
aoinit.m (anneau) for BBA
setoperationmonde for BBA
setpathsoleil for BBA
setorbitH Bug
setorbitV Bug
bpm2quad for BBA
getbpmBBAoffsets for getting devicelist

New functions 
getshift, plotmonbpm
bpm2quad4bba
tangodev2dev

27 August 2009
getbpmaverages set to 0.1 seconds
tangogetrunflag

23 November 2009
loco_build_BPMmat: to be LOCO Coupling/gain from Rmat -- TO be continue

3 December 2009
tango_read_attribute2 - modified to handle vectors

8 December 2009
lattice_prep.m - modified for dispersion, it was wrong
setoperationmode - modified for nanoscopium

9 Decembre 2009
soleilinit, updateatindex modified for sextupole AT group
