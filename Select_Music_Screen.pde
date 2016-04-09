class Select_Music_Screen {
  PImage first;
  String[][] songInfo = {
                   {"Twinkle, Twinkle, Little Star", "W.A. Mozart", "TwinkleTwinkle.txt"},
                    {"Honeybee", "Bohemian Folk Song", "Honeybee.txt"},
                    {"Lightly Row", "Traditional Folk Song", "LightlyRow.txt"},
                    {"Go Tell Aunt Rhody", "American Folk Song", "AuntRhody.txt"},
                    {"C Test", "Clement Ekaputra", "CTest.txt"}
                 };
  int rectPos; //which song cursor is over
  
    void setup(){
      
      first = loadImage("blue_button.png");
      first.resize(600,200);
      size(1600,900);
    }
    
    void draw(){
      textAlign(LEFT);
      textFont(optionHeadFont);
      text("Select Song", 80, 125);
      
      rectMode(CENTER);
      fill(lines);
      strokeWeight(1);
      stroke(lines);
      rect(screenSizeX/2, 145, screenSizeX-100, 5);
      
      int j = 0;
      for(j = 0; j <= songInfo.length; j++){
        strokeWeight(1);
        fill(lines+20, 128);
        stroke(lines+20, 128);
        rect(screenSizeX/2, 235+60*j, screenSizeX, 5);
      }
      
      mouseOver();
      stroke(lines);
      fill(lines);
      strokeWeight(5);
      line(screenSizeX*4/7, 235, screenSizeX*4/7, 235+60*(j-1));
      
      textSize(32);
      stroke(0);
      fill(0);
      text("Song Name", 100, 215); 
      text("Composer", 1000, 215);
     
     
       for(int i = 0; i < songInfo.length; i++){
         text(songInfo[i][0], 100, 275+60*i);
         text(songInfo[i][1], 1000, 275+60*i);
       }
      //display();
    }
    
    /*
    void display() { 
      background(255);
      textSize(100);
      stroke(0);
      fill(0);
      text("Select Song", width/3, 100);
      image(first, width/3, height/3);
      image(first, width/3, height*2/3);
      textSize(50);
      stroke(0);
    //fill(153, width, 100); 
      text("Song 1", width*7/16, height*7/16);
      text("Song 2", width*7/16,height*25/32);
      
      mouseOver();
    }
    */
    
    void mouseOver() { 
      
      rectPos = ((mouseY - 235) / (60));
      
      if(rectPos >= 0 && rectPos <  songInfo.length && mouseY > 235){
        fill(colorOptionTextTrue, 128);
        stroke(colorOptionTextTrue, 128);
        rect(screenSizeX/2, 265+60*(rectPos), screenSizeX, 50);
      }
    }
    
    
    //determines which song is clicked
    String mouseClicked()
    {
      while(rectPos < 0 && rectPos > songInfo.length - 2 && mouseY < 235){
        stage = 5;
      }
        stage = 6;
        return songInfo[rectPos][2];
      

    }

      /*
      if (mouseX<=width-100 && mouseX>=100) {
        if (mouseY>height/2 && mouseY<=height*3/4) {
          image(first, width/3, height*2/3, 600, 250);
          text("Song 2", width*7/16,height*25/32);
        
      } 
      if (mouseY<height/2&& mouseY>=height/4) {
      image(first, width/3, height/3, 600, 250);
         text("Song 1", width*7/16, height*7/16);
       
      }
      */
     
     
    
}