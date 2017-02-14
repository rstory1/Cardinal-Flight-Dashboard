///////////////////////////////////////////////////////
//                                                   //
//        CARDINAL FLIGHT TELEMETRY DASHBOARD        //
//                  V3.0 01/23/2017                  //
//                                                   //
///////////////////////////////////////////////////////

//----- DECLARATIONS ------------------------------ (0)
import processing.serial.*;

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
PImage img;  // Declare a variable to reference Header image
PFont font;  // Declare a variable to reference the Font
Table table; // Declare varible to reference Table

// Display Time & Date  
int sec = second(); // Values from 0 - 59
int min = minute(); // Values from 0 - 59
int h = hour();     // Values from 0 - 23
int d = day();      // Day of Month 1 - 31
int mon = month();  // Month of Year 1-12
int y = year();     // Year 20XX
 
String strsec = str(sec); //Convert int to String
String strmin = str(min); //    ''
String strh = str(h);     //    ''
String strd = str(d);     //    ''
String strmon = str(mon); //    ''
String stry = str(y);     //    ''
String time;
String date;

// Data received from the serial port:
float Var1 = 0;  
float Var2 = 0;  
float Var3 = 0;  
float Var4 = 0;  
float Var5 = 0;  
float Var6 = 0;  
float Var7 = 0;  
float Var8 = 0;  
float Var9 = 0;  
float Var10 = 0;  

Serial myPort; // The serial port

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
//barGraph temps = new barGraph(10, 200, "Temps", 1500, 50);

//graphBox ampsGraph = new graphBox();

void setup() {
  size(1800, 1000);
  oldWidth = width;
  oldHeight = height;
  surface.setResizable(true); 
  noStroke();
  //noLoop();  // Run once and stop
  
  background(0);
  
  img = loadImage("header2.png"); // Load Cardinal Flight Header Image
  
  for (int i = 0; i < borders.length; i = i+1) {
    localAngles[i]=calculateLocalValue(borders[i]);
  }
  
  numOfGauges = 3;
  gaugeDiameter = 300;
  
  if ((numOfGauges*gaugeDiameter)<=width) {
    amps.setCenter((width/2)-(gaugeDiameter)-(0.02*width), (1.553*gaugeDiameter)/2+140);
    volts.setCenter(width/2, (1.553*gaugeDiameter)/2+140);
    watts.setCenter((width/2)+(gaugeDiameter)+(0.02*width), (1.553*gaugeDiameter)/2+140);
  }
  
  //t = new timer(1000);
  //ampsGraph = new ADLinechart(30,675,300,320,"Data Set 1");
  //voltsGraph = new ADLinechart(350,675,300,320,"Data Set 1");
  //wattsGraph = new ADLinechart(700,675,300,320,"Data Set 1");
  //tempsGraph = new ADLinechart(1050,675,300,320,"Data Set 1");
  //ampsGraph.showYlabel();
  //voltsGraph.showYlabel();
  //wattsGraph.showYlabel();
  //tempsGraph.showYlabel();
  //ampsGraph.addDataSet("2");
  
  //--------------- .CSV TABLE ----- 
  table = new Table(); // Create a Table to Store Varibles
 
  table.addColumn("Time:");               // Column A Title 
  table.addColumn("Solar Voltage(V):");   // Column B Title  
  table.addColumn("Solar Amperage(mA):"); // Column C Title  
  table.addColumn("Solar Wattage(W):");   // Column D Title  
  table.addColumn("Final Voltage(V):");   // Column E Title  
  table.addColumn("Final Amperage(A):");  // Column F Title  
  table.addColumn("Final Wattage(W):");   // Column G Title  
  //--------------------------------   
  
  //------------- SERIAL SETUP ----- 
  if (Serial.list().length > 0) {
    printArray(Serial.list()); // List all the available serial ports
  
    // I know that the first port in the serial list on my mac
    // is always my  Arduino, so I open Serial.list()[0].
    // Open whatever port is the one you're using.
    myPort = new Serial(this, Serial.list()[0], 57600);
    // don't generate a serialEvent() unless you get a newline character:
    myPort.bufferUntil('\n');
  }
  //-------------------------------- 
  
}

