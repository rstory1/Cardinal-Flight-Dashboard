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

ADLinechart ampsGraph;
ADLinechart voltsGraph;
ADLinechart wattsGraph;
ADLinechart tempsGraph;
timer t;
int i=0, delta=1;
int dataSets=1;

circularGauge amps = new circularGauge(300, "Amperage (A)", "Out", "In");
circularGauge volts = new circularGauge(300, "Voltage (V)", "Out", "In");
circularGauge watts = new circularGauge(300, "Wattage (W)", "Out", "In");
barGraph temps = new barGraph(10, 200, "Temps", 1500, 50);

//graphBox ampsGraph = new graphBox();

void setup() {
  size(1800, 1000);
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
    amps.setCenter((width/2)-(gaugeDiameter)-(0.02*width), (1.553*gaugeDiameter)/2+125);
    volts.setCenter(width/2, (1.553*gaugeDiameter)/2+125);
    watts.setCenter((width/2)+(gaugeDiameter)+(0.02*width), (1.553*gaugeDiameter)/2+125);    
  }
  
  t = new timer(1000);
  ampsGraph = new ADLinechart(30,675,300,320,"Data Set 1");
  voltsGraph = new ADLinechart(350,675,300,320,"Data Set 1");
  wattsGraph = new ADLinechart(700,675,300,320,"Data Set 1");
  tempsGraph = new ADLinechart(1050,675,300,320,"Data Set 1");
  //lineGraph.showTitle();
  ampsGraph.showYlabel();
  voltsGraph.showYlabel();
  wattsGraph.showYlabel();
  tempsGraph.showYlabel();
  //lineGraph.showXlabel();
  //lineGraph.setDebugOn();
  ampsGraph.addDataSet("2");
  //lineGraph.hideShadow();
  
  //ampsGraph.setup(200,50,0,20);
  
}

void draw() {
  if (oldWidth != width) {
    amps.setCenter((width/2)-(gaugeDiameter)-(0.02*width), (1.553*gaugeDiameter)/2);
    volts.setCenter(width/2, (1.553*gaugeDiameter)/2);
    watts.setCenter((width/2)+(gaugeDiameter)+(0.02*width), (1.553*gaugeDiameter)/2);
  }
  
  background(0);
  a = mouseX;
  b = mouseY;
  amps.update();
  volts.update();
  watts.update();
  temps.update();
  
  drawGraph();
}

float calculateLocalValue(float value) {
    return startAngle+((value-minValue)/(maxValue-minValue)*spanAngle);
}

void drawGraph()
{
  if (t.over())
  {
    ampsGraph.pushValue(mouseY,i,0);    
    ampsGraph.pushValue(mouseX,i,1);
    voltsGraph.pushValue(mouseY,i,0);    
    voltsGraph.pushValue(mouseX,i,1);
    wattsGraph.pushValue(mouseY,i,0);    
    wattsGraph.pushValue(mouseX,i,1);
    tempsGraph.pushValue(mouseY,i,0);    
    tempsGraph.pushValue(mouseX,i,1);
    i+=delta;
    t.reset();
  }
  ampsGraph.update();
  voltsGraph.update();
  wattsGraph.update();
  tempsGraph.update();
}