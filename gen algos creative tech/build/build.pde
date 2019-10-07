//**********************************************************************
// Program name      : gen algos creativetech
// Author            : Bryan Costanza (GitHub: TravelByRocket)
// Date created      : 20191007
// Purpose           : in-class demo of generative algorithms
// Revision History  : 
// 20191007 -- working on it in class, starting fresh
//**********************************************************************

int frameCounter;
String filePrefix;
String timeCode;
String fileSuffix;

void settings() {
  size(600,600);
}

void setup() {
  frameCounter = 0;
  filePrefix = "data/capture";
  timeCode = year() + 
    nf(month(),2) + 
    nf(day(),2) + 
    nf(hour(),2) +
    nf(minute(),2) +
    nf(second(),2);
    
  fileSuffix = ".png";
  makeTheLand();
}

void draw() {
  
}

void drawMountains(int noiseScale,int offsetFromTop, color theColor, float noiseStep){
  noiseSeed((int) random(10000));
  noStroke();
  fill(theColor);
  beginShape();
  for(int i = 0; i < width; i++){
    vertex(i,noise(i*noiseStep)*noiseScale+offsetFromTop);
  }
  vertex(width,height);
  vertex(0,height);
  endShape();
}

void drawSun(){
  noStroke();
  fill(240,240,100);
  ellipseMode(RADIUS);
  int radius = (int) random(width/20,width/10);
  int xloc = (int) random(width);
  int yloc = (int) random(height);
  ellipse(xloc,yloc,radius,radius);
  
  fill(240,240,100,50);
  ellipse(xloc,yloc,radius*1.3,radius*1.3);
  
  fill(240,240,100,25);
  ellipse(xloc,yloc,radius*1.7,radius*1.7);
}

void makeTheLand(){
  background(175);
  drawSun();
  drawMountains(100,3*height/5,color(150),0.03);
  drawMountains(100,4*height/5,color(100),0.006);
  makeLightning((int) random(width), 0, 12);
  
  String imagePath = filePrefix + timeCode + "_" + nf(frameCounter,4) + fileSuffix; 
  
  save(imagePath);
  
  frameCounter++;
}

void makeLightning(int xloc, int yloc, float weight){
  int nextx = (int) random(xloc-width/10,xloc+width/10);
  int nexty = (int) random(yloc,yloc+height/10);
  stroke(255);
  strokeWeight(weight);
  line(xloc,yloc,nextx,nexty);
  weight = weight - random(1);
  if(weight > 0 && nexty < height){
    makeLightning(nextx,nexty,weight);
    if(1 > random(10)){
      makeLightning(nextx,nexty,weight);
    }
  }
  
  
}

void mouseClicked(){
  makeTheLand();
}
