class Wall extends Sand {
  Wall(int x, int y) {
    super(x, y, color(0, 0, 100));
    this.stuck = true;
  }

  void update(boolean spread) {
    this.stuck = true;
  }

  void render(int i, int j) {
    fill(0, 0, 100);
    noStroke();
    rect(i * w, j * w, w, w);
  }
}
