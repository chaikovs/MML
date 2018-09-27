function temp(CurrentToSet)

attrBX1Current='ANS-C04/EI/M-HU256.2_BX1/current';
attrBX2Current='ANS-C04/EI/M-HU256.2_BX2/current';
writeattribute(attrBX1Current, CurrentToSet);
writeattribute(attrBX2Current, CurrentToSet);