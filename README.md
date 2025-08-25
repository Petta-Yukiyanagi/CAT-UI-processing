# CAT-UI-processing
猫型ごみ箱ロボットのUIです。キーボードの1～5の入力操作でStateを変更できます。

このプロジェクトは Processing 4（core.jar） を使った純 Java プロジェクトです。
VS Code からの実行と、ターミナル（PowerShell）からの実行の両方に対応します。

前提条件

JDK 17 以上（推奨：Adoptium/Temurin）

Processing 4.x をインストール
core.jar の既定パス（例）
C:\Program Files\processing-4.3.4\core\library\core.jar

Windows を想定（mac/Linux の場合はクラスパスの区切り記号を : に読み替えてください）

フォルダ構成（抜粋）
CAT_UI/
├─ src/main/java/
│  └─ com/petta/catui/
│     ├─ ui/CATUIApp.java         // エントリ（main持ち）
│     ├─ core/ ...                // 組立（Builder/Factoryなど）
│     ├─ parts/ ...               // 基本パーツ
│     └─ decorators/ ...          // デコレータ
├─ .vscode/                       // VS Code 設定（任意）
└─ out/                           // ビルド出力（生成物）

1) VS Code から実行
1-1. 設定ファイル（推奨）

.vscode/settings.json

{
  "java.project.sourcePaths": ["src/main/java"],
  "java.project.outputPath": "out",
  "java.project.referencedLibraries": [
    "C:/Program Files/processing-4.3.4/core/library/core.jar"
  ]
}

1-2. すぐ走らせたい人向け（classpath 固定で確実に起動）

.vscode/launch.json

{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "java",
      "name": "Run CATUIApp (classpath)",
      "request": "launch",
      "mainClass": "com.petta.catui.ui.CATUIApp",
      "classPaths": [
        "${workspaceFolder}/out",
        "C:/Program Files/processing-4.3.4/core/library/core.jar"
      ],
      "cwd": "${workspaceFolder}"
    }
  ]
}


Java 拡張がプロジェクト認識できなくても実行できます。
後で認識できるようになったら classPaths ではなく mainClass だけのシンプル構成でもOKです。

1-3. 実行手順

VS Code で CAT_UI フォルダを直接開く

CATUIApp.java を開く

上部の Run ▶ を押す

もしくはサイドバー Run and Debug で Run CATUIApp (classpath) を選んで実行

注：Processing 4 では smooth() は settings() 内でのみ呼べます。setup() にあると起動時にエラーになります。

2) ターミナル（PowerShell）から実行
2-1. クリーン & ビルド
cd C:\Users\user\desktop\pde\CAT_UI

# 生成物を消す（任意）
Remove-Item -Recurse -Force .\out -ErrorAction SilentlyContinue

# すべての .java を列挙してファイル化（文字コードに注意）
$src = Get-ChildItem -Recurse -Filter *.java .\src\main\java | ForEach-Object { $_.FullName }
Set-Content -Path .\sources.txt -Value ($src -join "`r`n") -Encoding ascii

# コンパイル（Processing の core.jar をクラスパスに）
javac -encoding UTF-8 -d out `
  -cp "C:\Program Files\processing-4.3.4\core\library\core.jar" `
  -sourcepath src\main\java "@sources.txt"


@sources.txt は ASCII または UTF-8(BOMなし) で作ってください。UTF-16 だと MalformedInputException になります。

2-2. 実行
java -cp "out;C:\Program Files\processing-4.3.4\core\library\core.jar" com.petta.catui.ui.CATUIApp


Windows のクラスパス区切りは ;、mac/Linux は :。