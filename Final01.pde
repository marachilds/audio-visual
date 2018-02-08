/*
Draws an ellipse mapped to average of left and right bufferSize value
Alpha channel mapped to fft band
Stops running when audio ends and saves a jpeg
*/

import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
FFT fft;

float x, y;
float alpha;
float wh;
String title, extension, track;
String fileName;
float r, g, b;
float br, bg, bb;

void setup(){
  fullScreen();
  noCursor();
  //Set background rgb
  br = 255;
  bg = 255;
  bb = 255;
  
  background(br, bg, bb, 255);
  
  x = 5;
  y = 5;
  
  frameRate(60);
  
  minim = new Minim(this);
  
  //Change track name for different audio input
  title = "Castle on the Hill";
  extension = ".mp3";
  track = title + extension;
  
  song = minim.loadFile(track);
  song.play();
  
  fft = new FFT(song.bufferSize(), song.sampleRate());
}

void draw(){
  
  fft.forward( song.mix );
  for(int i = 0; i < fft.specSize(); i++)
  {
    alpha = map(fft.getBand(i), 0, 1, 0, 255);
    alpha += 150;
  }
  
  if(x < width){
        //Get buffer size and average left and right
        for(int j = 0; j < song.bufferSize() - 1; j++) {
          wh = ((song.left.get(j) + song.right.get(j)) / 2) * 15;
        }
        
        //RGB color with alpha mapped to fft band
        r = 0;
        g = 102;
        b = 255;
        
        fill(r, g, b, alpha);
        noStroke();
        ellipse(x, y, wh, wh);
        
        x += 15;
      
      //Starts drawing at top again, draws transparent overlay
      } else if((y > height - 20) && (song.isPlaying() == true)){
        fill(br, bg, bb, 50);
        rect(0, 0, height, width);
        y = 5;
      //Draws on new row if x excededs width
      } else {
        y += 15;
        x = 5;
    }
    
  //Save jpeg and stop looping when track is finished playing
  if(song.isPlaying() == false){
    fileName = title + ".jpeg";
    save(fileName);
    noLoop();
  }
}