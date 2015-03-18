class PopMenu{
 float xpos;
 float ypos;
 float Width;
 float Height;
 String [] itemWord;
 PopItem [] popItem;
 int itemNum;
 int chooseNum;
 int direction=0; //0:up 1:down
 boolean isShow=false;
 PopMenu(float tmpxpos,float tmpypos,float tmpWidth,float tmpHeight,String[] data,int tmpdirection)
 {
   xpos=tmpxpos;
   ypos=tmpypos;
   Width=tmpWidth;
   Height=tmpHeight;
   int len=data.length;
   itemWord=new String[len];
   direction=tmpdirection;
   for(int i=0;i<data.length;i++){
     itemWord[i]=data[i];
     //println(data[i]);
  }
   itemNum=len;
   popItem=new PopItem[len];
   for(int i=0;i<itemNum;i++)
   {
     if(direction==0)
       popItem[i]=new PopItem(xpos,ypos-(i+1)*Height,Width,Height-1,itemWord[i]);
     else
       popItem[i]=new PopItem(xpos,ypos+(i)*Height,Width,Height-1,itemWord[i]);
   }
   chooseNum=0;
 }
 
 void setDirection(int a){
   direction=a;
 }
 
 void setChoose(int Num){
   if(Num<=itemNum && Num>=0)
     chooseNum=Num;
 }
 
 void setData(String[] data){
   int len=data.length;
   itemWord=new String[len];
   for(int i=0;i<len;i++)
     itemWord[i]=data[i];
   itemNum=len;
   popItem=new PopItem[len];
   for(int i=0;i<itemNum;i++)
   {
     if(direction==0)
       popItem[i]=new PopItem(xpos,ypos-(i+1)*Height,Width,Height-1,itemWord[i]);
     else
       popItem[i]=new PopItem(xpos,ypos+(i+1)*Height,Width,Height-1,itemWord[i]);
   }
 }
 
 
 
 void draw(){
   if(isShow==false)
     return;
   for(int i=0;i<itemNum;i++)
   if(i==chooseNum)
       popItem[i].draw(true);
   else
       popItem[i].draw(false);
 } 
 
 void mouseOn(){
 }
 
 int clickPopMenu(){
   if(isShow==false)
     return -1;
   if(direction==0)
   {
     if(mouseX>=xpos && mouseX<=xpos+Width && mouseY<=ypos && mouseY>=ypos-Height*itemNum)
      {
        chooseNum=(int)((ypos-mouseY)/Height);
        println(chooseNum);
        isShow=false;
      }
   }
   else if(direction==1)
   {
     if(mouseX>=xpos && mouseX<=xpos+Width && mouseY>=ypos && mouseY<=ypos+Height*itemNum)
      {
        chooseNum=(int)((mouseY-ypos)/Height);
        println(chooseNum);
        isShow=false;
      }
   }
   return chooseNum;
 }
 
}

class PopItem{
  float xpos;
  float ypos;
  float Width;
  float Height;
  String word;
  color ItemC=color(230,100,100);
  color wordC=color(0,0,100);
  color ChooseC=color(60,100,100);
  color onC=color(320,100,100);
  
  PFont font;
  PopItem(float tmpxpos,float tmpypos,float tmpWidth,float tmpHeight,String tmpword)
  {
    xpos=tmpxpos;
    ypos=tmpypos;
    Width=tmpWidth;
    Height=tmpHeight;
    word=tmpword;
    font = createFont("Microsoft YaHei UI", 12);
  }
  
  void draw(boolean isChoose){
    if(isChoose)
      fill(ChooseC);
     else
      fill(ItemC);
    
    noStroke();
    rect(xpos,ypos,Width,Height); 
    fill(wordC);
    textAlign(LEFT);
     float w=textWidth(word);
    float tmp=Width/2.0-w/2.0;
    textFont(font, 12);
    text(word, xpos+tmp, ypos+12);
  } 
  
   void draw(color c){
    fill(c);
    noStroke();
    rect(xpos,ypos,Width,Height); 
    fill(wordC);
    float w=textWidth(word);
    float tmp=Width/2.0-w/2.0;
    textAlign(LEFT);
    textFont(font, 12);
    text(word, xpos+tmp, ypos+12);
  } 
  
  boolean mouseOn(){
    if(mouseX>=xpos && mouseX<=xpos+Width && mouseY>=ypos && mouseY<=ypos+Width)
      return true;
    else
      return false;
  }
  
}
