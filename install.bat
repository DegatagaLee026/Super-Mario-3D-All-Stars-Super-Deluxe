@echo off
cd /d "%~dp0"

:WELCOME
cls
echo =====================================================
echo Super Mario 3D All-Stars Super Deluxe Installer v1.0
echo =====================================================
echo.
echo Welcome! Thank you for downloading my mod!
echo This is the first script I've ever made, so any feedback is greatly appreciated.
echo.
echo.
echo Before we begin, please paste the path to your "Super Mario 3D All-Stars Deluxe" folder below.
echo If your path is valid, you will automatically be brought to the main menu.

:FOLDER_LOCATION
echo.
setlocal EnableDelayedExpansion
set /p frontend=Super Mario 3D All-Stars Deluxe folder:
set "frontend=!frontend:"=!"
endlocal & set "frontend=%frontend%"

	if exist "%frontend%\Super Mario 3D All-Stars DELUXE.bat" if exist "%frontend%\launcher\" if exist "%frontend%\data\" goto MENU
	
	echo.
	echo.
	echo.
	echo Path is Invalid! Please try again.
	echo Make sure you selected the correct folder.
	echo.
	echo If you are unsure what to look for, locate the folder that contains "Super Mario 3D All-Stars DELUXE.bat".
	echo Next, left click the folder once, make sure it's highlighted, and press Ctrl+Shift+C. 
	echo Finally, come back here and press Ctrl+V below...
	goto FOLDER_LOCATION


:MENU
cls
echo =====================================================
echo Super Mario 3D All-Stars Super Deluxe Installer v1.0
echo =====================================================
echo.
echo ----------
echo Main Menu
echo ----------
echo If this is your first time, remember to review the "readme.txt" file to know what you will need.
echo *Responses to questions are not case-sensitive.
echo.
echo.
echo What would you like to do?
echo.
echo ===== Main Actions =====
echo 1. New Installation
echo 2. Uninstall Mod
echo.
echo ===== Additional Tools =====
echo 3. Configure Switch Emulator      (Recommended After New Installation)
echo 4. Restore Super Mario 64 DS Save (If Backed Up During Uninstallation)
echo 5. Change Installation Folder
echo.
echo 0. Exit
echo.
set /p mainmenu=Please select 1-6 and press Enter:
echo.
echo.
echo.

if "%mainmenu%"=="1" goto INSTALL_METHOD
if "%mainmenu%"=="2" goto UNINSTALL
if "%mainmenu%"=="3" goto CONFIRGURE_SWITCH
if "%mainmenu%"=="4" goto RESTORE_64DS
if "%mainmenu%"=="5" goto FOLDER_LOCATION
if "%mainmenu%"=="0" goto EXIT
echo Invalid selection!
pause
goto MENU

:EXIT
exit

-------------------------------------------------------------REM INSTALLATION
:INSTALL_METHOD
cls
echo =====================================================
echo Super Mario 3D All-Stars Super Deluxe Installer v1.0
echo =====================================================
echo.
echo -----------------
echo New Installation
echo -----------------
echo.
if exist "temp_config.json" (
	echo Cleaning up previous incomplete installation...
	echo.
	del "temp_config.json" >nul 2>&1
)
echo Which Installation Method do you Prefer?
echo 1. Full Installation (Install all Games)
echo 2. Custom Installation (Choose Which Games to Install)
set /p install=Please select 1 or 2:

if "%install%"=="1" goto FULL_INSTALL
if "%install%"=="2" goto CUSTOM_INSTALL
echo.
echo Invalid selection!
pause
goto INSTALL_METHOD

