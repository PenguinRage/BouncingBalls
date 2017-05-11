
/* Ball Class: contains properties of the ball
 * https://processing.org/reference/shape_.html
 *
 */

class Ball
{
  // Dimensions x,y,z, radius, Velocity of X,Y,Z, Friction of x, y, z, Spin, direction
  float x,y,z,r, vx, vy, vz, g, s, d;
  Boolean remove;

  PShape ball;

  Ball(float x, float y)
  {
    // Set Dimensions
    setX(x);
    setY(y);
    setZ(1);
    // set Gravity
    setGravity(0.98);
    remove = false;

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
  void setGravity(float g) { this.g = g; }
  void setX(float x) { this.x = x; }
  void setY(float y) { this.y = y; }
  void setZ(float z) { this.z = z; }
  void setVelocityX(float x) { this.vx = x; }
  void setVelocityY(float y) { this.vy = y; }
  void setVelocityZ(float z) { this.vz = z; }
  void setRadius(float r) { this.r = r; }
  void setSpin(float s) { this.s = s; }
  void setDirection(float d) { this.d = d; }


  // Getters
  float getX() { return x; }
  float getY() { return y; }
  float getZ() { return z; }
  float getVelocityX() { return vx; }
  float getVelocityY() { return vy; }
  float getVelocityZ() { return vz; }
  float getRadius() { return r; }
  float getSpin() { return s; }
  float getDirection() { return d; }

  // Creates Ball Object
  void createBall()
  {
    noStroke();
    texture = loadImage(sketchPath("") + "images/"+ (int)random(0,26) + ".jpg");
    ball = createShape(SPHERE, getRadius());
    ball.setTexture(texture);

  }

  // Displays Ball Object
  void displayBall()
  {
    updateBall();
    pushMatrix();
    translate(getX(), getY(), getZ() * -1);
    rotateX(PI * getDirection() * frameCount * Math.abs(getVelocityZ() / getSpin()));
    shape(ball);
    popMatrix();

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

      if (getVelocityZ() < 0 && getDirection() > 0)
      {
        setDirection(getDirection() * -1.01);
      }
    }

    if (getZ() < -300)
    {
      remove = true;
    }

  }
}
