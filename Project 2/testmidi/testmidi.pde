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

int[] metermap = {8, 8, 8, 8, 5, 5, 8, 8, 8, 8, 8, 8, 5, 5, 8, 8, 5, 5};

void setup()
{
  size(400, 400);

  listDevices(); // list valid MIDI devices
  startMidiSynth(); // start the internal MIDI synth
  
  // start the sequencer and load the MIDI file:
  initSequencer("Act One Entrance.mid"); 

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
    int ppq = seq.getSequence().getResolution()/2; // how many ticks per eighth?
    long playheadraw = seq.getTickPosition(); // how many ticks are we into the file?
    int beats = int(playheadraw/ppq); // which eighth note are we on?
    int measure = 0; // which measure am i on?
    for(int i = 0;i<metermap.length;i++)
    { 
      beats = beats - metermap[i];
      if(beats<0)
      {
        measure = i;
        break; 
      }
        
    }
    
    text(measure, 100, 100);
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

