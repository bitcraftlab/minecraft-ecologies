
void keyPressed() {

  switch(key) {
    
  case '0':
    mc.setBlocks(Vec.xyz(xc-r2, yc-r2, zc-r2), Vec.xyz(xc+r2, yc+r2, zc+r2), AIR);
    break;

  case '1':
    createSphere(xc, yc, zc, r2, GRASS);
    break;

  case '2':
    createSphere(xc, yc, zc, r2, AIR);
    break;

  case '3':
    createHollowSphere(xc, yc, zc, r1, r2, GRASS);
    break;

  case '4':
    createHollowSphere(xc, yc, zc, r1, r2, AIR);
    break;

  case '5':
    thread("createSlowSphere");
    break;

  case '6':
    thread("removeSlowSphere");
    break;
  
  case '7':
    thread("createSlowCube");
    break;

  case '8':
    thread("removeSlowCube");
    break;
  }
  
}