-------------------------------------------------------------REM FULL INSTALLATION
:FULL_INSTALL
cls
echo =====================================================
echo Super Mario 3D All-Stars Super Deluxe Installer v1.0
echo =====================================================
echo.
echo ------------------
echo Full Installation
echo ------------------
echo.
		
		:CONFIRM_FULL
		set /p fullinstall="Proceed with Full Installation? (Y/N): "
			if /i "%fullinstall%"=="Y" goto VALIDATE_FILES		
			if /i "%fullinstall%"=="N" goto FULL_CANCELLED

		echo.
		echo Invalid selection!
   		pause
		goto FULL_INSTALL

		:FULL_CANCELLED
		echo.
		echo Installation Cancelled. Returning to Main Menu...
		pause
		goto MENU

		:VALIDATE_FILES
		echo.
		echo.
		echo.
		echo VALIDATING NECESSARY FILES
		echo ------------------------------
		echo.
		
		if exist "%frontend%\data\ROMS\Super Mario 64 DS.nds" (
			echo Super Mario 64 DS located!
			echo.
		) else (
			echo Super Mario 64 DS not found!
			echo.
			echo Please ensure all necessary files are placed correctly and restart the installation.
			echo Alternatively, you can also choose "Custom Installation" if you wish to only install some games.
			echo.
			pause
			goto MENU
		)

		if exist "%frontend%\data\ROMS\Super Mario Eclipse.iso" (
			echo Super Mario Eclipse located!
			echo.
		) else (
			echo Super Mario Eclipse not found!
			echo.
			echo Please ensure all necessary files are placed correctly and restart the installation.
			echo Alternatively, you can also choose "Custom Installation" if you wish to only install some games.
			echo.
			pause
			goto MENU
		)

		if exist "%frontend%\data\ROMS\Super Mario 3D World + Bowser's Fury.nsp" (
			echo Super Mario 3D World + Bowser's Fury located!
			echo.
		) else (
			echo Super Mario 3D World + Bowser's Fury not found!
			echo.
			echo Please ensure all necessary files are placed correctly and restart the installation.
			echo Alternatively, you can also choose "Custom Installation" if you wish to only install some games.
			echo.
			pause
			goto MENU
		)

		if exist "%frontend%\data\ROMS\Super Mario Odyssey.nsp" (
			echo Super Mario Odyssey located!
			echo.
		) else (
			echo Super Mario Odyssey not found!
			echo.
			echo Please ensure all necessary files are placed correctly and restart the installation.
			echo Alternatively, you can also choose "Custom Installation" if you wish to only install some games.
			echo.
			pause
			goto MENU
		)

		if exist "%frontend%\data\Switch\switchemulator.exe" (
			echo Switch Emulator located!
			echo.
		) else (
			echo Switch Emulator not found!
			echo.
			echo Please ensure all necessary files are placed correctly and restart the installation.
			echo Alternatively, you can also choose "Custom Installation" if you wish to only install some games.
			echo.
			pause
			goto MENU
		)


		echo.
		echo Validating Super Mario 64 DS Version...
		echo (This step is necessary to install the correct version of the Analog Hack)
		echo.
		set "filepath=%frontend%\data\ROMS\Super Mario 64 DS.nds"

		for /f "skip=1 tokens=1" %%A in ('certutil -hashfile "%filepath%" MD5') do (
		set "hash=%%A"
		goto HASH_DONE
		)

		:HASH_DONE
		echo Detected hash: %hash%
		echo.	
	
		if /i "%hash%"=="82ea4525a39dc2f484a054cff3f1b834" goto REV0_CONFIRMED
		if /i "%hash%"=="4ced5213f558e297541cb7314c909401" goto REV1_CONFIRMED
		goto VER_INVALID
			
			:REV0_CONFIRMED
			echo Version: Super Mario 64 DS (USA Rev 0)
			echo.
			echo Your ROM is Supported!
			echo.
			set revision=0
			pause
			goto ASK_CONTROLS

			:REV1_CONFIRMED
    			echo Version: Super Mario 64 DS (USA Rev 1)
			echo.
			echo Your ROM is Supported!
			echo.
			set revision=1
			pause
			goto ASK_CONTROLS
		
    			:VER_INVALID
			echo ERROR: Your ROM is unsupported or unknown. 
			echo Please ensure the following...
			echo.
			echo 1. Your ROM is a supported version: (USA Rev 0) or (USA Rev 1)
			echo 2. You have placed your ROM within the "ROMs" folder.
			echo 3. The name of your ROM has been changed to "Super Mario 64 DS.nds"
			echo.
			echo After confirming, please restart the installation process.
			echo.
			echo Returning to Main Menu...
			pause
			goto MENU

		
		:ASK_CONTROLS
		echo.
		echo.
		echo.
		echo ------------------------------------------------------------------------------------------
		echo Which controller preconfiguration would you like for Super Mario 64 DS?
		echo *Note, this does not change the game itself, it only installs preset button maps to the DeSmuME Emulator.
		echo.
		echo If you do not have the controllers listed below, or wish to use a different controller, select option 3.
		echo.
		echo 1. Xbox One/Series X Controller
		echo 2. Nintendo Pro Controller
		echo 3. Neither, I will configure this myself.
		echo.
		set /p controller=Please select 1-3 and press Enter:

		if not "%controller%"=="1" if not "%controller%"=="2" if not "%controller%"=="3" goto CONTROLLER_INVALID

		:ASK_ECLIPSE
		echo.
		echo.
		echo.
		echo ------------------------------------------------------------------------------------------
		echo Would you like Super Mario Eclipse to replace Super Mario Sunshine on the launcher, or have both?
		echo.
		echo 1. Keep Sunshine and add Eclipse
		echo 2. Replace Sunshine with Eclipse
		echo.
		set /p askeclipse=Please select 1 or 2 and press Enter:
		
		if not "%askeclipse%"=="1" if not "%askeclipse%"=="2" goto REPLACE_INVALID

		echo.
		echo.
		echo.
		echo ------------------------------------------------------------------------------------------
		echo Choices confirmed...
		echo If you have any issues with your controller configuration, or need to set your own,
		echo press Config, then Controller Config, upon launching Super Mario 64 DS.
		echo.
		echo Your installation will now begin.
		pause

		echo.
		echo.
		echo.
		echo INSTALLING FILES
		echo ------------------------------
		echo.
		echo Installing Super Mario 64 DS...
			copy /Y baseconfig\64.json temp_config.json >nul
			type additions\64ds.json >> temp_config.json
			copy /Y "scripts\Super Mario 64 DS.bat" "%frontend%\data\" >nul

		if "%askeclipse%"=="1" goto ECLIPSE_1
		if "%askeclipse%"=="2" goto ECLIPSE_2

		:ECLIPSE_1
		echo.
		echo Installing Super Mario Eclipse (keeping Sunshine)...
			type baseconfig\sunshine.json >> temp_config.json
			type additions\eclipse.json >> temp_config.json
			copy /Y "scripts\Super Mario Eclipse.bat" "%frontend%\data\" >nul
			type baseconfig\galaxy3dland.json >> temp_config.json
			goto CONTINUE_INSTALL

		:ECLIPSE_2
		echo.
		echo Installing Super Mario Eclipse (removing Sunshine)...
			type additions\eclipse.json >> temp_config.json
			copy /Y "scripts\Super Mario Eclipse.bat" "%frontend%\data\" >nul
			type baseconfig\galaxy3dland.json >> temp_config.json
			goto CONTINUE_INSTALL

		:CONTINUE_INSTALL
		echo.
		echo Installing Super Mario 3d World + Bowser's Fury...
			type additions\3dworld.json >> temp_config.json
			copy /Y "scripts\Super Mario 3D World.bat" "%frontend%\data\" >nul

		echo.
		echo Installing Super Mario Odyssey...
			type additions\odyssey.json >> temp_config.json
			copy /Y "scripts\Super Mario Odyssey.bat" "%frontend%\data\" >nul


		echo.
		echo Installing DeSmuME Emulator...
			type baseconfig\emulators.json >> temp_config.json
			type additions\desmume.json >> temp_config.json
			copy /Y "scripts\Configure DS.bat" "%frontend%\data\" >nul
			xcopy "ds\" "%frontend%\data\ds\" /E /I /Y >nul

		echo.			
		echo Installing Super Mario 64 DS Analog Hack...
			if "%revision%"=="0" (
			copy /Y "desmume_configs\sm64ds_analog_hack\revision0\Super Mario 64 DS.dct" "%frontend%\data\ds\Cheats\" >nul
			)

			if "%revision%"=="1" (
			copy /Y "desmume_configs\sm64ds_analog_hack\revision1\Super Mario 64 DS.dct" "%frontend%\data\ds\Cheats\" >nul
			)


		if "%controller%"=="3" (
		echo.
		echo Skipping DeSmuME controller config installation...
		) else (

		echo.
		echo Installing DeSmuME controller config...
			if "%controller%"=="1" (
			copy /Y "desmume_configs\control_configs\xbox_controller\desmume.ini" "%frontend%\data\ds\" >nul
			)

			if "%controller%"=="2" (
			copy /Y "desmume_configs\control_configs\switch_pro_controller\desmume.ini" "%frontend%\data\ds\" >nul
			)
		)

		echo.
		echo Integrating your choice of Switch Emulator...
			type additions\switchemulator.json >> temp_config.json
			copy /Y "scripts\Configure Switch.bat" "%frontend%\data\" >nul
			type baseconfig\end.json >> temp_config.json
		
		move /Y "temp_config.json" "%frontend%\launcher\Super Mario 3D All-Stars DELUXE_data\launcher_config.json" >nul
		

    		echo.
		echo Installing Icons, Logos, and Sounds...
    			copy /Y "assets\Icons\*" "%frontend%\data\Icons\" >nul
    			copy /Y "assets\Logos\*" "%frontend%\data\Logos\" >nul
    			copy /Y "assets\Sounds\*" "%frontend%\data\Sounds\" >nul

		echo.
		echo ---------------------------------
		echo Installation Complete! Have fun!
		echo ---------------------------------
		echo.
		pause
		goto MENU

