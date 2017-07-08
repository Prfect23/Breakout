 //<>//
import processing.sound.*;
SoundFile bounce;
SoundFile brickCrush;

Ball b;
Paddle p;
ArrayList<Brick> brick = new ArrayList<Brick>();
int numRows = 5;
int numCols = 10;
int score;
int multiplyer;
int lives;
int mode;

boolean up = false;
boolean down = false;
boolean left = false;
boolean right = false;
boolean restart = false;


void setup () {
  // Load a soundfile from the /data folder of the sketch and play it back
  bounce = new SoundFile(this, "sfx_movement_jump7.wav");
  brickCrush =new SoundFile(this, "sfx_sounds_damage3.wav");

  size (700, 700);
  p = new Paddle();
  newGame();
}

void draw () {
  background(242);

  switch (mode) {
  case 0:
    runGame();
    break;
  case 1:
    gameOver();
    break;
  }
  hud();
  bricksGoneCheck();
}

void runGame() {
  if (left) p.pos.x = constrain(p.pos.x -= 15, 0, width - p.w);
  if (right) p.pos.x = constrain(p.pos.x += 15, 0, width - p.w);

  b.update();
  p.update();
}

void gameOver() {
  if(restart) newGame(); //<>//
}


void newGame() {
  score = 0;
  multiplyer = 1;
  lives = 3;
  resetBricks();
  b = new Ball();
  mode = 0;
  p.pos.x = width/2 - p.w/2;
}

void bricksGoneCheck() {
  for (Brick brk : brick) {
    brk.update();
  }
  if (brick.size() == 0 && b.pos.y > height/2) resetBricks();
}

void hud() {
  fill(0, 0, 0);
  textSize(20);
  text("Score " + score, 10, 30);
  text("+" + multiplyer, 120, 30);
  text("Lives " + lives, width - 80, 30);

  if (b.gameOver) {
    textSize(40);
    text("Game Over", width/2 - 100, 2*height/3);
    textSize(20);
    text("Press SPACE to restart", width/2 - 100, 3*height/4);
  }
}

void resetBricks() {
  int leftMargin = 55;
  int topMargin = 80;
  int horzPitch = 60;
  int vertPitch = 35;
  int brickWidth = 50;
  int brickHeight = 25;

  for (int i = 0; i < numRows; i++) {
    for (int j = 0; j < numCols; j++) {
      Brick b = new Brick(leftMargin + (j * horzPitch), topMargin + (i * vertPitch), brickWidth, brickHeight);

      switch(i) {
      case 0:
        b.c = color(248, 201, 157);
        break;
      case 1:
        b.c = color(249, 120, 80);
        break;
      case 2:
        b.c = color(211, 48, 43);
        break;
      case 3:
        b.c = color(106, 39, 70);
        break;
      case 4:
        b.c = color(0, 11, 45);
        break;
      }

      brick.add(b);
    }
  }
}

void keyPressed() {
  switch (key) {
  case 'w':
    up = true;
    break;
  case 's':
    down = true;
    break;
  case 'a':
    left = true;
    break;
  case 'd':
    right = true;
    break;
  case 'p':
    b.inPlay = !b.inPlay;
    break;
  case 32:
    restart = true;
    break;
  }
}

void keyReleased() {
  switch (key) {
  case 'w':
    up = false;
    break;
  case 's':
    down = false;
    break;
  case 'a':
    left = false;
    break;
  case 'd':
    right = false;
    break;
  case 32:
    restart = false;
    break;
  }
}

// end of file