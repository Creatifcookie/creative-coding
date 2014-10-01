/*

Project #1: book-reader
Version 1
Programmer: Robert Hieger

Based on in-class code examples by R. Luke DuBois
This current first revision is based on A_loadtextfile
from our Session #3 class. For this example, I have
chosen Treasure Island, by Robert Louis Stevenson

Project Requirements:

1) Reasonable and readable formatting in a reasonably-sized
   window for text display.
2) Navigation Page Up, Page Down
3) Exit feature

Wish List:

1) Jump to Chapter
2) Jump to Page

BELOW IS THE CODE FROM A_loadtextfile (R. Luke DuBois) with
minor revisions for purposes of study and adaptation of the
code to load 
Treasure Island.

*/

// load a text file and spit it out again, all cleaned up
// no draw() loop

int currentline = 0;
String[] raw;
void setup()
{
  //
  // step 1: load the text file 
  //

  raw = loadStrings("treasure-island-raw.txt");
  printarray(raw);
}

void draw()
{
  
}


// NOT SURE HOW THIS WORKS. ASK.

void printarray(String[] p)
{
  for (int i= 0; i<p.length; i++)
  {
    println(p[i]);
  }
}

void keyPressed()
{
   println(raw[currentline] + "\tLine #" + currentline);
   currentline = (currentline+1) % raw.length;
}
