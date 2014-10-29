// My first attempts at abstracting functions to objects
// for music drawing subsystem.

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
