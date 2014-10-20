/*

Project #1: book-reader
Version 1.3
Programmer: Robert Hieger
October 6, 2014

In addition to items listed below, the aims of this revision are to begin abstraction of
reader functions into classes contained in a separate file.

Among imagined classes would be:

1) Book: A class to define and load a book
2) splashScreen: A class to define and load the program splash screen
3) pageLoad: A class to define boundaries of a page and load it

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


*/

// Set up String array into which text of book is read.

// String[] book;

int currentLine = 0;

PFont title, iHeader, body;

// Set up application window.

void setup() {
  
  size(800, 800);  // Render application frame 800 x 800 pixels.
  
  background(255, 0.5);  // White with 50% opacity.
  
  // Load fonts and set their properties.
  
  title = loadFont("HelveticaNeue-Bold-60.vlw");
  iHeader = loadFont("Times-Bold-60.vlw");        // Header for Instructions
  body = loadFont("Times-Roman-60.vlw");

  // Load array holding text of book;
  
  Book treasureIsland;

  treasureIsland = new Book("treasure-island.txt");
  
  String[] eBook = treasureIsland.load;
  
}

void draw() {
  
  // Text of Book gets drawn here.
  
  // Obviously some kind of loops will be necessary to start and stop load of pages. I am more than a bit stumped
  // at the moment. My first step is to draw the book title centered across the top of the frame.
  
  // Unfortunately, so far, every font I have created renders crappily. I don't know why.
 
 
 /* textFont(title);
 textAlign(CENTER);
 textSize(24);
 fill(0);
 smooth();
 text(book[0], width / 2, 45); */ 
 
 // Call splashScreen()

splashScreen();


}

// Function to create Splash Screen

void splashScreen() {
  
   // Renders splash screen with title of book and
   // minimal instructions on how to start reading
   // as well as how to advance or reverse through
   // pages.
   
   // Title Line 1
   
   String firstTitle = "Treasure";
   
   textFont(title);
   textAlign(CENTER);
   fill(255, 215, 0); // Gold color for title. Hopefully not cheesy.
   text( firstTitle, width /2, (height / 2) - 150 );  // Center toward top of frame.
   
   // Title Line 2
   
   String secondTitle = "Island";
   
   textFont(title);
   textAlign(CENTER);
   fill(255, 215, 0); // Gold color for title. Hopefully not cheesy.
   text( secondTitle, (width /2) + 38, ( (height / 2) -150 ) + 62 );
   
   // byLine
   
   String byLine = "by Robert Louis Stevenson";
   
   textFont(title);
   textSize(28);
   textAlign(CENTER);
   fill(255, 215, 0); // Gold color for title. Hopefully not cheesy.
   text( byLine, (width / 2), ( (height /2) - 150 ) + 124 );
   
   // Render Instructions
   
   String instructionHead = "Instructions";
   
   textFont(iHeader);
   textSize(18);
   textAlign(LEFT);
   fill(0);
   text( instructionHead, 50, ( (height / 2) - 150 ) + 200);
   
   // Render Ruling Line.
   
   line( 50, ( (height / 2) - 150 ) + 204, 142, ( (height / 2) - 150) + 204 );
   strokeWeight(1.25);
   smooth();
   
   // Start and Navigation Instructions
   
   String instructions = "To begin reading, press ENTER or RETURN. To move a page down or up, press the " +
                         "up- or down arrow, respectively. To exit, press Esc.";
    
    // Instruction Line 1
    
    textFont(body);
    textSize(18);
    textAlign(LEFT);
    fill(0);
    text(instructions.substring(0, 77), 50, ( (height / 2) - 150 ) + 230 );
    
    textFont(body);
    textSize(18);
    textAlign(LEFT);
    fill(0);
    text(instructions.substring(78, 130), 50, ( (height / 2) - 150 ) + 250 );

}

// load a text file and spit it out again, all cleaned up
// no draw() loop

/*void draw()
{
  
} */


// NOT SURE HOW THIS WORKS. ASK.

void printarray(String[] p)
{
  for (int i= 0; i<p.length; i++)
  {
    println(p[i]);
  }
}
