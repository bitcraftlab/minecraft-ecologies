
// the MCPI object
Minecraft mc;
import static pi.Block.*;

// parameters
int xc = 0;
int yc = 70;
int zc = 0;

int radius = 10;
int sleep = 100;

void setup() {
  mc = Minecraft.connect("localhost");
}

// we need a draw loop, otherwise there's no interaction!
void draw() {
}

void keyPressed() {

  switch(key) {
  case 'c':
    sphereGrid(5, 5, radius, GRASS);
    break;
  case 'd':
    sphereGrid(5, 5, radius, AIR);
    break;
  }
}


void sphereGrid(int xmax, int zmax, int r, Block material) {
  int count = 1;
  for (int x = 0; x < xmax; x++) {
    for (int z = 0; z < zmax; z++) {
      println("Block " + count++);
      createSphere(xc + x * 3 * r, yc, zc + z * 3 * r, r, material);
    }
  }
}


void createSphere(int xcenter, int ycenter, int zcenter, int r, Block material) {
  for (int x = xcenter - r; x <= xcenter + r; x++) {
    for (int y = ycenter - r; y <= ycenter + r; y++) {
      for (int z = zcenter - r; z <= zcenter + r; z++) {
        // get the distance of the current block from the center of the sphere
        float d = dist(x, y, z, xcenter, ycenter, zcenter);
        if (d < r) {
          mc.setBlock(x, y, z, material);
        }
      }
    }
  }
}