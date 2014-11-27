/*
 **************************************************************************************************
 *                                                                                                *
 * music_play:                                                                                    *
 *                                                                                                *
 * Programmer: Robert Hieger                                                                      *
 * Music Play v1.03                                                                               *
 *                                                                                                *
 * Begun: November 23, 2014
 * Completed: ??????, 2014
 *                                                                                                *
 * Program Objectives:                                                                            *
 *                                                                                                *
 * 1) Play a simple midi-based composition.                                                       *
 * 2) Display sheet music in sync with the music as it plays.                                     *
 * 3) Change background display in response to frequency and rhythm.                              *
 *                                                                                                *
 * VERY TALL ORDER, but somewhere to begin.                                                       *
 *                                                                                                *
 * In version 1.03, my goals are to:                                                              *
 *                                                                                                *
 * 1) Re-write musical notation classes to work with PImages and masks.                           *
 *                                                                                                *
 * 2) Begin work on MIDI-rendering class library.                                                 *
 *                                                                                                *
 **************************************************************************************************
*/

// Declare PImage Array

PImage[] anarchiaSystems = new PImage[9];

void setup() {
  
  // Set size of window.
  
  size(800, 800);
  background(255);      // White
  
    // Load music systems to anarchiaSystems PImage Array.
  
    for (int i = 0; i < anarchiaSystems.length; i++) {
      
     // Populate array with images anarchia-system1.jpg through anarchia-system9.jpg.
      
      anarchiaSystems[i] = loadImage("anarchia-system" + (i + 1) + ".png");
      
     // println( "Loaded" + loadImage("anarchia-system" + (i + 1) + ".png") );
      
    }  // end for
  
}

void draw() 
{
  background(255);
  Name Title = new Name("Anarchia Entrance Theme", 40.);
  
  Title.drawHead();
  
  subName subTitle = new subName("from Anarchia, by Hanon Reznikov, The Living Theatre", 60.);
  
  subTitle.drawSub();
  
  // Insert By-Line Credit
  
  credLine byLine = new credLine("music by Robert Hieger", 100);
  
  byLine.byDraw();
  
  image(anarchiaSystems[0], 65, 105);
  image(anarchiaSystems[1], 20, 205);
  image(anarchiaSystems[2], 20, 400);
  image(anarchiaSystems[3], 20, 600);
  
}