:CONTROLLER_INVALID
echo.
echo Invalid selection!
pause
goto ASK_CONTROLS

:REPLACE_INVALID
echo.
echo Invalid selection!
pause
goto ASK_ECLIPSE

------------------------------------------------------------- REM CUSTOM INSTALLATION
:CUSTOM_INSTALL
cls
echo =====================================================
echo Super Mario 3D All-Stars Super Deluxe Installer v1.0
echo =====================================================
echo.
echo --------------------
echo Custom Installation
echo --------------------
echo.
		
		:CONFIRM_CUSTOM
		set /p custominstall="Proceed with Custom Installation? (Y/N): "
			if /i "%custominstall%"=="Y" goto INITIATING_CUSTOM_INSTALL
			if /i "%custominstall%"=="N" goto CUSTOM_CANCELLED	

		echo.
		echo Invalid selection!
   		pause
		goto CUSTOM_INSTALL

		:INITIATING_CUSTOM_INSTALL
		echo.
		echo Beginning Installation Process...
		goto INSTALL_64DS

		:CUSTOM_CANCELLED
		echo.
		echo Installation Cancelled. Returning to Main Menu...
		pause
		goto MENU




REM 64 DS----------------
		:INSTALL_64DS
REM CONFIRM?--
		echo.
		echo.
		echo.
		echo SUPER MARIO 64 DS
		echo ------------------------------
		echo.
		set /p sm64ds="Would you like to install Super Mario 64 DS? (Y/N): "
		if /i "%sm64ds%"=="Y" goto 64DS_YES
		if /i "%sm64ds%"=="N" goto 64DS_NO
		
		echo.
		echo Invalid selection!
   		pause
		goto INSTALL_64DS

		:64DS_YES
