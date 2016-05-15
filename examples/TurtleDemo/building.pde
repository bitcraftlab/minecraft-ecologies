

void buildHouse(int width, int depth, int height, Block block1, Block block2) {

  // create a turtle
  turtle =  mc.tools.turtle;
  
  // go the starting point
  // and start drawing with the first material
  turtle
  .home()
  .off()
  .up(1)
  .block(block1)
  .on();

  // create the house layer by layer
  for (int i = 0; i < height; i++) {
    turtle
      .forward(depth)
      .right()
      .forward(width)
      .right()
      .forward(depth)
      .right()
      .forward(width)
      .right()
      .up(1);
  }

  // create a roof using the second material
  turtle.jump(0, 0, -1).block(block2);
  for (int s = depth; s >= 0; s -= 2) {
    turtle
      .forward(s)
      .right()
      .forward(width + 2)
      .right()
      .forward(s)
      .right()
      .forward(width + 2)
      .right()
      .jump(1, 1, 0);
  }

  // remove the door
  turtle.home().block(AIR).off().up(1).right().forward(width / 2).on().up(1);
}