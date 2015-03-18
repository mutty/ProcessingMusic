import processing.opengl.*;
import ddf.minim.*;
import javax.swing.*;

Button previousButton,startButton,nextButton,folderButton,cycleButton,showButton,volButton;
DShower dshow;
SYShower syshow;
PieShower pieshow;
GuShower gushow;
FreEgShower fregshow;
LineShower lineshow;

int currentShow=0;  //0:pieshow 1:gushow

boolean enableShow=false;
AudioPlayer player;
Minim minim;

VScrollbar playbar;
VolBar volumbar;
Progressor progressor;
PlayList playlist;
int PlayListNum=12;
PFont font;

color backC=color(0,0,100);
color wordC=color(0,0,100);
color uiC=color(230,100,100);
color showC=color(350,100,100);

PopMenu cycleMenu,showMenu;

String[] cycleWord={"顺序播放","随机播放","全部播放","单曲循环"};
String[] showWord={"旋转频率","悦动鼓点","跳动字符","动感频谱"};

void setup() {
  size(600,380,P3D);
  colorMode(HSB,360,100,100);
  background(0,0,100);
  frameRate(10);
  /*noFill();
  strokeWeight(3);
  stroke(200);
  fill(0,0,100);
  rect(1,1,598,398);*/
  minim=new Minim(this);
  font = createFont("Microsoft YaHei UI", 1);
 // dshow = new DShower(2,2,500,200);
  //dshow.setShow();
  syshow = new SYShower(0,0,400,340);
  pieshow = new PieShower(0,0,400,340,player);
  gushow = new GuShower(0,0,400,340,player);
  gushow.setup();
  fregshow = new FreEgShower(0,0,400,340,player);
  fregshow.setup();
  lineshow = new LineShower(0,0,400,340,player);
  
  
  playlist = new PlayList(400,0,200,340,PlayListNum);
  playbar = new VScrollbar(width-6, 0, 10, 340, 2,playlist.fileList.size(),PlayListNum);
  

  previousButton = new Button(5, 345,35,30,177,1).asPrevious();
  startButton = new Button(50, 345,35,30,177,2).asStart();
  nextButton = new Button(95,345,35,30,177,3).asNext();
  folderButton = new Button(140,345,45,30,177,4).asFolder();
  cycleButton = new Button(195,345,55,30,177,4).asCycle();
  showButton = new Button(0,0,40,30,177,5).asShow();
  cycleMenu = new PopMenu(195,340,50,20,cycleWord,0);
  volButton = new Button(260,345,30,30,177,6).asVolumn();
  volumbar = new VolBar(260,330,105,10,2,player);
    
  progressor = new Progressor(300,345,255,30,player);
  showMenu = new PopMenu(0,35,50,20,showWord,1);

}

void draw() {
    //dshow.draw();
    rotateX(0);
    rotateY(0);
    rotateZ(0);
    translate(0,0);
    
    startButton.display();
    nextButton.display();
    previousButton.display();
    folderButton.display();  
    volButton.display(); 
    progressor.draw();
    playlist.draw();
   
    playbar.update();
    playbar.display();

    if(currentShow==0)
    {
      if(player==null)
        pieshow.draw(false);
      else
        pieshow.draw(true);
    }
    else if(currentShow==1)
    {
      if(player==null)
        gushow.draw(false);
      else
        gushow.draw(true);
    }
    else if(currentShow==2)
    {
      if(player==null)
        fregshow.draw(false);
      else
        fregshow.draw(true);
    }
    else
    {
       if(player==null)
        lineshow.draw(false);
      else
        lineshow.draw(true);
    }
      
    cycleButton.display();
    cycleMenu.draw();
    showButton.display();
    showMenu.draw(); 
    
    volumbar.update();
    volumbar.display();

    if(player!=null && player.position()+1000>player.length())
    {
      playlist.getNextPlay();
      changePlay(playlist.CurNum);
    }

    
    /*if(player==null)
      syshow.draw(false);
    else
      syshow.draw(player.isPlaying());
    */
}


