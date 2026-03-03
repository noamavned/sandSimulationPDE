int fp = 1;
int dragFp = 1;
int c = 800;
int cols, rows;
int w = 5;
boolean spread = false;
Sand[][] grid;
ArrayList<Sand> activeGrains = new ArrayList<Sand>();
ArrayList<Sand> staticGrains = new ArrayList<Sand>();

void setup() {
  size(100, 400);
  colorMode(HSB, 360, 100, 100);
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
      s.update(spread);
    }
    if (s.stuck) {
      staticGrains.add(s);
      activeGrains.remove(i);
    }
  }

  for (Sand s : staticGrains) {
    s.render(s.x, s.y);
  }
  for (Sand s : activeGrains) {
    s.render(s.x, s.y);
  }
}

void spawn() {
  if (frameCount % dragFp == 0) {
    int x = mouseX / w;
    int y = mouseY / w;
  
    if (x >= 0 && x < cols && y >= 0 && y < rows && grid[x][y] == null) {
      int n = frameCount%c;
      float hueValue = map(n, 0, c-1, 0, 360);
      Sand newSand = new Sand(x, y, color(hueValue, 80, 90));
      grid[x][y] = newSand;
      activeGrains.add(newSand);
    }
  }
}

void flipGrid() {
  activeGrains.addAll(staticGrains);
  staticGrains.clear();

  grid = new Sand[cols][rows];

  for (int i = activeGrains.size() - 1; i >= 0; i--) {
    Sand s = activeGrains.get(i);
    
    s.y = (rows - 1) - s.y;
    s.stuck = false;

    if (s.x >= 0 && s.x < cols && s.y >= 0 && s.y < rows) {
      grid[s.x][s.y] = s;
    } else {
      activeGrains.remove(i);
    }
  }
}

void keyPressed() {
  if (key == ' ' || key == 'f') {
    flipGrid();
  }
}
