final int X_INIT = 250;
final int Y_INIT = 250;
final int PIECES = 64;

class Piece {
  PVector direction;
  float mass;
  int xPos, yPos;
  color c;
  
  Piece(PVector direction, float mass) {
    this.direction = direction;
    this.mass = mass;
    c = color(ceil(random(100)), 100, 100);
  }
  
  void render() {
    fill(c);
    pushMatrix();
    translate(X_INIT, Y_INIT);
    ellipse(xPos, yPos, ceil(mass), ceil(mass));
    popMatrix();
  }
  
  void move() {
    xPos += this.direction.x;
    yPos += this.direction.y;
  }
}

Piece[] pieces;
boolean blown_up;
int mass_sum;

void setup() {
  colorMode(HSB, 100);
  ellipseMode(CENTER);
  size(500, 500);
  
  blown_up = false;
  pieces = new Piece[PIECES];
  
  mass_sum = 0;
  for (int i = 0; i < PIECES; i++) {
    float theta = random(2 * PI);
    int mass = ceil(random(15)+5);
    pieces[i] = new Piece(new PVector(ceil(cos(theta) * mass), ceil(sin(theta) * mass)), mass);
    mass_sum += mass;
  }
}

void draw() {
  clear();
  if (!blown_up) {
    fill(100, 100, 100);
    ellipse(X_INIT, Y_INIT, sqrt(mass_sum/2*PI), sqrt(mass_sum/2*PI));
  } else {
    for (Piece p : pieces) {
      p.render();
    }
  }
}

void mouseClicked() {
  if (!blown_up) {
    blown_up = true;
  } else {
    for (Piece p : pieces) {
      p.move();
    }
  }
}
  