REM LOCATE--
		if exist "%frontend%\data\ROMS\Super Mario 64 DS.nds" (
			echo Super Mario 64 DS located!
			echo.
		) else (
			echo Super Mario 64 DS not found!
			echo.
			echo Please ensure all necessary files are placed correctly and restart the installation.
			echo.
			pause
			goto MENU
		)
REM VERSION--
		echo.
		echo Validating Super Mario 64 DS Version...
		echo (This step is necessary to install the correct version of the Analog Hack)
		echo.
		set "filepath=%frontend%\data\ROMS\Super Mario 64 DS.nds"

		for /f "skip=1 tokens=1" %%A in ('certutil -hashfile "%filepath%" MD5') do (
		set "hash=%%A"
		goto CUSTOM_HASH_DONE
		)

		:CUSTOM_HASH_DONE
		echo Detected hash: %hash%
		echo.	
	
		if /i "%hash%"=="82ea4525a39dc2f484a054cff3f1b834" goto CUSTOM_REV0_CONFIRMED
		if /i "%hash%"=="4ced5213f558e297541cb7314c909401" goto CUSTOM_REV1_CONFIRMED
		goto CUSTOM_VER_INVALID
			
			:CUSTOM_REV0_CONFIRMED
			echo Version: Super Mario 64 DS (USA Rev 0)
			echo.
			echo Your ROM is Supported!
			echo.
			set revision=0
			pause
			goto INSTALLING_64DS

			:CUSTOM_REV1_CONFIRMED
    			echo Version: Super Mario 64 DS (USA Rev 1)
			echo.
			echo Your ROM is Supported!
			echo.
			set revision=1
			pause
			goto INSTALLING_64DS
		
    			:CUSTOM_VER_INVALID
			echo ERROR: Your ROM is unsupported or unknown. 
			echo Please ensure the following...
			echo.
			echo 1. Your ROM is a supported version: (USA Rev 0) or (USA Rev 1)
			echo 2. You have placed your ROM within the "ROMs" folder.
			echo 3. The name of your ROM has been changed to "Super Mario 64 DS.nds"
			echo.
			echo After confirming, please restart the installation process.
			echo.
			echo Returning to Main Menu...
			pause
			goto MENU

REM INSTALL--
		:INSTALLING_64DS
		echo.
		echo installing Super Mario 64 DS...
			copy /Y baseconfig\64.json temp_config.json >nul
			type additions\64ds.json >> temp_config.json
			copy /Y "scripts\Super Mario 64 DS.bat" "%frontend%\data\" >nul
			goto INSTALL_ECLIPSE
REM SKIP--
		:64DS_NO
		echo.
		echo skipping Super Mario 64 DS...
			copy /Y baseconfig\64.json temp_config.json >nul
			goto INSTALL_ECLIPSE



REM ECLIPSE----------------
		:INSTALL_ECLIPSE
REM CONFIRM?--
		echo.
		echo.
		echo.
		echo SUPER MARIO ECLIPSE
		echo ------------------------------
		echo.
		set /p eclipse="Would you like to install Super Mario Eclipse? (Y/N): "
		if /i "%eclipse%"=="Y" goto ECLIPSE_YES
		if /i "%eclipse%"=="N" goto ECLIPSE_NO

		echo.
		echo Invalid selection!
   		pause
		goto INSTALL_ECLIPSE

		:ECLIPSE_YES
REM LOCATE--
		if exist "%frontend%\data\ROMS\Super Mario Eclipse.iso" (
			echo Super Mario Eclipse located!
			echo.
		) else (
			echo Super Mario Eclipse not found!
			echo.
			echo Please ensure all necessary files are placed correctly and restart the installation.
			echo.
			pause
			goto MENU
		)

REM REPLACE?--
		:CUSTOM_ASK_ECLIPSE
		echo Would you like Super Mario Eclipse to replace Super Mario Sunshine on the launcher, or have both?
		echo.
		echo 1. Keep Sunshine and add Eclipse
		echo 2. Replace Sunshine with Eclipse
		echo.
		set /p askeclipse=Please select 1 or 2 and press Enter:
		
		if "%askeclipse%"=="1" goto CUSTOM_ECLIPSE_1
		if "%askeclipse%"=="2" goto CUSTOM_ECLIPSE_2
			
		echo.
		echo Invalid selection!
   		pause
   		goto CUSTOM_ASK_ECLIPSE

