class barGraph {
  String gaugeName;
  float left;
  float top;
  float val1;
  float val2;
  float val3;
  float val4;
  float barWidth;
  float barHeight;
  
  
  barGraph (float bw, float bh, String name, float x, float y) {
    barWidth = bw;
    barHeight = bh;
    gaugeName = name;
    left = x;
    top = y;
    
  }
  
  void setTopLeft(float x, float y) {
    left = x;
    top = y;
  }
  
  void update() {
    for (float i=0;i<4;i++) {
      rect(left + (barWidth*i)+30, top, barWidth, barHeight);
    }
    println(str(barWidth*1+20));
  }
  
}