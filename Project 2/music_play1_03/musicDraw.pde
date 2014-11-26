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
     //titleFace = loadFont("HelveticaNeue-Thin-24.vlw");
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
      //subTitle = loadFont("HelveticaNeue-Thin-24.vlw");
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
     
     byLineType = createFont("GoudySansITCbyBT Light", 14);
     textFont(byLineType);
     
   }  // end credLine constructor
   
   void byDraw() {
     
     textAlign(RIGHT);
     
     text(nameString, width - 50, yPos);
     
   }  // end writeByLine
  
}  // end credLine

/*class Staff {
  
  float above;  // Define the space above the staff.
  
  Staff(float spaceAbove) {
   
    above = spaceAbove; 
   
  }  // end constructor
  
    void drawStaff() {
      
      smooth();  // Invoke antialiasing.
      
      // Loop to draw lines of staff
    
    
      for (int lineCount = 0; lineCount <= 5; lineCount++) {
      
        if (lineCount == 0) {
          
            line(width - 750, above, width - 50, above);      
          
        }  else {
          
             line(width - 750, above, width - 50, above);
             above += 8.;
             
        }  // end if-else
        
      }  // end for
    
    }  // end drawStaff 
      
  }  // end Staff
  
class barLine {
  
  // This class models a barline that both delimits
  // measures and unites systems of staves.
 
 float x1;  // Beginning X-coordinate
 float y1;  // Beginning Y-coordinate
 float x2;  // Ending X-coordinate
 float y2;  // Ending Y-coordinate

 barLine(float xPos1, float yPos1, float xPos2, float yPos2) {
  
   x1 = xPos1;
   y1 = yPos1;
   x2 = xPos2;
   y2 = yPos2;
  
 }  // end barLine construcor

 void lineRender() {
  
    line(x1, y1, x2, y2);  // Renders line.
    smooth();              // Invokes antialiasing.
  
 } 
  
}  // end class barLine */
