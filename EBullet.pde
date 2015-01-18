/*
*
**
***  Class Enemy Bullet
*/

class EBullet {
  float x, y;
  float speed;
  PImage sprite;
  
  EBullet(float x, float y, float speed, String path){
    this.x = x;
    this.y = y;
    this.speed = speed;
    sprite = loadImage(path);
  }
  void update(){
    y += speed;
  }
  Boolean isFinished(){
    // The bullet didn't hit any enemy.
    if(y + bulletHeight < height) return false;
    // The bullet is on his way
    else return true;
  }
  Boolean collideWithPlayer(){
     // Only when the bullet pass height/2.
    if(y > height/2){
      // Istruction for y collide
      if(y + bulletHeight >= p.y){
        // Istruction for collide tipe 1
        if(x >= p.x && x <= p.x + playerWidth){
          p.playerDamage();
          return true;
        }
        // Istruction for collide tipe 2, when the bullet hit with his left border, the (playerX + bulletWidth) right border of the player
        if(x + bulletWidth > p.x && x + bulletWidth < p.x + bulletWidth){
          p.playerDamage();
          return true;
        } 
      }
    }
    // No collision.
    return false;
  }
  void show(){
    pushMatrix();
    fill(0, 255, 255);
    noStroke();
    image(sprite, x, y, bulletWidth, bulletHeight);
    popMatrix();  
  }

}
