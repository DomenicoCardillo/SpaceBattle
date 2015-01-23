
/**
 * File: MainFunction
 *
 * Contain all the function,
 * @function: columnOfInterest(float), initGame(), resetGame(), startMenu(), gameOver(Boolean), loadBest(), musicStop(), showStats(int), showWarning().
 */


int columnOfInterest(float x) {
  for (int i = 0; i < numberOfEnemy; i++) {
    if (x >= pointOfInterest*i && x <= pointOfInterest * (i+1)) return (i+1);
  }
  return -1;
}

void createBackground() {
  int loc;
  float r, g, b;
  bg.loadPixels();
  bg0.loadPixels();
  bg1.loadPixels();
  bg2.loadPixels();
  for (int i = 0; i < bg.width; i++) {
    for (int j = 0; j < bg.height; j++) {
      loc = i + (j * bg.width);
      r = red(bg.pixels[loc]);
      b = blue(bg.pixels[loc]);
      g = green(bg.pixels[loc]);
      bg0.pixels[loc] = color(r, 0, b);
      bg1.pixels[loc] = color(0, b, 0);
      bg2.pixels[loc] = color(r, b, 0);
    }
  }
  bg2.updatePixels(); 
  bg1.updatePixels();
  bg0.updatePixels();
  bg.updatePixels(); 
}


void initGame() {
  /* Initalize the game. */

  // Create Player, center of the screen with height = height - paddingDown - playerHeight;
  p = new Player(width*0.5 - playerWidth/2, height - paddingDown - playerHeight, "img/player.png");

  // Create the array object with numberofenemy, enemy.
  eny = new ArrayList < Enemy > ();

  for (int i = 0; i < numberOfEnemy; i++) {
    if(LEVEL != 3) eny.add(new Enemy(pointOfInterest*i, height/20, "img/enemy.png"));
    else eny.add(new Enemy(pointOfInterest*i, height/20, "img/enemyBoss.png"));
  }
  // Change bullet dimension for LEVEL 3
  if(LEVEL == 3){
     bulletWidth = 20;
     bulletHeight = 20;
  }
  else{
     bulletWidth = 5;
     bulletHeight = 10;
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
  SHOT_BULLET_FRAME = 300;
  score = 0;
  enemyBulletSpeed = 3;
  bgIsSet = false;
}

void startMenu() {
  if (LEVEL > 0 && LEVEL < 4) {
    String x1 = "Level " + (LEVEL) + " success!!";
    String x2 = "Press key 1 for Level " + (LEVEL + 1);
    if(LEVEL == 3){
      String x3 = "Final boss level";
      text(x1, width*0.5 - (textWidth(x1)/2), height*0.75);
    }
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
    String x1 = "Press key 1 or S for Level Game";
    String x2 = "Press key 2 or A for Arcade Game";

    String x3 = "Press M for stop the music";
    String x4 = "Press R to RESET your Arcade Best Score";
    String x5 = "Use direction keys for MOVE the player!";
    String x6 = "Use backspace or up direction key for SHOOT a bullet!";
    String x7 = "Press E to EXIT";
    
    pushMatrix();
    fill(255);
    textSize(20);
    background(0);
    text(x1, width*0.5 - (textWidth(x1)/2), height*0.40);
    text(x2, width*0.5 - (textWidth(x2)/2), height*0.60);

    
    
    textSize(13);
    text(x3, width*0.5 - (textWidth(x3)/2), 15);
    
    textSize(10);
    text(x4, width*0.5 - (textWidth(x4)/2), 30);
    
    textSize(12);
    text(x5, width*0.5 - (textWidth(x5)/2), height - 30);
    text(x6, width*0.5 - (textWidth(x6)/2), height - 18);
    
    textSize(10);
    text(x7, width*0.5 - (textWidth(x7)/2), height - 5);

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
  String x = "You have won!!";
  String x2 = "You have lost!!";
  String x1 = "Press key 3 to retry"; 
  
  pushMatrix();
  fill(255);
  textSize(20);
  background(0);
  if (result) text(x, width*0.5 - (textWidth(x)/2), height*0.3);
  else text(x2, width*0.5 - (textWidth(x2)/2), height*0.3);
  
  text(x1, width*0.5 - (textWidth(x1)/2), height*0.9);
  popMatrix();

  if (arcade) {
    if (score > bestScore) {
      String best1 = "Your NEW BEST is " + score + "!"; 
      text(best1, width*0.5 - (textWidth(best1)/2), height*0.5);

      // Add to file

      PrintWriter output;
      output = createWriter("file/score.txt");
      output.println(score);
      output.flush(); // Writes the remaining data to the file
      output.close(); // Finishes the file

      bestScore = loadBest();
    } 
    else {
      String best2 = "Your BEST is " + bestScore; 
      text(best2, width*0.5 - (textWidth(best2)/2), height*0.5);
    }
  }
  // The game is finished.
  gameIsOver = true;
  resetGame();
  LEVEL = 0;
}

void showStats(int score) {
  String sc = "Score ";
  pushMatrix();
  fill(255, 255, 0, 70);
  textSize(12);
  if (arcade) text(sc + score, width - 100, height - 8);
  popMatrix();

  // Show life
  for (int i = 0; i < p.getLife (); i++) {
    image(life, 5 + i*life.width*0.5, height - (life.height*0.7), 15, 15);
  }
}

void musicStop() {
  player.close();
  minim.stop();
}

int loadBest() {
  BufferedReader reader;
  String line;

  reader = createReader("file/score.txt");
  try {
    line = reader.readLine();
  }
  catch(IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line != null) {
    String[] pieces = split(line, TAB);
    int sc = int(pieces[0]);
    return sc;
  }
  return 0;
}

void showWarningFireOff(float stringFire) {
  String x1 = "WARNING!";
  String x2 = "You have NO bullet!!";
  pushMatrix();
  fill(255, 0, 0);
  textSize(14);
  text(x1, width*0.5 - (textWidth(x1)/2), height*0.45);
  text(x2, width*0.5 - (textWidth(x2)/2), height*0.55);
  if(stringFire > 1500) text(stringFire - 2000, width*0.5, height*0.60);
  popMatrix();
}

void oneShootToDieWarning(){
  String x = "One SHOOT TO DIE!!";
  pushMatrix();
  fill(255, 0, 0, 95);
  textSize(14);
  text(x, width*0.5 - (textWidth(x)/2), height*0.45);
  popMatrix();
}

void resetBestScore(){
    // Add to file 0 reset
    PrintWriter output;
    output = createWriter("file/score.txt");
    output.println(0);
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    bestScore = loadBest();
}
