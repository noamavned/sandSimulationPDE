int fp = 1;
int dragFp = 1;
int c = 800;
int cols, rows;
int w = 5;
Sand[][] grid;
ArrayList<Sand> allGrains = new ArrayList<Sand>();
ArrayList<Wall> walls = new ArrayList<Wall>();

void setup() {
  size(100, 400);
  colorMode(HSB, 360, 100, 100);
  cols = width / w;
  rows = height / w;
  grid = new Sand[cols][rows];
  
  int neckY = rows / 2;
  int opening = 1;

  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      float distToCenter = abs(i - cols/2.0);
      float distToNeck = abs(j - neckY);
      if (distToCenter > distToNeck + opening && distToNeck < 15) {
        Wall b = new Wall(i, j);
        grid[i][j] = b;
        walls.add(b);
      }
    }
  }
}

void draw() {
  if (mousePressed) spawn();
  background(0);
  
  for (Wall b : walls) b.render(b.x, b.y);

  for (int i = allGrains.size() - 1; i >= 0; i--) {
    Sand s = allGrains.get(i);
    s.update();
    s.render(s.x, s.y);
  }
}

void spawn() {
  if (frameCount % dragFp == 0) {
    int x = mouseX / w;
    int y = mouseY / w;
    if (x >= 0 && x < cols && y >= 0 && y < rows && grid[x][y] == null) {
      float hueValue = map(frameCount % c, 0, c - 1, 0, 360);
      Sand newSand = new Sand(x, y, color(hueValue, 80, 90));
      grid[x][y] = newSand;
      allGrains.add(newSand);
    }
  }
}

void flipGrid() {
  grid = new Sand[cols][rows];

  for (Wall b : walls) {
    b.y = (rows - 1) - b.y;
    grid[b.x][b.y] = b;
  }

  for (Sand s : allGrains) {
    s.y = (rows - 1) - s.y;
    s.stuck = false;
    if (s.x >= 0 && s.x < cols && s.y >= 0 && s.y < rows) {
      grid[s.x][s.y] = s;
    }
  }
}

void keyPressed() {
  if (key == ' ' || key == 'f') flipGrid();
}
