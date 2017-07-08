class Ball { //<>// //<>// //<>//

  float initVel = 7;

  PVector pos;
  PVector vel;
  float d = 10; // diameter
  boolean inPlay;
  boolean gameOver;
  int resetStart = 0;

  Ball () {
    pos = new PVector(width/2, height/2);
    vel = new PVector(0.2, initVel);
    inPlay = true;
    gameOver = false;
  }


  void update () {
    if (inPlay) {
      checkEdge();
      pos.add(vel);
    } else if (!gameOver) {
      if (millis() - resetStart > 1000) inPlay = true;
      vel = new PVector(0.2, initVel);
    } else {
      println("you lose");
    }
    fill(255);

    ellipse(pos.x, pos.y, d, d);
    if (collisionCheck(p)) {
      bounce.play();
      setPaddleBounceAngle();
      multiplyer = 1;
    }
    for (int i = brick.size()-1; i >= 0; i--) {
      if (collisionCheck(brick.get(i))) {
        setBrickBounceAngle(brick.get(i));
        brickCrush.play();
        brick.remove(i);
        score += multiplyer;
        multiplyer += 1;
      }
    }
  }

  void brickRef() {
    fill(0);
    rect(width/2-90, 22, 35, 35);
  }

  void setBrickBounceAngle(Brick brk) {
    fill(255, 0, 0);
    if (b.pos.x > brk.pos.x && b.pos.x < brk.pos.x + brk.w) {
      if (b.pos.y + b.d/2 > brk.pos.y && b.pos.y + b.d/2 <= brk.pos.y + brk.h/2) {
        brickRef();
        fill(255, 0, 0);
        rect(width/2-88, 12, 30, 5); // top
        b.pos.y = brk.pos.y - b.d/2 ;
        if (b.vel.y > 0) b.vel.y *= -1;
      } else if (b.pos.y - b.d/2 < brk.pos.y + brk.h  && b.pos.y - b.d/2 > brk.pos.y + brk.h/2) {
        brickRef();
        fill(255, 0, 0);
        rect(width/2-88, 62, 30, 5); // bottom
        b.pos.y = brk.pos.y + brk.h + b.d/2;
        if (b.vel.y < 0) b.vel.y *= -1;
      }
    } if (b.pos.x + b.d/2 > brk.pos.x && b.pos.x + b.d/2 <= brk.pos.x + brk.w/2) {
      brickRef();
      fill(255, 0, 0);
      rect(width/2-100, 25, 5, 30); // left
      b.pos.x = brk.pos.x - b.d/2;
      b.vel.x *= -1;
    } else if (b.pos.x - b.d/2 < brk.pos.x + brk.w && b.pos.x - b.d/2 >= brk.pos.x + brk.w/2) {
      brickRef();
      fill(255, 0, 0);
      rect(width/2-50, 25, 5, 30); // right
      b.pos.x = brk.pos.x + brk.w + b.d/2;
      b.vel.x *= -1;
    }
  }

  void setPaddleBounceAngle () {

    float ballPos = b.pos.x - p.pos.x;
    float angle = map(ballPos, 0, p.w, 3*PI/4, PI/4);
    b.vel.x = initVel * cos(angle);
    b.vel.y = -initVel * sin(angle);
  }

  void checkEdge() {
    if (pos.x > width - d/2 || pos.x < 0 + d/2) vel.x *= -1;
    if (pos.y < 0 + d/2) vel.y *= -1;
    if (pos.y >= height + d/2) endRound();
  }

  void endRound() {

    b.pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    lives -= 1;
    inPlay = false;
    if (lives == 0) {
      endGame();
    } else {
      reset();
    }
  }

  void reset() {
    resetStart = millis();
  }

  void endGame() {
    gameOver = true;
    mode = 1;
  }

  boolean collisionCheck(Paddle pad) {
    boolean above = false;
    boolean below = false;
    boolean leftOf = false;
    boolean rightOf = false;
    boolean collision = false;

    if (b.pos.y + b.d/2 < pad.pos.y) above = true;
    if (b.pos.y - b.d/2 > pad.pos.y + pad.h) below = true;
    if (b.pos.x + b.d/2 < pad.pos.x) leftOf = true;
    if (b.pos.x - b.d/2 > pad.pos.x + pad.w) rightOf = true;

    if (!rightOf && !leftOf && !below && !above) collision = true;

    return collision;
  }

  boolean collisionCheck(Brick brk) {
    boolean above = false;
    boolean below = false;
    boolean leftOf = false;
    boolean rightOf = false;
    boolean collision = false;

    if (b.pos.y + b.d/2 < brk.pos.y) above = true;
    if (b.pos.y - b.d/2 > brk.pos.y + brk.h) below = true;
    if (b.pos.x + b.d/2 < brk.pos.x ) leftOf = true;
    if (b.pos.x - b.d/2 > brk.pos.x + brk.w) rightOf = true;

    if (!rightOf && !leftOf && !below && !above) collision = true;

    return collision;
  }


  //// end ////
}