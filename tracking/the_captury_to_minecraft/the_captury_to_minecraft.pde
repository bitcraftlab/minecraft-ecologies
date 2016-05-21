
// Connect to Minecraft using the MCPI API
// Connect to the Captury using osc-proxy.pd

// 3D Camera
import peasy.*;

// OSC
import netP5.*;
import oscP5.*;

// Minecraft
import static pi.Block.*;

// servers
String minecraftServer = "localhost"; // machine running minecraft
String capturyServer   = "localhost"; // osc proxy

// objects
OscP5 osc;
NetAddress remote;
PeasyCam cam;
Minecraft mc;

// trail of minecraft blocks
Block b = WATER;
int trailsize = 10;
ArrayList<Vec> trail;

// connection ports
int localport = 12000;
int remoteport = 13000;

// tracking params
String skeletonId = "100000";
float trackingFrameRate = 20;
float trackingRange = 100;

// root node position in the tracking system
float xroot, yroot, zroot;

// xrange for minecraft blocks
int xmin = -100;
int xmax = 100;

// yrange for minecraft blocks
int ymin = 0;
int ymax = 8;

// zrange for minecraft blocks
int zmin = -100;
int zmax = 100;

// previous block positions
int pxmc, pymc, pzmc;

void setup() {

  size(500, 500, P3D);
  cam = new PeasyCam(this, 500);
  trail = new ArrayList();

  // setup tracking connection
  osc = new OscP5(this, localport);
  remote = new NetAddress(capturyServer, remoteport);
  // setPort(remoteport);
  
  // subscribe to the position of the root node
  plugBone("Root");
  refreshSubscriptions();

  // connect to minecraft
  mc = Minecraft.connect(minecraftServer); 

}

void draw() {
  
  // draw a sphere to represent the position of the tracked object
  background(255);
  translate(xroot, yroot, zroot);
  sphere(10);

  // refresh subscription every second or so
  if (frameCount % 60 == 0) {
    refreshSubscriptions();
  }
  
}

void refreshSubscriptions() {
  subscribeBone("Root");
}

// catch all for OSC events
void oscEvent(OscMessage msg) {
  print("### received an osc message.");
  print(" addrpattern: "+msg.addrPattern());
  println(" typetag: "+msg.typetag());
}


// create plugs for bone messages
void plugBone(String bone) {
  String path =  "/" + skeletonId + "/blender/" + bone + "/vector";
  osc.plug(this, "update" + bone, path);
}

// callback function for root bone updates
public void updateRoot(float x, float y, float z) {
  
  // tracking coordinates
  println("Tracking: ", x, y, z);
  
  // processing coordinates
  yroot = map(x, 0, 100, 250, -250);
  xroot = map(y, -100, 100, -250, 250);
  zroot = map(z, 35, 43, 250, -250);
  println("Processing: ", xroot, yroot, zroot);
  
  // minecraft coordinates
  int xmc = (int) constrain(map(y, -100, 100, xmin, xmax), xmin, xmax);
  int ymc = (int) constrain(map(z, 35, 43, ymin, ymax), ymin, ymax);
  int zmc = (int) constrain(map(x, 0, 100, zmax, zmin), zmin, zmax);
  println("Minecraft: ", xmc, ymc, zmc);
  
  // check if we have entered a new block
  if(xmc != pxmc || ymc != pymc || zmc != pzmc) {

    // add a new block to minecraft
    Vec v = Vec.xyz(xmc, ymc, zmc);
    mc.setBlock(v, b);
    
    // add block to the beginning of the trail
    trail.add(v);
    
    // remove block from the end of the trail
    if(trail.size() > trailsize) {
      Vec end = trail.get(0);
      mc.setBlock(end, AIR); 
      trail.remove(0); 
    }
   
    // update previous minecraft position
    pxmc = xmc;
    pymc = ymc;
    pzmc = zmc;
    
  }

}

// configure the local port to be used by the captury (not implemented yet)
void setPort(int port) {
  OscMessage msg = new OscMessage("/configure/port");
  msg.add(port); 
  send(msg);
}


// subscribe to a specific bone
void subscribeBone(String bone) {
  OscMessage msg = new OscMessage("/subscribe/" + skeletonId + "/blender/" + bone + "/vector");
  msg.add(trackingFrameRate);
  msg.add(0.0);
  msg.add(trackingRange);
  send(msg);
}

// shorthand to send OSC messages
void send(OscMessage msg) {
  osc.send(msg, remote);
}