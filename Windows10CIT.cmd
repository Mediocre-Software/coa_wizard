@echo off
echo Warning This script is for Windows 10 PRO CITIZENSHIP edition only! Do not use for Home edition!
echo.
echo This script will copy and run the MARXpress tool from your FFKI server to this system.
echo The MARXpress tool will connect to MDOS SC, install a Key and generate a CBR file.
echo After MARXpress tool as finished, This scrip will copy the CBR files to the OUTPUT
echo folder on the FFKI server and delete the MARXpress tool from the system.
echo.
PAUSE


REM | Maps a network drive to the MDOS (Y:) folder and OUTPUT (Z:) folder on the FFKI server.

net use y: \\172.16.0.78\mdos\Script\Pro_Citizenship /user:Discount-PC-FFKI\coa BigStart2020
net use z: \\172.16.0.78\output /user:Discount-PC-FFKI\coa BigStart2020


REM | This will copy MARXpress files from MDOS folder on FFKI server to Desktop.
Xcopy Y:\. C:\Users\Administrator\Desktop\ /E


REM | This will run the MARXpress Tool and generate CBR files.
start /b /wait "" powershell -executionPolicy bypass  -file "C:\Users\Administrator\Desktop\MAR\Script\run.ps1"


REM | This will copy CBR files to FFKI server OUTPUT folder.
xcopy C:\Users\Administrator\Desktop\MAR\Output\*.* z:\ /y


REM | Removes network drives from computer. (Disconnects from FFKI server)

net use z: /D /Y
net use y: /D /Y


REM | Removes MARXpress Tool from system.
RMDIR C:\Users\Administrator\Desktop\MAR /S /Q

REM | Creates .txt file to mark units with DPKs installed
echo.>"C:\Users\Administrator\Desktop\Win10ProCit-Installed.txt"


echo.
echo.
echo The script has finished.
PAUSE