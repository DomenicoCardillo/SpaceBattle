
/**
 * Class Enemy
 *
 * @attr: x, y, speedX, acc, maxSpeedX, <EBullet> bul, sprite.
 * @function: Enemy(float, float, String), update(int), respawn(int), delete(int), show();
 */

class Enemy {
  float x, y;
  float speedX;
  float acc;
  float maxSpeedX;
  ArrayList < EBullet > bul;
  PImage sprite;
  Boolean alive;
  
  Enemy(float x, float y, String path){
    this.x = x;
    this.y = y;
    sprite = loadImage(path);
    speedX = 0.20; 
    acc = 0.025; 
    maxSpeedX = 1.40;
    bul = new ArrayList < EBullet > (maxBulletOnScreen);
    alive = true;
  }
  void update(){
    
    // Moviment
    if(direction == "right"){ 
      if(x + enemyWidth < width - 5) x += speedX;
      else direction = "left";
    }
    if(direction == "left"){ 
      if(x > 5) x -= speedX;
      else direction = "right";
    } 
    
    // Enemies shoot!
    if(enemyFireOn){
      enemyFireInProcess = true;
      enemyFireOn = false;
      
      // Search an enemy on screen that can shoot a bullet.
      Boolean find = false;
      int enemyShoot = 0;
      enemyShoot = int(random(0, numberOfEnemy*line));
      
      // Only NumberOfEnemy Boss
      if(eny.get(enemyShoot).alive) find = true;
      if(find){
        if(LEVEL != 3) bul.add( new EBullet(eny.get(enemyShoot).x + enemyWidth/2, eny.get(enemyShoot).y + (enemyHeight/2) + bulletHeight, enemyBulletSpeed, "img/laserRed.png") );
        else bul.add( new EBullet(eny.get(enemyShoot).x + enemyWidth/2, eny.get(enemyShoot).y + (enemyHeight/2) + bulletHeight, enemyBulletSpeed, "img/laserRedUltimate.png") );
      }
    }
    
    // The fire is in process, the bullets must be showed on the screen. 
    if(enemyFireInProcess){
      for(int i = 0; i < bul.size(); i++){ 
        // Update and show bullet with a cicle for.
        if(!bul.get(i).isFinished() && !bul.get(i).collideWithPlayer()){
          bul.get(i).update();
          bul.get(i).show();
        }
        // If the cicle of i bullet is finished remove it!
        else bul.remove(i);
      }
      // The array of bullet is empty, fire isn't in process yet.
      if(bul.size() < 0){ 
        enemyFireInProcess = false;
      }
    }  
    // Shoot a bullet each (GLOBAL.SHOT_BULLET_FRAME) frames.
    if(enemyTimeOfFire >= SHOT_BULLET_FRAME){ 
      enemyTimeOfFire = 0;
      enemyFireOn = true;
    }
    // EBullet time of frame counter is incrased.
    enemyTimeOfFire++;
  }
  
  /**
   * Respawn n-enemy
   *
   * @param num, number of enemy to respwan.
   * @return
   */
  
  void respawn(int num){
      int numOfRespawns = 0;  
      // Respawn n - enemy
      for(int i = 0; i < numberOfEnemy*line; i++){
        if(numOfRespawns == num) break;
         eny.get(i).alive = true;
         numberOfEnemyOnScreen++;
         numOfRespawns++;
      }
      enemyFireOn = true;
  }
  
  void delete(int index){
    if(eny.get(index).alive){
      score += 30;
      numberOfEnemyOnScreen--;
    }
    eny.get(index).alive = false;
    
    // Respawn if arcade and ENEMY ALL DIE.
    if(arcade && numberOfEnemyOnScreen == 0){
      set = false;
      score += 90;
      respawn(numberOfEnemy*line);
    } 
  }
  void setSprite(String path){ sprite = loadImage(path); }
  void show(){
    pushMatrix();
    fill(255, 0, 0);
    noStroke();
    image(sprite, x, y, enemyWidth, enemyHeight);
    popMatrix();  
  }
}
