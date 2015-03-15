import ddf.minim.*;
class Button {
  // Class variables
  boolean isNumber;
  boolean isSpecial;
  float numButtonValue;
  String opButtonValue;
  String spButtonValue;
  float xpos;
  float ypos;
  int boxSize = 45;
  int buttonW;
  int buttonH;
  boolean overBox = false;
  color buttonC;
   PFont font ;
  
  int type;  //1 play  2 stop 3 open
 
  // Constructor
  Button(float tempXpos, float tempYpos, int tempButtonW, int tempButtonH, color tempButtonC,int tmpType) {
    xpos = tempXpos;
    ypos = tempYpos;
    buttonW = tempButtonW;
    buttonH = tempButtonH;
    buttonC = tempButtonC;
    //println(numButtonValue);
    type=tmpType;
    font = createFont("Microsoft YaHei UI", 12);
  }

  
  Button asSpecial(String buttonValue) {
    isSpecial = true;
    spButtonValue = buttonValue;
    return this;
  }
 
  // Draw the button on the canvas
  void display() {
    // Draw rounded edged button on canvas
    if(isNumber) {
      fill(buttonC);
      stroke(0);
      strokeWeight(2);
      rect(xpos, ypos, buttonW, buttonH, 10);
      fill(122,44,22);
      textSize(24);
      text(int(numButtonValue), xpos+15, ypos+30);
    } else if (isSpecial) {
      fill(buttonC,30);
      stroke(0);
      noStroke();
      rect(xpos, ypos, buttonW, buttonH, 10);
      fill(0);
      textAlign(LEFT);
      textFont(font, 12);
      text(spButtonValue, xpos+15, ypos+20);
    } else {
      if (opButtonValue == "+/-") {
        fill(buttonC);
        stroke(0);
        strokeWeight(2);
        rect(xpos, ypos, buttonW, buttonH, 10);
        fill(0);
        textSize(18);
        text(opButtonValue, xpos+8, ypos+30);
      } else if (opButtonValue == "%") {
        fill(buttonC);
        stroke(0);
        strokeWeight(2);
        rect(xpos, ypos, buttonW, buttonH, 10);
        fill(0);
        textSize(24);
        text(opButtonValue, xpos+12, ypos+30);
      } else if (opButtonValue == "Sqrt") {
        fill(buttonC);
        stroke(0);
        strokeWeight(2);
        rect(xpos, ypos, buttonW, buttonH, 10);
        fill(0);
        textSize(17);
        text(opButtonValue, xpos+6, ypos+35);
      } else if (opButtonValue == "Sin") {
        fill(buttonC);
        stroke(0);
        strokeWeight(2);
        rect(xpos, ypos, buttonW, buttonH, 10);
        fill(0);
        textSize(19);
        text(opButtonValue, xpos+8, ypos+30);
      } else if (opButtonValue == "Cos") {
        fill(133);
        stroke(0);
        strokeWeight(2);
        rect(xpos, ypos, buttonW, buttonH, 10);
        fill(0);
        textSize(19);
        text(opButtonValue, xpos+7, ypos+30);
      } else if (opButtonValue == "-") {
        fill(buttonC);
        stroke(0);
        strokeWeight(2);
        rect(xpos, ypos, buttonW, buttonH, 10);
        fill(0);
        textSize(24);
        text(opButtonValue, xpos+18, ypos+30);
      } else if (opButtonValue == "Sq") {
        fill(buttonC);
        stroke(0);
        strokeWeight(2);
        rect(xpos, ypos, buttonW, buttonH, 10);
        fill(0);
        textSize(19);
        text(opButtonValue, xpos+12, ypos+30);
      } else if (opButtonValue == "C") {
        fill(buttonC);
        stroke(0);
        strokeWeight(2);
        rect(xpos, ypos, buttonW, buttonH, 10);
        fill(0);
        textSize(24);
        text(opButtonValue, xpos+11, ypos+30);
      } else if (opButtonValue == "Pow") {
        fill(buttonC);
        stroke(0);
        strokeWeight(2);
        rect(xpos, ypos, buttonW, buttonH, 10);
        fill(0);
        textSize(18);
        text(opButtonValue, xpos+5, ypos+30);
      }  else {
        fill(buttonC);
        stroke(0);
        strokeWeight(2);
        rect(xpos, ypos, buttonW, buttonH, 10);
        fill(0);
        textSize(24);
        text(opButtonValue, xpos+15, ypos+30);
      }
    }
  }
 
  // Handle mouse actions
  void clickButton() {
    overBox = mouseX > xpos && mouseX < xpos+buttonW && mouseY > ypos && mouseY < ypos+buttonH;
  }
  
  void openFile(){
    selectInput("Choose a file to play....","fileSelected");
  }
  
  void openFolder(){
    selectFolder("Choose a folder","folderSelected");
  }
  
  void beginPlay(AudioPlayer play){
    if(play!=null && play.isPlaying()==false)
      play.play();
  }
  
  void stopPlay(AudioPlayer play){
    if(play!=null && play.isPlaying()==true);
        play.pause();
  }
  
}