void draw() {
  font = createFont("univers-black-italic-wd.ttf",48,true);
  textFont(font);
   
  //// Display Header Image 
  //image(img, (width/2)-(img.width/2), 0); // header2.png (Top-Centered)
  
  if (oldWidth != width) {
    amps.setCenter((width/2)-(gaugeDiameter)-(0.02*width), (1.553*gaugeDiameter)/2+140);
    volts.setCenter(width/2, (1.553*gaugeDiameter)/2+140);
    watts.setCenter((width/2)+(gaugeDiameter)+(0.02*width), (1.553*gaugeDiameter)/2+140);
  }
  
  a = mouseX;
  b = mouseY;
  amps.update();
  volts.update();
  watts.update();
  //temps.update();
  
  //saveAndExit();
  
  //displayTime();
  
  //drawGraph();  
}

float calculateLocalValue(float value) {
    return startAngle+((value-minValue)/(maxValue-minValue)*spanAngle);
}

//----- DRAW GRAPHS -------------------------------
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
//------------------------------------------------- 

//----- SERIAL READ ------------------------------- 
void serialEvent(Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // split the string on the commas and convert the
    // resulting substrings into an integer array:
    float[] data = float(split(inString, ","));
    // if the array has at least 6 elements, you know
    // you got the whole thing.  Put the numbers in the
    // Data variables:
    if (data.length >=6) {
      Var1 = data[0];
      Var2 = data[1];
      Var3 = data[2];
      Var4 = data[3];
      Var5 = data[4];
      Var6 = data[5]; 
      Var7 = data[6];
      Var8 = data[7];
      Var9 = data[8];
      Var10 = data[9];
      
      println(Var1 + "\t" + Var2 + "\t" + Var3 + "\t" + Var4  + "\t" + Var5 + "\t" + Var6 + "\t" + Var7 + "\t" + Var8 + "\t" + Var9 + "\t" + Var10);
    }
  }
}
//------------------------------------------------- 

//----------------Save Table Button----------------- 
void saveAndExit() {
  //----- VARIBLE STORE & SAVE ----- (2h) 
   // Add Elements to Table 
   TableRow newRow = table.addRow();
      newRow.setString("Time:", time);
      newRow.setFloat("Solar Voltage(V):", Var1);
      newRow.setFloat("Solar Amperage(mA):", Var2);
      newRow.setFloat("Solar Wattage(W):", Var3);
      newRow.setFloat("Final Voltage(V):", Var4);
      newRow.setFloat("Final Amperage(A):", Var5);
      newRow.setFloat("Final Wattage(W):", Var6); 
      newRow.setFloat("Final Wattage(W):", Var7);
      newRow.setFloat("Final Wattage(W):", Var8);
      newRow.setFloat("Final Wattage(W):", Var9);
      newRow.setFloat("Final Wattage(W):", Var10);
      
   // Save Elements and Exit Program    
   fill(237,28,36);
   noStroke();
   rect((width)-200,50,150,50);
 
   fill(255);
   textAlign(CENTER,CENTER);
   textSize(20);
   text("Save & Exit",(width)-200,50,150,50);
  
   if(mouseX>=1000 && mouseY>=50 && mouseX<=1150 && mouseY<=100 && mousePressed==true) {
     fill(150, 0, 0);
     noStroke();
     rect(1000,50,150,50);
  
     fill(255);
     textSize(20);
     text("Save",1075,73);
     String filename = time + "_" + date + "_" + "test.csv";
     saveTable(table,filename,"csv");
     delay(300);
     exit();
   } 
   else if(mouseX>=1000 && mouseY>=50 && mouseX<=1150 && mouseY<=100) 
   {
     fill(255);
     noStroke();
     rect(1000,50,150,50);
 
     fill(0);
     textSize(20);
     text("Save",1075,73);
   } 
}
//-------------------------------- 

// Display Time XX:XX:XX
void displayTime() {
  textSize(20);
  time = strh + "h_" + strmin + "min_" + strsec + "sec";
  text("Time: " + time,50,60);

  // Display Date XX/XX/XXXX  
  date = strmon + "-" + strd + "-" + stry;
  text("Date: " + date,50,90);
}
//--------------------------------