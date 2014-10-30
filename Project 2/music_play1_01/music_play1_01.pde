/*
 **************************************************************************************************
 *                                                                                                *
 * music_play:                                                                                    *
 *                                                                                                *
 * Programmer: Robert Hieger                                                                      *
 * Music Play v1.01                                                                               *
 *                                                                                                *
 * Begun: October 22, 2014
 * Completed: October 30, 2014
 *                                                                                                *
 * Program Objectives:                                                                            *
 *                                                                                                *
 * 1) Play a simple midi-based composition.                                                       *
 * 2) Display sheet music in sync with the music as it plays.                                     *
 * 3) Change background display in response to frequency and rhythm.                              *
 *                                                                                                *
 * VERY TALL ORDER, but somewhere to begin.                                                       *
 *                                                                                                *
 * In version 1.01, my goals are to:                                                              *
 *                                                                                                *
 * 1) Break the programming problem into subsystems, as follows:                                  *
 *                                                                                                *
 *      a) Play musical file--MIDI or MP3                                                         *
 *      b) Render musical notation for the piece as it is played.                                 *
 *      c) Musical data visualization layer--background reacts to frequency and rhythm.           *
 *                                                                                                *
 *                                                                                                *
 * 2) First attempts at abstraction of functions into classes.                                    *
 *                                                                                                *
 **************************************************************************************************
*/

  // Image for Treble Cleff
  
  PImage treble;

void setup() {
  
  // Set size of window.
  
  size(800, 800);
  background(#faf0e6);      // Linen
  
  // Fonts used in this project
  
  PFont titleFace;        // Declare font object.
  titleFace = loadFont("HelveticaNeue-Medium-48.vlw");
  textFont(titleFace, 32);
  fill(0);
  
  treble = loadImage("treble-clef.png");
  
  
  // First I must learn how to crawl, then to walk,
  // then to run. I am going to attempt to hardcode
  // some of the above functions, then abstract them
  // to an external class file from which objects may
  // be instantiated.
  
    
}

void draw() {
  
  //Title("Anarchia Entrance Theme");
  
  // STANDARDIZED MEASUREMENTS FOR STAFF AND SYSTEM
  // SPACINGS AS FOLLOWS:
  
  // Staff Line: 2 pixels thick
  // Space Between Lines: 8 pixels
  // 5 Lines Per Staff
  // 50 pixels height for each staff
  // 50 pixels between each staff
  // 3 staves per system
  // Total Height per system: 250 pixels
  
  Name Title = new Name("Anarchia Entrance Theme", 50.);
  
  Title.drawHead();
  
  stroke(2);      // Make line stroke 2 pixels.
  smooth();       // Apply antialiasing.
  
  Staff staff1 = new Staff(75);      // Instantiate staff1
  Staff staff2 = new Staff(175);     // Instantiate staff2
  Staff staff3 = new Staff(275);     // Instantiate staff3 
  
  staff1.drawStaff();  // Draw the first staff.
  staff2.drawStaff();  // Draw the second staff.
  staff3.drawStaff();  // Draw the third staff.
    
  //drawStaff(75);
  //smooth();
  image(treble, 45, 50);
  treble.resize(62, 80);
  smooth();
  //drawStaff(165);
  image(treble, 45, 150);
  treble.resize(62, 80);
  smooth();
  //drawStaff(255);
  image(treble, 45, 250);
  treble.resize(62, 80);
  smooth();
  closeSystem(50, 75, 50, 307);  // Draw bar line to connect system.
  
  // NOTE: Not too clear yet why the ending y-Coordinate above is 307.
  // From my figurings, it would seem it should have been 325, but
  // that was way off. Also note that the closeSystem() function still
  // needs to be abstracted.
  
}

/*
 *
 * Assume a 600 pixel long musical staff centered
 * in a window width of 800.
 *
*/

/*void Title(String titleString) {
  
  // Internal Variable
  
  String title = titleString;
  text(title, ((width / 2) -title.length()) /2, 50);
  
}*/

void drawStaff(float above) {
  
  // Internal variables

  float spaceAbove = above;

  // Loop to draw lines of staff
  
  
  for (int lineCount = 1; lineCount <= 5; lineCount++) {
    
    if (lineCount == 0) {
      
        line(width - 750, spaceAbove, width - 50, spaceAbove);      
      
    }  else {
      
         line(width - 750, spaceAbove, width - 50, spaceAbove);
         spaceAbove += 8.;
         
    }  // end if-else
        
  }  // end for
  
}  // end drawStaff(float above)

void closeSystem(float x1, float y1, float x2, float y2) {
  
  line(x1, y1, x2, y2);
  smooth();
 
}
