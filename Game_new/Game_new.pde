// Her kan du styre den generelle game volume
float volume = 0.06;             
void setup() {
  fullScreen();
  //size(1600,900); // only here for debug reasons, can be used if a smaller screen is desired.
  loop = new SoundFile(this, "loop.wav"); 
  ded = new SoundFile(this, "ded.wav");
  win = new SoundFile(this, "win.wav");
  C = new CoreSystem();
  S = new StarSystem();
  C.ready();
}

void draw() {
  if (start == true) {
    C.displayMenu();
    return;
  }
  C.play();
}

void keyPressed() {
  if (start) {
    start = false;
    System.out.print("Start --> ");
  }
  if (key == 'A' | key == 'a'| keyCode==LEFT) {
    rocketSpeedX = -movementspeed;
  } else if (key == 'D' | key == 'd'| keyCode==RIGHT) {
    rocketSpeedX =  movementspeed;
  }
  if (restart) {
    C.gamerestart();
    loop();
    System.out.print("Restart --> ");
  }
}

void keyReleased() { 
  if (key == 'A' | key == 'a' | keyCode==LEFT && rocketSpeedX<0) {
    rocketSpeedX = 0;
  } else if (key == 'D' | key == 'd' | keyCode==RIGHT && rocketSpeedX>0) {
    rocketSpeedX = 0;
  }
}