REM INSTALL--
		:CUSTOM_ECLIPSE_1
		echo.
		echo Installing Super Mario Eclipse (keeping Sunshine)...
			type baseconfig\sunshine.json >> temp_config.json
			type additions\eclipse.json >> temp_config.json
			copy /Y "scripts\Super Mario Eclipse.bat" "%frontend%\data\" >nul
			type baseconfig\galaxy3dland.json >> temp_config.json
			goto INSTALL_3DWORLD

		:CUSTOM_ECLIPSE_2
		echo.
		echo Installing Super Mario Eclipse (removing Sunshine)...
			type additions\eclipse.json >> temp_config.json
			copy /Y "scripts\Super Mario Eclipse.bat" "%frontend%\data\" >nul
			type baseconfig\galaxy3dland.json >> temp_config.json
			goto INSTALL_3DWORLD
REM SKIP--
		:ECLIPSE_NO
		echo.
		echo skipping Super Mario Eclipse...
			type baseconfig\sunshine.json >> temp_config.json
			type baseconfig\galaxy3dland.json >> temp_config.json
			goto INSTALL_3DWORLD



REM 3DWORLD----------------
		:INSTALL_3DWORLD
REM CONFIRM?--
		echo.
		echo.
		echo.
		echo SUPER MARIO 3D WORLD + BOWSER'S FURY
		echo ----------------------------------------
		echo.
		set /p sm3dworld="Would you like to install Super Mario 3d World + Bowser's Fury? (Y/N): "
		if /i "%sm3dworld%"=="Y" goto 3DWORLD_YES
		if /i "%sm3dworld%"=="N" goto 3DWORLD_NO

		echo.
		echo Invalid selection!
   		pause
		goto INSTALL_3DWORLD

		:3DWORLD_YES
REM LOCATE--
		if exist "%frontend%\data\ROMS\Super Mario 3D World + Bowser's Fury.nsp" (
			echo Super Mario 3D World + Bowser's Fury located!
			echo.
		) else (
			echo Super Mario 3D World + Bowser's Fury not found!
			echo.
			echo Please ensure all necessary files are placed correctly and restart the installation.
			echo.
			pause
			goto MENU
		)
REM INSTALL--
		:3DWORLD_YES
		echo.
		echo Installing Super Mario 3d World + Bowser's Fury...
			type additions\3dworld.json >> temp_config.json
			copy /Y "scripts\Super Mario 3D World.bat" "%frontend%\data\" >nul
			goto INSTALL_ODYSSEY
REM SKIP--
		:3DWORLD_NO
		echo.
		echo skipping Super Mario Super Mario 3d World + Bowser's Fury...
			goto INSTALL_ODYSSEY



REM ODYSSEY----------------
		:INSTALL_ODYSSEY
REM CONFIRM?--
		echo.
		echo.
		echo.
		echo SUPER MARIO ODYSSEY
		echo ----------------------------------------
		echo.
		set /p odyssey="Would you like to install Super Mario Odyssey? (Y/N): "
		if /i "%odyssey%"=="Y" goto ODYSSEY_YES
		if /i "%odyssey%"=="N" goto ODYSSEY_NO

		echo.
		echo Invalid selection!
   		pause
		goto INSTALL_ODYSSEY

		:ODYSSEY_YES
REM LOCATE--
		if exist "%frontend%\data\ROMS\Super Mario Odyssey.nsp" (
			echo Super Mario Odyssey located!
			echo.
		) else (
			echo Super Mario Odyssey not found!
			echo.
			echo Please ensure all necessary files are placed correctly and restart the installation.
			echo.
			pause
			goto MENU
		)
REM INSTALL--
		:ODYSSEY_YES
		echo.
		echo Installing Super Mario Odyssey...
			type additions\odyssey.json >> temp_config.json
			copy /Y "scripts\Super Mario Odyssey.bat" "%frontend%\data\" >nul
			goto INSTALL_EMULATORS
REM SKIP--
		:ODYSSEY_NO
		echo.
		echo skipping Super Mario Odyssey...
			goto INSTALL_EMULATORS



REM EMULATORS----------------
		:INSTALL_EMULATORS
		echo.
		echo.
		echo.
		echo EMULATORS
		echo ----------------------------------------
		echo.
		echo Next, we will install your emulators. 
		echo This part will be configured automatically based on your game selection...
		type baseconfig\emulators.json >> temp_config.json



