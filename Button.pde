import ddf.minim.*;
class Button {
  // Class variables
  boolean isPrevious=false;
  boolean isNext=false;
  boolean isStart=false;
  boolean isCycle=false;
  boolean isFolder=false;
  boolean isShow=false;
  boolean isVolumn=false;
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
  PFont font,font2 ;
  
  int cycleState=0; //1 seq 2 random 3 allCyc 4 singleCyc
   
  color backC=color(0,0,100);
  color wordC=color(0,0,100);
  color uiC=color(230,100,100);
  color showC=color(350,100,100);
  color showButtonC=color(210,100,100);
  
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
    buttonC=color(230,100,100);
    font = createFont("Microsoft YaHei UI", 15);
    font2 = createFont("Microsoft YaHei UI", 12);
  }

  
  Button asStart() {
    isStart = true;
    return this;
  }
  
  Button asPrevious(){
    isPrevious=true;
    return this;
  }
  
  Button asNext(){
    isNext=true;
    return this;
  }
  
  Button asCycle(){
    isCycle=true;
    return this;
  }
  
  Button asFolder(){
    isFolder=true;
    return this;
  }
  
  Button asShow(){
    isShow=true;
    return this;
  }
  
  Button asVolumn(){
    isVolumn=true;
    return this;
  }
  
  void setPlayer(AudioPlayer play){
    player = play;
  }
 
  // Draw the button on the canvas
  void display() {
     fill(uiC);
      smooth();
      noStroke();
      rect(xpos, ypos, buttonW, buttonH);
      fill(wordC);
     float boudtmp=buttonH/6.5;
     float boudtmp2=boudtmp*2;
     noStroke();
     smooth();
    if (isStart) {
      if(player==null)
       triangle(xpos+boudtmp,ypos+boudtmp,xpos+boudtmp,ypos+buttonH-boudtmp,xpos+buttonW-boudtmp,ypos+buttonH/2.0);
      else if(player.isPlaying()==false || player==null)
        triangle(xpos+boudtmp,ypos+boudtmp,xpos+boudtmp,ypos+buttonH-boudtmp,xpos+buttonW-boudtmp,ypos+buttonH/2.0);
      else
        rect(xpos+boudtmp2,ypos+boudtmp2,buttonW-boudtmp2*2,buttonH-boudtmp2*2);
    }
   else if(isPrevious)
   {
      rect(xpos+boudtmp,ypos+boudtmp,boudtmp2,buttonH-boudtmp2);
      triangle(xpos+boudtmp+boudtmp2,ypos+buttonH/2.0,xpos+buttonW-boudtmp,ypos+buttonH-boudtmp,xpos+buttonW-boudtmp,ypos+boudtmp);
   }
   else if(isNext)
   {
     rect(xpos+buttonW-boudtmp2-boudtmp,ypos+boudtmp,boudtmp2,buttonH-boudtmp2);
     triangle(xpos+boudtmp,ypos+boudtmp,xpos+boudtmp,ypos+buttonH-boudtmp,xpos+buttonW-boudtmp2-boudtmp,ypos+buttonH/2.0);
   }
   else if(isCycle){
      fill(wordC);
      textAlign(LEFT);
      textFont(font2, 12);
      if(cycleState==0)
        text("顺序播放", xpos+3, ypos+20);
      else if(cycleState==1)
        text("随机播放", xpos+3, ypos+20);
      else if(cycleState==2)
        text("全部循环", xpos+3, ypos+20);
      else if(cycleState==3)
         text("单曲循环", xpos+3, ypos+20);
   }
   else if(isFolder){
      fill(wordC);
      textAlign(LEFT);
      textFont(font, 15);
      text("打开", xpos+8, ypos+20);
   }
   else if(isShow){
     fill(wordC);
     textAlign(LEFT);
     textFont(font,15);
     text("特效",xpos+5,ypos+20);
   }
   else if(isVolumn)
   {
     fill(wordC);
     textAlign(LEFT);
     textFont(font2,12);
     text("VOL",xpos+3,ypos+20);
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
