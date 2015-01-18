/*
*
**
***  Key Controller
*/
void keyPressed(){
  switch(keyCode) {
    case RIGHT: right = true; break;
    case LEFT: left = true; break;
    case UP: up = fire; break;
    case ' ': backspace = fire; break;
    case '1': num1 = true; break;
    case '2': num2 = true; break;

  }
}
void keyReleased(){
  switch(keyCode) {
    case RIGHT: right = false; break;
    case LEFT: left = false; break;
    case UP: up = false; break;
    case ' ': backspace = false; break;
    case '1': num1 = false; break;
    case '2': num2 = false; break;
  }
}

