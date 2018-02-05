//Draws an ellipse at the bpm for the bufferSize value

import ddf.minim.*;

Minim minim;
AudioPlayer song;

float x, y;
float w, h;
float bpm;

void setup(){
  //Setting width to 160 (bpm) * 3 = 480 to align beats
  size(480, 800);
  background(0);
  
  x = 5;
  y = 5;
  
  bpm = 160;
  frameRate(bpm/4);
  
  minim = new Minim(this);
  song = minim.loadFile("Ready For It.mp3");
  
  song.play();
}

void draw(){
  stroke(255);
  fill(255);
  
  if(x < width){
        for(int i = 0; i < song.bufferSize() - 1; i++) {
          w = song.left.get(i)*10;
          h = song.left.get(i)*10;
        }
        ellipse(x, y, w, h);
        x += 5;
      } else {
        y += 5;
        x = 5;
    };
}