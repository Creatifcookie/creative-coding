// testfontcrap

// Experiment performed by R. Luke DuBois


PFont f;

void setup()
{
  size(800, 600);
  background(255);
  fill(0);
  f = createFont("HelveticaNeue Thin", 400);
  textFont(f);
  //textSize(400);  // Redundant function
  textAlign(CENTER);
  text("Testing123!!!", width/2, height/2);
  
}

void draw()
{
  
}
