/*
*
**
***  Class Enemy
*/

class Enemy {
  float x, y;
  float speedX;
  float acc;
  float maxSpeedX;
  ArrayList < EBullet > bul;
  PImage sprite;
  
  Enemy(float x, float y, String path){
    this.x = x;
    this.y = y;
    sprite = loadImage(path);
    speedX = 0.20; 
    acc = 0.025; 
    maxSpeedX = 1.40;
    bul = new ArrayList < EBullet > (maxBulletOnScreen);
  }
  void update(int index){
    
    // Moviment left and right.
    if(x + enemyWidth < (index+1) * pointOfInterest && direction == "left") x += speedX;
    else direction = "right";
    if(x > index * pointOfInterest && direction == "right") x -= speedX;
    else direction = "left";
    
    timeElapsed++;
    // Time elapsed, after (GLOBAL.ENEMY_MOVE_FRAME) frame speed is incrased by acceleration.
    if(timeElapsed > ENEMY_MOVE_FRAME){
      timeElapsed = 0;
      // incrased speed += acceleration
      for(int i = 0; i < numberOfEnemy; i++) if(eny.get(i) != null) eny.get(i).speedX = speedX + acc;
    } 
    
    // Too Fast, fix to a maxSpeedX value.
    if(speedX > maxSpeedX) for(int i = 0; i < numberOfEnemy; i++) if(eny.get(i) != null) eny.get(i).speedX = maxSpeedX;
    
    // Enemies shoot!
    if(enemyFireOn){ // Init to shoot when the speed of the enemies reaches the maxSpeed. 
      enemyFireInProcess = true;
      enemyFireOn = false;
      
      // Search an enemy on screen that can shoot a bullet.
      Boolean find = false;
      int enemyShoot = 0;
      while(!find){
        enemyShoot = int(random(0, numberOfEnemy));
        if(eny.get(enemyShoot) != null) find = true;
      }
      bul.add( new EBullet(eny.get(enemyShoot).x + enemyWidth/2, eny.get(enemyShoot).y + (enemyHeight/2) + bulletHeight, bulletSpeed*1.5, "img/laserRed.png") );
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
    if(enemyTimeOfFire == SHOT_BULLET_FRAME){ 
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
      for(int i = 0; i < numberOfEnemy; i++){
        if(numOfRespawns == num) break;
        if(eny.get(i) == null){
           eny.set(i, new Enemy(pointOfInterest*i, height/20, "img/enemy.png"));
           numberOfEnemyOnScreen++;
           numOfRespawns++;
        }
      }
  }
  void delete(int index){
    eny.set(index, null);
    numberOfEnemyOnScreen--;
    if(arcade && numberOfEnemyOnScreen == 0){
      set = false;
      respawn(numberOfEnemy);
    } 
  }
  void show(){
    pushMatrix();
    fill(255, 0, 0);
    noStroke();
    image(sprite, x, y, enemyWidth, enemyHeight);
    popMatrix();  
  }
}
