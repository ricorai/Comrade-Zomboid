@echo off
setlocal
cd /d "%~dp0"

echo ========================================================
echo   [ComradeInstaller] Compiling Native C# Build from src/...
echo ========================================================

set CSC="C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe"
if not exist %CSC% (
    set CSC="C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe"
)

if not exist %CSC% (
    echo [ComradeInstaller] ERROR: .NET Framework 4.0 csc.exe compiler not found!
    exit /b 1
)

%CSC% /nologo /target:winexe /optimize+ /platform:anycpu /r:System.dll,System.Drawing.dll,System.Windows.Forms.dll,System.Data.dll,System.IO.Compression.FileSystem.dll /out:"..\ComradeInstaller.exe" "ComradeInstaller.cs"

if %errorlevel% neq 0 (
    echo [ComradeInstaller] Compilation FAILED.
    pause
    exit /b %errorlevel%
)

echo [ComradeInstaller] Compilation SUCCESSFUL: ..\ComradeInstaller.exe
timeout /t 2 >nul
exit /b 0
