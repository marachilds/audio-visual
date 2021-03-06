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
  //Setting width to 135 (bpm) * 3 = 405 to align beats
  //Or 6 times = 810
  size(810, 800);
  colorMode(HSB);
  background(0);
  
  x = 5;
  y = 15;
  
  bpm = 135;
  //Either bpm or bpm/2
  frameRate(bpm/15);
  
  minim = new Minim(this);
  song = minim.loadFile("Castle on the Hill.mp3", 1024);
  song.play();
  
  fft = new FFT(song.bufferSize(), song.sampleRate());
}

void draw(){
  
  fft.forward( song.mix );
  for(int i = 0; i < fft.specSize(); i++)
  {
    hue = map(fft.getBand(i), 0, 1, 80, 180);
  }
  
  stroke(hue, 100, 255);
  fill(hue, 100, 255);
  
  if(x < width){
        for(int j = 0; j < song.bufferSize() - 1; j++) {
          w = song.left.get(j)*20;
          h = song.left.get(j)*20;
        }
        ellipse(x, y, w, h);
        x += 15;
      } else {
        y += 15;
        x = 5;
    };
}