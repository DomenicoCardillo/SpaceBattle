
/**
 * File: MainFunction
 * --> GAME CONTROLLERS 
 * Contain all the function and Controller,
 * @function: columnOfInterest(float), initGame(), resetGame(), startMenu(), gameOver(Boolean), loadBest(), musicStop(), showStats(int), showWarning().
 */


/* 
 * funt: Initalize the game. 
 */
 
void initGame() {
  // Create Player, center of the screen with height = height - paddingDown - playerHeight;
  p = new Player(width*0.5 - playerWidth*0.5, height - paddingDown - playerHeight, "img/player.png");

  // Create the array object with numberofenemy, enemy.
  eny = new ArrayList < Enemy > ();
  
  // Set line correctly if wrong  
  if(line <= 1){
    line = 2;
    numberOfEnemyOnScreen = numberOfEnemy*line;
  }
  if(line > 4){
    line = 4;
    numberOfEnemyOnScreen = numberOfEnemy*line;
  } 
  // Last level the line is 1.
  if(LEVEL == 3){
    line = 1;
    numberOfEnemyOnScreen = numberOfEnemy*line;
  }
  float distanceY = 0;
  for (int i = 0; i < numberOfEnemy*line; i++) {
      distanceY = height*0.05;
      if(line > 1) if(i >= numberOfEnemy) distanceY = height*0.15;
      if(line > 2) if(i >= numberOfEnemy*(line-2)) distanceY = height*0.25;
      if(line > 3) if(i >= numberOfEnemy*(line-1)) distanceY = height*0.35;
      
      if(LEVEL != 3) eny.add(new Enemy(pointOfInterest*(i%numberOfEnemy), distanceY, "img/enemy.png"));
      // Boss Level 3
      else eny.add(new Enemy(pointOfInterest*(i), distanceY, "img/enemyBoss.png"));
  }
  // Change bullet dimension for LEVEL 3
  if(LEVEL == 3){
     bulletWidth = 20;
     bulletHeight = 20;
     enemyWidth = 40;
     enemyHeight = 30;
  }
  else{
     bulletWidth = 5;
     bulletHeight = 10;
     enemyWidth = 30; 
     enemyHeight = 20;
  }
}
void resetGame() {
  // Reset Player
  p = null;
  // Reset Enemy
  for (int i = 0; i < numberOfEnemy*line; i++) {
    eny.set(i, null);
  }
  // Reset Number Of Enemy.
  if(LEVEL == 4) line = 4;
  
  // Reset Number Of Enemy.
  numberOfEnemyOnScreen = numberOfEnemy*line;

  // Reset other active variables.
  gameStart = false;
  if (LEVEL > 0) singleplayer = true;
  else singleplayer = false;
  arcade = false;
  direction = "right";
  fireInProcess = false;
  bulletCount = -1;
  timeOfFire = 0;
  fireOn = false;
  enemyTimeOfFire = 0;
  enemyFireInProcess = false;
  enemyFireOn = true;
  right = left = backspace = num1 = num2 = false;
  fire = true; // possibility for player to fire a bullet.
  fireOff = 0;
  SHOT_BULLET_FRAME = 300;
  score = 0;
  enemyBulletSpeed = 3;
  bgIsSet = false;
}

// @param: mode is ARCADE = false/true
void loadingGame(Boolean mode){ 
  String load = "Loading ";
  String load1 = "Load Backgrounds";
  String load2 = "Load Brutal Enemies";
  String load3 = "Load Strong Player";
  String load4 = "";
  if(mode) load4 = "Start Arcade Game";
  else load4 = "Start Singleplayer Game";
  pushMatrix();
  fill(255);
  textSize(20);
  background(0);
  int mapLoad = round(map(loading, 0, 400, 0, 100));
  text(load + mapLoad, width*0.5 - textWidth(load)*0.5 - 10, height*0.3);
  
  textSize(15);
  
  if(loading >= 100) text(load1, width*0.5 - textWidth(load1)*0.5 - 1.5, height*0.45);
  if(loading >= 200) text(load2, width*0.5 - textWidth(load2)*0.5 - 1.5, height*0.55);
  if(loading >= 300) text(load3, width*0.5 - textWidth(load3)*0.5 - 1.5, height*0.65);
  if(loading >= 350) text(load4, width*0.5 - textWidth(load4)*0.5 - 1.5, height*0.75);
  popMatrix();
  loading++;
}

