
import pi.*;
import pi.tool.Turtle;
import static pi.Block.*;

// the MCPI object
Minecraft mc;
Turtle turtle;

void setup() {

  // create a canvas of 100 x 100 pixels
  size(100, 100);

  // paint the background black
  background(0);

  // draw a label
  text("[B]uild", 20, 40);
  text("[R]emove", 20, 60);

  // connect to the server that runs minecraft
  mc = Minecraft.connect("ariadne.medien.uni-weimar.de");
  
}

// we need a draw loop, otherwise there's no interaction!
void draw() {};

void keyPressed() {
  switch(key) {
    
    case 'b':
      // build a new house
      buildHouse(6, 8, 10, BRICK_BLOCK, WOOD);
      break;
      
    case 'r':
      // remove the house
      buildHouse(6, 8, 10, AIR, AIR);
      break;
  }
}