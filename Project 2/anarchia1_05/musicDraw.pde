/*
 * musicDraw Library:
 *
 * Contained within this library are the classes responsible for drawing the page title,
 * subtitle, and by-line. Additionally, it includes the classes that draw individual
 * systems of music notation and methods to mask and reveal portions of music systems
 * in time to the music played by the midiLib module.
*/


// The Name class may be instantiated to create and place a title on the first sheet
// of music. It takes two parameters--the String name and a float vertPos, which stores
// the y-Coordinate of the title in the instantiated object.

class Name {
  
  PFont titleFace;        // Declare font object.

  String nameString;  // title
  float yPos;         // y-Coordinate
  
  Name(String name, float vertPos) {

    titleFace = createFont("HelveticaNeue Thin", 28);
    textFont(titleFace);
    fill(0);
     
     nameString = name;
     yPos = vertPos; 
      
  }  // end constructor
 
 // Class Method

  void drawHead() {
   
    textAlign(CENTER);
    text(nameString, width/2, yPos );
    //smooth();
   
  }  // end drawHead()
  
}  // end Name

// The subName class may be instantiated to create and place a subtitle on the first sheet of
// music. It, too, takes two parameters--the String name and a float vertPos, which stores the
// y-Coordinate of the title in the instantiated object.

class subName {
  
  String subTitString;  // String to hold subtitle
  float yPos;           // Float to store y-Coordinate
  
  subName(String sub, float vertPos) {
    
      subTitString = sub;
      yPos = vertPos;
      
      PFont subTitle;      // Subtitle Typeface
      subTitle = createFont("HelveticaNeue Thin", 16);
      textFont(subTitle);
    
  }  // end constructor
  
  void drawSub() {
    
      textAlign(CENTER);
      
      text(subTitString, width/2, yPos);
      smooth();
    
  }  // end drawSub()
  
}  // end class SubName

// The credLine class renders by-line credit underneath and right-aligned to the Name class.

class credLine {
  
   String nameString;  // Author name
   float yPos;        // Y-coordinate
   
   // credLine constructor
   
   credLine(String name, float yCoord) {
     
     nameString = name;
     yPos = yCoord;
     
     PFont byLineType;
     
     byLineType = createFont("Adobe Naskh", 26);
     textFont(byLineType);
     
   }  // end credLine constructor
   
   void byDraw() {
     
     textAlign(RIGHT);
     
     text(nameString, width - 50, yPos);
     
   }  // end writeByLine
  
}  // end credLine

class makeMusic {
  
  // Constructor
  
  makeMusic(PImage[] arrayName, int numElements) {
    
    //PImage[] name = arrayName[
    
  }  // end constructor */
  
} // end makeMusic
