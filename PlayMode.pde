public class PlayMode
{

  PVector[] position; //array contains positions of all notes
  PVector velocity; //moves notes left across the screen
  
  PImage alto_clef, time_signature; //images loaded
    
  int totalLength; //total pixel length of song, used to determine where to put notes
  int numBars; //number of measures/bar lines needed
  int[] barPosition; //stores x-coordinates of bar lines
  
  boolean[] correct;
  boolean[] in;
  boolean[] past;
  boolean notEmpty;
  boolean right;
  
  String input;
  
  int score;
  
  Song song; //song loaded
  Note[] songInfo; //note information for song
  
  
  public void setup(String filename)
  {
    //sets screen size
    screenSizeX = 1600;
    screenSizeY = 900;
    surface.setSize(screenSizeX, screenSizeY);
    
    //white background
    background(255);
    
    //loads images
    alto_clef= loadImage("alto clef.jpg");
    alto_clef.resize(90,130);
    time_signature = loadImage("4-4-basic-time-signature.jpg");
   
    //loads song from textfile
    song = new Song(filename);
    song.createSong();
    songInfo = song.getSong();
    
    //determines initial positions of all notes
    position = new PVector[songInfo.length];
    velocity = new PVector(-3, 0);
    
    correct = new boolean[songInfo.length];
    in = new boolean[songInfo.length];
    past = new boolean[songInfo.length];
    
    //1600 pixels before first note
    totalLength = 1600;
    
    //position vector of first note
    position[0] = new PVector(1600, screenSizeY/2 - 15*(songInfo[0].getPitchNum() - 1));
    
    //determines initial position vectors of all notes
    for(int i = 1; i < songInfo.length; i++){
      totalLength += songInfo[i-1].getLength();
      position[i] = new PVector(totalLength, screenSizeY/2 - 15*(songInfo[i].getPitchNum() - 1));
    }
    
    //determines number of bar lines needed
    numBars = floor(totalLength/500);
    barPosition = new int[numBars+4];
    
    //determines initial positions of all bar lines
    for(int i = 0; i < barPosition.length; i++){
      barPosition[i] = 50+500*i;
    }
    
    score = 0;
    
    /*
    textFont(optionHeadFont);
    text("Ready?", screenSizeX, 100);
    textFont(optionTextFont);
    text("Click anywhere to begin...", screenSizeX, 150);
    */
    
  }
  
  public void draw()
  {
    strokeWeight(1);
    background(255);
    rectMode(CENTER);
    
    if ( myPort.available() > 0) 
    {  // If data is available,
       input = myPort.readStringUntil('\n');         // read it and store it in val
       System.out.println(input);
    } 
    //loads images 
    imageMode(CENTER);
    image(alto_clef,100,screenSizeY/2);
    image(time_signature,200,screenSizeY/2);
 
    fill(0);
    stroke(0);
    
    strokeWeight(3);
   

    //draws notes if on the screen to speed up program
    for(int i = 0; i < songInfo.length; i++){
      if(position[i].x >= 0 || position[i].x <= 1700){
        if(position[i].x < 450){
          in[i] = true;
        }
        if(position[i].x < 350){
          past[i] = true;
        }
        
        if(input != null){
          notEmpty = Compare.notEmpty(input);
          right = Compare.check(songInfo[i].getPitch(), input);
          songInfo[i].checkNote(notEmpty, right, in[i], past[i]);
        }
        songInfo[i].drawNote(position[i].x, position[i].y);
        
      }
      position[i].add(velocity);
    }
    
    fill(0);
    stroke(0);
      //draws bar lines
    for(int i = 0; i < barPosition.length; i++){
      line(barPosition[i], screenSizeY/2-60, barPosition[i], screenSizeY/2+60);  
      barPosition[i] += velocity.x;
    }
    
    //draws staff
    strokeWeight(1);
    fill(0);
    for(int i = 0; i < 5; i++){
      rect(screenSizeX/2, screenSizeY/2-60+30*i, screenSizeX+100, 2);
    }
    
    //note checking zone
    fill(177, 177, 177, 100);
    stroke(177);
    rect(400, screenSizeY/2, 100, 200); 
    
  }
  
}