/*
 **************************************************************************************************
 *                                                                                                *
 * anarchia: (formerly music_play) new code branch                                                *
 *                                                                                                *
 * Programmer: Robert Hieger                                                                      *
 * Music Play v1.06                                                                               *
 *                                                                                                *
 * Begun: December 12, 2014                                                                       *
 * Completed: December ??, 2014                                                                   *
 *                                                                                                *
 * Program Objectives:                                                                            *
 *                                                                                                *
 * 1) Play a simple midi-based composition.                                                       *
 * 2) Display sheet music in sync with the music as it plays.                                     *
 * 3) Change background display in response to frequency and rhythm.                              *
 *    NOTE: This feature may go to a wishlist in the interest of time.                            *
 *                                                                                                *
 * In version 1.06, my goals are to:                                                              *
 *                                                                                                *
 * 1) Catch any remaining X-coordinate offset bugs on musical system reveal.                      *
 *                                                                                                *
 * 2) Implement fade-in class to fade notation in measure by measure.                             *
 *                                                                                                *
 * 3) Integrate MIDI playing without keyRelease() logic.                                          *
 *                                                                                                *
 * 4) If possible, add data visualization module.                                                 *
 *                                                                                                *
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
  
  8, 8, 8, 8, 5,                        // System 1
  5, 8, 8, 8,                           // System 2
  8, 8, 8, 5, 5,                        // System 3
  8, 8, 5, 5,                           // System 4 (end of page 1)
  5, 5, 5, 5, 5,                        // System 5 (beginning of page 2)
  5, 8, 8, 8,                           // System 6
  8, 8, 8, 8,                           // System 7 (end of page 2)
  5, 5, 5, 5,                           // System 8 (beginning of page 3)
  8, 8, 8                               // System 9 (end of page 3)
};

// Declare and populate array with values representing the
// last system shown on screen after each measure is revealed.

int[] lastSystemShown = {
  0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3,    // Page 1
  4, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6,                   // Page 2
  7, 7, 7, 7, 8, 8, 8                                      // Page 3
  
};

// Declare and populate array with values representing the
// index of the first system appearing on each page for each
// measure that is revealed.

int[] whichPage = {
  
  0, 0, 0, 0, 0,        // Page 1
  0, 0, 0, 0,
  0, 0, 0, 0, 0,
  0, 0, 0, 0,
  4, 4, 4, 4, 4,        // Page 2
  4, 4, 4, 4,
  4, 4, 4, 4,
  7, 7, 7, 7,           // Page 3
  7, 7, 7
};

// Declare and populate array with values representing the X-coordinate
// offset for placement of each musical system.

int[] systemX = {
  
  65, 20, 20, 20,    // Page 1
  20, 20, 20,        // Page 2
  20, 20             // Page 3
  
};

// Declare and populate array with values representing the Y-coordinate
// offset for placement of each musical system.

int[] systemY = {
  
  105, 205, 400, 600,  // Page 1
  105, 300, 500,       // Page 2
  105, 300             // Page 3
};

// Measure X-coordinate offset for rectangle mask. Each row of elements represents
// the ending point in pixels for each measure so that the mask is offset to reveal
// the measure.

int[] measureX = {
  296, 413, 521, 638, 755,    // Page One
  281, 480, 648, 762,
  299, 427, 533, 642, 755,
  411, 553, 665, 764,
  296, 415, 528, 643, 765,    // Page Two
  282, 454, 627, 766,
  326, 459, 610,756, 
  330, 465, 603,755,          // Page Three
  426,648,765
};

// Stores value for the current measure in the sequence as it plays.

int measure = 0;

// Declare object of loadScore type

// loadScore loadAnarchia;

void setup() {
  
  // Set size of sketch window.

  size(800, 800);
  
  // Instantiate loadScore object

  //loadAnarchia = new loadScore(anarchiaSystems[9], "anarchia-system");

  PImage[] anarchiaSystems = new PImage[9];
  
  // Populate array.
  
  for (int i = 0; i < anarchiaSystems.length; i++) {
      
      // Load all PImages into array.
     
      anarchiaSystems[i] = loadImage( "anarchia-system" + (i + 1) + ".png" );
      
    }  // end for
    
    // Initialize MIDI Synthesizer, load sequence and start MIDI sequencer.
    
    listDevices(); // list valid MIDI devices
    
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
      
      beats = beats - meterMap[i];
      
      if (beats<0) {
        
        measure = i; // this is kind of the most important line in the whole thing
        
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
  
}  // end draw()
