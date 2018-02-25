final int X_INIT = 720;
final int Y_INIT = 450;
final int Z_INIT = -450;
final int PIECES = 100;

class Piece {
  PVector direction;
  float mass;
  int xPos, yPos, zPos;
  color c;
  
  Piece(PVector direction, float mass) {
    this.direction = direction;
    this.mass = mass;
    c = color(ceil(random(100)), 100, 100);
  }
  
  void render(int i) {
    if (i==0){
      fill(255,255,255);
    }else{
    fill(c);
    }
    pushMatrix();
    translate(X_INIT+xPos, Y_INIT+yPos, Z_INIT+zPos);
    sphere(ceil(mass));
    popMatrix();
  }
  
  void move() {
    xPos += this.direction.x;
    yPos += this.direction.y;
    zPos += this.direction.z;
  }
}

Piece[] pieces;
boolean blown_up = true;
int mass_sum;

void setup() {
  colorMode(HSB, 100);
  ellipseMode(CENTER);
  fullScreen(P3D);
  frameRate(300);
  blown_up = true;
  pieces = new Piece[PIECES];
  
  mass_sum = 0;
  for (int i = 0; i < PIECES; i++) {
    float theta = random(2 * PI);
    float mass = random(0,30);
    pieces[i] = new Piece(new PVector(ceil(cos(theta) * mass)/10, (sin(theta) * mass)/10, ceil(random(10))), mass);
    mass_sum += mass;
  }
}

void draw() {
  clear();
  noStroke();
//pointLight(0, 20, 255, pieces[0].xPos, pieces[0].yPos, pieces[0].zPos);
pointLight(0, 20, 255, 600, 0, 0);
pointLight(0, 20, 255, 600, 450, 0);
pointLight(0, 20, 10, 600, 450, 1000);
//pushMatrix();
//translate(600,0,0);
//sphere(20);
//translate(600,455,0);
//sphere(20);
//translate(600,0,100);
//sphere(20);
//popMatrix();

    fill(100, 100, 100); 
    for (Piece a : pieces) {
      for (Piece b : pieces) {
        if (dist(a.xPos, a.yPos, a.zPos, b.xPos, b.yPos, b.zPos)+a.mass+b.mass < 0){
         PVector temp = a.direction;
         a.direction = b.direction;
         b.direction = temp;
        }
    }
    }
    for (Piece p : pieces) {
      if (abs(p.xPos)>700){
        p.direction.mult(-1);
      }
      
       if (abs(p.yPos)>450){
        p.direction.mult(-1);
      }
      
      if (abs(p.zPos)>1000){
        p.direction.mult(-1);
      }
    }
     for (Piece p : pieces) {
      p.move();
    }
    for (int i = 0; i < PIECES; i++) {
      pieces[i].render(i);
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
  