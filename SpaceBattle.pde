/*
*
**
***  Prj name: SpaceBattle
*/

void setup(){
  size(WIDTH, HEIGHT);
  bg = loadImage("img/bg.jpg");
  frameRate(60);
  noLoop();
}
void draw(){
  if(!gameStart) startMenu();
  else{
    background(bg);
    //debug();  
    for(int i = 0; i < numberOfEnemy; i++){
      if(eny.get(i) != null){
        eny.get(i).update(i);
        eny.get(i).show();
      }
    }
    p.update();
    p.show();
    
    showStats();
    
    if(p.getLife() == 0){
      gameOver(false);
    }
    if(numberOfEnemyOnScreen == 0){
      gameOver(true);
    }
  }
}
