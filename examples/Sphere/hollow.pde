
void createHollowSphere(int xcenter, int ycenter, int zcenter, int rinside, int r, Block material) {
  for (int x = xcenter - r; x <= xcenter + r; x++) {
    for (int y = ycenter - r; y <= ycenter + r; y++) {
      for (int z = zcenter - r; z <= zcenter + r; z++) {
        // get the distance of the current block from the center of the sphere
        float d = dist(x, y, z, xcenter, ycenter, zcenter);
        if (d > rinside && d < r) {
          mc.setBlock(x, y, z, material);
        }
      }
    }
  }
}