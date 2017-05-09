/* Documentation
 * Using vertex to create the walls
 * https://processing.org/reference/vertex_.html
 */


PImage wall;
PImage floor;
PImage ceiling;

int z = -1000; // determines how far the vertex is pushed back
void setup() {
  size(800, 500, P3D);
  wall = loadImage(sketchPath("") + "images/27.png");
  wall.resize(wall.width/5, wall.height/5);

}

void buildEnvironment() {
  // Build the back wall
  beginShape();
  texture(wall);
  vertex(0, 0, z, 0, 0);
  vertex(width, 0, z, width, 0);
  vertex(width, height, z, width, height);
  vertex(0, height, z, 0, height);
  endShape();

  // Build the left wall
  beginShape();
  texture(wall);
  vertex(0, 0, 0, 0, 0);
  vertex(0, 0, z, width, 0);
  vertex(0, height, z, width, height);
  vertex(0, height, 0, 0, height);
  endShape();

  // Build the floor
  beginShape();
  vertex(0, height, 0, 0, 0);
  vertex(0, height, z, 0, 0);
  vertex(width, height, z, width, height);
  vertex(width, height, 0, width, 0);
  endShape();

  // Build the ceiling
  beginShape();
  vertex(0, 0, 0, 0, 0);
  vertex(0, 0, z, 0, height);
  vertex(width, 0, z, width, height);
  vertex(width, 0, 0, width, 0);
  endShape();

  // Build the right wall
  beginShape();
  texture(wall);
  vertex(width, 0, 0, 0, 0);
  vertex(width, 0, z, width, 0);
  vertex(width, height, z, width, height);
  vertex(width, height, 0, 0, height);
  endShape();
}

void draw() {
  buildEnvironment();
}
