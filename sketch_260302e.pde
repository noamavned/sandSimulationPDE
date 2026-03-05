int fp = 1;
int dragFp = 1;
int c = 800;
int opening = 3;

int cols, rows;
int w = 2, n = 40000;

Sand[][] grid;
ArrayList<Sand> allGrains = new ArrayList<Sand>();
ArrayList<Wall> walls = new ArrayList<Wall>();

void setup() {
  size(200, 800);
  frameRate(10000);
  colorMode(HSB, 360, 100, 100);

  cols = width / w;
  rows = height / w;
  grid = new Sand[cols][rows];

  int neckY = rows / 2;
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      float distToCenter = abs(i - cols/2.0);
      float distToNeck = abs(j - neckY);

      if (distToCenter > distToNeck + opening && distToNeck < rows / 2) {
        Wall b = new Wall(i, j);
        grid[i][j] = b;
        walls.add(b);
      }
    }
  }
  initiateSand(n);
}

void draw() {
  if (mousePressed) spawn();
  background(0);

  for (Wall b : walls) {
    b.render(b.x, b.y);
  }

  if (frameCount % fp == 0) {
    for (int i = allGrains.size() - 1; i >= 0; i--) {
      allGrains.get(i).update();
    }
  }

  for (Sand s : allGrains) {
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
    grid[s.x][s.y] = s;
  }
}

void keyPressed() {
  if (key == ' ' || key == 'f') flipGrid();
}

void initiateSand(int count) {
  int placed = 0;
  int attempts = 0;
  int maxAttempts = count * 10;

  while (placed < count && attempts < maxAttempts) {
    int rx = (int)random(cols);
    int ry = (int)random(0, rows / 2); 

    if (grid[rx][ry] == null) {
      float hueValue = map(placed % c, 0, c - 1, 0, 360);
      Sand s = new Sand(rx, ry, color(hueValue, 80, 90));
      
      grid[rx][ry] = s;
      allGrains.add(s);
      placed++;
    }
    attempts++;
  }
}
