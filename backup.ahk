^b::  ; Ctrl + B を押すと
    ; クリップボードからファイルパスを取得
    ClipWait  ; クリップボードが更新されるまで待機
    FilePath := Clipboard  ; クリップボードの内容を変数に格納

    ; もしクリップボードが空なら何もしない
    if (FilePath = "") {
        MsgBox, クリップボードが空です。ファイルパスをコピーしてください。
        return
    }

    ; もしファイルパスが存在しない場合、エラーメッセージを表示
    if (!FileExist(FilePath)) {
        MsgBox, 指定されたファイルが存在しません: %FilePath%
        return
    }

    ; スクリプトがあるディレクトリから相対パスを指定
    psScript := A_ScriptDir . "\backup.ps1"  ; スクリプトのあるディレクトリと相対パスを結合

    ; PowerShell スクリプトを非表示で実行
    Run, powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "%psScript%" -FilePath "%FilePath%", , Hide
    return
