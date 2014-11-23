/*

  Library of Classes Necessary for music_play application

*/

class Staff {
  
  // Properties of staff
 
  private  float lineLength;        // Length of each staff line
  private  float lineSpacing;       // Spacing between each staff line
  private  float spaceAfter;        // Space between staves
  
  // Constructor
  
  Staff(float line, float spacing, float gap) {
    
   lineLength = line;
   lineSpacing = spacing;
   spaceAfter = gap; 
    
  }
  
  // Member methods
  
  void staffDraw() {
    
    //int lineCount;      // iterator
    
    for (int lineCount = 0; lineCount <= 4; lineCount++) {
    
      line(width + 10, height + 10, lineLength - (width + 10), height + 10);
    
    }
    
  }
  
}
