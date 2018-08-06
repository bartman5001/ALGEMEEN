@echo off
if "%1"=="" GOTO Usage

SETX BISUSER %1
SET BISUSER=%1


:Begin
cls
Echo Voor het wachtwoord voor de BIS P9 user %BISUSER%9 in voor het mounten van de L en X drive.
cmdkey /add:pbis9.asp-services.net /user:%BISUSER%9 /pass 2>&1>Nu1 
net use /persistent:yes >Nul 2>&1
net use l: /delete >Nu1 2>&1
net use x: /delete >nul 2>&1
net use l: \\pbis9.asp-services.net\nccwt >nul 2>&1
if "%errorlevel%"=="2" goto NetUseError
net use x: \\pbis9.asp-services.net\bis9 >nul 2>&1
net use /persistent:no >nul 2>&1
Echo.
Echo =====================================================================================================================
Echo De L: en X: drive zijn aangemaakt
echo inloggegevens voor het maken van de L en X drive opgeslagen in de wachtwoordkluis van Windows. Ook na reboot zullen
echo de L en X schijf nu beschikbaar zijn en ook de BISUSER variable is in het user profiel opgeslagen.
Echo.
echo Er is in de user environment een variable set BISUSER aangemaakt.
set BISUSER
Echo =====================================================================================================================
GOTO Eind

:NetUseError
Echo Verkeerde gebruikersnaam of wachtwoord.
Echo (Laat bij de gebruikersnaam de 9 aan het eind weg.)
Echo.
GOTO Eind
:Usage
Echo Missende UserID 
Echo Usage: %~n0 ^<UserID^>
Echo.
Echo.

:Eind
