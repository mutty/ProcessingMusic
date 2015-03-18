import ddf.minim.*;
class PieShower extends Shower{
  
  AudioPlayer play;
  AudioMetaData meta;
  
  PFont font;
  float MAXR;
  int size;
  int step=0;
  int rotateRate=8;
  
  color backC=color(0,0,100);
  color wordC=color(0,0,100);
  color uiC=color(230,100,100);
  color showC=color(350,100,100);
  color showBackC=color(0,0,0);
  color timeC=color(320,100,100);
  
  PieShower(float tmpXpos,float tmpYpos,float tmpWidth,float tmpHeight,AudioPlayer tmpplayer){
     super(tmpXpos,tmpYpos,tmpWidth,tmpHeight);
     MAXR=tmpHeight>tmpWidth?(tmpWidth/2.0):(tmpHeight/2.0);
     player=tmpplayer;
     font = createFont("Microsoft YaHei UI", 30);
  }
  
  
  void draw(boolean isShow){
  
    if(isShow==false)
    {
     super.draw();
      return;
    }
    fill(showBackC);
    rect(xpos,ypos,Width,Height);
    int size=play.bufferSize();
    float tmpX=xpos+Width/2.0;
    float tmpY=ypos+Height/2.0;
    float tmpPi=6*PI/size;
    float r1,r2;
    int suojian=1;
    int a=(int)(suojian*255.0/size);
    
    for(int i=0;i<size-suojian;i+=suojian)
    {
      r1=MAXR*play.left.get(i)+MAXR;
      if(i>size-suojian)
        r2=r1;
      else
        r2=MAXR*play.left.get(i+suojian)+MAXR;
      noStroke();
      fill((step+i)%360,100,100);
      r1=constrain(r1,0,2*MAXR);
      r2=constrain(r2,0,2*MAXR);
      arc(tmpX,0.9*tmpY,r1,r2,tmpPi*i,tmpPi*(i+1));
    }
    step+=rotateRate;
    super.drawInfo(meta);
  }
  
  void setPlayer(AudioPlayer tmpplay){
    play=tmpplay;
    meta = play.getMetaData();
    step=0;
  }
  
}
