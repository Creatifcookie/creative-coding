
PImage main;

void setup()
{
  size(500, 500);
  main = loadImage("main.png");
  
}

void draw()
{
  background(255, 0, 0);
  image(main, 0, 0);
  fill(255, 255, 255);
  noStroke();
  rect(mouseX, 0, width, height);
  
}
