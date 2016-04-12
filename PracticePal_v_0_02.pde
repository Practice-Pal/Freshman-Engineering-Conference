import processing.serial.*;
Serial myPort;  // Create object from Serial class

PImage musicNote; //image of music note
PFont titleFont, optionFont, optionHeadFont, optionTextFont; //font of title, font of options, font of header of options, font of text of options
int screenSizeX, screenSizeY, stage; //length of screen, height of screen, stage number
color colorOptionTextFalse, colorOptionTextTrue; //color of options if not moused over, color of options if moused over
color colorBackButton; //color of back button
color lines; //color of music lines
color colorOptionHead, colorOptionText; //color of option head and text

Select_Music_Screen music_select;
PlayMode playmode;
MainMenu mainMenu;

void setup()
{

  //sets size of screen
  screenSizeX = 1600; 
  screenSizeY = 900;
  surface.setSize(screenSizeX, screenSizeY); 
  
  background(255); //sets color of background
  
  titleFont = loadFont("SegoeUI-LightItalic-200.vlw"); 
  optionFont = loadFont("SegoeUI-Light-40.vlw"); 
  optionHeadFont = loadFont("SegoeUI-Light-60.vlw"); 
  optionTextFont = loadFont("SegoeUI-Light-30.vlw"); 
  musicNote = loadImage("music Note Title Screen.png");
  
  colorOptionTextFalse = color(49, 44, 44);
  colorOptionTextTrue = color(201);
  lines = color(188, 175, 175);
  colorOptionHead = color(52, 45, 45);
  colorOptionText = color(70, 65, 65);
  colorBackButton = color(251);
  
  music_select = new Select_Music_Screen();

  playmode = new PlayMode();
  mainMenu = new MainMenu();
  
  myPort = new Serial(this, "COM8", 9600);
  
  stage = 1;
}


void draw()
{
  
  if (stage == 1){ //goes to main menu
    mainMenu.menu();
    
  }
  else if (stage == 2){ //goes to about screen
    mainMenu.about();
  }
  else if(stage == 3)
  {
    mainMenu.highscores();
  }
  else if(stage == 4)
  {
    mainMenu.options();
  }
  else if(stage == 5)
  {
    mainMenu.play();
  }
  else if(stage == 6)
  {
    playmode.setup(music_select.returnSong());
    stage = 7;
  }
  else if (stage == 7)
  {
    playmode.draw();
    backButton();
  }
    
}


//moves to new screen when mouse is clicked
void mouseClicked()
{
  if (stage == 1){
    if(overAbout())
      stage = 2;
    else if(overHighScores())
      stage = 3;
    else if(overOptions())
      stage = 4;
    else if (overPlay())
      stage = 5;
  }
  
  else if (stage == 5){
    if(music_select.overSong())
      music_select.returnSong();
  }
  
  else if(stage != 1){
    if (overBack(screenSizeX-25, screenSizeY-25, 100))
      stage = 1;
  }
}

void backButton()
{
  ellipseMode(CENTER);
  fill(colorBackButton);
  stroke(lines);
  strokeWeight(10);
  int backCenterX = screenSizeX-25, backCenterY = screenSizeY-25;
  ellipse(backCenterX, backCenterY, 200, 200);
  
  optionUpdate(backCenterX, backCenterY, 100);
  
  textAlign(CENTER);
  fill(colorOptionTextFalse);
  stroke(colorOptionTextFalse);
  textFont(optionFont);
  text("Back", screenSizeX-50, screenSizeY-37);

}


//determines and highlights what option is selected on the menu screen
void menuUpdate()
{
  int rectPos = 0;
  if(overPlay())
    rectPos = 1;
  else if (overAbout())
    rectPos = 2;
  else if (overHighScores())
    rectPos = 3;
  else if (overOptions())
    rectPos = 4;
    
  if(rectPos > 0){
    fill(colorOptionTextTrue, 128);
    stroke(colorOptionTextTrue, 128);
    rect(screenSizeX/2, screenSizeY/2+30+60*(rectPos-1), screenSizeX, 50);
  }
}


//turns back button different color if mouse is over back button
void optionUpdate(int backCenterX, int backCenterY, int radius)
{
  if(overBack(backCenterX, backCenterY, radius)){
    fill(colorOptionTextTrue);
    stroke(colorOptionTextTrue);
    ellipse(backCenterX, backCenterY, 2*radius-22.5, 2*radius-22.5);
  }
}
    

//true if mouse is over the play button
boolean overPlay()
{
  if(mouseY >= screenSizeY/2+2.5 && mouseY <= screenSizeY/2+57.5)
    return true;
  else
    return false;
}

//true if mouse is over the about button
boolean overAbout(){
   if(mouseY >= screenSizeY/2+62.5 && mouseY <= screenSizeY/2+117.5)
     return true;
   else
     return false;
}


//true if mouse is over the high scores button
boolean overHighScores()
{
   if(mouseY >= screenSizeY/2+122.5 && mouseY <= screenSizeY/2+177.5)
     return true;
   else
     return false;
}


//true if mouse is over the options button
boolean overOptions()
{
   if(mouseY >= screenSizeY/2+182.5 && mouseY <= screenSizeY/2+237.5)
     return true;
   else
     return false;
}


//true if mouse is over the back button
boolean overBack(int backCenterX, int backCenterY, int radius)
{
  double dist = sqrt(pow(mouseX-backCenterX,2) + pow(mouseY-backCenterY,2));
  if(dist < radius)
    return true;
  else
    return false;
}