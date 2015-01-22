import ddf.minim.*;

/**
 * Project Name: Space Battle!
 * File Name: SpaceBattle
 *
 *
 * Created by Processing 2.2.1
 * Studente: Domenico Cardillo
 * Matricola: W83000090
 */
 
void setup(){
  
  // GLOBAL.WIDTH, GLOBAL.HEIGHT
  size(WIDTH, HEIGHT);
  
  // Adding bg image.
  bg = loadImage("img/bg.jpg");
  bg1 = loadImage("img/bg.jpg");
  bg2 = loadImage("img/bg.jpg");
  
  // Create level background
  createBackground();
   
  // Adding music
  minim = new Minim(this);
  player = minim.loadFile("audio/bg.mp3", 2048);
  
  // Play Music
  player.play();
  
  // Set FrameRate
  frameRate(60);
  
  // Active noLoop().
  noLoop();
}
void draw(){
  if(gameIsOver){ 
    if(num3){
      gameIsOver = false;
      gameStart = false;
    }
  }
  else if(!gameStart) startMenu();
  else{
    
    // Add Background
    if(LEVEL == 0) background(bg);
    if(LEVEL == 1) background(bg1);
    if(LEVEL == 2) background(bg2);
    
    if(backspace){
      // Stop Music
      musicStop();
    }
    
    // Load Best Score.
    if(bestScore == 0) bestScore = loadBest();
    
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
    showStats(score);
    
    // Game Over for player
    if(p.getLife() == 0) gameOver(false, score);
    
    if(singleplayer){     
      // Game Over for enemy, and level up!
      if(numberOfEnemyOnScreen == 0){
        if(LEVEL < 3) LEVEL++;
        resetGame();
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
        gameOver(true, 0);
      } 
    }
    else if(arcade){
        score++;
        if(!set && numberOfEnemyOnScreen == 1){
          set = true;
          if(SHOT_BULLET_FRAME - 50 > 0) SHOT_BULLET_FRAME -= 50;
          else{
            if(enemyBulletSpeed < 5) enemyBulletSpeed += 0.2;
          }
        }
    }
  } //else !gamestart
}