REM DESMUME--
		if /i "%sm64ds%"=="Y" goto DESMEMU_YES
		if /i "%sm64ds%"=="N" goto DESMEMU_NO
		
		:DESMEMU_YES
		echo.
		echo Installing DeSmuME Emulator...
			type additions\desmume.json >> temp_config.json
			copy /Y "scripts\Configure DS.bat" "%frontend%\data\" >nul
			xcopy "ds\" "%frontend%\data\ds\" /E /I /Y >nul
		echo.			
		echo Installing Super Mario 64 DS Analog Hack...
			if "%revision%"=="0" goto INSTALL_REVISION_0
			if "%revision%"=="1" goto INSTALL_REVISION_1


			:INSTALL_REVISION_0
			copy /Y "desmume_configs\sm64ds_analog_hack\revision0\Super Mario 64 DS.dct" "%frontend%\data\ds\Cheats\" >nul
			goto SWITCH_CHECK

			:INSTALL_REVISION_1
			copy /Y "desmume_configs\sm64ds_analog_hack\revision1\Super Mario 64 DS.dct" "%frontend%\data\ds\Cheats\" >nul
			goto SWITCH_CHECK

		:DESMEMU_NO
		echo skipping DeSmuME Emulator...
		goto SWITCH_CHECK

		:SWITCH_CHECK
		if /i "%sm3dworld%"=="Y" goto INSTALL_SWITCH
		if /i "%odyssey%"=="Y" goto INSTALL_SWITCH

		goto SKIP_SWITCH

REM SWITCH--
		:INSTALL_SWITCH
		echo Integrating your choice of Switch Emulator...
			type additions\switchemulator.json >> temp_config.json
			copy /Y "scripts\Configure Switch.bat" "%frontend%\data\" >nul
		goto CUSTOM_ASK_CONTROLS

		:SKIP_SWITCH
		echo Skipping Switch Emulator...
		goto CUSTOM_ASK_CONTROLS


REM CONTROL--
		:CUSTOM_ASK_CONTROLS
		if /i "%sm64ds%"=="N" goto END
		echo.
		echo.
		echo.
		echo Which controller preconfiguration would you like for Super Mario 64 DS?
		echo *Note, this does not change the game itself, it only installs preset button maps to the DeSmuME Emulator.
		echo.
		echo If you do not have the controllers listed below, or wish to use a different controller, select option 3.
		echo.
		echo 1. Xbox One/Series X Controller
		echo 2. Nintendo Pro Controller
		echo 3. Neither, I will configure this myself.
		echo.
		set /p controller=Please select 1-3 and press Enter:
		
		if "%controller%"=="1" goto CUSTOM_CONTROL_1
		if "%controller%"=="2" goto CUSTOM_CONTROL_2
		if "%controller%"=="3" goto CUSTOM_CONTROL_3

		echo.
		echo Invalid selection!
   		pause
   		goto CUSTOM_ASK_CONTROLS


		:CUSTOM_CONTROL_1
		echo.
		echo Installing DeSmuME controller config...
			copy /Y "desmume_configs\control_configs\xbox_controller\desmume.ini" "%frontend%\data\ds\" >nul
			goto CUSTOM_CONTROL_COMPLETE

		:CUSTOM_CONTROL_2
		echo.
		echo Installing DeSmuME controller config...
			copy /Y "desmume_configs\control_configs\switch_pro_controller\desmume.ini" "%frontend%\data\ds\" >nul
			goto CUSTOM_CONTROL_COMPLETE		

		:CUSTOM_CONTROL_3
		echo.
		echo Skipping DeSmuME controller config installation...
			goto CUSTOM_CONTROL_COMPLETE

		:CUSTOM_CONTROL_COMPLETE
		echo.
		echo Controller configuration complete.
		echo If you have any issues with your controller configuration, or need to set your own,
		echo press Config, then Controller Config, upon launching Super Mario 64 DS.
		echo.
		pause
		goto END
		
		:END
		type baseconfig\end.json >> temp_config.json

		move /Y "temp_config.json" "%frontend%\launcher\Super Mario 3D All-Stars DELUXE_data\launcher_config.json" >nul

