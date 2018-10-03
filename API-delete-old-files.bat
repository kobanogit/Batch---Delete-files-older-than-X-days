@echo off

REM "D:\Backup & Maintenance\_BACKUP\_Batch\API-delete-old-files.bat" test 14

REM Folder :
set folder=%~1
REM DAYS :
set olderThan=%~2

D:
cd "D:/Backup & Maintenance/_BACKUP/"%folder%

echo.
rem characters black, background white
echo      Clean outdated files in folder :
echo [36m                   %folder%        
rem characters white, background black (re-initialize)
echo [0m      Files older than :
rem characters black, background white
echo [36m                    %olderThan% days
rem characters white, background black (re-initialize)
echo [0m
echo.

REM Creation of a temporary file to count outdates files
set file=tempFile.txt
copy NUL %file% >NUL
REM Add new line in temporaryFile for each outdated file

rem search according to folder and age and store in %file%
forfiles /S /d -%olderThan% /C "cmd /c echo @file >> %file%" 2>NUL

REM Count number of lines in file = number of outdates files
set /a FilesLinesQty=0
for /f %%a in ('type "%file%"^|find "" /v /c') do set /a FilesLinesQty=%%a
REM if 1 or more outdates files :
IF %FilesLinesQty% GTR 0 echo         Outdated files : %FilesLinesQty%
REM si no outdates file :
IF %FilesLinesQty% == 0 echo         Outdated files : 0
del "tempFile.txt"

REM Delete outdates files
IF %FilesLinesQty% GTR 0 ForFiles /s /d -%olderThan% /c "cmd /c del @path"

REM Count remaining backup files left in backup folder
set count=0
for %%x in (*.*) do set /a count+=1
rem echo         Remaining files after cleaning : %count%

REM If 1 or more remaining files : OK
IF %count% GTR 0 (
	echo.
	echo         [42mCleaning OK[0m
	echo         [42mRemaining backup files after cleaning : %count% 
	echo [0m [32m
	REM : Remaining files list after cleaning :  :
	FORFILES /S /C "cmd /c echo          @file" 
	echo 
)

IF %count% == 0 (
	echo  [101m
	echo         Remaining files after cleaning : %count%  
	echo.
	echo         PROBLEM : NO BACKUP FILE LEFT IN BACKUP FOLDER
	rem echo 
)
echo.
echo.

rem bouleur blanc sur fond noir (ré-initialisation)
echo [0m
@pause
