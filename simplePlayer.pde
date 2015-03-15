import processing.opengl.*;
import ddf.minim.*;
import javax.swing.*;

Button playButton,stopButton,openButton,folderButton;
DShower dshow;
SYShower syshow;
boolean enableShow=false;
AudioPlayer player;
Minim minim;

VScrollbar bar;
Progressor progressor;
PlayList playlist;
int PlayListNum=12;
PFont font;

void setup() {
  size(600,400,P3D);
  background(50,55,55);
  frameRate(10);
  noFill();
  strokeWeight(3);
  stroke(200);
  rect(1,1,598,398);
  minim=new Minim(this);
  font = createFont("Microsoft YaHei UI", 1);
 // dshow = new DShower(2,2,500,200);
  //dshow.setShow();
  syshow = new SYShower(2,2,398,340);
  playlist = new PlayList(400,2,200,340,PlayListNum);
  bar = new VScrollbar(width-6, 0, 10, 340, 2,playlist.fileList.size(),PlayListNum);
  playButton = new Button(80, 350,60,30,177,1).asSpecial("play");
  stopButton = new Button(10, 350,60,30,177,2).asSpecial("stop");
  openButton = new Button(150,350,60,30,177,3).asSpecial("open");
  folderButton = new Button(220,350,60,30,177,4).asSpecial("folder");
  progressor = new Progressor(300,350,260,30,player);
}

void draw() {
    //dshow.draw();
    rotateX(0);
    rotateY(0);
    rotateZ(0);
    translate(0,0);
    
    stopButton.display();
    openButton.display();
    playButton.display();
    folderButton.display();
   
    progressor.draw();
    playlist.draw();
    bar.update();
    bar.display();
    if(player==null)
      syshow.draw(false);
    else
      syshow.draw(player.isPlaying());
    
}


void mousePressed() {  
   playButton.clickButton();
   stopButton.clickButton();
   openButton.clickButton();
   folderButton.clickButton();
   if(playButton.overBox){
     println("begin Play");
     playButton.beginPlay(player);
     enableShow=true;
   }
   if(stopButton.overBox){
     println("stop play");
     playButton.stopPlay(player);
     enableShow=false;
   }
   if(openButton.overBox){
     println("open file");
     openButton.openFile();
   }
   if(folderButton.overBox){
     folderButton.openFolder();
   }
   if(progressor.clickOn()==true)
     progressor.jump();
   
   if(bar.overEvent()==false)
   {
     int a=playlist.clickPlayList();
     if(a>=0 && a<playlist.fileList.size()){
       if(player!=null){
         if(player.isPlaying()==true)
            player.pause();
          }
        player=minim.loadFile(playlist.fileList.get(a).getAbsolutePath(),2048);
        progressor.setPlayer(player);
        player.play();
        playlist.CurNum=a;
        enableShow=true;
     }
   }
   
   float barPos=bar.getPos();
   int begSong=(int)(barPos*playlist.fileList.size())-1;
   if(begSong<0)
     begSong=0;
   playlist.updateFirShow(begSong);
}

 void  fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    if(player!=null)
      player.close();
    player=minim.loadFile(selection.getAbsolutePath(),2048);
     playlist.fileList.add(selection);
     progressor.setPlayer(player);
    player.play();
    playlist.CurNum=playlist.fileList.size()-1;
    println(playlist.fileList.size());
    enableShow=true;
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
        if(tmp[len-1].equals("mp3") || tmp[len-1].equals("wmv") || tmp[len-1].equals("m4a"))
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
    bar.updateListNum(playlist.fileList.size());
    player=minim.loadFile(playlist.fileList.get(0).getAbsolutePath(),2048);
    progressor.setPlayer(player);
    player.play();
    playlist.CurNum=0;
    enableShow=true;
}
