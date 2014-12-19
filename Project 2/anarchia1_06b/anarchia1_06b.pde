/*
 **************************************************************************************************
 *                                                                                                *
 * anarchia: (formerly music_play) new code branch                                                *
 *                                                                                                *
 * Programmer: Robert Hieger                                                                      *
 * Music Play v1.06b                                                                              *
 *                                                                                                *
 * Begun: December 13, 2014                                                                       *
 * Completed: December 18, 2014                                                                   *
 *                                                                                                *
 * Program Objectives:                                                                            *
 *                                                                                                *
 * 1) Play a simple midi-based composition.                                                       *
 * 2) Display sheet music in sync with the music as it plays.                                     *
 *                                                                                                *
 * In version 1.06b, my goals are to:                                                             *
 *                                                                                                *
 * 1) Catch any remaining imperfections.                                                          *
 *                                                                                                *
 * 2) Update and complete code documentation.                                                     *
 *                                                                                                *
 * 3) Integrate MIDI playing without keyRelease() logic.                                          *
 *                                                                                                *
 *                                                                                                *
 * ACKNOWLEDGMENT:                                                                                *
 *                                                                                                *
 * I am indebted to R. Luke DuBois for his contribution of his humorously named "midishit"        *
 * module, which provides a Java library-based implementation allowing the load and playback      *
 * of a MIDI file using the synthesizer subsystem of the operating system.                        *
 *                                                                                                *
 * Further, my original musical system-positioning algorithms are retrofitted with enhanced       *
 * code for which I also owe a debt of gratitude to R. Luke DuBois. This code includes the        *
 * necessary logic for:                                                                           *
 *                                                                                                *
 * 1) Drawing a system only up to a given X-coordinate offset.                                    *
 *                                                                                                *
 * 2) Masking each system in progression with an opaque rectangle to size.                        *
 *                                                                                                *
 * 3) Setting that rectangle's alpha channel value to 0 to fade in each measure in sync           *
 *    with the MIDI sequence.                                                                     *
 *                                                                                                *
 * 4) Implementation of MIDI play on initialization of the program.                               *
 *                                                                                                *
 * 5) keyReleased() implementation which traps any uncoded key, but on release of any             *
 *    coded key, acts as a toggle, stopping the sequence or, conversely, resetting and            *
 *    playing it from the beginning.                                                              *
 **************************************************************************************************
 */

// Java Imports for MIDI Support

import javax.sound.midi.MidiSystem;
import javax.sound.midi.MidiDevice;
import javax.sound.midi.MidiDevice.Info;
import javax.sound.midi.Synthesizer;
import javax.sound.midi.MidiChannel;
import javax.sound.midi.Sequence;
import javax.sound.midi.Sequencer;

// Instantiate synthesizer object.

Synthesizer synth;

// Instantiate array of MidiChannel objects.

MidiChannel[] channels;

// Instantiate MIDI Sequencer object.

Sequencer seq;

// Is the sequence loaded?

boolean sequenceIsLoaded = false;

// Is the sequence playing for the first time?

boolean firstTime = true;

/*****************************************************************************************************
 *                                                                                                   *
 * DECLARE AND POPULATE ARRAYS NECESSARY FOR LINKING MIDI TO DISPLAY OF MUSICAL NOTATION SYSTEMS.    *
 * ALSO DECLARATION OF NECESSARY GLOBAL VARIABLES.                                                   *
 *                                                                                                   *
 * 1) meterMap[] array: values for the number of eighth notes in each measure                        *
 *                                                                                                   *
 * 2) lastSystemShown array: values of the system number to which each revealed measure belongs      *
 *                                                                                                   *
 * 3) whichPage[] array: values of the first system on each page for each revealed measure           *
 *                                                                                                   *
 * 4) systemX[] array: values for the X-coordinate offset at which each system is placed             *
 *                                                                                                   *
 * 5) systemY[] array: values for the Y-coordinate offset at which each system is palced             *
 *                                                                                                   *
 * 6) measureX[] array: values for the X-coordinate at which each revealed measure ends              *
 *                                                                                                   *
 * 7) measure: variable to hold the value of the current measure being played in the sequence        *
 *                                                                                                   *
 * 8) anarchiaSystems[9]: 9 element PImage array of PNG files for each musical system                * 
 *                                                                                                   *
 *****************************************************************************************************
 */

