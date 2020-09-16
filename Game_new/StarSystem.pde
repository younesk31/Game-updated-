
class StarSystem {
  int x[], y[], speed[], count; 
  {
    count = 1000;
    x = new int[count];
    y = new int[count];
    speed = new int[count];

    for (int i = 0; i < count; i++)
    {
      x[i] = round(random(width));
      y[i] = round(random(height));
      speed[i] = 1;
    }
  }

  void stars() {
    stroke(255) ;
    for (int i = 0; i < count; i++)
    {
      if (y[i] > height)
      {
        y[i] = 0;
        x[i] = round(random(width));
        //speed[i] = round(random(1, 2));
      } else {
        point(x[i], y[i]);
        point(x[i], y[i]);
        y[i] += (speed[i]*2+canisterSpeedUpgrade+5);
      }
    }
  }
}