REM ASSETS--
		:INSTALLING_ASSETS
		echo.
		echo.
		echo.
		echo ADDITIONAL ASSETS
		echo ------------------------------
    		echo.
			if /i "%sm64ds%"=="Y" (
				echo Installing Assets for Super Mario 64 DS...
			    	copy /Y "assets\Icons\mario64ds.png" "%frontend%\data\Icons\" >nul
    				copy /Y "assets\Logos\mario64ds.png" "%frontend%\data\Logos\" >nul
    				copy /Y "assets\Sounds\mario64ds.wav" "%frontend%\data\Sounds\" >nul
				)

			if /i "%sm64ds%"=="N" echo Omitting Assets for Super Mario 64 DS...


			if /i "%eclipse%"=="Y" (
				echo Installing Assets for Super Mario Eclipse...
			    	copy /Y "assets\Icons\marioeclipse.png" "%frontend%\data\Icons\" >nul
    				copy /Y "assets\Logos\marioeclipse.png" "%frontend%\data\Logos\" >nul
    				copy /Y "assets\Sounds\marioeclipse.wav" "%frontend%\data\Sounds\" >nul
				)

			if /i "%eclipse%"=="N" echo Omitting Assets for Super Mario Eclipse...


			if /i "%sm3dworld%"=="Y" (
				echo Installing Assets for Super Mario 3d World + Bowser's Fury...
			    	copy /Y "assets\Icons\mario3dworld.png" "%frontend%\data\Icons\" >nul
    				copy /Y "assets\Logos\mario3dworld.png" "%frontend%\data\Logos\" >nul
    				copy /Y "assets\Sounds\mario3dworld.wav" "%frontend%\data\Sounds\" >nul
				)

			if /i "%sm3dworld%"=="N" echo Omitting Assets for Super Mario 3d World + Bowser's Fury...


			if /i "%odyssey%"=="Y" (
				echo Installing Assets for Super Mario Odyssey...
			    	copy /Y "assets\Icons\marioodyssey.png" "%frontend%\data\Icons\" >nul
    				copy /Y "assets\Logos\marioodyssey.png" "%frontend%\data\Logos\" >nul
    				copy /Y "assets\Sounds\marioodyssey.wav" "%frontend%\data\Sounds\" >nul
				)

			if /i "%odyssey%"=="N" echo Omitting Assets for Super Mario Odyssey...


	if /i "%sm64ds%"=="N" if /i "%eclipse%"=="N" if /i "%sm3dworld%"=="N" if /i "%odyssey%"=="N" goto EASTER_EGG

		echo.
		echo.
		echo.
		echo ---------------------------------
		echo Installation Complete! Have fun!
		echo ---------------------------------
		echo.
		pause
		goto MENU

		:EASTER_EGG
		echo.
		echo.
		echo.
		echo -------------------------------------
		echo Congrats! You said NO to every game!
		echo -------------------------------------
		echo.
		echo Why the hell did you download this mod???
		echo.
		pause
		goto MENU


-------------------------------------------------------------REM UNINSTALL MOD
:UNINSTALL
cls
echo =====================================================
echo Super Mario 3D All-Stars Super Deluxe Installer v1.0
echo =====================================================
echo.
echo ------------
echo Uninstaller
echo ------------
echo.
echo You are about to uninstall this mod. All files created and modified by this installer will be deleted and the Super Mario 3D All-Stars Deluxe launcher will be restored to defaults.
echo.
echo Game ROMs and switch emulator will need to be removed manually.
echo.
echo.
echo.
	:UNINSTALL_CONFIRMATION
	set /p uninstall_confirmation="Would you like to proceed with the uninstallation? (Y/N): "
		
		if /i "%uninstall_confirmation%"=="Y" goto CHECK_SAVE
		if /i "%uninstall_confirmation%"=="N" goto UNINSTALL_CANCELLED

	echo.
	echo Invalid selection!
   	pause
	goto UNINSTALL
	
	:UNINSTALL_CANCELLED
	echo.
	echo Uninstallation Cancelled. Returning to Main Menu.
	pause
	goto MENU
	
	:CHECK_SAVE
	if exist "%frontend%\data\ds\Battery\Super Mario 64 DS.dsv" goto :BACKUP_SM64DS

		goto DELETING_FILES
		

		:BACKUP_SM64DS
		echo.
		echo Wait! A save file for Super Mario 64 DS has been found.
		echo Unless saved elsewhere on your PC, this file will be deleted during uninstallation.
		:BACKUP_QUESTION
		set /p backupsave="Would you like to back up your save file now? (Y/N): "
			if /i "%backupsave%"=="Y" goto BACKUP_SAVE_YES
			if /i "%backupsave%"=="N" goto BACKUP_SAVE_NO

			echo.
			echo Invalid selection!
   			pause
			goto BACKUP_SM64DS


		:BACKUP_SAVE_YES
			echo Saving Backup Now...
			md "Super Mario 64 DS Save Backup\" 2>nul
			copy /Y "%frontend%\data\ds\Battery\Super Mario 64 DS.dsv" "Super Mario 64 DS Save Backup\" >nul 
			echo.
			echo -----------------
			echo Backup Complete!
			echo -----------------
			echo A new folder has been made within the same directory as this script titled "Super Mario 64 DS Save Backup".
			echo You can find your backup there under the name, "Super Mario 64 DS.dsv".
			echo.
			echo Be sure to keep it in a safe place!
			echo.
			echo If you wish to restore this save later, select the "Restore Super Mario 64 DS Save" from the Main Menu.
			echo.
			echo.
			echo Uninstallation will now begin...
			pause
			goto DELETING_FILES_AFTER_BACKUP


		:BACKUP_SAVE_NO
		echo.
		set /p doubleconfirmation="Are you sure? Your save file for Super Mario 64 DS will be deleted! (Y/N): "
			
			if /i "%doubleconfirmation%"=="Y" goto DELETING_FILES
			if /i "%doubleconfirmation%"=="N" goto BACKUP_SM64DS

			echo.
			echo Invalid selection!
   			pause
			goto BACKUP_SAVE_NO


	:DELETING_FILES
	echo Confirmation Received. Deleting Files...
	:DELETING_FILES_AFTER_BACKUP
	echo.
	echo Deleting Configuration Files...
		del "%frontend%\data\Super Mario 64 DS.bat" /Q
		del "%frontend%\data\Super Mario Eclipse.bat" /Q
		del "%frontend%\data\Super Mario 3D World.bat" /Q
		del "%frontend%\data\Super Mario Odyssey.bat" /Q
		del "%frontend%\data\Configure DS.bat" /Q
		del "%frontend%\data\Configure Switch.bat" /Q
	echo.
	echo Deleting DeSmuME Emulator...
		rmdir /S /Q "%frontend%\data\ds\"
	echo.
	echo Deleting Logos...
		del "%frontend%\data\Logos\mario64ds.png" /Q
		del "%frontend%\data\Logos\marioeclipse.png" /Q
		del "%frontend%\data\Logos\mario3dworld.png" /Q
		del "%frontend%\data\Logos\marioodyssey.png" /Q
	echo.
	echo Deleting Icons...
		del "%frontend%\data\Icons\mario64ds.png" /Q
		del "%frontend%\data\Icons\marioeclipse.png" /Q
		del "%frontend%\data\Icons\mario3dworld.png" /Q
		del "%frontend%\data\Icons\marioodyssey.png" /Q
	echo.
	echo Deleting Sounds...
		del "%frontend%\data\Sounds\mario64ds.wav" /Q
		del "%frontend%\data\Sounds\marioeclipse.wav" /Q
		del "%frontend%\data\Sounds\mario3dworld.wav" /Q
		del "%frontend%\data\Sounds\marioodyssey.wav" /Q
	echo.
	echo Restoring Launcher Configuration Defaults...
		copy /Y "launcher_config.json" "%frontend%\launcher\Super Mario 3D All-Stars DELUXE_data\launcher_config.json" >nul

	echo.
	echo.
	echo -------------------------
	echo Uninstallation Complete!
	echo Mod has now been uninstalled. Don't forget to remove your ROMs and switch emulator added at installation if you wish.
	echo.
	echo Thank you for trying my mod! Returning to Main Menu...
	pause
	goto MENU

