import ddf.minim.*;
import ddf.minim.analysis.*;
class GuShower extends Shower
{
  float Radius;
  int WNum=5;
  int HNum=5;
  
  AudioPlayer player;
  BeatDetect beat;
  AudioMetaData meta;
  
  GuShower(float tmpXpos,float tmpYpos,float tmpWidth,float tmpHeight,AudioPlayer tmpplayer){
     super(tmpXpos,tmpYpos,tmpWidth,tmpHeight);
     player=tmpplayer;
     Radius=Width<Height?Width/6.0:Height/6.0;
  }
  
  void setup(){
    beat = new BeatDetect();
    eRadius = Radius;
  }
  
  void setPlayer(AudioPlayer play){
    player = play;
    meta = play.getMetaData();
  }
  
  void draw(boolean isShow){
    if(isShow==false)
      super.draw();
     noStroke();
    fill(showBackC);
    rect(xpos,ypos,Width,Height);
    float tx=Width/WNum;
    float ty=Height/HNum;
    for(int i=0;i<WNum;i++)
      for(int j=0;j<HNum;j++)
      {
        float x=tx*(i+0.5);
        float y=ty*(j+0.5);
        drawCir(x,y);
      }
     super.drawInfo(meta);
  }
  
  float eRadius;
  float rotate=0;
  void drawCir(float x,float y){
    beat.detect(player.mix);
    float a = map(eRadius, 20, 80, 60, 255);
    //fill(60, 255, 0, a);
    if ( beat.isOnset() ) eRadius = Radius;
    for(int i=0;i<eRadius+random(5,10);i++)
    {
      fill(((int)((x*0.38+y*0.38+i))+rotate)%360,100,100,100-0.5*i);
      ellipse(x,y,i,i);
    }
    //rotate(rotate);
    rotate+=0.1;
    //ellipse(width/2, height/2, eRadius, eRadius);
    eRadius *= 0.97;
    if ( eRadius < 10 ) eRadius = 10;
  }
  
  
}
