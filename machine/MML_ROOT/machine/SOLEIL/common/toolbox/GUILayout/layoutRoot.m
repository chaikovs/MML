function folder = layoutRoot()
%layoutRoot  returns the folder containing the layout toolbox
%
%   folder = layoutRoot() returns the full path to the folder containing
%   the layout toolbox.
%
%   Examples:
%   >> folder = layoutRoot()
%   folder = 'C:\Temp\LayoutToolbox1.0'
%
%   See also: layoutVersion

%   Copyright 2009-2010 The MathWorks Ltd.
%   1.1    
%   2012/05/08 08:02:59

folder = fileparts( mfilename( 'fullpath' ) );