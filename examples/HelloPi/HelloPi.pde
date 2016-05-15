
// the MCPI object
Minecraft mc;

// our message to the worls
String msg = "hello";

void setup() {
  
  // create a canvas of 100 x 100 pixels
  size(100, 100);
  
  // paint the background black
  background(0);
  
  // draw the message right in the middle of the screen
  textAlign(CENTER);
  text(msg, width/2, height/2);
  
  // connect to the server that runs minecraft
  mc = Minecraft.connect("enigma.medien.uni-weimar.de");
 
}

// we need a draw loop, otherwise there's no interaction!
void draw() {}

// do something when we click on the processing window
void mousePressed() {

  // print the message to the local console
  println("posted >>> " + msg + " <<<");
  
  // send the message to minecraft
  mc.postToChat(msg);

}