@echo off

REM "D:\Backup & Maintenance\_BACKUP\_Batch\API-delete-old-files.bat" test 14

REM Folder :
set folder=%~1
REM DAYS :
set olderThan=%~2

D:
cd "D:/Backup & Maintenance/_BACKUP/"%folder%

echo.
rem echo "    Nettoyage anciens fichiers du dossier : " %folder%
rem echo "    Fichiers supprimes : plus de : " %olderThan% " jours"
echo      Nettoyage fichiers perimes dossier et nb jours :
echo.
rem couleur noir sur fond blanc :
echo [7m
echo                   %folder%     %olderThan%                      
rem bouleur blanc sur fond noir (ré-initialisation)
echo [0m
echo.

REM Creation of a temporary file to count outdates files
set file=tempFile.txt
copy NUL %tempFile% >NUL
REM Add new line in temporaryFile for each outdated file

rem recherche fichiers selon critères dossier et age
forfiles /S /d -%olderThan% /C "cmd /c echo @file >> tempFile.txt" 2>NUL

REM Count number of lines in file = number of outdates files
set /a FilesLinesQty=0
for /f %%a in ('type "%file%"^|find "" /v /c') do set /a FilesLinesQty=%%a
REM echo %file% has %FilesLinesQty% lines
echo.
REM si au moins 1 fichier périmé
IF %FilesLinesQty% GTR 0 echo         %FilesLinesQty% fichiers perimes
IF %FilesLinesQty% GTR 0 del "tempFile.txt"
REM si aucun fichier périmé
IF %FilesLinesQty% == 0 echo        Aucun fichier perime
echo.

REM Delete outdates files
IF %FilesLinesQty% GTR 0 ForFiles /s /d -%olderThan% /c "cmd /c del @path"

REM Count remaining backup files kept
set count=0
for %%x in (*.*) do set /a count+=1
echo         %count% fichier(s) restant(s) apres nettoyage :

REM si minimum 1 fichier conserver : OK
IF %count% GTR 0 (
	echo.
	echo.
	echo         Nettoyage OK : %count% fichiers backup recent existants :
	)
IF %count% GTR 0 echo.
IF %count% GTR 0 echo  [42m
IF %count% GTR 0 echo         Nettoyage OK : %count% fichiers backup recent existants :
IF %count% GTR 0 echo [0m [32m
rem IF %count% GTR 0 echo  [32m

REM : Liste des fichiers conservés
FORFILES /S /C "cmd /c echo             @file" 
IF %count% GTR 0 echo 

IF %count% == 0 echo  [101m
IF %count% == 0 echo.
IF %count% == 0 echo.
IF %count% == 0 echo          PROBLEME : aucun fichier restant dans le dossier
IF %count% == 0 echo.
IF %count% == 0 echo.
IF %count% == 0 echo 
echo.
echo.

rem bouleur blanc sur fond noir (ré-initialisation)
echo [0m
@pause
