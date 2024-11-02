@echo off
echo WARNING: This script will clean the specified disks. All data on these disks will be erased.
echo.

REM Display disk information for verification
wmic diskdrive get caption,size
echo.

REM Prompt for confirmation before proceeding
set /p confirm="Are you sure you want to clean disks 0 to 4? This action is irreversible. (Y/N): "
if /i not "%confirm%"=="Y" (
    echo Operation canceled.
    exit /b
)

REM Generate DiskPart script to clean disks
echo list disk > clean_script.txt
for %%i in (0 1 2 3 4) do (
    echo select disk %%i >> clean_script.txt
    echo clean >> clean_script.txt
    echo list disk >> clean_script.txt
)

REM Run DiskPart with the generated script
diskpart /s clean_script.txt

REM Clean up
del clean_script.txt

echo.
echo Disk cleanup operation completed. Please verify the disks.
pause
