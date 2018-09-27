function SOFB_ON_OFF(YES_NO)
SOFBDevServAttr=['ANS/DG/PUB-SOFB/state'];
writeattribute(SOFBDevServAttr,YES_NO);
end