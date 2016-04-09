public class Song
{
  private String[] unparsed; //array containing initial information from text file, unseparated
  private Note[] song; //contains string arrays of size two, contains pitch and duration information from text file
  //private int[][] drawData; //contains note info converted into info to be used to draw notes
  
  //constructor
  Song (String filename)
  {
    unparsed = loadStrings(filename); //loads data file
    song = new Note[unparsed.length]; 
    
    for(int i = 0; i < unparsed.length; i++){
      song[i] = new Note(split(unparsed[i], '\t')); //transfers information from unparsed string array into note object
    }
    
    //drawData = new int[unparsed.length][2];
  }
  
  void createSong()
  {
    for(int i = 0; i < song.length; i++){
      song[i].determinePitch();
      song[i].determineLength();
      
      //drawData[i][0] = song[i].getPitchNum();
      //drawData[i][1] = song[i].getLength();
    }
  }
  
  Note[] getSong()
  {
    return song;
    
  }
  /*
  int[][] getSong()
  {
    return drawData;
  }
  */
}