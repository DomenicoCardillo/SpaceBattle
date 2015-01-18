/*
*
**
***  Key Controller
*/

void keyPressed(){
  switch(keyCode) {
    case RIGHT: right = true; break;
    case LEFT: left = true; break;
    case UP: fire = true; break;
    case ' ': backspace = true; break;
  }
}
void keyReleased(){
  switch(keyCode) {
    case RIGHT: right = false; break;
    case LEFT: left = false; break;
    case UP: fire = false; break;
    case ' ': backspace = true; break;
  }
}
