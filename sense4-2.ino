
//int analogPin=0;
char val;
int val1 = 0;
int val2 = 0;
int val3 = 0;
int val4 = 0;
String note1;
String note2;
String note3;
String note4;
//sharps are lowercase letters

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  //Serial.println("Strip 1 | Strip 2 | Strip 3 | Strip 4");

}
void loop() {

  //if (Serial.available())
  /*{ // If data is available to read,
    val = Serial.read(); // read it and store it in val
    }
    if (val == '1') { // If 1 was received*/

  val1 = analogRead(0);
  val2 = analogRead(1);
  val3 = analogRead(2);
  val4 = analogRead(3);

  // }
  //String1(A string)

  if (val1 >= 958) {
    note1 = "B4";
    //Serial.println(note1);
  }
  else if (val1 >= 823) {
    note1 = "C5";

    //Serial.println(note1);
  }
  else if (val1 >= 650) {
    note1 = "C#5";

    //Serial.println(note1);
  }
  else if (val1 >= 560) {
    note1 = "D5";

    //Serial.println(note1);
  }
  else if (val1 >= 490) {
    note1 = "Eb5";

    // Serial.println(note1);
  }
  else if (val1 >= 450) {
    note1 = "E5";

    //Serial.println(note1);
  }
  else if (val1 >= 200) {
    note1 = "F5";

    //Serial.println(note1);
  }
  else {
    note1 = ' ';
  }


  if (val2 >= 955) {
    note2 = "E4";
    //Serial.println(note2);
  }
  else if (val2 >= 810) {
    note2 = "F4";
    //Serial.println(note2);
  }
  else if (val2 >= 690) {
    note2 = "F#4";
    // Serial.println(note2);
  }
  else if (val2 >= 620) {
    note2 = "G4";
    //Serial.println(note2);
  }
  else if (val2 >= 520) {
    note2 = "G#4";
    //Serial.println(note2);
  }
  else if (val2 >= 465) {
    note2 = "A4";
    //Serial.println(note2);
  }
  else if (val2 >= 410) {
    note2 = "Bb4";
    //Serial.println(note2);
  }
  else if (val2 >= 345) {
    note2 = "B4";
    //Serial.println(note2);
  }
  else if (val2 >= 200) {
    note2 = "C5";
    //Serial.println(note2);
  }
  else {
    note2 = ' ';
  }


  if (val3 >= 985) {
    note3 = "A3";
    //Serial.println(note3);
  }
  else if (val3 >= 965) {
    note3 = "Bb3";
    //Serial.println(note3);
  }
  else if (val3 >= 788) {
    note3 = "B3";
    //Serial.println(note3);
  }
  else if (val3 >= 588) {
    note3 = "C4";
    //Serial.println(note3);
  }
  else if (val3 >= 520) {
    note3 = "C#4";
    //Serial.println(note3);
  }
  else if (val3 >= 475) {
    note3 = "D4";
    //Serial.println(note3);
  }
  else if (val3 >= 420) {
    note3 = "Eb4";
    //Serial.println(note3);
  }
  else if (val3 >= 365) {
    note3 = "E4";
    //Serial.println(note3);
  }
  else if (val3 >= 200) {
    note3 = "F4";
    //Serial.println(note3);
  }
  else {
    note3 = ' ';
  }



  if (val4 >= 965) {
    note4 = "D3";
    //Serial.println(note4);
  }
  else if (val4 >= 940) {
    note4 = "Eb3";
    //Serial.println(note4);
  }
  else if (val4 >= 795) {
    note4 = "E3";
    //Serial.println(note4);
  }
  else if (val4 >= 645) {
    note4 = "F3";
    //Serial.println(note4);
  }
  else if (val4 >= 555) {
    note4 = "F#3";
    //Serial.println(note4);
  }
  else if (val4 >= 450) {
    note4 = "G3";
    //Serial.println(note4);
  }
  else if (val4 >= 375) {
    note4 = "G#3";
    //Serial.println(note4);
  }
  else if (val4 >= 325) {
    note4 = "A3";
    //Serial.println(note4);
  }
  else if (val4 >= 200) {
    note4 = "Bb3";
    //Serial.println(note4);
  }
  else {
    note4 = ' ';
  }

  if (note1 == " " && note2 == " " && note3 == " ") {
    Serial.println(note4);
  }
  else if (note1 == " " && note2 == " " && note4 == " " ){
  Serial.println(note3);
  }
  else if (note1 == " " && note3 == " " && note4 == " " ){
  Serial.println(note2);
  }
  else if (note2 == " " && note3 == " " && note4 == " " ){
  Serial.println(note1);
  }





  /*Serial.println(note1);
    //Serial.print("  ");
    Serial.println(note2);
    //Serial.print("  ");
    Serial.println(note3);
    //Serial.print("  ");
    Serial.println(note4);*/




  delay(200);

}
