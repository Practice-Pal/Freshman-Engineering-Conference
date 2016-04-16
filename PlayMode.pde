public class PlayMode
{

  PVector[] position; //array contains positions of all notes
  PVector velocity; //moves notes left across the screen
  
  PImage alto_clef, time_signature; //images loaded
    
  int totalLength; //total pixel length of song, used to determine where to put notes
  int numBars; //number of measures/bar lines needed
  int[] barPosition; //stores x-coordinates of bar lines
  
  boolean[] correct; //array storing each note and if user played correct
  boolean[] in; //true if note is in the checking area
  boolean[] past; //true if note is past the checking area
  boolean notEmpty; //true if input exists
  
  String input; //string storing inputs from arduino
  String info[];
  
  int score; //running total of score
  int combo; //running total of combo; resets to 0 if user plays incorrect note
  int maxCombo; //max combo
  int numCorrect; //total number of notes correct
  int numNotes; //total number of notes played at a given moment
  float accuracy; //% accuracy
  
  int fade;
  int refade;
  
  final int great = 300; //adds 300*combo if user plays correct
  
  Song song; //song loaded
  Note[] songInfo; //note information for song
 
  
  public void setup(String filename[])
  {
    //sets screen size
    screenSizeX = 1600;
    screenSizeY = 900;
    surface.setSize(screenSizeX, screenSizeY);
    info = filename;
    //white background
    background(255);
    
    //loads images
    alto_clef= loadImage("alto clef.jpg");
    alto_clef.resize(90,130);
    time_signature = loadImage("4-4-basic-time-signature.jpg");
    
    //loads song from textfile
    song = new Song(info[2] + ".txt");
    song.createSong();
    songInfo = song.getSong();
    
    //determines initial positions of all notes
    position = new PVector[songInfo.length];
    velocity = new PVector(-4, 0);
    
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
    combo = 0;
    maxCombo = 0;
    numNotes = 0;
    numCorrect = 0;
    accuracy = 0;
    fade = 0; 
    refade = 255;
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
    
    textFont(optionHeadFont);
    textAlign(RIGHT);
    text(nf(score, 8), screenSizeX, 50);
    text(nf(accuracy, 2, 2) + "%", screenSizeX, 120);
    textAlign(LEFT);
    text(combo + "x", 0, screenSizeY);
       
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
        if(position[i].x < 502.5){
          in[i] = true;
        }
        if(position[i].x < 497.5){
          past[i] = true;
        }
        
        //goes to compare methods to compare input and correct pitch
        if(input != null){
          notEmpty = Compare.notEmpty(input);
          correct[i] = Compare.check(songInfo[i].getPitch(), input, songInfo[i].openString());
          songInfo[i].checkNote(notEmpty, correct[i], in[i], past[i]); //sorry this is kinda confusing code, i was a little frazzled while writing this
          
          if(!songInfo[i].getChecked() && songInfo[i].getDone()){
            if(songInfo[i].getCorrect()){
              combo++;
              numCorrect++;
              if(combo == 0)
                score += great;
              else
                score += combo*great;
            }
            else{
              combo = 0;
            }
            if(combo > maxCombo){
              maxCombo = combo;
            }
            numNotes++;
            accuracy = 100*(float)numCorrect/numNotes;
            songInfo[i].setChecked();
          }
          
            
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
    color(0, 9, 62, 192);
    stroke(177);
    rect(500, screenSizeY/2, 5, 200); 
    
    //if song is at its end
    if(position[songInfo.length - 1].x <= 200){
      fill(255, fade);
      rect(screenSizeX/2, screenSizeY/2, screenSizeX, screenSizeY);
      fade += 10;
      
      if(fade > 255){
        fill(255);
        rect(screenSizeX/2, screenSizeY/2, screenSizeX, screenSizeY);
        delay(1000);
        stage = 8;
      }
    }

  }
  
  //goes to end game screen
  void postGame()
  {
     highScores.endGame(info[0], info[1], score, numCorrect, numNotes-numCorrect, maxCombo, accuracy);
     fill(255, refade);
     stroke(255, refade);
     rect(screenSizeX/2, screenSizeY/2, screenSizeX, screenSizeY);
     if(refade > 0)
       refade -= 10;
  }
}