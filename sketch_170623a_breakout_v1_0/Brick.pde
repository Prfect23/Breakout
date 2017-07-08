class Brick {
  
  PVector pos;
  float w;
  float h;
  color c;
  
  Brick (float x, float y, float widthDim, float heightDim) {
    pos = new PVector(x, y);
    w = widthDim;
    h = heightDim;
  }
  
  void update () {
    fill(c);
    rect(pos.x, pos.y, w, h);
  }
  
  
}