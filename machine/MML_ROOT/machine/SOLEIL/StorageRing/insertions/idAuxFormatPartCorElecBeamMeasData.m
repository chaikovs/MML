function sRes = idAuxFormatPartCorElecBeamMeasData(sOrig)
%err = 0;
% endLineInds = strfind(sOrig, '\n');
% if(length(endLineInds) <= 0)
%     err = 1;
%     fprintf('Incorrect input string format');
% end

dlm = char(10);
 
[sBkgHE1, remain] = strtok(sOrig, dlm);
[sHE01, remain] = strtok(remain, dlm);
[sHE02, remain] = strtok(remain, dlm);
[sHE03, remain] = strtok(remain, dlm);
sBkgHE2 = sHE03;
[sHE04, remain] = strtok(remain, dlm);
[sHE05, remain] = strtok(remain, dlm);

[sBkgVE1, remain] = strtok(remain, dlm);
[sVE01, remain] = strtok(remain, dlm);
[sVE02, remain] = strtok(remain, dlm);
[sVE03, remain] = strtok(remain, dlm);
sBkgVE2 = sVE03;
[sVE04, remain] = strtok(remain, dlm);
[sVE05, remain] = strtok(remain, dlm);

[sBkgHS1, remain] = strtok(remain, dlm);
[sHS01, remain] = strtok(remain, dlm);
[sHS02, remain] = strtok(remain, dlm);
[sHS03, remain] = strtok(remain, dlm);
sBkgHS2 = sHS03;
[sHS04, remain] = strtok(remain, dlm);
[sHS05, remain] = strtok(remain, dlm);

[sBkgVS1, remain] = strtok(remain, dlm);
[sVS01, remain] = strtok(remain, dlm);
[sVS02, remain] = strtok(remain, dlm);
[sVS03, remain] = strtok(remain, dlm);
sBkgVS2 = sVS03;
[sVS04, remain] = strtok(remain, dlm);
sVS05 = strtok(remain, dlm);

sRes = '            if strcmp(corName, ''CHE'')\n';
sRes = strcat(sRes, '                fnMeasMain = cellstr([''', sHE01, ''';\n');
sRes = strcat(sRes, '                                      ''', sHE02, ' '';\n');
sRes = strcat(sRes, '                                      ''', sHE03, '  '';\n');
sRes = strcat(sRes, '                                      ''', sHE04, '  '';\n');
sRes = strcat(sRes, '                                      ''', sHE05, ' '']);\n');
sRes = strcat(sRes, '                fnMeasBkgr = cellstr([''', sBkgHE1, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgHE1, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgHE2, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgHE2, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgHE2, ''']);\n');
sRes = strcat(sRes, '            elseif strcmp(corName, ''CVE'')\n');
sRes = strcat(sRes, '                fnMeasMain = cellstr([''', sVE01, ''';\n');
sRes = strcat(sRes, '                                      ''', sVE02, ' '';\n');
sRes = strcat(sRes, '                                      ''', sVE03, '  '';\n');
sRes = strcat(sRes, '                                      ''', sVE04, '  '';\n');
sRes = strcat(sRes, '                                      ''', sVE05, ' '']);\n');
sRes = strcat(sRes, '                fnMeasBkgr = cellstr([''', sBkgVE1, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgVE1, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgVE2, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgVE2, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgVE2, ''']);\n');
sRes = strcat(sRes, '            elseif strcmp(corName, ''CHS'')\n');
sRes = strcat(sRes, '                fnMeasMain = cellstr([''', sHS01, ''';\n');
sRes = strcat(sRes, '                                      ''', sHS02, ' '';\n');
sRes = strcat(sRes, '                                      ''', sHS03, '  '';\n');
sRes = strcat(sRes, '                                      ''', sHS04, '  '';\n');
sRes = strcat(sRes, '                                      ''', sHS05, ' '']);\n');
sRes = strcat(sRes, '                fnMeasBkgr = cellstr([''', sBkgHS1, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgHS1, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgHS2, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgHS2, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgHS2, ''']);\n');
sRes = strcat(sRes, '            elseif strcmp(corName, ''CVS'')\n');
sRes = strcat(sRes, '                fnMeasMain = cellstr([''', sVS01, ''';\n');
sRes = strcat(sRes, '                                      ''', sVS02, ' '';\n');
sRes = strcat(sRes, '                                      ''', sVS03, '  '';\n');
sRes = strcat(sRes, '                                      ''', sVS04, '  '';\n');
sRes = strcat(sRes, '                                      ''', sVS05, ' '']);\n');
sRes = strcat(sRes, '                fnMeasBkgr = cellstr([''', sBkgVS1, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgVS1, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgVS2, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgVS2, ''';\n');
sRes = strcat(sRes, '                                      ''', sBkgVS2, ''']);\n');
sRes = strcat(sRes, '            end\n');
