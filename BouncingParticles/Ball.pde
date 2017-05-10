
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
  void setX(float x) { this.x = x; }
  void setY(float y) { this.y = y; }
  void setZ(float z) { this.z = z; }
  void setVelocityX(float x) { this.vx = x; }
  void setVelocityY(float y) { this.vy = y; }
  void setVelocityZ(float z) { this.vz = z; }
  void setRadius(float r) { this.r = r; }


  // Getters
  float getX() { return x; }
  float getY() { return y; }
  float getZ() { return z; }
  float getVelocityX() { return vx; }
  float getVelocityY() { return vy; }
  float getVelocityZ() { return vz; }
  float getRadius() { return r; }

  // Creates Ball Object
  void createBall() {
    ball = createShape(SPHERE, getRadius());
  }

  // Displays Ball Object
  void displayBall()
  {
    pushMatrix();
    translate(getX(), getY(), getZ() * -1);
    shape(ball);
    popMatrix();
  }

}
