
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
    setGravity(0.98);

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
    ball = createShape(SPHERE, getRadius());
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

    /* Screen window
    else if (getZ() < 0)
    {
      setZ(0);
      setVelocityZ(vz * fz);
    }
    */

  }

  void collision()
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
