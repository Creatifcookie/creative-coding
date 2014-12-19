
void listDevices()
{
  try {
    MidiDevice.Info[] midiDeviceInfoArray = MidiSystem.getMidiDeviceInfo();
    for ( MidiDevice.Info midiDeviceInfo : midiDeviceInfoArray ) {
      System.out.println("Next device:");
      System.out.println("  Name: " + midiDeviceInfo.getName());
      System.out.println("  Description: " + midiDeviceInfo.getDescription());
      System.out.println("  Vendor: " + midiDeviceInfo.getVendor());
      System.out.println("  toString(): " + midiDeviceInfo.toString());
      System.out.println("");
    }
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

void startMidiSynth()
{
  // open the default synthesizer from the MIDI system
  try {
    synth = MidiSystem.getSynthesizer();
    synth.open();
    channels = synth.getChannels();
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

void initSequencer(String filename)
{
  // load a MIDI file into a sequencer
  try {
    seq = MidiSystem.getSequencer();
    seq.open();

    // file reference for MIDI file:
    File myMidiFile = new File(dataPath(filename)); // file must be in data folder
    // sequence object loads file:
    Sequence mySeq = MidiSystem.getSequence(myMidiFile);
    // sequencer uses sequence:
    seq.setSequence(mySeq);
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

void stopMidiSynth()
{
  synth.close(); // shut off synthesizer and release system resources
}

