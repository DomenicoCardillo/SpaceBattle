
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
  
  int collideWithEnemy() {
    int [] enemyCollide = columnOfInterest(x);
    for (int i = 0; i < line; i++) {
      int index = enemyCollide[i];
      if (eny.get(index).alive) {
        if (eny.get(index).y + enemyHeight >= y) {
          if (x >= eny.get(index).x - 5 && x <= eny.get(index).x + enemyWidth) {
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

