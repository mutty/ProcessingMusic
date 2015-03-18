import ddf.minim.*;
class VolBar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  AudioPlayer player;
  
  boolean isShow=false;
  
  float volumRatio=0.50;
  
  color backC=color(0,0,100);
  color wordC=color(0,0,100);
  color uiC=color(230,100,100);
  color showC=color(350,100,100);
  
  VolBar (float xp, float yp, int sw, int sh, int l,AudioPlayer play) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
    player=play;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if(isShow==false)
      return false;
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    if(isShow)
    {
      noStroke();
      fill(uiC);
      rect(xpos, ypos, swidth, sheight);
      if (over || locked) {
        fill(0, 0, 0);
      } else {
        fill(102, 102, 102);
      }
      rect(spos, ypos, sheight, sheight);
    }
  }
  
  void setPlayer(AudioPlayer play){
    player=play;
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    if(overEvent()==true)
     {
       float ratio=((mouseX-xpos)/swidth);
       if(ratio<0)
         ratio=0;
        if(ratio>1)
          ratio=1;
       volumRatio=ratio;
       //println("set Volumn 35");
       //tmpP.setVolume(volumRatio);
       return ratio;
     }
     return volumRatio;
  }
}
