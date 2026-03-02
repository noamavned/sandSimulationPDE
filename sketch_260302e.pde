int fp = 1;
int dragFp = 10;
int cols, rows;
int w = 5;
Sand[][] grid;
ArrayList<Sand> activeGrains = new ArrayList<Sand>();

void setup() {
  size(870, 400);
  cols = width / w;
  rows = height / w;
  grid = new Sand[cols][rows];
  background(0);
}

void draw() {
  if (mousePressed) {
    spawn();
  }
  background(0);
  for (int i = activeGrains.size() - 1; i >= 0; i--) {
    Sand s = activeGrains.get(i);
    if (frameCount % fp == 0) {
      s.update();
    }
    if (s.stuck) {
      activeGrains.remove(i);
    }
  }

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid[i][j] != null) {
        grid[i][j].render(i, j);
      }
    }
  }
}

void spawn() {
  if (frameCount % dragFp == 0) {
    int x = mouseX / w;
    int y = mouseY / w;
  
    if (x >= 0 && x < cols && y >= 0 && y < rows && grid[x][y] == null) {
      Sand newSand = new Sand(x, y);
      grid[x][y] = newSand;
      activeGrains.add(newSand);
    }
  }
}
