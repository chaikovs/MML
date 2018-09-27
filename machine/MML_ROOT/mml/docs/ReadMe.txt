Install directions:
1.  Expand the zip files.  The top level Middle Layer directory tree is the following.

	<MiddleLayerDirectory>acceleratorcontrol
        <MiddleLayerDirectory>acceleratorlink
        <MiddleLayerDirectory>applications/loco
        <MiddleLayerDirectory>at
        <MiddleLayerDirectory>atold
        <MiddleLayerDirectory>machine

    acceleratorcontrol, at, and applications are in one zip file.
    acceleratorlink and machine directories are in separate zip files.

2.  Run the appropriate set path function.  For the ALS,
    >>  run <MiddleLayerDirectory>setpathals

    As long as the Middle Layer subdirectory layout is not changed, the
    MiddleLayerDirectory tree can be moved anywhere.  The path is set by the
    location of the set path function.

    A good test is to run plotfamily.  Try getting an orbit, adding the
    lattice drawing to the plot, etc.  There are about 11 rings presently simulated.
    Look in the machine directory to see which accelerators you have.
    Usually the als, spear3, xray, vuv are the only accelerators distributed
    with the release.  If you want the setup files for another accelerator
    it's best to contact them directly.  I don't give out the setup software
    for other accelerators without their consent.

3.  You might need to change which Matlab-to-control system link to use.
    Look in the acceleratorlink directory to see what's available.

    Note: For EPICS users:
          1. MCA does not need any additions to environment variables.
          2. If using labCA or SCA the library path will need to be changed.
	     For example:
             a. LabCA on Solaris, add to the LD_LIBRARY_PATH
                <MiddleLayerDirectory>acceleratorlink/labca/lib/solaris-sparc
             b. SCA on Solaris, add to the LD_LIBRARY_PATH
                <MiddleLayerDirectory>acceleratorlink/sca/lib/solaris-sparc

4. The AT simulator and LOCO are not needed for the middle layer but it's very nice to
   have them working.  I include them in the distribution.  The AT version is the one I
   use and have tested with the Middle Layer and LOCO.  For the latest AT release and
   important information about changes to AT see Andrei’s website.
   http://www.slac.stanford.edu/~terebilo/at/

   Note: The new AT does not work on linux when using a Matlab version
         less than 7.  I'm not sure why, but I prefer to upgrade Matlab or use
         an older AT version than to figure it out.  The set path function will
         select the proper version.  However, if using an older AT, then
         the environmental variable ATROOT needs to be defined.
         ATROOT = <MiddleLayerDirectory>/at_old
         The new AT does not require an environmental variable ATROOT.

5. To create a setup for a new accelerator look at the ALS or a simpler ring like vuv for an
   example.  The basics tasks are the following.
   a. Write a setpath<name> file in acceleratorcontrol
   b. Create new acclerator directories under the machine directory.
      Write a new aoinit, setoperationalmode, and updateatindex files as well
      as an AT deck.
   This process usually takes a couple days to get correct.  Look in the
   MiddleLayerManual.doc in the docs directory for some guidance.  Since the
   setup is not well documented feel free to contact me for more help.

6. If you find any bugs in the software please contact me.  I'm trying to make
   the software as bug free as possible.  Also, if you write a new function that would be
   useful for other accelerators please send it to me to be included in future releases.


Greg Portmann
gjportmann@lbl.gov
1-510-486-4105

