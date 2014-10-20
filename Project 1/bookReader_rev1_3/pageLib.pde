/* Page and Book Library
 *
 * This library of classes will contain classes that load a splash screen,
 * define and load raw text of a book into an array of strings, and
 * load and define boundaries of each page within a book.
 *
*/



class Book {
  
  private String[] book;
  
  // Constructor
  
  Book(String name) {
  
  title = name;
  
  }  // end Book(String name)

  // Member methods

  void load() {
   
  loadStrings = book(title);
  
  }  // end create()
    
}  // end Book
