import ddf.minim.*;

/**
 * Project Name: Space Battle
 * File Name: SpaceBattle
 *
 *
 * Created by Processing 2.2.1
 * Studente: Domenico Cardillo
 * Matricola: W83000090
 */

void setup() {

  // GLOBAL.WIDTH, GLOBAL.HEIGHT
  size(WIDTH, HEIGHT);

  // Adding bg image.
  bg = loadImage("img/bg.jpg");
  bg0 = loadImage("img/bg.jpg");
  bg1 = loadImage("img/bg.jpg");
  bg2 = loadImage("img/bg.jpg");
  life = loadImage("img/life.png");

  // Create level background
  createBackground();

  // Adding music
  minim = new Minim(this);
  player = minim.loadFile("audio/bg.mp3", 2048);

  //Adding Font
  font = loadFont("font/ArcadeClassic-48.vlw"); 
  textFont(font); 
  
  // Play Music
  player.play();

  // Set FrameRate
  frameRate(60);

  // Active noLoop().
  noLoop();
}
void draw() {
  if (gameIsOver) { 
    if (num3) {
      gameIsOver = false;
      gameStart = false;
    }
  } 
  else if (!gameStart) startMenu();
  else {
    
    // Add Background
    if(!bgIsSet){
      bgIsSet = true;
      backgroundID = int(random(0, 4));
    }
    if (arcade && LEVEL == 0) {
      switch(backgroundID) {
        case 0: background(bg);  break;
        case 1: background(bg1); break;
        case 2: background(bg2); break;
        case 3: background(bg0); break;
      }
    } 
    else background(bg);
 
    if (LEVEL == 1) background(bg0);
    if (LEVEL == 2) background(bg1);
    if (LEVEL == 3) background(bg2);

    // Load Best Score.
    if (bestScore == 0) bestScore = loadBest();

    // Enemy UPDATE and SHOW.
    for (int i = 0; i < numberOfEnemy; i++) {
      eny.get(i).update(i);
      if (eny.get(i).alive) eny.get(i).show();
    }

    // Player UPDATE and SHOW.
    p.update();
    p.show();

    // Show statistic of player
    showStats(score);

    // Game Over for player
    if (p.getLife() <= 0) gameOver(false, score);

    // Mod SINGLEPLAYER
    if (singleplayer) {     
      // Game Over for enemy, and level up!
      if (numberOfEnemyOnScreen == 0) {
        if (LEVEL < 4) LEVEL++;
        resetGame();
      }
      // Set global variable per level.
      if (LEVEL == 0) {      
        SHOT_BULLET_FRAME = 300;
        ENEMY_MOVE_FRAME = 80;
      }
      if (LEVEL == 1) {
        ENEMY_MOVE_FRAME = 90;
        fireOff++;
        if (fireOff <= 2000) { 
          SHOT_BULLET_FRAME = 50;
          showWarningFireOff(fireOff);
          fire = false;
        } 
        else{
          SHOT_BULLET_FRAME = 150;
          fire = true;
        }
      }
      if (LEVEL == 2) {
        SHOT_BULLET_FRAME = 60;
        ENEMY_MOVE_FRAME = 80;
        fire = true;
      }
      if(LEVEL == 3) {
        // boss level
        SHOT_BULLET_FRAME = 80;
        ENEMY_MOVE_FRAME = 70;
        oneShootToDieWarning();
      }
      // You Win.
      if (LEVEL == 4) {
        gameOver(true, 0);
      }
    }
    // Mod ARCADE
    else if (arcade) { 
      if (!set && numberOfEnemyOnScreen == 1) {
        set = true;
        if (SHOT_BULLET_FRAME - 50 > 0){
          SHOT_BULLET_FRAME -= 50;
        }
        else {
          if (enemyBulletSpeed < 10) enemyBulletSpeed += 0.35;
          if(p.getLife() < 3){
            p.setLife(p.getLife() + 1);
          }       
        }
      }
    }
  } //else !gamestart
  if (stopSong && musicOn) musicStop();
  if (resumeSong && !musicOn) musicStart();
  if (resScore) resetBestScore();
  if (exit) exit();
  
  // Controll bg.mp3 and restart it
  checkSound(); 
}

