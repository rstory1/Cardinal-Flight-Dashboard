///////////////////////////////////////////////////////
//                                                   //
//        CARDINAL FLIGHT TELEMETRY DASHBOARD        //
//                  V3.0 01/23/2017                  //
//                                                   //
///////////////////////////////////////////////////////

float[] borders = {10,20,30,40,50,60,70,80,90 };
float minValue = 10;
float maxValue = 90;
float redGreenValue = 25;
float greenRedValue = 60;
float startAngle = 150;
float spanAngle = 240;
float[] localAngles = {0,0,0,0,0,0,0,0,0};
float a;
float b;
float oldWidth;
float oldHeight;
float gaugeDiameter;
int numOfGauges;

circularGauge amps = new circularGauge(300, "Amperage (A)", "Out", "In");
circularGauge volts = new circularGauge(300, "Voltage (V)", "Out", "In");
circularGauge watts = new circularGauge(300, "Wattage (W)", "Out", "In");


void setup() {
  size(1000, 1000);
  oldWidth = width;
  oldHeight = height;
  surface.setResizable(true); 
  noStroke();
  //noLoop();  // Run once and stop
  for (int i = 0; i < borders.length; i = i+1) {
    localAngles[i]=calculateLocalValue(borders[i]);
  }
  
  numOfGauges = 3;
  gaugeDiameter = 300;
  
  if ((numOfGauges*gaugeDiameter)<=width) {
    amps.setCenter((width/2)-(gaugeDiameter)-(0.02*width), (1.553*gaugeDiameter)/2);
    volts.setCenter(width/2, (1.553*gaugeDiameter)/2);
    watts.setCenter((width/2)+(gaugeDiameter)+(0.02*width), (1.553*gaugeDiameter)/2);    
  }
  
  
}

void draw() {
  if (oldWidth != width) {
    amps.setCenter((width/2)-(gaugeDiameter)-(0.02*width), (1.553*gaugeDiameter)/2);
    volts.setCenter(width/2, (1.553*gaugeDiameter)/2);
    watts.setCenter((width/2)+(gaugeDiameter)+(0.02*width), (1.553*gaugeDiameter)/2);
  }
  
  background(100);
  a = mouseX;
  b = mouseY;
  amps.update();
  volts.update();
  watts.update();
}

float calculateLocalValue(float value) {
    return startAngle+((value-minValue)/(maxValue-minValue)*spanAngle);
}