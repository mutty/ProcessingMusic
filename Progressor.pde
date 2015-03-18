import processing.opengl.*;
import ddf.minim.*;
import javax.swing.*;
class Progressor{
  float xpos;
  float ypos;
  float Width;
  float Height;
  float curPos;
  PFont font ;
  AudioPlayer play;
  
  color backC=color(0,0,100);
  color wordC=color(0,0,100);
  color uiC=color(230,100,100);
  color showC=color(350,100,100);
  color timeC=color(320,100,100);
  
  Progressor(float tmpxpos,float tmpypos,float tmpWidth,float tmpHeight,AudioPlayer tmpplay){
    xpos=tmpxpos;
    ypos=tmpypos;
    Width=tmpWidth;
    Height=tmpHeight;
    play=tmpplay;
    font = createFont("Microsoft YaHei UI", 15);
    //font = loadFont("Pro-20.vlw");
  }

  void setPlayer(AudioPlayer tmpplay){
    play=tmpplay;
  }
  
  void draw(){
    fill(uiC);
    noStroke();
    rect(xpos,ypos,Width,Height);
    fill(timeC);
    noStroke();
    rect(xpos+Width,ypos,41,Height);
    if(play!=null)
    {
      strokeWeight(4);
      int tmp=(int)(play.bufferSize()/Width);
      float tmp2=Height*0.5;
      int k=1;
      float position = map( play.position(), 0, play.length(), 0, Width );
      fill( timeC);
      noStroke();
      rect(xpos, ypos, position,Height);
      for(int i = 0; i+tmp < play.bufferSize() - 1; i+=tmp)
      {
        stroke(i/tmp,100,100);
        float a=play.left.get(i);
        if(a>0.5) a=0.5;
        if(a<-0.5) a=-0.5;
        float b=play.left.get(i+1);
        if(b>0.5) b=0.5;
        if(b<-0.5) b=-0.5;
        
        line(xpos+k, ypos+ Height/2+ a*tmp2,  xpos+k+1, ypos+ Height/2+b*tmp2);
        k++;
      }
      
      int a=play.position()/1000;
      int min=a/60;
      int sec=a%60;
      String pp=nf(min,2)+":"+nf(sec,2);
      //println(pp);
      
      fill(wordC);
      textAlign(LEFT);
      textFont(font, 15);
      text(pp,xpos+Width,ypos+Height/2+4);
    }
 }
 
 boolean clickOn(){
   if(mouseX>xpos && mouseX<xpos+Width && mouseY>ypos && mouseY<ypos+Height)
       return true;
   else
     return false;
 }
 
 void jump()
  {
   int position = int( map( mouseX-xpos, mouseY-ypos, Width, mouseY-ypos, play.length() ) );
  //println("jump position "+a+ " L:"+play.length());
   if(play!=null)
     play.cue( position );
  }
}
