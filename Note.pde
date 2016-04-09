class Note
{
  
  private String pitch; //letter form of note passed in
  private int pitchNum; //note converted into a representative int
  
  private int noteValue; //int representatinon of note value. 16 = sixteenth note, 8 = eighth note, etc...
  private int drawLength; //int representation of note length, how far away from next note in pixels note will be
  
  private boolean sharp; //true if the note is sharp
  private boolean flat; //true if the note is flat
  PImage sharpSign = loadImage("sharp.jpg"); //loads sharp image
  PImage flatSign = loadImage("flat.jpg"); //loads flat image
  
  private boolean correct; //true if user plays correct note
  private boolean done; //true if user pressed a key
 
  color noteColor = color(0);
  color right = color(28, 255, 0);
  color wrong = color(255, 0, 0);
  int fade = 255;
  
  //constructor
  Note(String[] info)
  {
    pitch = info[0];
    noteValue = Integer.parseInt(info[1]);
  }
  
  
  //turns letter of pitch into int representing position away from middle C (1)
  void determinePitch()
  {
    switch((pitch.toLowerCase().charAt(0))){
      case 'c':
        pitchNum = 1;
        break;
      case 'd':
        pitchNum = 2;
        break;
      case 'e':
        pitchNum = 3;
        break;
      case 'f':
        pitchNum = 4;
        break;
      case 'g':
        pitchNum = 5;
        break;
      case 'a':
        pitchNum = 6;
        break;
      case 'b':
        pitchNum = 7;
        break;
    }
    
    
    if(pitch.charAt(1) == '#'){
      sharp = true;
      pitchNum += 8*((int)pitch.charAt(2)-48-4);
    }
    else if (pitch.charAt(1) == 'b'){
      flat = true;
      pitchNum += 8*((int)pitch.charAt(2)-48-4);
    }
    else{
     pitchNum += 8*((int)pitch.charAt(1)-48-4); 
    }
    
  }
  
  //converts length of note into pixel distance
  void determineLength() 
  {
    drawLength = 500/noteValue;
  }
  
  //returns int pitchNum
  int getPitchNum()
  {
    //System.out.println(pitchNum);
    return pitchNum;
  }
  
  
  int getLength()
  {
    //System.out.println(drawLength);
    return drawLength;
  }
  
  void drawNote(float xPos, float yPos)
  {
    imageMode(CENTER);
    if(sharp){
      image(sharpSign, xPos-40, yPos, 50, 70);
    }
    else if(flat){
      image(flatSign, xPos-40, yPos-15, 60, 90);
    }
    
    if(done)
      fade -= 5;
    if(correct)
      noteColor = color(right, fade);
    else if(!correct && done)
      noteColor = color(wrong, fade);
    ellipseMode(CENTER);
   
   
    switch(noteValue){
      case 1: //whole note
        stroke(noteColor);
        strokeWeight(5);
        fill(255);
        ellipseMode(CENTER);
        ellipse(xPos, yPos, 40, 25);
        break;
        
      case 2: //half note
        strokeWeight(5);
        stroke(noteColor);
        fill(255, fade);
        ellipseMode(CENTER);
        ellipse(xPos, yPos, 40, 25);
        line(xPos+22.5, yPos, xPos+20, yPos-90);
        break;
       
      case 4: //quarter note
        strokeWeight(5);
        fill(noteColor);
        stroke(noteColor);
        ellipseMode(CENTER);
        ellipse(xPos, yPos, 40, 25);
        line(xPos+22.5, yPos, xPos+20, yPos-90);
        break;
        
      case 8: //eighth note
        strokeWeight(5);
        fill(noteColor);
        stroke(noteColor);
        ellipseMode(CENTER);
        ellipse(xPos, yPos, 40, 25);
        line(xPos+22.5, yPos, xPos+20, yPos-90);
        curve(xPos-50, yPos-50, xPos+22.5, yPos-90, xPos+40, yPos-50, xPos, yPos);
        break;
    }
    
  }
      
  void checkNote(boolean pressed, boolean right, boolean in, boolean past)
  {
    if(in && !done){
      if(pressed){
        done = true;
        if(right){
          correct = true;
        }
        else{
          correct = false;
        }
      }
    }
    
    if(past && !correct){
      done = true;
    }
    
  }
  
  
  //returns string pitch
  String getPitch()
  {
    return pitch; 
  }
  
    /*
  //returns int noteValue
  int getNoteValue()
  {
    return noteValue; 
  }
  */
}