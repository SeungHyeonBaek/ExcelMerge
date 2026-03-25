@echo off
setlocal

echo [1/3] Checking runtime dependencies...
python -c "import pandas, openpyxl, tkinter" 2>nul
if errorlevel 1 (
    echo Installing runtime dependencies...
    python -m pip install -r requirements.txt
    if errorlevel 1 goto :error
) else (
    echo Already installed, skipping.
)

echo [2/3] Checking PyInstaller...
python -c "import PyInstaller" 2>nul
if errorlevel 1 (
    echo Installing PyInstaller...
    python -m pip install pyinstaller
    if errorlevel 1 goto :error
) else (
    echo Already installed, skipping.
)

echo [3/3] Building single EXE...
python -m PyInstaller --noconfirm ExcelMergeTool.spec
if errorlevel 1 goto :error

echo.
echo Build completed.
echo EXE path: dist\ExcelMergeTool.exe
exit /b 0

:error
echo.
echo Build failed.
exit /b 1
