# 設定
$dlPath = "$([Environment]::GetFolderPath('Desktop'))\demo_payload.ps1"
$regKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
$regName = "DemoSecurityTest"
$SearchPath = "C:\Users\Public"
$OutputPath = "C:\Users\Public\detected_files.csv"
$Keywords = @("*機密*", "*重要*", "*個人情報*")
$Extensions = @("*.docx", "*.xlsx", "*.txt")

# クリーンアップ（念のため最初に実行）
Remove-Item $dlPath -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $regKey -Name $regName -ErrorAction SilentlyContinue

# STEP 2: Reconnaissance (Data Discovery)
$Results = @()
foreach ($keyword in $Keywords) {
    foreach ($ext in $Extensions) {
        $files = Get-ChildItem -Path $SearchPath -Include "$keyword$ext" -Recurse -ErrorAction SilentlyContinue
        foreach ($file in $files) {
            $Results += [PSCustomObject]@{
                "ファイル名" = $file.Name; "検索ワード" = $keyword; "パス" = $file.FullName
            }
        }
    }
}
$Results | Export-Csv -Path $OutputPath -Encoding UTF8 -NoTypeInformation

# STEP 3: Persistence
New-ItemProperty -Path $regKey -Name $regName -PropertyType String -Value "powershell.exe -WindowStyle Hidden -File $dlPath" -Force

# STEP 4: Credential Access (Dummy)
try {
    $lsass = Get-Process lsass -ErrorAction Stop
} catch { }

# 実行完了後の対話（デモ用）
$wshell = New-Object -ComObject Wscript.Shell
$result = $wshell.Popup("攻撃シミュレーションが完了しました。`nファイル探索、永続化、LSASSアクセス試行を記録しました。`nEnterキーで全クリーンアップを実行します。", 0, "Security Demo", 64)

# クリーンアップ
Remove-Item $dlPath, $OutputPath -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $regKey -Name $regName -ErrorAction SilentlyContinue