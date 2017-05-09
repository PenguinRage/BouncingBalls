import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class BouncingParticles extends PApplet {

/* Documentation
 * Using vertex to create the walls
 * https://processing.org/reference/vertex_.html
 */


PImage wall;
PImage floor;
PImage ceiling;
int z = -1000; // determines how far the vertex is pushed back
public void setup() {
  
  wall = loadImage(sketchPath("") + "images/27.png");
  wall.resize(wall.width/5, wall.height/5);

}

public void buildEnvironment() {
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

public void draw() {
  buildEnvironment();

  Ball b = new Ball();
}

/* Ball Class: contains properties of the ball
 *
 *
 */

class Ball {
  int x;
  int y;
  int z;

  // Setters
  public void setX(int x) { this.x = x; }
  public void setY(int y) { this.y = y; }
  public void setZ(int z) { this.z = z; }

  // Getters
  public int getX() { return x; }
  public int getY() { return y; }
  public int getZ() { return z; }
}
  public void settings() {  size(800, 500, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BouncingParticles" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
