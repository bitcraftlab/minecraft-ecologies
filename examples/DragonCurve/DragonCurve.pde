
import static pi.Block.*;
Minecraft mc;

// lsystem rules
String axiom = "FX";
String yRule = "-FX-Y";
String xRule = "X+YF+";

// angle of the turtle
int angle = 0;

// stepsize on screen
int step = 2;

// steps per frame
int frameStep = 10;

// sequence of turtle commands
String seq;

// start coordinates
int x = 0;
int y = 0;
int z = 10;

boolean drawInMinecraft = true;

// pink wool
Block b = WOOL.withData(6);

// light blue wool
//Block b = WOOL.withData(3);


void setup() {
  
  size(600, 600);
  background(255);  
  noStroke();
  
  // generate dragon curve sequence
  seq = dragonSequence(12);
  
  // connect to the minecraft server
  mc = Minecraft.connect("localhost");

}


void draw() {
  
  
  // fade out what was previously drawn
  fill(255, 10);
  rect(0, 0, width, height);
  
  // draw several steps per frame
  for(int i = 0; i < frameStep; i++) {
    
    // get current step
    int step = frameCount * frameStep + i;
    
    // draw until we have reached the end of the sequence
    if(step < seq.length()) {
      drawStep(seq, step);
    }
    
  }
  
}


void drawStep(String s, int step) {
  switch(s.charAt(step)) {
    
  case '+':
    turnRight();
    break;

  case  '-':
    turnLeft();
    break;

  case 'F':
    forward();
    break;
  }
  
}

String dragonSequence(int iter) {

  String s = axiom;

  // iteration of the dragon curve
  for (int i = 0; i < iter; i++) {

    // create a new sequence
    String snew="";

    // iterate over the whole sequence
    for (int j = 0; j < s.length(); j++) {

      // get the next char from the sequence
      char ch = s.charAt(j);

      // replace one char at a time
      switch(ch) {

      case 'X': // apply X-rule
        snew += xRule;
        break;

      case 'Y': // apply Y-rule
        snew += yRule;
        break;

      default: // all other chars are copied
        snew += ch;
        break;
      }
    }
    s = snew;
  }

  return s;
}

void forward() {

  // relative motion
  int dx = int(cos(angle* HALF_PI));
  int dy = int(sin(angle* HALF_PI));

  // mid-point
  int xm = x + dx;
  int ym = y + dy;

  // draw points
  setPoint(x, y);
  setPoint(xm, ym);

  // update coords
  x = x + 2 * dx;
  y = y + 2 * dy;
}

void turnLeft() {
  angle--;
}

void turnRight() {
  angle++;
}

void setPoint(int x, int y) {

  // draw a block on screen
  fill(0);
  rect(width/2 + x * step, height/2 + y * step, step, step);

  if (drawInMinecraft) {
    // println("set block ", x, y, z);
    mc.setBlock(x, z, y, b);
  }
  
}