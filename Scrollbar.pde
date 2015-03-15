class VScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  int listNum;
  int showNum;

  VScrollbar (float xp, float yp, int sw, int sh, int l,int tmplistNum,int tmpshowNum) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sh - sw;
    ratio = (float)sh / (float)widthtoheight;
    xpos = xp-swidth/2;
    ypos = yp;
    spos = ypos - swidth/2 + sheight/2;
    newspos = spos;
    sposMin = ypos;
    sposMax = ypos - swidth + sheight;
    loose = l;
    listNum = tmplistNum;
    showNum = tmpshowNum;
  }
  
  void updateListNum(int num){
    listNum=num;
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
      newspos = constrain(mouseY-swidth/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    if(listNum<=showNum)
      return;
    float tmp=(float)showNum/((float)listNum);
    if(spos+tmp*sheight>ypos+sheight)
       spos=ypos+(1.0-tmp)*sheight;
    //println("ratio"+tmp);
    noStroke();
    fill(204);
    //println("sheight"+sheight);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(xpos, spos, swidth, sheight*tmp);
  }

  float getPos() {
    float tmp=(float)showNum/((float)listNum);
    return (spos-ypos)/((1-tmp)*sheight);
  }
}
