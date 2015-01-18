/*
*
**
***  Main Function
*/

void createDebugLine(){
  pushMatrix();
  stroke(255);
  for(int i = 0; i <= numberOfEnemy; i++) line(i * pointOfInterest, 0, i * pointOfInterest, height);
  popMatrix();
}
void debug(){
  createDebugLine();
  /* Print the string DEBUG */
  String deb = "< Debug Mode >";
  pushMatrix();
  fill(0, 255, 0);
  translate(width/25, height/2 + textWidth(deb)/2);
  rotate(radians(270));
  text(deb, 0, 0);
  popMatrix();
}

int columnOfInterest(float x){
  for(int i = 0; i < numberOfEnemy; i++){
    if(x >= pointOfInterest*i && x <= pointOfInterest * (i+1)) return (i+1);
  }
  return -1;
}

void initGame(){
  /* Initalize the game. */
  
  // Create Player, center of the screen with height = height - paddingDown - playerHeight;
  p = new Player(width/2 - playerWidth/2, height - paddingDown - playerHeight, "img/player.png");
  
  // Create the array object with numberofenemy, enemy.
  eny = new ArrayList < Enemy > ();
  for(int i = 0; i < numberOfEnemy; i++){
    eny.add(new Enemy(pointOfInterest*i, height/20, "img/enemy.png"));
  }
}

void resetGame(){
  // Reset Player
  p = null;
  // Reset Enemy
  for(int i = 0; i < numberOfEnemy; i++){
    eny.set(i, null);
  }
  // Reset Number Of Enemy.
  numberOfEnemyOnScreen = numberOfEnemy;
  
  // Reset other active variables.
  gameStart = false;
  direction = "left";
  timeElapsed = 0;
  fireInProcess = false;
  bulletCount = -1;
  timeOfFire = 0;
  fireOn = false;
  enemyTimeOfFire = 0;
  enemyFireInProcess = false;
  enemyFireOn = true;
  right = left = fire = backspace = false;
}

void startMenu(){
  String x = "< Press Backspace >";
  pushMatrix();
  fill(255);
  textSize(20);
  background(0);
  text(x, width/2 - (textWidth(x)/2), height/2);
  popMatrix();
  
  if(backspace){
    gameStart = true;
    initGame();
  }
  loop();
}

void gameOver(Boolean result){
  String x = "< You have";
  pushMatrix();
  fill(255);
  textSize(20);
  background(0);
  if(result) text(x + " won!! >", width/2 - (textWidth(x)/2) - (textWidth(x)/2), height/2);
  else text(x + " lost!! >  ", width/2 - (textWidth(x)/2) - (textWidth(x)/2.5), height/2);
  popMatrix();
  // The game is finished.
  noLoop();
  
  resetGame();
  
  // To start another game active this :D
  // startMenu();
}
void showStats(){
  
  /* Print the string DEBUG */
  String pl = "< Player Life: ";
  String ne = "< Number Of Enemy: ";
  pushMatrix();
  // alpha factor 50 %
  fill(255, 255, 0, 50);
  textSize(15);
  translate(width - textWidth(pl)/4, height/2 - textWidth(pl)/2);
  rotate(radians(90));
  text(pl + p.getLife() + " >", 0, 0);
  popMatrix();
  
  pushMatrix();
  translate(width/25, height/2 + textWidth(ne)/2);
  rotate(radians(270));
  text(ne + numberOfEnemyOnScreen + " >", 0, 0);
  popMatrix();
}
