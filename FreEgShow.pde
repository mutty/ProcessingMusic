import ddf.minim.*;
import ddf.minim.analysis.*;
class FreEgShower extends Shower
{
  Minim minim;
  AudioPlayer player;
  BeatDetect beat;
  BeatListener bl;
  AudioMetaData meta;
  PFont font;
  float kickSize, snareSize, hatSize;
  
  String l1="Processing Music";
  String l2="BY";
  String l3="And4U";
  
  FreEgShower(float tmpXpos,float tmpYpos,float tmpWidth,float tmpHeight,AudioPlayer tmpplayer){
     super(tmpXpos,tmpYpos,tmpWidth,tmpHeight);
     player=tmpplayer;
  }
  
  void setup(){
    kickSize = snareSize = hatSize = 16;
    font = createFont("Microsoft YaHei UI", 50);
    textAlign(CENTER);
  }
  
  void setPlayer(AudioPlayer play){
    player=play;

    beat = new BeatDetect(player.bufferSize(), player.sampleRate()); 
    beat.setSensitivity(50);  
    bl = new BeatListener(beat, player);
    meta = player.getMetaData();
    l2 = meta.author();
    l3 = meta.title();
        
  }
  
  void draw(boolean isShow){
    if(isShow==false)
      super.draw();
     noStroke();
    fill(showBackC);
    rect(xpos,ypos,Width,Height);
    if ( beat.isKick() ) kickSize = 32;
    if ( beat.isSnare() ) snareSize = 32;
    if ( beat.isHat() ) hatSize = 32;
    
    float w1=Width/(l1.length()+1);
    for(int i=0;i<l1.length();i++){
      fill(kickSize*(i+0.5),100,100);
      textFont(font,kickSize*random(1,2));
      String tmp=l1.substring(i,i+1);
      text(tmp,5+i*w1,Height/4);
    }
    
    float w2=Width/(l2.length()+1);
    for(int i=0;i<l2.length();i++){
      fill(snareSize*(i+0.5),100,100);
      textFont(font,snareSize*random(1,2));
      String tmp=l2.substring(i,i+1);
      text(tmp,5+i*w2,Height/2);
    }
    
    float w3=Width/(l3.length()+1);
    for(int i=0;i<l3.length();i++){
      fill(hatSize*(i+0.5),100,100);
      textFont(font,hatSize*random(1,2));
      String tmp=l3.substring(i,i+1);
      text(tmp,5+i*w3,3*Height/4);
    }
   
    kickSize = constrain(kickSize * 0.95, 16, 32);
    snareSize = constrain(snareSize * 0.95, 16, 32);
    hatSize = constrain(hatSize * 0.95, 16, 32);
    
    /*
    String info1 = meta.author();
    String info2 = meta.title();

    fill(71,64,100,80);
    noStroke();
    rect(xpos+0.1*Width,ypos+0.82*Height,0.8*Width,0.18*Height);
    fill(wordC);
    textAlign(LEFT);
    println(info1);
    textFont(font, 18);
    float sw=textWidth(info1);
    text(info1,xpos+Width/2.0-sw/2.0,ypos+0.85*Height+15);
    sw=textWidth(info2);
    fill(110,100,100);
    text(info2,xpos+Width/2.0-sw/2.0,ypos+0.85*Height+40);
    */
   // meta = player.getMetaData();
    //super.drawInfo(meta);
  }
  
}



class BeatListener implements AudioListener
{
  private BeatDetect beat;
  private AudioPlayer source;
  
  BeatListener(BeatDetect beat, AudioPlayer source)
  {
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }
  
  void samples(float[] samps)
  {
    beat.detect(source.mix);
  }
  
  void samples(float[] sampsL, float[] sampsR)
  {
    beat.detect(source.mix);
  }
}

