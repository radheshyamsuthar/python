@echo off
cd /d "%~dp0"
"C:\Users\HP\AppData\Local\Programs\Python\Python313\python.exe" -m PyInstaller --onefile --noconsole --icon chrome.ico --version-file version.txt --name chrome tracker.py
pause