// Declare and populate array for number of eighth notes
// in each measure.

int[] meterMap = {

  8, 8, 8, 8, 5,                                              // System 1
  5, 8, 8, 8,                                                 // System 2
  8, 8, 8, 5, 5,                                              // System 3
  8, 8, 5, 5,                                                 // System 4 (end of page 1)
  5, 5, 5, 5, 5,                                              // System 5 (beginning of page 2)
  5, 8, 8, 8,                                                 // System 6
  8, 8, 8, 8,                                                 // System 7 (end of page 2)
  5, 5, 5, 5,                                                 // System 8 (beginning of page 3)
  8, 8, 8                                                     // System 9 (end of page 3)
};

// Declare and populate array with values representing the
// last system shown on screen after each measure is revealed.

int[] lastSystemShown = {
  0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3,      // Page One
  4, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6,                     // Page Two
  7, 7, 7, 7, 8, 8, 8                                        // Page Three
};

// Declare and populate array with values representing the
// index of the first system appearing on each page for each
// measure that is revealed.

int[] whichPage = {

  0, 0, 0, 0, 0,                    // Page One
  0, 0, 0, 0, 
  0, 0, 0, 0, 0, 
  0, 0, 0, 0, 
  4, 4, 4, 4, 4,                    // Page Two
  4, 4, 4, 4, 
  4, 4, 4, 4, 
  7, 7, 7, 7,                       // Page Three
  7, 7, 7
};

// Declare and populate array with values representing the X-coordinate
// offset for placement of each musical system.

int[] systemX = {

  65, 20, 20, 20,                 // Page One
  20, 20, 20,                     // Page Two
  20, 20                          // Page Three
};

// Declare and populate array with values representing the Y-coordinate
// offset for placement of each musical system.

int[] systemY = {

  105, 205, 400, 600,            // Page One
  105, 300, 500,                 // Page Two
  105, 300                       // Page Three
};

// Measure X-coordinate offset for rectangle mask. Each row of elements represents
// the ending point in pixels for each measure so that the mask is offset to reveal
// the measure.

int[] measureX = {
  296, 413, 521, 638, 755,       // Page One
  281, 480, 648, 762, 
  299, 427, 533, 642, 755, 
  411, 553, 665, 764, 
  295, 415, 528, 643, 765,      // Page Two
  282, 454, 627, 766, 
  326, 459, 610, 756, 
  330, 465, 603, 755,          // Page Three
  426, 648, 765
};

// measureLeft is the X-coordinate representing the ending point in pixels of the
// previous measure. This value + 1 pixel determines where an alpha channel-based
// rectangle fades from 255 to 0 opacity fading in the next measure.

int[] measureLeft = {
  144, 296, 413, 521, 638,    // Page One
  144, 281, 480, 648, 
  144, 299, 427, 533, 642, 
  144, 411, 553, 665, 
  144, 295, 415, 528, 643,    // Page Two
  144, 282, 454, 627, 
  144, 326, 459, 610, 
  144, 330, 465, 603,        // Page Three
  144, 426, 648
};



// Stores value for the current measure in the sequence as it plays.

int measure = 0;

// Stores value for the number of the previous measure.

int previousMeasure = -1;

// Stores the value for the alpha value in the alpha-based rectangle
// mentioned above. Its value is initialized to 255 so that the
// rectangle is opaque and completely covers any given measure.

int fadeAlpha = 255;

