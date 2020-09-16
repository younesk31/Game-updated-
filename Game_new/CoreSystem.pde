// bruger processings egen lyd og billed import system for at det skal virke på din masking skal du download deres libary.
import processing.sound.*; SoundFile loop; SoundFile ded; SoundFile win; PImage loader; PImage fuel;
// variabler der fastsætter positioner og størrelser
float canisterX;                   float rocketX;             
float canisterY;                   float rocketY;             
float canisterDiameter = 100;      float rocketDiameter = 250;
// hastigheder på fjende såvel som spiller/raket                     
float canisterSpeedUpgrade = 0.3;  float movementspeed = 31;
float canisterSpeedY = 1;          float rocketSpeedX;    
// rainbow effect som jeg bruger rundt omkring til text osv.
float rainbow;                  
// parametere der sørger for goal/score/health også kaldt fuel og points.
float rnd = random(150,200);
int score = 0;                     int goal = round(rnd);
int health = 1;                    int points = 0;          
// game boolean expressions/mechanics 
boolean dead = false;            boolean won = false; 
boolean start = true;            boolean restart = false;
// Strings med essential text
String Start = "Press any key to start";                String Start1 = "Use the Arrow keys or W & D";
String Won = "YOU WON!";                                String Won1= "Press any key for menu";
String Gameover = "GAME OVER";                          String Gameover1 = "You ran out of fuel!"+'\n'+"Press a key to return to menu";
// Strings med info
String Creator = "Creator; Slider"; // Created by Slider Slayer aka younes :D
String Achievement = "Collect "+goal+" fuel to Win!";        String Info = "|Working on obstacles|";
// Class calls
CoreSystem C; StarSystem S;

class CoreSystem {  
  void ready() {
    loader = loadImage("loader.png");
    fuel = loadImage("fuel.png");
    loop.loop(1, volume);
    colorMode(HSB);
    canisterX=width/2;    
    rocketX=width/2;
    canisterY=height/2;   
    rocketY=height/1.1;
    textAlign(CENTER, BOTTOM);
  }


  void play() {
    if (rainbow >= 255)  rainbow = 0;  else  rainbow++;
    // highscore = max score i samme game.
    if (score == 0 || points >= score) {
      score = points;
    }
    // points == Collected 
    if (points == goal) {
      loop.stop();
      background(0);
      fill(rainbow, 250, 255);
      noStroke();
      textSize(50);
      text(Won, width/2, height/2);
      text(Won1, width/2, height/2+100);
      start = false;
      restart = true;
      dead = false;
      won = true;
      sound();
      System.out.print("Venter på input --> ");
      noLoop();
      return;
    }
    // health == Fuel capacity
    if (health == 0) {
      loop.stop();
      background(0);
      fill(rainbow, 250, 255);
      textSize(50);
      text("Highest score: "+score, width/2, height/12);
      noStroke();
      textSize(100);
      text(Gameover, width/2, height/2);
      fill(255, 150, 150);
      textSize(50);
      text(Gameover1, width/2, height/2+125);
      start = false;
      restart = true;
      dead = true;
      won = false;
      sound();
      System.out.print("Venter på input --> ");
      noLoop();
      return;
    }
    background(0);
    //Tegn en illusion af stjerner
    S.stars();
    // Billed import som er erstatning for mine cirkler.
    noStroke();
    fill(rainbow, 255, 255);
    image(fuel, canisterX - 30, canisterY - 50, canisterDiameter - 45, canisterDiameter);
    //ellipse(canisterX, canisterY, canisterDiameter, canisterDiameter);         // kun til at teste!
    circle(rocketX, rocketY + 20, 75); 
    image(loader, rocketX - 100, rocketY - 145, rocketDiameter - 50, rocketDiameter);
    //ellipse(rocketX, rocketY, rocketDiameter, rocketDiameter);                         // kun til at teste!
    rocketX = rocketX + rocketSpeedX;

    float distance = dist(canisterX, canisterY, rocketX, rocketY);
    if (distance < (rocketDiameter + canisterDiameter)/2) {
      canisterSpeedY = canisterSpeedY + canisterSpeedUpgrade;
      health = health + 2;
      points = points + 1;
      canisterY = height;
      canisterX = random(width);

    }

    fill(64, 75, 255);
    textSize(25);
    text("Fuel capacity: "+health, width/1.1, height/12-25);
    text("Collected: "+points, width/1.1, height/12);

    fill(64, 75, 255);
    textSize(25);
    text(Achievement, width/6, 30);
    

    //textSize(25);
    //text(Info, width/7, height);                                                                             //turned off for github

    canisterY += canisterSpeedY;
    if (canisterY > height) {
      canisterY = 0;
      health = health-1;
    } else if (rocketX > width) {
      rocketX = 0;
    } else if (rocketX < 0) {
      rocketX = width;
    }
  }

  void displayMenu() {
    background(0, 0, 0);
    textSize(30);
    fill(50, 255, 255);
    text(Start, width/2, height/2);
    text(Start1, width/2, height/2+100);
    fill(rainbow++, 255, 255);
    //    text(Creator, width/8, 0+50);
    return;
  }

  void gamerestart() {
    if (restart) {
      restart = false;
      start = true;
      health = 1;                
      points = 0;
      canisterSpeedY = 1;
      loop.loop(1, volume);
      draw();
      System.out.print("Nyt game --> ");
    }
  }

  void sound() {
    if (won) {
      win.play(1, volume);
      won = false;
      System.out.print("Vandt + lyd --> ");
    } else if (dead) {
      ded.play(1, volume);
      dead = false;
      System.out.print("Død + Lyd --> ");
    }
  }
}
