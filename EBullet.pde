
/**
 * Class EBullet
 *
 * @attr: x, y, speed, sprite.
 * @function: EBullet(float, float, float, String), update(), isFinished(), collideWithPlayer(), show();
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
          if(LEVEL != 3) p.playerDamage(1);
          else p.playerDamage(3);
          return true;
        }
        // Istruction for collide type 2, when the bullet hit with his left border, the (playerX + bulletWidth) right border of the player.
        if(x + bulletWidth > p.x && x + bulletWidth < p.x + bulletWidth){
          if(LEVEL != 3) p.playerDamage(1);
          else p.playerDamage(3);
          return true;
        } 
      }
    }
    // No collision.
    return false;
  }
  void setSprite(String path){ sprite = loadImage(path); }
  void show(){
    pushMatrix();
    fill(0, 255, 255);
    noStroke();
    image(sprite, x, y, bulletWidth, bulletHeight);
    popMatrix();  
  }

}