PImage[] anarchiaSystems = new PImage[9];

void setup() {
  
  frameRate(80);  // Adjust frame rate so each measure draws in slightly
                  // over 3 seconds.
  
  // Set size of sketch window.

  size(800, 800);

  // Populate array.

  for (int i = 0; i < anarchiaSystems.length; i++) {

    // Load all PImages into array.

    anarchiaSystems[i] = loadImage( "anarchia-system" + (i + 1) + ".png" );
    
  }  // end for

  // Initialize MIDI Synthesizer, load sequence and start MIDI sequencer.

  startMidiSynth(); // start the internal MIDI synth

  // Start the sequencer and load the MIDI file:

  initSequencer("anarchia-entrance.mid");

}  // end setup()

void draw() {
  
  /*****************************************************************************************
   *                                                                                       *
   * The following code figures out what measure in he sequence is currently being played  *
   * and syncs the revelation of each measure of musical notation to the sequence.         *
   * It does so by:                                                                        *
   *                                                                                       *
   * 1) Determining how many quarternotes per measure and getting the ticks, then          *
   *    dividing that value by 2 to determine the ticks per eihgth note.                   *
   *                                                                                       *
   * 2) Determining how many ticks into the sequence we are.                               *
   *                                                                                       *
   * 3) Dividing the current tick position by the value of the eigth note we are on.       *
   *                                                                                       *
   * 4) Determining which measure to reveal.                                               *
   *                                                                                       *
   *****************************************************************************************
   */

  if ( seq.isRunning() ) {

    int ppq = seq.getSequence().getResolution() /2; // how many ticks per eighth?

    long playheadraw = seq.getTickPosition(); // how many ticks are we into the file?

    int beats = int(playheadraw / ppq); // which eighth note are we on?

    measure = 0; // which measure am i on?

    // RTSKED(ish)

    for (int i = 0; i < meterMap.length; i++) {

      beats = beats - meterMap[i];    // Subtracts number of eighth notes in current measure
                                      // from the value of beats (initialized to 0) to determine
                                      // current position in score.

      if (beats < 0) {

        measure = i;                 // This is kind of the most important line in the whole thing as
                                     // it increments the value of measure from 0-37 (1-38 for us humans).

        break;
        
      }  // end inner if
      
    }  // end for
    
  }  // end outer if

  // Draw Page Header Information.

  background(255);  // Set background to white.

  // Instantiate Title object.

  Name Title = new Name("Anarchia Entrance Theme", 40.);

  Title.drawHead();  // Draw Title

  // Instantiate subTitle object.

  subName subTitle = new subName("from Anarchia, by Hanon Reznikov, The Living Theatre", 60.);

  subTitle.drawSub();  // Draw subTitle.

  // Instantiate written object.

  yearWritten written = new yearWritten("written 1995", 100.);

  written.drawYear();  // Draw written.

  // Instantiate byLine object.

  credLine byLine = new credLine("music by Robert Hieger", 100.);

  byLine.byDraw();  // Draw byLine.

  /* DRAW SYSTEMS OF MUSICAL NOTATION. */

  // Set parameters for rectangle to be used as mask for musical systems.

  fill(255);    // Set fill of rectangle to white, same as sketch.
  noStroke();  //  Set rectangle stroke width to 0.

  // Draw (reveal) each measure synced to sequence.

  for (int i = 0; i < anarchiaSystems.length; i++) {

    // If whichPage, indexed to the value of the beginning measure of each system,
    // is greater than or equal to the incrementer, draw an opaque rectangle the
    // width and height of the current system making it invisible.
    
    if ( whichPage[measure] >= i ) {

      rect(0, 105, width, height);
      
    }  // end if
    
    // If the lastSystemShown, indexed by measure, is greater than or equal to the
    // loop increment value, draw the system and current index of measure up to
    // the systemX X-offset value at the loop increment value, and the systemY
    // Y-offset value at the loop increment value.

    if ( lastSystemShown[measure] >= i ) {

      image(anarchiaSystems[i], systemX[i], systemY[i]);
      
    }  // end if
    
    // Following is implementation of a fade-in feature, which first checks to see
    // if the lastSystemShown, indexed to measure, is equal to the loop increment.
    // If so, it goes on to check if the value of previousMeasure, initialized at -1,
    // is equal to the value of measure, initialized to 0.
    
    // Then, if the value of previousMeasure is equal to measure, initialized to 0,
    // the value of fadeAlpha is decremented on each frame (default of 60 per second),
    // until reaching the value of 0 or total transparency, revealing the measure.
    // Framerate is set here to 80, fading in each measure in slightly over 3 seconds.
    
    // Finally, if previousMeasure is not equal to measure, fadeAlpha is set to 255,
    // making the masking rectangle opaque, and previousMeasure is set equal to the
    // value of measure, so that the next time through the loop, a measure is
    // revealed by virtue of the fadAlpha-- statement in the if clause.

    if ( lastSystemShown[measure] == i ) {

      if (previousMeasure==measure) {
        
        fadeAlpha--;
        
      } else {
        
        fadeAlpha = 255;
        previousMeasure = measure;
        
      }  // end if-else
      
      // First draw a rectangle mask at an opacity equal to the value of fadeAlpha.

      fill(255, fadeAlpha);    // Set opacity to the value of fadeAlpha.
      
      // Draw the rectangle at an X-coordinate offset equal to measureLeft, indexed by measure,
      // a Y-coordinate offset equal to systemY indexed by the loop increment. Width is
      // specified according to measureX (the x-coordinate offset), indexed by measure, minus
      // the value of the measureLeft, indexed by measure; height is specified by the height
      // value of anarchiaSystems, indexed by the loop increment.
      
      rect(measureLeft[measure], systemY[i], measureX[measure]-measureLeft[measure], anarchiaSystems[i].height);
      
      // Now draw an opaque rectangle at the X- and Y-coordinate offsets specified for each system
      // and of width and height values attributable to anarchiaSystems, indexed by loop increment.

      fill(255);          // Set rectangle fill to white and fully opaque.
      
      // Draw the rectangle as described above.
      
      rect(measureX[measure], systemY[i], anarchiaSystems[i].width, anarchiaSystems[i].height);
      
    }  // end outer if
    
  }  // end for
  
  // Start sequence only if it is loaded and if it is the first time
  // the sequence has played.

  if (sequenceIsLoaded == true && firstTime == true) {
    
    // Start Sequence.
    
    startSeq();            // Start MIDI sequence.
    
    firstTime = false;     // Set firstTime boolean to false preventing
                           // sequence from looping.
    
  }  // end if
  
}  // end draw()

// starSeq() Function

void startSeq() {

  seq.setTickPosition(0);    // Rewind to beginning.
  seq.start();               // Start sequence.
}  // end startSeq()

// Function seqStop()

void stopSeq() {

  seq.stop();              // Stop sequence.
  
  stopMidiSynth();        // Shut down synthesizer resource and free system resource.
  
}  // end seqStop()

/*************************************************************************************************
 *                                                                                               *
 * keyReleased() Toggle:                                                                         *
 *                                                                                               *
 * The following keyPressed() method acts as a toggle. If pressed once, MIDI playback and        *
 * synced score rendering stop. If pressed again, MIDI sequence is rewound to beginning and      *
 * playback and rendering commence from start of sequence.                                       *
 *                                                                                               *
 *************************************************************************************************
 */

void keyReleased() {
  
  if (key!=CODED) {

    if ( seq.isRunning() ) {    // Trap and eliminate Command key. NOTE: This does not work.

      stopSeq();    // Stop sequence.
      
    } else {

      startSeq();
      
    }  // end if-else
    
  }  // end outer if
  
}  // end keyPressed()
