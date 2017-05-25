/* Documentation
 * Using vertex to create the walls
 * https://processing.org/reference/vertex_.html
 * Click to build new objects
 * https://processing.org/reference/mouseClicked_.html
 */

PImage wall;
PImage floor;
PImage ceiling;
PImage texture;
int id = 0;

boolean clicked = false;

ArrayList<Ball> balls = new ArrayList<Ball>();

int depth = -1000; // depth of our game
float fx = -0.1;
float fy = -0.9;
float fz = -0.6;

void buildEnvironment() {
  noStroke();
  // Build the back wall
  beginShape();
  texture(wall);
  vertex(0, 0, depth, 0, 0);
  vertex(width, 0, depth, width, 0);
  vertex(width, height, depth, width, height);
  vertex(0, height, depth, 0, height);
  endShape();

  // Build the left wall
  beginShape();
  texture(wall);
  vertex(0, 0, 0, 0, 0);
  vertex(0, 0, depth, width, 0);
  vertex(0, height, depth, width, height);
  vertex(0, height, 0, 0, height);
  endShape();

  // Build the floor
  beginShape();
  texture(floor);
  vertex(0, height, 0, 0, 0);
  vertex(0, height, depth, 0, 0);
  vertex(width, height, depth, width, height);
  vertex(width, height, 0, width, 0);
  endShape();

  // Build the ceiling
  beginShape();
  texture(ceiling);
  vertex(0, 0, 0, 0, 0);
  vertex(0, 0, depth, 0, height);
  vertex(width, 0, depth, width, height);
  vertex(width, 0, 0, width, 0);
  endShape();

  // Build the right wall
  beginShape();
  texture(wall);
  vertex(width, 0, 0, 0, 0);
  vertex(width, 0, depth, width, 0);
  vertex(width, height, depth, width, height);
  vertex(width, height, 0, 0, height);
  endShape();
}

// Trigger to determine when to add a ball
void mouseClicked()
{
  clicked = true;
}

void setup() {
  size(800, 500, P3D);
  wall = loadImage(sketchPath("") + "images/27.png");
  wall.resize(wall.width/3, wall.height/3);
  floor = loadImage(sketchPath("") + "images/54.jpg");
  floor.resize(floor.width*2, floor.height*2);
  ceiling = floor;
}

void draw() {
  buildEnvironment();

  if(clicked)
  {
    balls.add(new Ball(mouseX, mouseY));
    clicked = false;
  }

  for (int i = 0; i < balls.size(); i++) {
    balls.get(i).displayBall();
  }

  for (int i = balls.size()-1; i >= 0; i--)
  {
    if (balls.get(i).remove)
    {
      balls.remove(i);
    }
  }
}