void mousePressed() {  
   previousButton.clickButton();
   startButton.clickButton();
   nextButton.clickButton();
   folderButton.clickButton();
   volButton.clickButton();
   if(volButton.overBox)
     volumbar.isShow=!volumbar.isShow;
   cycleButton.clickButton();
   if(cycleButton.overBox){
     cycleMenu.isShow=!cycleMenu.isShow;
   }
   int c=cycleMenu.clickPopMenu();
   if(c!=-1)
   {
     cycleButton.cycleState=c<0?0:c;
     playlist.cycleState=cycleButton.cycleState;
   }
   
   showButton.clickButton();
   if(showButton.overBox)
   {
     //println("click show button");
     showMenu.isShow=!showMenu.isShow;
   }
   if(player!=null)
   {
     int d=showMenu.clickPopMenu();
     if(d!=-1)
       currentShow=d;
   }  
   else
     showMenu.isShow=false;
     
   if(previousButton.overBox){
     playlist.getNextPlay();
     changePlay(playlist.CurNum);
   }
   if(startButton.overBox){
     println("status change");
     if(player!=null)
       if(player.isPlaying()==true)
       {
         startButton.stopPlay(player);
          enableShow=false;
        }
       else
       {
         startButton.beginPlay(player);
          enableShow=true;
        }
   }
   if(nextButton.overBox){
    // println("play next");
     playlist.getNextPlay();
     changePlay(playlist.CurNum);
   }
   if(folderButton.overBox){
     folderButton.openFolder();
   }
 
   
   if(progressor.clickOn()==true)
     progressor.jump();
   
   if(playbar.overEvent()==false)
   {
     int a=playlist.clickPlayList();
     if(a>=0 && a<playlist.fileList.size()){
       playlist.CurNum=a;
       changePlay(playlist.CurNum);
     }
   }
   
   float barPos=playbar.getPos();
   int begSong=(int)(barPos*playlist.fileList.size())-1;
   if(begSong<0)
     begSong=0;
   playlist.updateFirShow(begSong);
   
   volumbar.getPos();
   if(player!=null)
     player.setVolume(volumbar.volumRatio);
   //tmpP.setVolume(volumRatio);
}

void changePlay(int next){
     if(player!=null)
        player.close();
     player=minim.loadFile(playlist.fileList.get(next).getAbsolutePath(),2048);
     progressor.setPlayer(player);
     player.play();
     pieshow.setPlayer(player);
     gushow.setPlayer(player);
     fregshow.setPlayer(player);
     lineshow.setPlayer(player);
     //volumbar.setPlayer(player);
     enableShow=true;
}

 void  fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    if(player!=null)
      player.close();
    playlist.fileList.add(selection);
    playlist.CurNum=playlist.fileList.size()-1;
    changePlay(playlist.CurNum);
   // player=minim.loadFile(selection.getAbsolutePath(),2048);
     
    // progressor.setPlayer(player);
    //player.play();
    // pieshow.setPlayer(player);
   
    //println(playlist.fileList.size());
    //enableShow=true;
  }
}

void folderSelected(File selection) {
    String[] contents = selection.list();
    if(contents != null){
      contents = sort(contents);
      int count = 0;
      for (int i = 0; i < contents.length; i++) {
        //println(contents);
        String[] tmp = contents[i].split("\\.");
        int len=tmp.length;
        //println(tmp+" "+len);
        if(tmp[len-1].equals("mp3") || tmp[len-1].equals("wmv"))
        {
            File fileItem = new File(selection, contents[i]);
            println("read music file "+ fileItem.getName());
            playlist.fileList.add(fileItem);
        }
      }
    }
    if(player!=null){
       if(player.isPlaying()==true)
          player.pause(); 
    }
    playbar.updateListNum(playlist.fileList.size());
    player=minim.loadFile(playlist.fileList.get(0).getAbsolutePath(),2048);
    progressor.setPlayer(player);
    player.play();
    pieshow.setPlayer(player);
    gushow.setPlayer(player);
    fregshow.setPlayer(player);
    lineshow.setPlayer(player);
    playlist.CurNum=0;
    enableShow=true;
}
