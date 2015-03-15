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
  int ClickItem=-1;
  
  int firShowNum=0;
  
  
  PlayList(float tmpposx,float tmpposy,float tmpwidth,float tmpheight,int tmpitemnum)
  {
    posx=tmpposx;
    posy=tmpposy;
    Width=tmpwidth;
    Height=tmpheight;
    ItemNum=tmpitemnum;
    ItemHeight=Height/(1.0*ItemNum);
    font = createFont("Microsoft YaHei UI", 15);
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
        fill(255,255);
      noStroke();
      rect(posx,posy+i*ItemHeight,Width,ItemHeight-2);
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
        fill(255,255,0);
        noStroke();
        rect(posx,posy+(i-firShowNum)*ItemHeight,Width,ItemHeight-2);
      }
      fill(255,0,0);
      float middleY=posy+(i-firShowNum)*ItemHeight+ItemHeight/2.0;
      textAlign(LEFT);
      textFont(font, 12);
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
  
  
  void updateFirShow(int a){
    firShowNum=a;
  }
  
    
  
}
