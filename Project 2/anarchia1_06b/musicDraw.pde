/*******************************************************************************************
 *                                                                                         *
 * musicDraw Library:                                                                      *
 *                                                                                         *
 * Contained within this library are the classes responsible for drawing the page title,   *
 * subtitle, year written and by-line.                                                     *
 *                                                                                         *
 *******************************************************************************************
*/


// The Name class may be instantiated to create and place a title on the first sheet
// of music. It takes two parameters--the String name and a float vertPos, which stores
// the y-Coordinate of the title in the instantiated object.

class Name {
  
  PFont titleFace;        // Declare font object.

  String nameString;  // title
  float yPos;         // y-Coordinate
  
  // Name constructor
  
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
  
  // subName constructor
  
  subName(String sub, float vertPos) {
    
      subTitString = sub;
      yPos = vertPos;
      
      PFont subTitle;      // Subtitle Typeface
      subTitle = createFont("HelveticaNeue Thin", 16);
      textFont(subTitle);
    
  }  // end constructor
  
  // Class method
  
  void drawSub() {
    
      textAlign(CENTER);
      
      text(subTitString, width/2, yPos);
    
  }  // end drawSub()
  
}  // end class SubName


// the yearWritten class renders the year written credit underneath and left-aligned to the Name
// and subName classes

class yearWritten {
  
  String yearString;    // Year written
  float yPos;           //
 
 // yearWritten consturctor
 
 yearWritten(String year, float vertPos) {
   
   yearString = year;  // Set year to parameter value.
   yPos = vertPos;    // Set Y-coordinate to parameter value.
   
   // Define and size font for year written credit
   
   PFont yearType;    // Declare PFont for year written typeface.
   
   yearType = createFont("Adobe Naskh", 26);
   textFont(yearType);
   
 }  // end yearWritten constructor
 
 // Class method
 
 void drawYear() {
   
  textAlign(LEFT);
  text(yearString, width - 710, yPos);
   
 }  // end drawYear()
 
}  // end yearWritten(String year, float vertPos)


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
   
   // Class method
   
   void byDraw() {
     
     textAlign(RIGHT);
     
     text(nameString, width - 50, yPos);
     
   }  // end writeByLine
  
}  // end credLine
