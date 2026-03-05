class Sand {
  int x, y;
  boolean stuck = false;
  color col;
  float v = 0;
  float a = 5;
  float dt = 0.1;

  Sand(int x, int y, color col) {
    this.x = x;
    this.y = y;
    this.col = col;
  }

  void update() {
    if (stuck && canMoveSomewhere()) {
      stuck = false;
    }

    if (stuck) return;

    v += a * dt;
    int steps = floor(v);
    if (steps < 1) steps = 1;

    for (int i = 0; i < steps; i++) {
      int nextY = y + 1;
      if (nextY >= rows) {
        stopMoving();
        break;
      }

      if (grid[x][nextY] == null) {
        moveTo(x, nextY);
      } else {
        
        if (grid[x][nextY] instanceof Wall) {
          this.v *= 0.2;
        }

        if (this.v > 1.5 && !(grid[x][nextY] instanceof Wall) && grid[x][nextY].stuck) {
           if (tryPush(x, nextY)) {
             moveTo(x, nextY); 
             this.v *= 0.7;
             continue; 
           }
        }
        
        int dir = random(1) < 0.5 ? -1 : 1;
        if (canMoveTo(x + dir, nextY)) {
          moveTo(x + dir, nextY);
          this.v *= 0.9;
        } else if (canMoveTo(x - dir, nextY)) {
          moveTo(x - dir, nextY);
          this.v *= 0.9;
        } else {
          stopMoving();
          break;
        }
      }
    }
  }

  boolean tryPush(int targetX, int targetY) {
    Sand victim = grid[targetX][targetY];
    if (victim == null || victim instanceof Wall) return false;

    int pushDir = random(1) < 0.5 ? -1 : 1;
    if (canMoveTo(targetX + pushDir, targetY)) {
      victim.moveTo(targetX + pushDir, targetY);
      victim.stuck = false; 
      return true;
    } else if (canMoveTo(targetX - pushDir, targetY)) {
      victim.moveTo(targetX - pushDir, targetY);
      victim.stuck = false;
      return true;
    }
    return false;
  }

  boolean canMoveSomewhere() {
    int nextY = y + 1;
    if (nextY >= rows) return false;
    if (grid[x][nextY] == null) return true;
    if (x > 0 && grid[x - 1][nextY] == null) return true;
    if (x < cols - 1 && grid[x + 1][nextY] == null) return true;
    return false;
  }

  void stopMoving() {
    stuck = true;
    this.v = 0;
  }

  void moveTo(int nextX, int nextY) {
    grid[x][y] = null;
    x = nextX;
    y = nextY;
    grid[x][y] = this;
  }

  boolean canMoveTo(int nextX, int nextY) {
    return (nextX >= 0 && nextX < cols && nextY < rows && grid[nextX][nextY] == null);
  }

  void render(int i, int j) {
    fill(col);
    noStroke();
    rect(i * w, j * w, w, w);
  }
}
