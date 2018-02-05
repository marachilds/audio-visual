float x, y;

void setup(){
  size(900, 900, P2D);
  background(0);
  x = 5;
  y = 5;
}

void draw(){
  //print(y);
  if(x < width){
    ellipse(x, y, 5, 5);
    x += 15;
    //print(width);
    //print(x);
  } else {
    y += 15;
    x = 5;
  };
}