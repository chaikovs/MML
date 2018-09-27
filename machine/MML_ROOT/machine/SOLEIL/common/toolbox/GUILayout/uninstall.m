function uninstall()
%uninstall  remove the layout package from the MATLAB path
%
%   uninstall() removes the layout tools from the MATLAB path.
%
%   Examples:
%   >> uninstall()
%
%   See also: install

%   Copyright 2008-2010 The MathWorks Ltd.
%   1.1    
%   2012/05/08 08:02:59

thisdir = fileparts( mfilename( 'fullpath' ) );

rmpath( thisdir );
rmpath( fullfile( thisdir, 'layoutHelp' ) );
rmpath( fullfile( thisdir, 'Patch' ) );
savepath();