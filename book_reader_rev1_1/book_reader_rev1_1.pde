/*

Project #1: book-reader
Version 1.1
Programmer: Robert Hieger

This revision is based loosely on code from R. Luke Dubois'
C_drawsometext.pde from our Session #3 class.

Stated project objectives remain the same and are listed below.

Project Requirements:

1) Reasonable and readable formatting in a reasonably-sized
   window for text display.
2) Navigation Page Up, Page Down
3) Exit feature

Wish List:

1) Jump to Chapter
2) Jump to Page

In this iteration I hope to implement:

1) Creation of a font and ability to draw text from the book in a Processing window.


*/

// Set up String array into which text of book is read.

String[] book;

int currentLine = 0;

PFont title, heading, body; // Instantiate two PFont objects to hold heading and body text fonts.

// Set up application window.

void setup() {
  
  size(800, 800);  // Render application frame 800 x 800 pixels.
  
  background(255, 0.5);  // White with 50% opacity.
  
  // Load fonts and set their properties.
  
  title = loadFont("LucidaSans-48.vlw");
  //heading = loadFont("GillSans-24.vlw");
  //body = loadFont("Charter-Roman-14.vlw");

  // Load array holding text of book;

  book = loadStrings("treasure-island.txt");
  
}

void draw() {
  
  // Text of Book gets drawn here.
  
  // Obviously some kind of loops will be necessary to start and stop load of pages. I am more than a bit stumped
  // at the moment. My first step is to draw the book title centered across the top of the frame.
  
  // Unfortunately, so far, every font I have created renders crappily. I don't know why.
 
 
 textFont(title);
 textAlign(CENTER);
 textSize(24);
 fill(0);
 smooth();
 text(book[0], width / 2, 45); 
  
}




// load a text file and spit it out again, all cleaned up
// no draw() loop

/*void draw()
{
  
}


// NOT SURE HOW THIS WORKS. ASK.

void printarray(String[] p)
{
  for (int i= 0; i<p.length; i++)
  {
    println(p[i]);
  }
}

void keyPressed()
{
   println(book[currentLine] + "\tLine #" + currentLine);
   currentLine = (currentLine+1) % book.length;
}

*/
