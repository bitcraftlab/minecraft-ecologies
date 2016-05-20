import pi.Minecraft.*;

// the MCPI object
Minecraft mc;

void setup() {

  // create a canvas of 100 x 100 pixels
  size(100, 100);

  // paint the background black
  background(0);

  // draw a label
  textAlign(CENTER);
  text("drag me!", width/2, height/2);

  // connect to the server that runs minecraft
  mc = Minecraft.connect("localhost");
}

// we need a draw loop, otherwise there's no interaction!

void draw() {

  if (mousePressed) {
    
    // get the player
    Player p = mc.player;
    
    // get it's position and show it on the console
    Vec v = p.getPosition();
    println(v.x, v.y, v.z);
  
    // new x-value based on distance from the center
    int x = mouseX - width/2; 
    
    // new y-value based on distance from the top edge
    int y = height - mouseY;
    
    // create a new vector
    Vec v2 = Vec.xyz(x, y, v.z);
    
    // use the vector to update the position
    p.setPosition(v2);
    
  }
  
}
