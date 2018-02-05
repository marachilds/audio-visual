//Draws an ellipse at the bpm/15 for the bufferSize value
//Color based on frequency

import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
FFT fft;

float x, y;
float w, h;
float bpm;
float hue;

void setup(){
  size(800, 800);
  colorMode(HSB);
  background(0);
  
  x = 5;
  y = 15;
  
  bpm = 135;
  //Either bpm or bpm/2
  frameRate(60);
  
  minim = new Minim(this);
  song = minim.loadFile("My Favorite Things.mp3", 1024);
  song.play();
  
  fft = new FFT(song.bufferSize(), song.sampleRate());
}

void draw(){
  
  rectMode(CENTER);
  
  fft.forward( song.mix );
  for(int i = 0; i < fft.specSize(); i++) {
    hue = map(fft.getBand(i), 0, 1, 0, 360);
  };
  
  stroke(hue, 100, 255);
  noFill();
  
  if(x < width){
        for(int j = 0; j < song.bufferSize() - 1; j++) {
          w = (song.left.get(j)*10)+2;
          h = (song.left.get(j)*100)+5;
        }
        ellipse(x, y, w, h);
        x += 3;
      } else {
        y += 15;
        x = 5;
    };
}