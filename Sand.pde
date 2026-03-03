class Sand {
  int x, y;
  boolean stuck = false;
  color col;

  Sand(int x, int y, color col) {
    this.x = x;
    this.y = y;
    this.col = col;
  }

void update(boolean spread) {
  if (stuck) return;

  if (y + 1 >= rows) {
    stuck = true;
    return;
  }

  if (grid[x][y + 1] == null) {
    moveTo(x, y + 1);
    return;
  }
  if (grid[x][y + 1].stuck) {
    if (!spread) {
      int dir = random(1) < 0.5 ? -1 : 1;
    
      if (canMoveTo(x + dir, y + 1)) {
        moveTo(x + dir, y + 1);
      } 
      else if (canMoveTo(x - dir, y + 1)) {
        moveTo(x - dir, y + 1);
      } 
      else {
        stuck = true;
      }
    } else {
        int dir = (random(1) < 0.5) ? -1 : 1;

      if (canMoveTo(x + dir, y + 1)) {
        moveTo(x + dir, y + 1);
      } else if (canMoveTo(x - dir, y + 1)) {
        moveTo(x - dir, y + 1);
      }
      else if (canMoveTo(x + dir, y)) {
        moveTo(x + dir, y);
      } else if (canMoveTo(x - dir, y)) {
        moveTo(x - dir, y);
      } else {
        stuck = true; 
      }
    }
  }
}

void moveTo(int nextX, int nextY) {
  if (grid[nextX][nextY] == null) {
    grid[x][y] = null;
    x = nextX;
    y = nextY;
    grid[x][y] = this;
  }
}
boolean canMoveTo(int nextX, int nextY) {
  return (nextX >= 0 && nextX < cols && nextY < rows && grid[nextX][nextY] == null);
}

  void render(int i, int j) {
    fill(this.col);
    noStroke();
    rect(i * w, j * w, w, w);
  }
}

