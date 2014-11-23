// Adapted from code at the following URL:

// http://jexp.ru/index.php/Java_Tutorial/Development/MIDI_Sound#Load_and_play_Midi_audio

// This code throws unhandled exception that I have no idea
// how to fix.

import javax.sound.midi.MidiDevice;
import javax.sound.midi.MidiSystem;
import javax.sound.midi.MidiUnavailableException;
import javax.sound.midi.Sequence;
import javax.sound.midi.Sequencer;

Sequence entrance = MidiSystem.getSequence(new File("anarchia-entrance.mid"));

Sequencer myMIDI = MidiSystem.getSequencer();
myMIDI.open();
myMIDI.setSequence(entrance);
myMIDI.start();
