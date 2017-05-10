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
 * Click to build new objects
 * https://processing.org/reference/mouseClicked_.html
 */

PImage wall;
PImage floor;
PImage ceiling;
boolean clicked = false;

ArrayList<Ball> balls = new ArrayList<Ball>();

int z = -1000; // depth of our game

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

// Trigger to determine when to add a ball
public void mouseClicked()
{
  clicked = true;
}

public void setup() {
  
  wall = loadImage(sketchPath("") + "images/27.png");
  wall.resize(wall.width/5, wall.height/5);
}

public void draw() {
  buildEnvironment();

  if(clicked)
  {
    balls.add(new Ball(mouseX, mouseY));
    clicked = false;
  }

  for (int i = 0; i < balls.size(); i++) {
    balls.get(i).displayBall();
  }
}

/* Ball Class: contains properties of the ball
 * https://processing.org/reference/shape_.html
 *
 */

class Ball {
  // Dimensions x,y,z, radius, Velocity of X,Y,Z
  float x,y,z,r, vx, vy, vz;
  PShape ball;

  Ball(float x, float y)
  {
    // Setting the values
    setX(x);
    setY(y);
    setZ(1);
    setRadius(random(30,40));

    // Build Object
    createBall();

  }

  // Setters
  public void setX(float x) { this.x = x; }
  public void setY(float y) { this.y = y; }
  public void setZ(float z) { this.z = z; }
  public void setVelocityX(float x) { this.vx = x; }
  public void setVelocityY(float y) { this.vy = y; }
  public void setVelocityZ(float z) { this.vz = z; }
  public void setRadius(float r) { this.r = r; }


  // Getters
  public float getX() { return x; }
  public float getY() { return y; }
  public float getZ() { return z; }
  public float getVelocityX() { return vx; }
  public float getVelocityY() { return vy; }
  public float getVelocityZ() { return vz; }
  public float getRadius() { return r; }

  // Creates Ball Object
  public void createBall() {
    ball = createShape(SPHERE, getRadius());
  }

  // Displays Ball Object
  public void displayBall()
  {
    pushMatrix();
    translate(getX(), getY(), getZ() * -1);
    shape(ball);
    popMatrix();
  }

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
