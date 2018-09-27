%The user should write text describing the m-files found in this directory
%The top three lines will not be overwritten in subsequent versions of Contents.m
%PLEASE replace these three header lines with MEANINGFUL text
%  
%ADDAOPREFIX - Adds prefix to all AcceleratorObjects PV names
%AOKEEP - Removes families from the Accelerator Families except those included in KEEPLIST
%CELL2FIELD - Converts a cell array to a strucutre array
%CHECKLIMITS - Checks whether setpoints exeeds min and max limits (range) 
%COMMON2DEV - Converts common nmaes to device lists
%COMMON2FAMILY - Converts common to family names
%COMMON2HANDLE - Returns handles for common names
%DEV2COMMON - Converts Device lists to common names
%DEV2ELEM - Converts an element list to a device list
%EDITLIST - Edits a list
%ELEM2DEV - Converts a device list to an element list
%FAMILY2COMMON - Converts family to common names
%FAMILY2DEV - Returns the device list for a family
%FAMILY2HANDLE - Returns handles for a family
%FAMILY2STATUS - Returns status of devices
%FAMILY2TOL - Gives Tolerances for a field family
%FAMILY2UNITS - Gives units corresponding to the Family.Field
%FIELD2CELL - Converts a structure to a cell array
%FINDKEYWORD - Finds a keyword with a cell of strings
%FINDROWINDEX - Finds row index
%GETAM - Gets monitor channels
%GETFAMILYDATA - Gets data associated with the accelerator control 
%GETFAMILYLIST - Returns a list of all the family names (string matrix)
%GETFAMILYTYPE - Returns the family type (string matrix)
%GETLIST - Returns Device List for a Family
%GETMAXSP - Maximum value of the setpoint
%GETMEMBEROF - Returns the membership information of a family (cell of strings)
%GETMINSP - Gets minimum value of the setpoint
%GETMODE - Returns the present family mode ('Online', 'Simulator', 'Manual', 'Special', etc)
%GETPV - Gets a TANGO attribute (or AT simulated channel)
%GETRUNFLAG - Returns whether setpoint is reached or not
%GETSP - Gets setpoint channels
%GETSPOS - Gets S-position of family or element
%GETTOL - Returns the tolerance between the setpoint and monitor 
%GETUNITS - Returns the present family units ('Hardware' or 'Physics')
%ISFAMILY - True for family names
%ISMEMBEROF - Returns turn if the membership information of a family (cell of strings)
%LOADAT - Re-loads AT model
%MEASRATE - noise on channels
%MONMAGS - Monitors all magnet power supplies and plots various statistics
%MONRATES - Tests the analog monitor data rate for BPMs and corrector magnets
%RAW2REAL - Converts raw control system data to calibrated values
%REAL2RAW - Converts calibrated data to raw control system values
%SETAM - Sets analog monitor value
%SETPV - Absolute setpoint change via MATLAB channel access or AT simulator
%SETSP - Absolute setpoint change to the 'Setpoint' field
%SHOWFAMILY - Prints out the family structure
%STEPPV - Incremental setpoint change via MATLAB channel access or AT simulator
%STEPSP - Setps setpoints
