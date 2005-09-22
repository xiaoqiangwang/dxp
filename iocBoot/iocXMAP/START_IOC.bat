REM Tell medm where to look for .adl files.  If this environment variable is already set then
REM comment out the following line
set EPICS_DISPLAY_PATH=..\..\dxpApp\op\adl;..\..\..\mca\mcaApp\op\adl;..\..\..\autosave\asApp\op\adl
REM Note that we must use the Windows "start" command or medm won't find X11 dlls
start medm -x -macro "P=dxpXMAP:, D=dxp1, M=mca1" single_dxp_top.adl
REM Put Cygwin in the path so the EPICS application can find cygwin1.dll
PATH=c:\cygwin\bin;C:\XIA_xmap_dlls
..\..\bin\cygwin-x86\xmapApp.exe st.cmd