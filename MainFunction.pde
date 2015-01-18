
/**
 * File: MainFunction
 *
 * Contain all the function,
 * @function: columnOfInterest(float), initGame(), resetGame(), startMenu(), gameOver(Boolean), loadBest(), musicStop(), showStats(int), showWarning().
 *
 */
 
 
int columnOfInterest(float x) {
  for (int i = 0; i < numberOfEnemy; i++) {
    if (x >= pointOfInterest*i && x <= pointOfInterest * (i+1)) return (i+1);
  }
  return -1;
}


void initGame() {
  /* Initalize the game. */

  // Create Player, center of the screen with height = height - paddingDown - playerHeight;
  p = new Player(width*0.5 - playerWidth/2, height - paddingDown - playerHeight, "img/player.png");

  // Create the array object with numberofenemy, enemy.
  eny = new ArrayList < Enemy > ();
  for (int i = 0; i < numberOfEnemy; i++) {
    eny.add(new Enemy(pointOfInterest*i, height/20, "img/enemy.png"));
  }
}

void resetGame() {
  // Reset Player
  p = null;
  // Reset Enemy
  for (int i = 0; i < numberOfEnemy; i++) {
    eny.set(i, null);
  }
  // Reset Number Of Enemy.
  numberOfEnemyOnScreen = numberOfEnemy;

  // Reset other active variables.
  gameStart = false;
  if (LEVEL > 0) singleplayer = true;
  else singleplayer = false;
  arcade = false;
  direction = "left";
  timeElapsed = 0;
  fireInProcess = false;
  bulletCount = -1;
  timeOfFire = 0;
  fireOn = false;
  enemyTimeOfFire = 0;
  enemyFireInProcess = false;
  enemyFireOn = true;
  right = left = up = backspace = num1 = num2 = false;
  fire = true; // possibility for player to fire a bullet.
  fireOff = 0;
}

void startMenu() {
  if (LEVEL > 0 && LEVEL < 3) {
    String x1 = "Level " + (LEVEL) + " success!!";
    String x2 = "< Press '1' for Level: " + (LEVEL + 1) + " >";
    pushMatrix();
    fill(255);
    textSize(20);
    background(0);
    text(x1, width*0.5 - (textWidth(x1)/2), height*0.40);
    text(x2, width*0.5 - (textWidth(x2)/2), height*0.60);
    popMatrix();

    if (num1) {
      gameStart = true;
      initGame();
    }
  } 
  else {
    String x1 = "< Press '1' for Level Game >";
    String x2 = "< Press '2' for Arcade Game >";
    pushMatrix();
    fill(255);
    textSize(20);
    background(0);
    text(x1, width*0.5 - (textWidth(x1)/2), height*0.35);
    text(x2, width*0.5 - (textWidth(x2)/2), height*0.65);
    popMatrix();
    if (num1) {
      gameStart = true;
      singleplayer = true;
      arcade = false;
      initGame();
    }
    if (num2) {
      gameStart = true;
      arcade = true;
      singleplayer = false;
      initGame();
    }
  }
  loop();
}

void gameOver(Boolean result, int score) {
  String x = "    You have";
  String x1 = "< Press '1' to retry >"; 
  pushMatrix();
  fill(255);
  textSize(20);
  background(0);
  if (result) text(x + " won!!", width*0.5 - (textWidth(x)/2) - (textWidth(x)/2), height*0.3);
  else text(x + " lost!!", width*0.5 - (textWidth(x)/2) - (textWidth(x)/2.5), height*0.3);
  text(x1, width*0.5 - (textWidth(x1)/2), height*0.5);
  popMatrix();
  
  if(arcade){
    if(bestScore < score){
      String best1 = "< Your New best: " + score + " >"; 
      text(best1, width*0.5 - (textWidth(best1)/2), height*0.7);
      
      // Add to file
      
      PrintWriter output;
      output = createWriter("score.txt");
      output.println(score);
      output.flush(); // Writes the remaining data to the file
      output.close(); // Finishes the file
      
      bestScore = loadBest();
    }
    else{
      String best2 = "< You Best: " + bestScore  + " >"; 
      text(best2, width*0.5 - (textWidth(best2)/2), height*0.7);
    }  
  }
  // The game is finished.
  noLoop();
  resetGame();
  LEVEL = 0;
}

void showStats(int score) {
  String pl = "< Player Life: ";
  String ne = "< Number Of Enemy: ";
  String sc = "< Score: ";
  pushMatrix();
  // alpha factor 50 %
  fill(255, 255, 0, 50);
  textSize(15);
  translate(width - textWidth(pl)/4, height*0.5 - textWidth(pl)/2);
  rotate(radians(90));
  text(pl + p.getLife() + " >", 0, 0);
  popMatrix();

  pushMatrix();
  translate(width/25, height*0.5 + textWidth(ne)/2);
  rotate(radians(270));
  text(ne + numberOfEnemyOnScreen + " >", 0, 0);
  popMatrix();
  
  pushMatrix();
  textSize(12);
  text(sc + score + " >", width - 100, height - 8);
  popMatrix();

}

void musicStop(){
  player.close();
  minim.stop();
}

int loadBest(){
  BufferedReader reader;
  String line;
  
  reader = createReader("score.txt");
  try{
    line = reader.readLine();
  }catch(IOException e){
    e.printStackTrace();
    line = null;
  }
  if(line != null){
    String[] pieces = split(line, TAB);
    int sc = int(pieces[0]);
    return sc; 
  }
  return 0;
}

void showWarningFireOff() {
  String x1 = " <Warning> ";
  String x2 = "You have NO bullet!! ";
  pushMatrix();
  fill(255, 0, 0);
  textSize(14);
  text(x1, width*0.5 - (textWidth(x1)/2), height*0.45);
  text(x2, width*0.5 - (textWidth(x2)/2), height*0.55);
  popMatrix();
}

