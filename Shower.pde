import processing.opengl.*;
import ddf.minim.*;

class Shower{
  float xpos;
  float ypos;
  float Width;
  float Height;
  
  color backC=color(0,0,100);
  color wordC=color(0,0,100);
  color uiC=color(230,100,100);
  color showC=color(350,100,100);
  color showBackC=color(0,0,0);
  color timeC=color(320,100,100);
  PFont font1,font2;
  
  Shower(float tmpXpos,float tmpYpos,float tmpWidth,float tmpHeight)
  {
    xpos=tmpXpos;
    ypos=tmpYpos;
    Width=tmpWidth;
    Height=tmpHeight;
    font1 = createFont("Microsoft YaHei UI", 30);
  }
  
  void setShow(){
    noStroke();
    fill(50,200,200);
  }
  
  void draw(){
    noStroke();
    fill(showBackC);
    rect(xpos,ypos,Width,Height);
    fill(wordC);
    textFont(font1, 30);
    text(" Welcom to use \nProcessing Music",xpos+Width/5,ypos+Height/2);
  }
  
  void drawInfo(AudioMetaData meta){
    String info1 = meta.author();
    String info2 = meta.title();
    float sw=textWidth(info1);
    fill(71,64,100,80);
    noStroke();
    rect(xpos+0.1*Width,ypos+0.82*Height,0.8*Width,0.18*Height);
    fill(wordC);
    textAlign(LEFT);
    textFont(font1, 18);
    text(info1,xpos+Width/2.0-sw/2.0,ypos+0.85*Height+15);
    sw=textWidth(info2);
    fill(110,100,100);
    text(info2,xpos+Width/2.0-sw/2.0,ypos+0.85*Height+40); 
  }
  
 
}
