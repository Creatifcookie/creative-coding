// My first attempts at abstracting functions to objects
// for music drawing subsystem.

// The Name class may be instantiated to create and place a title on the first sheet
// of music. It takes two parameters--the String name and a float vertPos, which stores
// the y-Coordinate of the title in the instantiated object.

class Name {
  
  String nameString;  // title
  float yPos;         // y-Coordinate
  
  Name(String name, float vertPos) {
   
      nameString = name;
      yPos = vertPos; 
      
  }  // end constructor
 
 // Class Method

  void drawHead() {
   
    text(nameString, ((width / 2) -nameString.length()) /2, yPos);
   
  }  // end drawHead()
  
}  // end Name

// The credLine class renders by-line credit underneath and right-aligned to the Name class.

class credLine {
  
   String nameString;  // Author name
   float yPos;        // Y-coordinate
   float xPos;        // X-coordinate
   
   // credLine constructor
   
   credLine(String name, float yCoord, float xCoord) {
     
     nameString = name;
     yPos = yCoord;
     xPos = xCoord; 
     
   }  // end credLine constructor
   
   void writeByLine() {
     
     text("By " + nameString,  yPos, xPos);
     
   }  // end writeByLine
  
}  // end credLine

// The Staff class creates a staff positioned with passed parameters and draws the
// staff centered horizontally on the page given a page width of 800 pixels with
// a 50 pixel margin on either side of the staff.

class Staff {
  
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
  
}  // end class barLine
