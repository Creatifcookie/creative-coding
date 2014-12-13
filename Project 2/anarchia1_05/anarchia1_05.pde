/*
 **************************************************************************************************
 *                                                                                                *
 * anarchia: (formerly music_play) new code branch                                                *
 *                                                                                                *
 * Programmer: Robert Hieger                                                                      *
 * Music Play v1.05                                                                               *
 *                                                                                                *
 * Begun: December 9, 2014                                                                        *
 * Completed: December 12, 2014                                                                   *
 *                                                                                                *
 * Program Objectives:                                                                            *
 *                                                                                                *
 * 1) Play a simple midi-based composition.                                                       *
 * 2) Display sheet music in sync with the music as it plays.                                     *
 * 3) Change background display in response to frequency and rhythm.                              *
 *    NOTE: This feature may go to a wishlist in the interest of time.                            *
 *                                                                                                *
 * In version 1.05, my goals are to:                                                              *
 *                                                                                                *
 * 1) Finish PImage progressive reveal of music systems.                                          *
 *                                                                                                *
 * 2) Add class to draw year written credit.                                                      *
 *                                                                                                *
 * 3) Integrate MIDI playing without keyRelease() logic.                                          *
 *                                                                                                *
 **************************************************************************************************
 */

// JAVA IMPORTS FOR MIDI SUPPORT
import javax.sound.midi.MidiSystem;
import javax.sound.midi.MidiDevice;
import javax.sound.midi.MidiDevice.Info;
import javax.sound.midi.Synthesizer;
import javax.sound.midi.MidiChannel;
import javax.sound.midi.Sequence;
import javax.sound.midi.Sequencer;

// MIDI stuff
Synthesizer synth;
MidiChannel[] channels;
Sequencer seq;

// these are the number of eighth notes per measure
int[] metermap = {
  8, 8, 8, 8, 5, 5, 8, 8, 8, 8, 8, 8, 5, 5, 8, 8, 5, 5,
  5, 5, 5, 5, 5, 5, 8, 8, 8, 8, 8, 8, 8, 
  5, 5, 5, 5, 8, 8, 8
};

// this is the last system shown, indexed by measure
int[] lastsystemshown = {
  0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3,
  4, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6,
  7, 7, 7, 7, 8, 8, 8
  
};

// this is the starting system of each page, indexed by measure
int[] whichpage = {
  0, 0, 0, 0, 0,        // Page One
  0, 0, 0, 0,
  0, 0, 0, 0, 0,
  0, 0, 0, 0,
  4, 4, 4, 4, 4,        // Page Two
  4, 4, 4, 4,
  4, 4, 4, 4,
  7, 7, 7, 7,          // Page Three
  7, 7, 7
};

// these are the X offsets for the system images
int[] systemX = {
  65, 20, 20, 20,
  20, 20, 20,
  20, 20
};

// these are the Y offsets for the system images
int[] systemY = {
  105, 205, 400, 600,
  105, 300, 500,
  105, 300
};

// Measure X offset for rectangle mask
// Each row of elements represents the ending point
// in pixels for each measure so that the mask is
// offset to reveal the measure.

int[] measureX = {
  296, 413, 521, 638, 755,    // Page One
  281, 480, 648, 762,
  299, 427, 533, 642, 755,
  411, 553, 665, 764,
  296, 415, 528, 643, 765,    // Page Two
  282, 454, 627, 766,
  326, 459, 610,756, 
  330, 465, 604,755,          // Page Three
  426,649,765
};

int measure = 0; // this is the current measure on the sequence


// Declare PImage Array

PImage[] anarchiaSystems = new PImage[9];

void setup() {

  // Set size of window.

  size(800, 800);
  background(255);      // White

  // Load music systems to anarchiaSystems PImage Array. This is brute force approach.
  // My aim will be to abstract this into a class as well so that it may be 

  for (int i = 0; i < anarchiaSystems.length; i++) {

    // Populate array with images anarchia-system1.jpg through anarchia-system9.jpg.

    anarchiaSystems[i] = loadImage("anarchia-system" + (i + 1) + ".png");

    //println( "Loaded" + loadImage("anarchia-system" + (i + 1) + ".png") );
  }  // end for*/

  // MIDI INITIALIZATION CODE
  listDevices(); // list valid MIDI devices
  startMidiSynth(); // start the internal MIDI synth

    // start the sequencer and load the MIDI file:
  initSequencer("Act One Entrance.mid");
}

void draw() 
{

  // FIGURE OUT CURRENT MEASURE IN MIDI
  if (seq.isRunning())
  {
    int ppq = seq.getSequence().getResolution()/2; // how many ticks per eighth?
    long playheadraw = seq.getTickPosition(); // how many ticks are we into the file?
    int beats = int(playheadraw/ppq); // which eighth note are we on?
    measure = 0; // which measure am i on?
    for (int i = 0; i<metermap.length; i++) // RTSKED(ish)
    { 
      beats = beats - metermap[i];
      if (beats<0)
      {
        measure = i; // this is kind of the most important line in the whole thing
        break;
      }
    }
  }

  // DRAWING CODE
  background(255);
  Name Title = new Name("Anarchia Entrance Theme", 40.);

  Title.drawHead();

  subName subTitle = new subName("from Anarchia, by Hanon Reznikov, The Living Theatre", 60.);

  subTitle.drawSub();
  
  // Insert year written credit
  
  yearWritten written = new yearWritten("written 1995", 100.);
  
  written.drawYear();

  // Insert By-Line Credit

  credLine byLine = new credLine("music by Robert Hieger", 100.);

  byLine.byDraw();


  // MAIN SYSTEMS OF MUSIC

  fill(255);    // Set fill of rectangle to white, same as sketch
  noStroke();  //  Set stroke width to 0 for rectangle.  

  for (int i = 0; i<anarchiaSystems.length; i++)
  {
    if(whichpage[measure]>=i) rect(0, 105, width, height);
    if (lastsystemshown[measure]>=i) image(anarchiaSystems[i], systemX[i], systemY[i]); 
    if (lastsystemshown[measure]==i) {
      rect(measureX[measure], systemY[i], anarchiaSystems[i].width, anarchiaSystems[i].height);
    }
  }




  /*****************************************************************
   *  
   * Adapted from code kindly provided by Luke DuBois
   *
   * 1) Create white rectangle to mask music system
   *
   * 2) Progressively reveal music system synchronized to MIDI file
   *
   *****************************************************************
   */




  //println(measure);
  println(mouseX);
  // Draw static rectangle over first system.
}


void stop()
{
  seq.stop(); // stop the sequence (doesn't hurt even if it's not playing)
  stopMidiSynth(); // shut down the synthesizer
}


void keyReleased()
{
  if (seq.isRunning()) { // are we already playing?
    seq.stop(); // stop
  } else
  {
    seq.setTickPosition(0); // rewind
    seq.start(); // start
  }
}

