//**********************************************************************
// Author            : Bryan Costanza (GitHub: TravelByRocket)
// Date created      : 20191128
// Purpose           : YouTube tutorial video about generative art using Perlin noise and recursive functions
//**********************************************************************

String filePrefix;
int captureCounter;
String fileSuffix;

void settings() {
  size(600,600);
}

void setup() {
  filePrefix = "data/capture" + 
              year() + 
              nf(month(),2) + 
              nf(day(),2) + 
              nf(hour(),2) + 
              nf(minute(),2) + 
              nf(second(),2);
  captureCounter = 0;
  fileSuffix = ".png";
  
  makeNewScene();
}

void draw() {
  
}

void saveScreenshot(){
  // data/capture20191128154750_0001.png
  save(filePrefix + "_" + nf(captureCounter,4) + fileSuffix);
}

void makeMountains(int offsetFromBottom, float noiseScale, float scaleFactor, color theColor){
  noiseSeed((int) random(10000));
  noStroke();
  fill(theColor);
  beginShape();
  vertex(0,height);
  for(int i = 0; i < width; i++){
    vertex(i,height - (noise(i*noiseScale)*scaleFactor + offsetFromBottom));
  }
  vertex(width,height);
  endShape();
}

void mouseClicked(){
  makeNewScene();
}

void makeNewScene(){
  background(#FFA662);
  makeSun();
  makeMountains(height/2,0.05,100,#B6A6C6);
  makeMountains(height/4,0.01,50,#76649D);
  makeLightning((int) random(width/10,width*9/10), 0, 10);
  
  saveScreenshot();
  captureCounter++;
}

void makeSun(){
  noStroke();
  color sunYellow = #FFFFB9;
  int diameter = (int) random(70,100);
  int xloc = (int) random(random(width));
  int yloc = (int) random(height/2);
  
  fill(sunYellow,25);
  ellipse(xloc,yloc,diameter*1.4,diameter*1.4);
  fill(sunYellow,50);
  ellipse(xloc,yloc,diameter*1.2,diameter*1.2);
  fill(sunYellow,100);
  ellipse(xloc,yloc,diameter,diameter);
}

void makeLightning(int xloc, int yloc, float theWeight){
  noFill();
  strokeWeight(theWeight);
  stroke(#FFFFFF);
  
  int xnext = xloc + (int) random(-width/10,width/10);
  int ynext = yloc + (int) random(width/10);
  
  line(xloc,yloc,xnext,ynext);
  
  float nextWeight = theWeight * (random(0.7,0.95));
  if(ynext < height){
    makeLightning(xnext,ynext,nextWeight);
    if(random(10) < 1){
      makeLightning(xnext,ynext,nextWeight);
    }
  }
}
