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

int depth = -1000; // depth of our game
float fx = -0.1f;
float fy = -0.9f;
float fz = -0.6f;

public void buildEnvironment() {
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
  vertex(0, height, 0, 0, 0);
  vertex(0, height, depth, 0, 0);
  vertex(width, height, depth, width, height);
  vertex(width, height, 0, width, 0);
  endShape();

  // Build the ceiling
  beginShape();
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

class Ball
{
  // Dimensions x,y,z, radius, Velocity of X,Y,Z, Friction of x, y, z, Spin, direction
  float x,y,z,r, vx, vy, vz, g, s, d;

  PShape ball;

  Ball(float x, float y)
  {
    // Set Dimensions
    setX(x);
    setY(y);
    setZ(1);

    // set Gravity
    setGravity(0.98f);

    // Set Velocity of the Object
    setVelocityX(random(-20,30));
    setVelocityY(random(-20,30));
    setVelocityZ(random(20));

    // Set Radius of the Object
    setRadius(random(30,40));
    // Set spin & it's direction for the Object
    setSpin(random(50,80));
    setDirection(1);

    // Build Object
    createBall();
  }

  // Setters
  public void setGravity(float g) { this.g = g; }
  public void setX(float x) { this.x = x; }
  public void setY(float y) { this.y = y; }
  public void setZ(float z) { this.z = z; }
  public void setVelocityX(float x) { this.vx = x; }
  public void setVelocityY(float y) { this.vy = y; }
  public void setVelocityZ(float z) { this.vz = z; }
  public void setRadius(float r) { this.r = r; }
  public void setSpin(float s) { this.s = s; }
  public void setDirection(float d) { this.d = d; }


  // Getters
  public float getX() { return x; }
  public float getY() { return y; }
  public float getZ() { return z; }
  public float getVelocityX() { return vx; }
  public float getVelocityY() { return vy; }
  public float getVelocityZ() { return vz; }
  public float getRadius() { return r; }
  public float getSpin() { return s; }
  public float getDirection() { return d; }

  // Creates Ball Object
  public void createBall()
  {
    ball = createShape(SPHERE, getRadius());
  }

  // Displays Ball Object
  public void displayBall()
  {
    updateBall();
    pushMatrix();
    translate(getX(), getY(), getZ() * -1);
    rotateX(PI * getDirection() * frameCount * Math.abs(getVelocityZ() / getSpin()));
    shape(ball);
    popMatrix();

  }

  // Updates Ball Object's destination
  public void updateBall()
  {

    setVelocityY(vy + g);
    setX(x +vx);
    setY(y + vy);
    setZ(z + vz);

    // Rebounding Conditions
    // Left Wall
    if (getX() < getRadius())
    {
      setX(getRadius());
      setVelocityX(vx * fx);
    }
    // Right Wall
    else if (getX() > width - getRadius())
    {
      setX(width - getRadius());
      setVelocityX(vx * fx);
    }

    // Ceiling
    if (getY() < getRadius())
    {
      setY(getRadius());
      setVelocityY(vy * fy);
    }
    // Floor
    else if (getY() > height - getRadius())
    {
      setY(height - getRadius());
      setVelocityY(vy * fy);
    }

    // Back Wall
    if (getZ() > Math.abs(depth))
    {
      setZ(Math.abs(depth));
      setVelocityZ(vz * fz);

      if (getVelocityZ() < 0 && getDirection() > 0)
      {
        setDirection(getDirection() * -1.01f);
      }
    }

    /* Screen window
    else if (getZ() < 0)
    {
      setZ(0);
      setVelocityZ(vz * fz);
    }
    */

  }

  public void collision()
  {
    for (int i = 0; i < balls.size(); i++)
    {
      Ball b = balls.get(i);
      // Not this ball
      if (b.equals(this)) continue;
      // minimal distance between the balls
      float dif_min = b.getRadius() + this.getRadius();
      float dif_x = getX() - b.getX();
      float dif_y = getY() - b.getY();
      float dif_z = getZ() - b.getZ();

      float xy = sqrt(dif_x * dif_x + dif_y * dif_y);
      float xz = sqrt(dif_x * dif_x + dif_z * dif_z);
      float yz = sqrt(dif_y * dif_y + dif_z * dif_z);

      if (xy <= dif_min && xz <= dif_min && yz <= dif_min)
      {
        // Collision part
      }
    }
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
