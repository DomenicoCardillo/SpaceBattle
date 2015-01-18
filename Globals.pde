/*
*
**
***  Globals
*/


final int WIDTH = 500; // Change with multiply of 100, and delete background image.
final int HEIGHT = 300; // Change with multiply of 100, and delete background image.


int LEVEL = 0;
int SHOT_BULLET_FRAME = 300; // Change for incrase rateo fire of enemy.
int ENEMY_MOVE_FRAME = 80; // Change for incrase time of enemy to reach the maximum speed.


/* Img */
PImage bg;

/* Objects */
ArrayList < Enemy > eny;
Player p;

/* Main */ 
int numberOfEnemy = 3;
int numberOfEnemyOnScreen = numberOfEnemy;
Boolean gameStart = false;
int pointOfInterest = WIDTH/numberOfEnemy;
int paddingDown = 8;

/* Enemy  */ 
int enemyWidth = 30;
int enemyHeight = 20;
String direction = "left";
int timeElapsed = 0;

/* Player */
int playerWidth = 30;
int playerHeight = 20;
Boolean fire = true;
int fireOff = 0;

/* Bullet */
int bulletWidth = 5;
int bulletHeight = 10;
Boolean fireInProcess = false;
int bulletSpeed = 3;
int bulletCount = -1;
int timeOfFire = 0;
Boolean fireOn = false;
int maxBulletOnScreen = 8;


/* EBullet */
int enemyTimeOfFire = 0;
Boolean enemyFireInProcess = false;
Boolean enemyFireOn = true;

/* Key */
Boolean right = false, left = false, up = false, backspace = false;
Boolean num1 = false, num2 = false;

