import ddf.minim.*;
import ddf.minim.analysis.*;
class LineShower extends Shower
{
   AudioPlayer player;
   FFT         fft;
   LineShower(float tmpXpos,float tmpYpos,float tmpWidth,float tmpHeight,AudioPlayer tmpplayer){
     super(tmpXpos,tmpYpos,tmpWidth,tmpHeight);
     player=tmpplayer;
  }
  
  void setShower(){
  }
  
  void setPlayer(AudioPlayer play){
    player = play;
    fft = new FFT( player.bufferSize(), player.sampleRate() );
  }
  
  void draw(boolean isShow){
    if(isShow==false)
      super.draw();
    noStroke();
    fill(showBackC);
    rect(xpos,ypos,Width,Height);
    fft.forward( player.mix );
    float bottomP=Height/1.25;
    for(int i = 0; i < fft.specSize() && i<Width; i++)
    {
      stroke(i,100,100);
    //  println("draw i"+fft.specSize());
    // draw the line for frequency band i, scaling it up a bit so we can see it
    float tmp=bottomP- fft.getBand(i)*8;
    if(tmp<=30)
      tmp=31;
      line(xpos+i, ypos+bottomP, i+xpos, tmp);
    }
    
    super.drawInfo(player.getMetaData());
  }
}
