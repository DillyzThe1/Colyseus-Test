@echo off
title Colyseus Test - Build Screen
set /p menu="Build game? [Y/N/C]"
       if %menu%==Y goto BuildGame
       if %menu%==y goto BuildGame
       if %menu%==N goto CancelGame
       if %menu%==n goto CancelGame
       if %menu%==C goto Credits
       if %menu%==c goto Credits
       cls
	   
:BuildGame 
cls
title Colyseus Test - Building
set /p menu="Build debug? [Y/N/C]"
       if %menu%==Y goto BuildDebug
       if %menu%==y goto BuildDebug
       if %menu%==N goto BuildRelease
       if %menu%==n goto BuildRelease
       if %menu%==C goto Credits
       if %menu%==c goto Credits
       cls
	   
:BuildDebug
cls
title Colyseus Test - Building Debug
echo Compiling, please wait...
lime test windows -debug
echo.
echo Debug build complete.
set /p menu="Recompile? [Y/N/C]"
       if %menu%==Y goto BuildDebug
       if %menu%==y goto BuildDebug
       if %menu%==N goto CancelGame
       if %menu%==n goto CancelGame
       if %menu%==C goto Credits
       if %menu%==c goto Credits
       cls
exit
	   
:BuildRelease
cls
title Colyseus Test - Building
echo Compiling, please wait...
lime test windows -release
echo.
echo Relase build complete.
set /p menu="Recompile? [Y/N/C]"
       if %menu%==Y goto BuildRelease
       if %menu%==y goto BuildRelease
       if %menu%==N goto CancelGame
       if %menu%==n goto CancelGame
       if %menu%==C goto Credits
       if %menu%==c goto Credits
       cls
exit

:CancelGame 
cls
title Colyseus Test - Cancelling
echo Build aborted. Press any key to continue.
exit 

:Credits
cls
title Colyseus Test - Credits
echo Colyseus Test
echo.
echo Dev links:
echo https://www.github.com/DillyzThe1
echo.
echo.
echo Press any key to continue.
exit
