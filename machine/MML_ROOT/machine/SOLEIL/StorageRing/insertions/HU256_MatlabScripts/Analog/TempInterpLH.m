function [BZPCurrentsInterp, CVECurrentsInterp, CHECurrentsInterp, CVSCurrentsInterp, CHSCurrentsInterp]=TempInterpLH()


BZPCurrentsi1=0:-10:-200;
BZPCurrentsi2=-200:10:200;
BZPCurrentsi3=200:-10:0;


BZPCurrentsTemp1= [000.000	-020.000	-040.000	-060.000	-080.000	-100.000	-120.000	-140.000	-160.000	-180.000	-200.000];
CVECurrentsTemp1= [000.000	000.010	000.030	000.040	000.050	000.060	000.070	000.080	000.100	000.120	000.140];
CHECurrentsTemp1= [000.000	-000.030	-000.050	-000.070	-000.100	-000.130	-000.160	-000.200	-000.230	-000.270	-000.330];
CVSCurrentsTemp1= [000.000	000.020	000.030	000.050	000.070	000.090	000.110	000.140	000.170	000.200	000.230];
CHSCurrentsTemp1= [000.000	-000.020	-000.040	-000.060	-000.080	-000.100	-000.130	-000.150	-000.180	-000.220	-000.260];

BZPCurrentsTemp2= [-200.000	-180.000	-160.000	-140.000	-120.000	-100.000	-080.000	-060.000	-040.000	-020.000	000.000	020.000	040.000	060.000	080.000	100.000	120.000	140.000	160.000	180.000	200.000];
CVECurrentsTemp2= [000.140	000.110	000.090	000.070	000.050	000.030	000.030	000.010	000.000	-000.020	-000.040	-000.050	-000.070	-000.070	-000.080	-000.090	-000.090	-000.090	-000.090	-000.090	-000.090];
CHECurrentsTemp2= [-000.330	-000.270	-000.230	-000.190	-000.150	-000.100	-000.070	-000.030	000.000	000.020	000.040	000.070	000.080	000.110	000.140	000.170	000.200	000.240	000.280	000.320	000.370];
CVSCurrentsTemp2= [000.230	000.200	000.160	000.130	000.110	000.090	000.070	000.050	000.030	000.010	000.000	-000.020	-000.030	-000.040	-000.040	-000.050	-000.050	-000.050	-000.050	-000.050	-000.050];
CHSCurrentsTemp2= [-000.260	-000.200	-000.170	-000.150	-000.110	-000.080	-000.050	-000.020	000.010	000.030	000.050	000.060	000.080	000.100	000.120	000.150	000.170	000.200	000.230	000.260	000.300];

BZPCurrentsTemp3= [200.000	180.000	160.000	140.000	120.000	100.000	080.000	060.000	040.000	020.000	000.000];
CVECurrentsTemp3= [-000.090	-000.090	-000.080	-000.080	-000.080	-000.080	-000.080	-000.070	-000.060	-000.050	000.000];
CHECurrentsTemp3= [000.370	000.320	000.280	000.240	000.190	000.140	000.100	000.070	000.040	000.010	000.000];
CVSCurrentsTemp3= [-000.050	-000.050	-000.050	-000.040	-000.040	-000.040	-000.040	-000.030	-000.020	-000.010	000.000];
CHSCurrentsTemp3= [000.300	000.250	000.220	000.190	000.160	000.120	000.090	000.060	000.040	000.010	000.000];

CVECurrentsInterp1=interp1(BZPCurrentsTemp1, CVECurrentsTemp1, BZPCurrentsi1);
CHECurrentsInterp1=interp1(BZPCurrentsTemp1, CHECurrentsTemp1, BZPCurrentsi1);
CVSCurrentsInterp1=interp1(BZPCurrentsTemp1, CVSCurrentsTemp1, BZPCurrentsi1);
CHSCurrentsInterp1=interp1(BZPCurrentsTemp1, CHSCurrentsTemp1, BZPCurrentsi1);

CVECurrentsInterp2=interp1(BZPCurrentsTemp2, CVECurrentsTemp2, BZPCurrentsi2);
CHECurrentsInterp2=interp1(BZPCurrentsTemp2, CHECurrentsTemp2, BZPCurrentsi2);
CVSCurrentsInterp2=interp1(BZPCurrentsTemp2, CVSCurrentsTemp2, BZPCurrentsi2);
CHSCurrentsInterp2=interp1(BZPCurrentsTemp2, CHSCurrentsTemp2, BZPCurrentsi2);

CVECurrentsInterp3=interp1(BZPCurrentsTemp3, CVECurrentsTemp3, BZPCurrentsi3);
CHECurrentsInterp3=interp1(BZPCurrentsTemp3, CHECurrentsTemp3, BZPCurrentsi3);
CVSCurrentsInterp3=interp1(BZPCurrentsTemp3, CVSCurrentsTemp3, BZPCurrentsi3);
CHSCurrentsInterp3=interp1(BZPCurrentsTemp3, CHSCurrentsTemp3, BZPCurrentsi3);

BZPCurrentsInterp= [BZPCurrentsi1 BZPCurrentsi2 BZPCurrentsi3];
CVECurrentsInterp=[CVECurrentsInterp1 CVECurrentsInterp2 CVECurrentsInterp3];
CHECurrentsInterp=[CHECurrentsInterp1 CHECurrentsInterp2 CHECurrentsInterp3];
CVSCurrentsInterp=[CVSCurrentsInterp1 CVSCurrentsInterp2 CVSCurrentsInterp3];
CHSCurrentsInterp=[CHSCurrentsInterp1 CHSCurrentsInterp2 CHSCurrentsInterp3];
 





 





 