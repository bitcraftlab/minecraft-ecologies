
// the MCPI object
Minecraft mc;
import static pi.Block.*;

// parameters
int xc = 0;
int yc = 70;
int zc = 0;
int r1 = 8;
int r2 = 10;
int sleep = 100;

void setup() {
  mc = Minecraft.connect("ariadne.medien.uni-weimar.de");
}

// we need a draw loop, otherwise there's no interaction!
void draw() {
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