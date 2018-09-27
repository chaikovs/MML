function test()
fid=fopen('/home/operateur/GrpGMI/HU256_CASSIOPEE/MatlabScripts/TestChar', 'a')
toto={'a'; 'b '; 'c  '};
totochar=char(toto);
alphachar=['a  '; 'ab '; 'abc'];
fwrite (fid, alphachar);
%fprintf(fid, '%s', alphachar);
fclose(fid);