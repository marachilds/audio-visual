//Draws an ellipse at the bpm for the bufferSize value

import ddf.minim.*;

Minim minim;
AudioPlayer song;

float x, y;
float w, h;
float bpm;

void setup(){
  size(800, 800);
  background(0);
  
  x = 5;
  y = 5;
  
  bpm = 160;
  frameRate(bpm);
  
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
        x += 15;
      } else {
        y += 15;
        x = 5;
    };
}