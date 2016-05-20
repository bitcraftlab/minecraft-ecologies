
void createSlowSphere() {
  println("create slow sphere");
  createSlowSphere(xc, yc, zc, r2, GRASS, sleep);
}

void removeSlowSphere() {
  println("delete slow sphere");
  createSlowSphere(xc, yc, zc, r2, AIR, sleep);
}

void createSlowCube() {
  println("create slow cube");
  createSlowCube(xc, yc, zc, r2, GRASS, sleep);
}

void removeSlowCube() {
  println("delete slow cube");
  createSlowCube(xc, yc, zc, r2, AIR, sleep);
}