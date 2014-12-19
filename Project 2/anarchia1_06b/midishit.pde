/*********************************************************************************
 *                                                                               *
 * midishit:                                                                     *
 *                                                                               *
 * This module provides all MIDI functions to this program, and was written by   *
 * R. Luke DuBois, with additional documentation provided by me.                 *
 *                                                                               *
 *********************************************************************************
*/

// listDevices() function tests for the presence of system MIDI devices
// and then prints out the information for the default MIDI device
// to the console. This was used only during testing phases and is not
// invoked in this program.

void listDevices() {
  
  try {
    
    MidiDevice.Info[] midiDeviceInfoArray = MidiSystem.getMidiDeviceInfo();
    
    for ( MidiDevice.Info midiDeviceInfo : midiDeviceInfoArray ) {
      
      System.out.println("Next device:");
      System.out.println("  Name: " + midiDeviceInfo.getName());
      System.out.println("  Description: " + midiDeviceInfo.getDescription());
      System.out.println("  Vendor: " + midiDeviceInfo.getVendor());
      System.out.println("  toString(): " + midiDeviceInfo.toString());
      System.out.println("");
      
    }  // end for
    
  }  // end try

  catch (Exception e) {
    
    e.printStackTrace();  // Prints out stack trace error message to console.
    
  }  // end catch
  
}  // end listDevices()


// startMidiSynth() function looks for default MIDI synthesizer on
// system, opens it and initializes the MIDI channels for the device.

void startMidiSynth() {
  
  // Open the default synthesizer from the MIDI system.
  
  try {
    
    synth = MidiSystem.getSynthesizer();  // Instantiate synthesizer object.
    
    synth.open();                        //  Initialize synthesizer.
    
    channels = synth.getChannels();      // Initialize MIDI channels.
    
  }  // end try
  
  catch (Exception e) {
    
    e.printStackTrace();              // Print stack trace error to console.
    
  }  // end catch
  
}  // end startMidiSynth()


// initSequencer() function instantiates a sequencer object which
// provides the MIDI sequence for the synthesizer object. The
// sequencer object is then initialized and a file handle is created
// to point to a MIDI file. Finally a boolean value sequenceIsLoaded
// is set to true for evaluation of a conditional statement that
// initiates play of the sequence.

void initSequencer(String filename) {
  
  // Load a MIDI file into a sequencer.
  
  try {
    
    seq = MidiSystem.getSequencer();                // Declare handle to sequencer.
    
    seq.open();                                     // Initialize sequencer.

    // File handle for MIDI file:
    
    File myMidiFile = new File(dataPath(filename)); // File must be in data folder.
    
    // Sequence object loads file:
    
    Sequence mySeq = MidiSystem.getSequence(myMidiFile);
    
    // Sequencer uses sequence:
    
    seq.setSequence(mySeq);                        // Load MIDI file.
    
    sequenceIsLoaded = true;                      //  Set sequenceIsLoaded boolean to true.
    
  }  // end try
  
  catch (Exception e) {
    
    e.printStackTrace();                        // Print stack trace error to console.
    
  }  // end catch
}


// stopMidiSynth() function shuts down the synthesizer object and releases
// its associated system resources.

void stopMidiSynth() {
  
  synth.close();
  
}  // end stopMidiSynth()
