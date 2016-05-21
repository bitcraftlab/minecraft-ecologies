// Connect to the Captury using osc-proxy.pd

import peasy.*;
import netP5.*;
import oscP5.*;

OscP5 osc;
NetAddress remote;
PeasyCam cam;

int localport = 12000;
int remoteport = 13000;

float xroot, yroot, zroot;

void setup() {

  size(500, 500, P3D);
  cam = new PeasyCam(this, 500);

  osc = new OscP5(this, localport);
  remote = new NetAddress("localhost", remoteport);
  // setPort(remoteport);

  plugBone("Root");
  refreshSubscriptions();
}

void draw() {

  background(255);   
  translate(xroot, yroot, zroot);
  sphere(50);

  // refresh subscription every second or so
  if (frameCount % 60 == 0) {
    refreshSubscriptions();
  }
}

void refreshSubscriptions() {
  subscribeBone("Root");
}



void oscEvent(OscMessage msg) {
  print("### received an osc message.");
  print(" addrpattern: "+msg.addrPattern());
  println(" typetag: "+msg.typetag());
}


void plugBone(String bone) {
  String path =  "/100000/blender/" + bone + "/vector";
  osc.plug(this, "update" + bone, path);
}

public void updateRoot(float x, float y, float z) {
  yroot = map(x, 0, 100, 250, -250);
  xroot = map(y, -100, 100, -250, 250);
  zroot = map(z, 35, 43, 250, -250);
  println(x, y, z);
}

void setPort(int port) {
  OscMessage msg = new OscMessage("/configure/port");
  msg.add(port); 
  send(msg);
}


void subscribeBone(String bone) {
  OscMessage msg = new OscMessage("/subscribe/100000/blender/" + bone + "/vector");
  msg.add(50.0);
  msg.add(0.0);
  msg.add(100.0);
  send(msg);
}

void send(OscMessage msg) {
  osc.send(msg, remote);
}