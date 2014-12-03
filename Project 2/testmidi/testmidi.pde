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
    int ppq = seq.getSequence().getResolution(); // how many ticks per quarter?
    long playheadraw = seq.getTickPosition(); // how many ticks are we into the file?
    int beats = int(playheadraw/ppq); // which quarter note are we on?
    text(beats, 100, 100);
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

