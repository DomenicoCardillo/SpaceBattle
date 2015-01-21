
/**
 * File: Key Controller
 *
 * Overriding of keypressed and keyrelased function.
 * @Keys: right, left, up, backspace, num1, num2.
 */
 
 
void keyPressed(){
  switch(keyCode) {
    case RIGHT: right = true; break;
    case LEFT: left = true; break;
    case UP: up = fire; break;
    case ' ': backspace = fire; break;
    case '1': num1 = true; break;
    case '2': num2 = true; break;
    case '3': num3 = true; break;


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
    case '3': num3 = false; break;
  }
}

