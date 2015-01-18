/*
*
**
***  Prj name: SpaceBattle
*/

    
    // Number Of Level = 3 -> [0, 1, 2];
    // Level 0: difficult normal: low rateo, low speed;
    // Level 1: no bullet for player for number of frames, the player have to resist;
    // Level 2: difficult hard: hight rateo, max speed of bullet; 


void setup(){
  
  // GLOBAL.WIDTH, GLOBAL.HEIGHT
  size(WIDTH, HEIGHT);
  
  // Adding bg image.
  bg = loadImage("img/bg.jpg");
  
  // Set FrameRate
  frameRate(60);
  
  // Active noLoop().
  noLoop();
}
void draw(){
  if(!gameStart) startMenu();
  else{
    
    // Add Background
    background(bg);
    
    // Activate Debug Mode.
    //debug();  
    
    // Enemy UPDATE and SHOW.
    for(int i = 0; i < numberOfEnemy; i++){
      if(eny.get(i) != null){
        eny.get(i).update(i);
        eny.get(i).show();
      }
    }
    
    // Player UPDATE and SHOW.
    p.update();
    p.show();
    
    // Show statistic of player
    showStats();
    
    // Game Over for player
    if(p.getLife() == 0) gameOver(false);
    
    // Game Over for enemy, and level up!
    if(numberOfEnemyOnScreen == 0){
      resetGame();
      if(LEVEL < 3) LEVEL++;
    }
    // Set global variable per level.
    if(LEVEL == 0){      
      SHOT_BULLET_FRAME = 300;
      ENEMY_MOVE_FRAME = 80; 
    }
    if(LEVEL == 1){
      SHOT_BULLET_FRAME = 150;
      ENEMY_MOVE_FRAME = 80;
      fireOff++;
      if(fireOff <= 500){
        showWarningFireOff();
        fire = false;
      }
      else fire = true;
    }
    if(LEVEL == 2){
      SHOT_BULLET_FRAME = 50;
      ENEMY_MOVE_FRAME = 80;
      fire = true;
    }
    // You Win.
    if(LEVEL == 3){
      gameOver(true);
    } 
  }
}