int [] columnOfInterest(float x) {
  int [] enemyOfInterest = new int [line];
  if(line != 1){
    int j = 0;
    for(int i = 0; i < numberOfEnemy*line; i++){
      if (x >= pointOfInterest*((i)%numberOfEnemy) && x <= pointOfInterest * ((i+1)%numberOfEnemy) ){
        enemyOfInterest[j] = i;
        j++;
      }
    }
    // Particular Case last column all 0 with line > 1.
    if(enemyOfInterest[1] == 0){
      for(int i = 1; i <= line; i++){
        enemyOfInterest[i-1] = (numberOfEnemy*i) - 1;
      }
    }
  }
  else{
    for (int i = 0; i < numberOfEnemy*line; i++) {
      if (x >= pointOfInterest*i && x <= pointOfInterest * (i+1)){
        enemyOfInterest[0] = i; 
      }
    }
  }    
  return enemyOfInterest;
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

/* Interface CTRL */

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
    text(x1, width*0.5 - (textWidth(x1)*0.5), height*0.4);
    text(x2, width*0.5 - (textWidth(x2)*0.5), height*0.6);
    popMatrix();

    if (num1) {
      gameStart = true;
      initGame();
    }
  } 
  else {
    String x1 = "Press key 1 or S for Level Game";
    String x2 = "Press key 2 or A for Arcade Game";

    String x3 = "Press M to stop and N to start the music";
    String x4 = "Press R to RESET your Arcade Best Score";
    String x5 = "Use direction keys for MOVE the player!";
    String x6 = "Use backspace direction key for SHOOT a bullet!";
    String x7 = "Press E to EXIT";
    
    pushMatrix();
    
    fill(255);
    textSize(20);
    background(0);
    text(x1, width*0.5 - (textWidth(x1)*0.5), height*0.40);
    text(x2, width*0.5 - (textWidth(x2)*0.5), height*0.60);
    
    
    textSize(13);
    text(x3, width*0.5 - (textWidth(x3)*0.5), 15);
    
    textSize(10);
    text(x4, width*0.5 - (textWidth(x4)*0.5), 30);
    
    textSize(12);
    text(x5, width*0.5 - (textWidth(x5)*0.5), height - 30);
    text(x6, width*0.5 - (textWidth(x6)*0.5), height - 18);
    
    textSize(10);
    text(x7, width*0.5 - (textWidth(x7)*0.5), height - 5);

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
  if (result) text(x, width*0.5 - (textWidth(x)*0.5), height*0.3);
  else text(x2, width*0.5 - (textWidth(x2)*0.5), height*0.3);
  
  text(x1, width*0.5 - (textWidth(x1)*0.5), height*0.9);
  popMatrix();

  if (arcade) {
    if (score > bestScore) {
      String best1 = "Your NEW BEST is " + score + "!"; 
      text(best1, width*0.5 - (textWidth(best1)*0.5), height*0.5);

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
      text(best2, width*0.5 - (textWidth(best2)*0.5), height*0.5);
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
  fill(255, 255, 0, 90);
  textSize(15);
  if (arcade) text(sc + score, width - 100, height - 8);
  popMatrix();

  // Show life
  for (int i = 0; i < p.getLife (); i++) {
    image(life, 5 + i*life.width*0.5, height - (life.height*0.7), 15, 15);
  }
}

/* Music CTRL */
void musicStart() {
  musicOn = true;
  player = minim.loadFile("audio/bg.mp3", 2048);
  player.play();
}
void musicStop(){ 
  musicOn = false;
  player.close(); 
}
void checkSound(){
  if(!player.isPlaying()){
    player.rewind();
    player.play();
  }
}

/* Best Score CTRL */
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
void resetBestScore(){
    // Add to file 0 reset
    PrintWriter output;
    output = createWriter("file/score.txt");
    output.println(0);
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    bestScore = loadBest();
}

/* Show Warning Controller */
void showWarningFireOff(float stringFire) {
  String x1 = "WARNING!";
  String x2 = "You have NO bullet!!";
  pushMatrix();
  fill(255, 0, 0, 85);
  textSize(14);
  text(x1, width*0.5 - (textWidth(x1)*0.5), height*0.45);
  text(x2, width*0.5 - (textWidth(x2)*0.5), height*0.55);
  if(stringFire > 1500) text(int(2000 - stringFire), width*0.5, height*0.60);
  popMatrix();
}
void oneShootToDieWarning(){
  String x = "One SHOOT TO DIE!!";
  pushMatrix();
  fill(255, 0, 0, 85);
  textSize(14);
  text(x, width*0.5 - (textWidth(x)*0.5), height*0.45);
  popMatrix();
}
void shootSetup(){
    lastSaveBack = saveBack;
    saveBack = backspace;
}