-------------------------------------------------------------REM CONFIGURE SWITCH EMULATOR
:CONFIRGURE_SWITCH
if exist "%frontend%\data\Switch\switchemulator.exe" goto START_SWITCH

	echo.
	echo No Switch Emulator was found!
	echo.
	echo Please ensure the following:
	echo 1. You named the .exe file of your switch emulator "switchemulator.exe".
	echo 2. You placed your switch emulator in a folder named "Switch" within the "data" folder.
	echo Then try again.
	echo.
	echo The result should look like this...
	echo.
	echo [Your Super Mario 3d All-Stars Deluxe Folder]
	echo +---data
	echo     +---Switch
	echo         +---switchemulator.exe
	echo         +---other emulator files
	echo.
	echo Returning to Main Menu...
	pause
	goto MENU

	:START_SWITCH
	start "" "%frontend%\data\Switch\switchemulator.exe"
	goto MENU

-------------------------------------------------------------REM RESTORE MARIO 64 DS SAVE
:RESTORE_64DS
cls	
echo =====================================================
echo Super Mario 3D All-Stars Super Deluxe Installer v1.0
echo =====================================================
echo.
echo ------------------------------------
echo Super Mario 64 DS Save File Restore
echo ------------------------------------
echo.
echo If you backed up a Super Mario 64 DS save file during a previous uninstallation of this mod,
echo and would like to restore it to a new installation, please paste the path to it below...
echo.

:MARIO64DS_LOCATION
echo.
setlocal EnableDelayedExpansion
set /p mario64dssave=Super Mario 64 DS Save File:
set "mario64dssave=!mario64dssave:"=!"
endlocal & set "mario64dssave=%mario64dssave%"

for %%A in ("%mario64dssave%") do set "filename=%%~nxA"

if not exist "%mario64dssave%" goto INVALID_SAVE
if /i not "%filename%"=="Super Mario 64 DS.dsv" goto INVALID_SAVE
if not exist "%frontend%\data\ds\Battery\" goto INVALID_SAVE

goto SAVE_RESTORED

			:INVALID_SAVE
			echo.
			echo.
			echo.
			echo Save file or destination path is invalid!
			echo.
			echo Please ensure you have completed a new installation and your save file is named "Super Mario 64 DS.dsv".
			goto MARIO64DS_LOCATION

			:SAVE_RESTORED
			copy /Y  "%mario64dssave%" "%frontend%\data\ds\Battery\" >nul
			echo.
			echo.
			echo Save File Restored Successfully!
			pause
			goto MENU