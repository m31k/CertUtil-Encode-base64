@echo off
color 0D & Mode 83,3
If "%~1"=="" ( 
    color 0C & Mode 80,3
    echo(
    echo       Drag and drop a file over this batch script to be encoded.
    Timeout /T 5 /nobreak>nul & exit /b
)
@for /f %%i in ("certutil.exe") do if not exist "%%~$path:i" (
  echo CertUtil.exe not found.
  pause
  exit /b
)
set "TempFile=%Temp%\Temp_b64
set "OutputFile=%~nx1_encoded%~x0"
If exist "%OutputFile%" Del "%OutputFile%" >nul 2>&1
echo(
echo         Encoding "%~nx1"...
certutil.exe -f -encode "%~1" "%TempFile%" >nul 2>&1
(
    echo @echo off 
    echo CERTUTIL -f -decode "%%~f0" "%%Temp%%\%~nx1" ^>nul 2^>^&1 
    echo Start "%~n1" "%%Temp%%\%~nx1"
    echo Exit
)> "%OutputFile%"
copy "%OutputFile%" /b + "%TempFile%" /b >nul 2>&1
If exist "%TempFile%" Del "%TempFile%" >nul 2>&1
Timeout /T 2 /NoBreak>nul
