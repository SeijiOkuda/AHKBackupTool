param (
    [string]$FilePath  # コマンドライン引数でファイルパスを指定
)

# ファイルが存在するか確認
if (-Not (Test-Path $FilePath)) {
    Write-Host "Error: File does not exist at the specified path: $FilePath"
    Read-Host "Press Enter to close"
    exit 1
}

# 親ディレクトリのパスを取得
$ParentDir = Split-Path -Parent $FilePath

# 'bk' フォルダのパスを作成
$BackupDir = Join-Path -Path $ParentDir -ChildPath "bk"
if (-Not (Test-Path $BackupDir)) {
    New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null
    Write-Host "Created directory: $BackupDir"
} else {
    Write-Host "Directory already exists: $BackupDir"
}

# タイムスタンプ付きのファイル名を生成（ファイル名とタイムスタンプの間にアンダースコアを追加）
$Timestamp = Get-Date -Format "yyyyMMddHHmmss"  # アンダースコアなし
$FileName = [System.IO.Path]::GetFileNameWithoutExtension($FilePath)
$Extension = [System.IO.Path]::GetExtension($FilePath)
$BackupFileName = "$FileName`_$Timestamp$Extension"  # アンダースコアはファイル名とタイムスタンプの間のみ

$BackupFilePath = Join-Path -Path $BackupDir -ChildPath $BackupFileName

# ファイルをコピー
Copy-Item -Path $FilePath -Destination $BackupFilePath -Force
Write-Host "Backup created: $BackupFilePath"

