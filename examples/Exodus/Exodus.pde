
Connection c;

void setup() {
  c = new Connection(this, "localhost", 4711);
}

void draw() {}

int[] getPlayerIds() {
  c.send("world.getPlayerIds");
  return int(split(c.receive(), "|"));
}

void mousePressed() {
  
  println("killall");
  
  int[] ids = getPlayerIds();
  
  for(int i = 0; i < ids.length; i++) {
    
    // get coordinates of the player
    c.send("entity.getTile", ids[i]);
    int[] pos = int(split(c.receive(), ","));
    int x = pos[0];
    int y = pos[1];
    int z = pos[2];
    
    // kill everyone with Lava
    c.send("world.setBlock", x, y, z, 10); 

  }

}