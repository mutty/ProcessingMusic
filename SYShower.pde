class SYShower extends Shower{
  
  float r;
  PFont font;
  
   SYShower(float tmpXpos,float tmpYpos,float tmpWidth,float tmpHeight){
     super(tmpXpos,tmpYpos,tmpWidth,tmpHeight);
     font = createFont("Microsoft YaHei UI", 30);
    }
    
  void draw(boolean isShow){  
    fill(0,20);
    rect(xpos,ypos,Width,Height);
    if(isShow==false)
    {
      fill(50,255,0);
      textFont(font, 30);
      text(" Welcom to use \nProcessing Music",xpos+Width/5,ypos+Height/2);
      return;
    }

    stroke(33);
    translate(Width/2,Height/2);
    noStroke();
    rotate(r);
    
    float angle=1440* float(mouseY)/float(height);
    rotate(radians(angle));
    
    for(int i=0;i<400;i++)
    {
      
      rotate(radians(360/50)*i);
     
      fill(i+225,i*5,i*20,100);
      if(i*4<Height)
        ellipse(i*1.5,0,10+player.left.get(i)*100,
          10+player.left.get(i+1)*200);
      fill(i/2,i+255,0,80);
      if(70-i>0)
        rect(i*1.5,0,i/2,i/2);
    }
    r=r+0.15;
  }
  
}
