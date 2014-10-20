/*
 **************************************************************************************************
 *                                                                                                *
 * music_play:                                                                                    *
 *                                                                                                *
 * Programmer: Robert Hieger                                                                      *
 * Music Play v1.0                                                                                *
 *                                                                                                *
 * Begun: October 8, 2014
 * Completed: October 21, 2014
 *                                                                                                *
 * Program Objectives:                                                                            *
 *                                                                                                *
 * 1) Play a simple midi-based composition.                                                       *
 * 2) Display sheet music in sync with the music as it plays.                                     *
 * 3) Change background display in response to frequency and rhythm.                              *
 *                                                                                                *
 * VERY TALL ORDER, but somewhere to begin.                                                       *
 *                                                                                                *
 **************************************************************************************************
*/

// GLOBAL VARIABLES -- YET TO BE DEFINED

void setup() {
  
  // Set size of window.
  
  size(800, 800);
  background(#faf0e6);      // Linen
  
  
  // First I must learn how to crawl, then to walk,
  // then to run. I am going to attempt to hardcode
  // some of the above functions, then abstract them
  // to an external class file from which objects may
  // be instantiated.
  
    
}

void draw() {
  
  stroke(2);      // Make line stroke 2 pixels.
  smooth();       // Apply antialiasing.
    
  drawStaff(50);
  
}

/*
 *
 * Assume a 600 pixel long musical staff centered
 * in a window width of 800.
 *
*/

void drawStaff(float above) {
  
  // Internal variables

  float spaceAbove = above;

  // Loop to draw lines of staff
  
  for (int lineCount = 0; lineCount <= 4; lineCount++) {
    
    if (lineCount == 0) {
      
      line(width - 750, spaceAbove, width - 50, spaceAbove);
      
    }  else {
      
       line(width - 750, spaceAbove + 12, width - 50, spaceAbove + 12);
      
    }  // end if-else
    
  }  // end for
  
}  // end drawStaff(float above)
