class PlayList{
  float posx;
  float posy;
  float Width;
  float Height;
  float ItemHeight;
  float fontSize;
  int ItemNum;
  PFont font ;
  ArrayList<File> fileList= new ArrayList<File>();
  //File[] file=new File[100];
  int CurNum=-1;  //now playing
  
  int cycleState=0;  //0 seq 1 random 2 allCyc 3 singleCyc
  int ClickItem=0;
  
  int firShowNum=0;
  
  color backC=color(0,0,100);
  color wordC=color(0,0,100);
  color uiC=color(230,100,100);
  color showC=color(350,100,100);
  color curPlayC=color(15,100,100);
  
  PlayList(float tmpposx,float tmpposy,float tmpwidth,float tmpheight,int tmpitemnum)
  {
    posx=tmpposx;
    posy=tmpposy;
    Width=tmpwidth;
    Height=tmpheight;
    ItemNum=tmpitemnum;
    ItemHeight=Height/(1.0*ItemNum);
    font = createFont("Microsoft YaHei UI", 13);
  }
  
  PlayList(File[] f)
  {
    for(int i=0;i<f.length;i++)
      fileList.add(f[i]);
  }
  
  void drawTitle() {
    fill(255, 200);
    for(int i=0;i<ItemNum;i++)
    {
      float middleY=posy+(i-1)*ItemHeight+ItemHeight/2.0;
      textAlign(LEFT);
      text(fileList.get(i).getName(),posx+5,middleY);
    }
  }
  
  void draw(){
    for(int i=0;i<ItemNum;i++)
    {
      fill(uiC);
      noStroke();
      rect(posx,posy+i*ItemHeight,Width,ItemHeight-1.5);
    }
   
    
    if(fileList.size()==0)
      return;
    if(fileList.size()<ItemNum)
      firShowNum=0;
    else if(fileList.size()-firShowNum<ItemNum)
      firShowNum=fileList.size()-ItemNum;
    for(int i=firShowNum;i<firShowNum+ItemNum && i<fileList.size();i++)
    {
      if(i==CurNum)
      {
        fill(curPlayC);
        noStroke();
        rect(posx,posy+(i-firShowNum)*ItemHeight,Width,ItemHeight-2);
      }
      fill(wordC);
      float middleY=posy+(i-firShowNum)*ItemHeight+ItemHeight/2.0+2;
      textAlign(LEFT);
      textFont(font, 13);
      text(fileList.get(i).getName(),posx+1,middleY);
    }
  }
  

  
  int clickPlayList() {
    if(mouseX>=posx && mouseX<=posx+Width && mouseY>=posy && mouseY<=posy+Height)
    {
      ClickItem=(int)((mouseY-posy)/ItemHeight);
      println("You Choose "+ClickItem+ " to play");
      CurNum = ClickItem+firShowNum;
      return ClickItem+firShowNum;
    }
    return -1;
  }
  
  void getNextPlay(){
    int s=fileList.size();
    if(cycleState==0)
    {
      if(CurNum<s-1);
        CurNum++;
    }
    else if(cycleState==1)
    {
      println("get random next");
      CurNum=(int)(random(0,s-1));
    }
    else if(cycleState==2)
    {
      CurNum=(CurNum+1)%s;
    }
    else if(cycleState==3)
      CurNum=CurNum;
  }
  
  void updateFirShow(int a){
    firShowNum=a;
  }
  
  
  
  void playNow(){
    
  }
  
}
