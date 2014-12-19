/*
 **************************************************************************************************
 *                                                                                                *
 * transition_4:                                                                                  *
 *                                                                                                *
 * Programmer: Robert Hieger                                                                      *
 * transition_4 v1.0                                                                              *
 *                                                                                                *
 * Begun: December 17, 2014                                                                       *
 * Completed: December 18, 2014                                                                   *
 *                                                                                                *
 * Program Objective:                                                                             *
 *                                                                                                *
 * Create a stub program that plays Anarchia Transition #4.                                       *
 *                                                                                                *
 * Flaws in Version 1:                                                                            *
 *                                                                                                *
 * 1) Sound balance between flute and piano is wrong. Piano sounds muffled.                       *
 *                                                                                                *
 * 2) One portion of piano accompinament holds sustain pedal over several measures                *
 *    producing a muddle of chords. Possibly fault of MIDI file.                                  *
 *                                                                                                *
 * 3) Missing implementation for animation of musical notation.                                   *
 *                                                                                                *
 * ACKNOWLEDGMENT:                                                                                *
 *                                                                                                *
 * I am indebted to R. Luke DuBois for his contribution of his humorously named "midishit"        *
 * module, which provides a Java library-based implementation allowing the load and playback      *
 * of a MIDI file using the synthesizer subsystem of the operating system.                        *
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

Synthesizer synth;
MidiChannel[] channels;
Sequencer seq;

PFont pf;

int[] metermap = {
  6, 6, 6, 6,
  6, 6, 6, 6,
  6, 6, 6, 6,
  6, 6, 6, 6,
  6, 6, 6, 6,
  6, 6, 6, 6,
  6, 6, 6, 6,
  6, 6, 6, 6,
  6, 6, 6, 6,
  6, 6, 6, 6
};

void setup()
{
  size(400, 400);

  //listDevices(); // list valid MIDI devices
  startMidiSynth(); // start the internal MIDI synth
  
  // start the sequencer and load the MIDI file:
  initSequencer("transition4.mid"); 

  pf = createFont("Georgia", 48);
  textFont(pf);
}

void stop()
{
  seq.stop(); // stop the sequence (doesn't hurt even if it's not playing)
  stopMidiSynth(); // shut down the synthesizer
}

void draw()
{
  background(0);
  if (seq.isRunning())
  {
    int ppq = seq.getSequence().getResolution(); // how many ticks per quarter?
    long playheadraw = seq.getTickPosition(); // how many ticks are we into the file?
    int beats = int(playheadraw/ppq); // which quarter note are we on?
    int measure = 0; // which measure am i on?
    for(int i = 0; i < metermap.length; i++)
    { 
      beats = beats - metermap[i];
      if(beats < 0)
      {
        measure = i;
        break; 
      }
        
    }
    
    text("Measure " + (measure + 1), 75, 100);
  }
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
