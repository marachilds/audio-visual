//Draws an ellipse at the bpm for the bufferSize value
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
  //Setting width to 103 (bpm) * 4 = 412 to align beats
  //Or 103 * 8 = 824
  size(824, 800);
  colorMode(HSB);
  background(0);
  
  x = 5;
  y = 5;
  
  bpm = 103;
  //Either bpm or bpm/2
  frameRate(bpm);
  
  minim = new Minim(this);
  song = minim.loadFile("Something Just Like This.mp3", 1024);
  song.play();
  
  fft = new FFT(song.bufferSize(), song.sampleRate());
}

void draw(){
  
  fft.forward( song.mix );
  for(int i = 0; i < fft.specSize(); i++)
  {
    hue = map(fft.getBand(i), 0, 1, 0, 360);
  }
  
  stroke(hue, 255, 255);
  fill(hue, 255, 255);
  
  if(x < width){
        for(int j = 0; j < song.bufferSize() - 1; j++) {
          w = song.left.get(j)*10;
          h = song.left.get(j)*10;
        }
        ellipse(x, y, w, h);
        x += 5;
      } else {
        y += 5;
        x = 5;
    };
}