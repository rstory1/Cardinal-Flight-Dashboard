class graphBox {
  // Set the width and height of the window to make
  int windowWidth = 400;
  int windowHeight = 300;
  float maxValue; //Maximum value expected to read
  float minValue; //Min value expected to read
  float[] readings;
    
  void setup(float w, float h, float min, float max)
  {
    windowWidth = int(w);
    windowHeight = int(h);
    minValue = min;
    maxValue = max;
    readings = new float[windowWidth]; // initialized to zeroes
  }
   
  void update()
  {
    pushMatrix();
    //stroke(255,0,0);  // stroke will be red on dots plotted
    //fill(255,0,0);  // fill will be red on dots plotted
    
    //background(255);  // Sets the background to white and clears screen each time through loop
    readings[windowWidth - 1] = mouseY; // Put the new value in the last spot of the array
     
    // Map the element so it fits in our graph
    readings[windowWidth - 1] = map(readings[windowWidth - 1], 0, maxValue, 0, windowHeight);
     
    // Plot all the points
    for (int i = 0; i < windowWidth - 1; i++)
    {
      if (readings[i] != 0) // Don't plot anything at zero, as that's the default value in the array
      {
        ellipse(i, height - readings[i], 3, 3); //<>//
      }
      readings[i] = readings[i + 1]; // Shift the readings to the left so can put the newest reading in
    }  
    popMatrix();
  }
}