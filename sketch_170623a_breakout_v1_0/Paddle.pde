class Paddle {
  
  PVector pos;
  float w = 80; // width
  float h = 10; // height
  color c = color(50,50,50);
  
  Paddle () {
    
    pos = new PVector(width/2 - w/2, height*0.9);
  }
  
  void update () {
    fill(c);
    rect(pos.x, pos.y, w, h);
  }
  
  
  
  
  
}