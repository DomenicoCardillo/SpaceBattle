
/**
 * Class Bullet
 *
 * @attr: x, y, speed, sprite.
 * @function: Bullet(float, float, float, String), update(), isFinished(), collideWithEnemy(), show();
 */

class Bullet {
  float x, y;
  float speed;
  PImage sprite;

  Bullet(float x, float y, float speed, String path) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    sprite = loadImage(path);
  }
  void update() {
    y -= speed;
  }
  Boolean isFinished() {
    // The bullet didn't hit any enemy.
    if (y > 0) return false;
    // The bullet is on his way
    else return true;
  }
  
  /* Old collide:
  
  int collideWithEnemy(){
   // Only when the bullet pass height/2.
   if(y < height/2){
   // Calcolate the column of interest for the coordinate bullet x.
   int w = columnOfInterest(x) - 1;
   // Controll if eny floor of w is null
   if(eny.get(w) != null){
   // The height of the enemies is the same, i search for floor(w).
   if(eny.get(w).y + enemyHeight >= y){
   // This control is obsolete becouse has already been checked.
   if(eny.get(w) != null){
   // Controll for range of x of element in floor w
   if(x >= eny.get(floor(w)).x && x <= eny.get(w).x + enemyWidth){
   eny.get(w).delete(w);
   return w;
   }
   }
   }
   }
   }
   return -1;
   }*/

  int collideWithEnemy() {
    int [] enemyCollide = columnOfInterest(x);
    for (int i = 0; i < line; i++) {
      int index = enemyCollide[i];
      if (eny.get(index).alive) {
        if (eny.get(index).y + enemyHeight >= y) {
          if (x >= eny.get(index).x && x <= eny.get(index).x + enemyWidth) {
            eny.get(index).delete(index);
            return index;
          }
        }
      }
    } 
    return -1;
  }

  void setSprite(String path) { 
    sprite = loadImage(path);
  }
  void show() {
    pushMatrix();
    fill(0, 255, 0);
    noStroke();
    image(sprite, x, y, bulletWidth, bulletHeight);
    popMatrix();
  }
}

