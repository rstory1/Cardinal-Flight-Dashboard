class circularGauge {
  float diameter;
  String gaugeName;
  String leftValueName;
  String rightValueName;
  float centerX;
  float centerY;
  
  circularGauge (float d, String name, String leftName, String rightName) {
    diameter = d;
    gaugeName = name;
    leftValueName = leftName;
    rightValueName = rightName; //<>//
  }
  
  void setCenter(float x, float y) {
    centerX = x;
    centerY = y;
  }
  
  void setDiameter(float d) {
    diameter = d;
  }
  
  void update() {
    //checkGaugeFit(diameter);
    textSize(diameter/10);
    textAlign(CENTER, CENTER);
    
    float lastAngle = radians(startAngle); //<>//
    fill(255,255,255);
    ellipse(centerX, centerY, diameter, diameter);
    
    fill(255,0,0);
    arc(centerX, centerY, diameter, diameter, lastAngle, radians(calculateLocalValue(redGreenValue)));
    arc(centerX, centerY, diameter, diameter, radians(calculateLocalValue(greenRedValue)), radians(startAngle+spanAngle));
    
    fill(255,255,255);
    ellipse(centerX, centerY, .85*diameter, .85*diameter); //<>//
    
    fill(255,165,0);
    
    ellipse(centerX, centerY, 0.1*diameter, 0.1*diameter);
    
    pushMatrix();
    translate(centerX,centerY);
    rotate(radians(calculateLocalValue(a-b)+90));
    //rotate(frameCount*radians(90) / 20);
    //translate(0, -60);
    triangle(-(0.1*diameter)/2, 0, 0, -0.5*diameter, (0.1*diameter)/2, 0);
    popMatrix();
    
    fill(255,255,255);
    rect(centerX-(diameter/2), (centerY)+(diameter/2),diameter/3, (diameter/6));
    fill(255,0,0);
    text(str(a), centerX-(diameter/2), (centerY)+(diameter/2),diameter/3,(diameter/6));
    text(leftValueName, centerX-(diameter/2), (centerY)+(diameter/1.5),diameter/3,(diameter/6));
    
    fill(255,255,255);
    rect(centerX+(diameter/6), centerY+(diameter/2),diameter/3, diameter/6);
    fill(255,0,0);
    //textSize(30);
    text(str(b), centerX+(diameter/6), centerY+(diameter/2),diameter/3,diameter/6);
    text(rightValueName, centerX+(diameter/6), centerY+(diameter/1.5),diameter/3,diameter/6);
    
    fill(255,255,255);
    rect(centerX-(diameter/2), centerY-(0.72*diameter),(centerX+(diameter/2))-((centerX)-(diameter/2)),(diameter/6));
    fill(255,0,0);
    text(gaugeName, centerX-(diameter/2), centerY-(0.72*diameter),(centerX+(diameter/2))-((centerX)-(diameter/2)),(diameter/6));
  }
  
  //void checkGaugeFit(float d) {
  //  // If the width of the window is less than the diameter of the gauge, then make the gauge diameter smaller
  //  if (width<d) {
  //    setDiameter(width);
  //  }
  //}
}