# CAT-UI-processing

猫型ごみ箱ロボットの UI です。  
キーボードの **1～5 の入力操作**で State を変更できます。

このプロジェクトは **Processing 4（core.jar）** を使った純 Java プロジェクトです。  
VS Code からの実行と、ターミナル（PowerShell）からの実行の両方に対応します。

---

## 前提条件

- **JDK 17 以上**（推奨：Adoptium/Temurin）  
- **Processing 4.x** をインストール  
- `core.jar` の既定パス例：  

  ```
  C:\Program Files\processing-4.3.4\core\library\core.jar
  ```

- Windows を想定（mac/Linux の場合はクラスパスの区切り記号を `:` に読み替えてください）

---

## フォルダ構成（抜粋）

```
CAT_UI/
├─ src/main/java/
│  └─ com/petta/catui/
│     ├─ ui/CATUIApp.java         // エントリ（main持ち）
│     ├─ core/ ...                // 組立（Builder/Factoryなど）
│     ├─ parts/ ...               // 基本パーツ
│     └─ decorators/ ...          // デコレータ
├─ .vscode/                       // VS Code 設定（任意）
└─ out/                           // ビルド出力（生成物）
```

---

## 1. VS Code から実行

### 1-1. 設定ファイル（推奨）

`.vscode/settings.json`

```json
{
  "java.project.sourcePaths": ["src/main/java"],
  "java.project.outputPath": "out",
  "java.project.referencedLibraries": [
    "C:/Program Files/processing-4.3.4/core/library/core.jar"
  ]
}
```

### 1-2. すぐ走らせたい人向け（classpath 固定で確実に起動）

`.vscode/launch.json`

```json
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
```

💡 Java 拡張がプロジェクトを認識できなくても実行可能です。  
後で認識できるようになったら `classPaths` ではなく `mainClass` だけのシンプル構成でも OK です。

### 1-3. 実行手順

1. VS Code で `CAT_UI` フォルダを直接開く  
2. `CATUIApp.java` を開く  
3. 上部の ▶ Run を押す  
4. もしくはサイドバー **Run and Debug** で `Run CATUIApp (classpath)` を選んで実行  

⚠️ **注意**：Processing 4 では `smooth()` は `settings()` 内でのみ呼べます。  
`setup()` にあると起動時にエラーになります。

---

## 2. ターミナル（PowerShell）から実行

### 2-1. クリーン & ビルド

```powershell
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
```

💡 `@sources.txt` は **ASCII または UTF-8(BOMなし)** で作成してください。  
UTF-16 だと `MalformedInputException` が発生します。

---

### 2-2. 実行

```powershell
java -cp "out;C:\Program Files\processing-4.3.4\core\library\core.jar" com.petta.catui.ui.CATUIApp
```

- Windows のクラスパス区切り → `;`  
- mac/Linux のクラスパス区切り → `:`

---
