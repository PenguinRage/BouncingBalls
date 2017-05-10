
/* Ball Class: contains properties of the ball
 * https://processing.org/reference/shape_.html
 *
 */

class Ball {
  // Dimensions x,y,z, radius, Velocity of X,Y,Z, Friction of x, y, z
  float x,y,z,r, vx, vy, vz, g;

  PShape ball;

  Ball(float x, float y)
  {
    // Set Dimensions
    setX(x);
    setY(y);
    setZ(1);

    // set Gravity
    setGravity(0.98);

    // Set Velocity of the Object
    setVelocityX(random(-20,20));
    setVelocityY(random(-20,20));
    setVelocityZ(random(20));

    // Set Radius of the Object
    setRadius(random(30,40));

    // Build Object
    createBall();

  }

  // Setters
  void setGravity(float g) { this.g = g; }
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
    updateBall();
  }

  // Updates Ball Object's destination
  void updateBall()
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
    }

    /* Screen window
    else if (getZ() < 0)
    {
      setZ(0);
      setVelocityZ(vz * fz);
    }
    */

  }
}
