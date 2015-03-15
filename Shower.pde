import processing.opengl.*;

class Shower{
  float xpos;
  float ypos;
  float Width;
  float Height;
  
  Shower(float tmpXpos,float tmpYpos,float tmpWidth,float tmpHeight)
  {
    xpos=tmpXpos;
    ypos=tmpYpos;
    Width=tmpWidth;
    Height=tmpHeight;
  }
  
  void setShow(){
    noStroke();
    fill(50,200,200);
    rect(xpos,ypos,Width,Height);
  }
  
  void draw(){
    
  }
 
}
