Character character;
TextDisplay textDisplay;
float globalScale;

void setup() {
  fullScreen();
  smooth(8);

  // 元基準(400x300)に対する等倍スケール
  globalScale = min(width/400.0, height/300.0);

  // リファクタリング後のCharacterクラスをインスタンス化
  character = new Character(this, globalScale);

  // テキスト表示初期化
  textDisplay = new TextDisplay(this, globalScale);

  // 自動送り設定
  textDisplay.setAutoAdvance(true, 2.5f); // 2.5秒後に自動送り
  
}

void draw() {
  background(0);
  character.update();
  character.draw();

  textDisplay.update();
  textDisplay.draw();
}

/**
 * キー入力の処理。
 * メインスケッチ側でキーと表情の対応を定義する形に修正。
 */
void keyPressed() {
  switch (key) {
    case '1': 
      character.setExpression("NORMAL"); 
      textDisplay.showMessage("Hello,World! ,,^•ﻌ•^,,"); 
      break;
    case '2': 
      character.setExpression("QUESTION"); 
      textDisplay.showMessage("うーん"); 
      break;
    case '3': 
      character.setExpression("HAPPY"); 
      textDisplay.showMessage("嬉しい！"); 
      break;
    case '4': 
      character.setExpression("SLEEPING"); 
      textDisplay.showMessage("おやすみ…"); 
      break;
    case '5':
      textDisplay.showMessage("Thank you for Leading ,,^•ﻌ•^,,");
      new java.util.Timer().schedule(
        new java.util.TimerTask() {
          public void run() {
            character.setExpression("SMILE");
          }
        },
        2100  // 2.3秒後に実行
      );
     break;
    case ' ': 
      textDisplay.nextPage(); 
      break;
  }
}
