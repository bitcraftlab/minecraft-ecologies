
void createCube(int xcenter, int ycenter, int zcenter, int r, Block material) {
  for (int x = xcenter - r; x <= xcenter + r; x++) {
    for (int y = ycenter - r; y <= ycenter + r; y++) {
      for (int z = zcenter - r; z <= zcenter + r; z++) {
        mc.setBlock(x, y, z, material);
      }
    }
  }
}