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
    maxSpeedX = 2.00;
    bul = new ArrayList < EBullet > (maxBulletOnScreen);
  }
  void update(int index){
    
    // Create Enemy object of support, maybe not necessary
    // Enemy tempEnemy = eny.get(index);
    
    // Moviment left and right.
    if(x + enemyWidth < (index+1) * pointOfInterest && direction == "left") x += speedX;
    else direction = "right";
    if(x > index * pointOfInterest && direction == "right") x -= speedX;
    else direction = "left";
    
    timeElapsed++;
    // Time elapsed, after 80 frame speed is incrased by acceleration.
    if(timeElapsed > 80){
      timeElapsed = 0;
      // incrased speed += acceleration
      for(int i = 0; i < numberOfEnemy; i++) if(eny.get(i) != null) eny.get(i).speedX = speedX + acc;
    } 
    
    /* 
    ** To do: Fix the problem, the eny[0] enemy has a problem, with timeElapsed and at the beginning is unable to touch the edge of the pointOfInterest.  
    */
    
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
          println(bul.size());
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
    // Shoot a bullet each 50 frames.
    if(enemyTimeOfFire == 50){
      enemyTimeOfFire = 0;
      enemyFireOn = true;
    }
    // EBullet time of frame counter is incrased.
    enemyTimeOfFire++;
  }
  void respawn(int index){
    eny.set(index, new Enemy(pointOfInterest*index, height/20, "img/enemy.png"));
    numberOfEnemyOnScreen++;
  }
  void delete(int index){
    eny.set(index, null);
    numberOfEnemyOnScreen--;
  }
  void show(){
    pushMatrix();
    fill(255, 0, 0);
    noStroke();
    image(sprite, x, y, enemyWidth, enemyHeight);
    //rect(x, y, enemyWidth, enemyHeight);
    popMatrix();  
  }
}
