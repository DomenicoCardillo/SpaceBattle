
/**
 * File: Key Controller
 *
 * Overriding of keypressed and keyrelased function.
 * @Keys: right, left, up, backspace, num1, num2, resScore, num3, stopBg.
 */
 
 
void keyPressed(){
  switch(keyCode) {
    case RIGHT: right = true; break;
    case LEFT: left = true; break;
    case UP: up = fire; break;
    case ' ': backspace = fire; break;
    case '1': num1 = true; break;
    case 's': num1 = true; break;
    case 'S': num1 = true; break; 
    case '2': num2 = true; break;
    case 'a': num2 = true; break;
    case 'A': num2 = true; break; 
    case '3': num3 = true; break;
    case 'r': resScore = true; break;
    case 'R': resScore = true; break;
    case 'm': stopBg = true; break;
    case 'M': stopBg = true; break;
    case 'e': exit = true; break;
    case 'E': exit = true; break;
  }
}
void keyReleased(){
  switch(keyCode) {
    case RIGHT: right = false; break;
    case LEFT: left = false; break;
    case UP: up = false; break;
    case ' ': backspace = false; break;
    case '1': num1 = false; break;
    case 's': num1 = false; break;
    case 'S': num1 = false; break; 
    case '2': num2 = false; break;
    case 'a': num2 = false; break;
    case 'A': num2 = false; break; 
    case '3': num3 = false; break;
    case 'r': resScore = false; break;
    case 'R': resScore = false; break;
    case 'm': stopBg = false; break;
    case 'M': stopBg = false; break;
    case 'e': exit = false; break;
    case 'E': exit = false; break;  
  }
}

