//**********************************************************************
// Author            : Bryan Costanza (GitHub: TravelByRocket)
// Date created      : 20191005
// Purpose           : Workshop on generative algorithms
// Revision History  : 
// 20191005 -- make mountains with Perlin, sun, lightning, trees
// 20191007 -- header update, file structure renamed
//**********************************************************************

String dataDir    = "../../data/";

int saveCounter;
String savePrefix;
String saveSuffix;

void settings() {
  size(600,600);
}

void setup() {
  saveCounter = 0;
  savePrefix = "data/capture" + nf(day(),2) + nf(hour(),2) + nf(minute(),2) + nf(second(),2) + "_";
  saveSuffix = ".png";
  makeThatPlace();
}

void draw() {

}

void makeHills(color theColor, int vertScale, int offsetFromTop, float noiseScale){
  noStroke();
  fill(theColor);
  beginShape();
  float contour[] = new float[width];
  for(int i = 0; i < width; i++){
    contour[i]=noise(i*noiseScale)*vertScale+offsetFromTop;
    vertex(i,contour[i]);
  }
  vertex(width,height);
  vertex(0,height);
  endShape(CLOSE);
  
  int NUMTREES = 10;
  for (int j = 0; j < NUMTREES; j++){
    drawTree(contour);
  }
  
}

void makeSun(color theColor){
  int xval = (int) random(width);
  int yval = (int) random(height);
  int radius = (int) random(width/20,width/10);
  
  ellipseMode(RADIUS);
  noStroke();
  
  fill(theColor); // primary central circle
  ellipse(xval,yval,radius,radius);
  fill(theColor,50); // secondary outer circle
  ellipse(xval,yval,radius*1.4,radius*1.4);
  fill(theColor,25); // tertiary outer circle
  ellipse(xval,yval,radius*1.7,radius*1.7);
}

void mouseClicked(){
  noiseSeed((long) random(1000));
  makeThatPlace();
  saveCounter++;
}

void makeThatPlace(){
  background(40,150,200);
  makeSun(color(200,200,20));
  makeHills(color(150),200,3*height/5,0.02);
  makeHills(color(220),150,4*height/5,0.002);
  makeLightning();
  save(savePrefix+nf(saveCounter,4)+saveSuffix);
}

void drawTree(float theContour[]){
  int xval = (int) random(width);
  int yval = (int) random(theContour[xval],height);
  
  int trunkWidth = 10;
  int trunkHeight = 40;
  
  rectMode(CORNERS);
  
  fill(100,20,20);
  rect(xval-trunkWidth/2,yval,xval+trunkWidth/2,yval-trunkHeight);
  
  fill(50,200,75);
  triangle(xval-25,yval-20,xval+25,yval-20,xval,yval-60);
  
}

void makeLightning(){
  int xval = (int) random(width);
  int yval = 0;
  float weight = random(8,12);
  stroke(250);
  strokeWeight(weight);
  int nextx = (int) xval-10+(int)random(20);
  int nexty = (int) random(50);
  line(xval,yval,nextx,nexty);
  
  lightningContinue(nextx,nexty,9);
}

void lightningContinue(int xloc,int yloc, float weight){
  int nextx = (int) xloc-10+(int)random(40-6*weight);
  int nexty = yloc + (int) random(50);
  strokeWeight(weight);
  
  line(xloc,yloc,nextx,nexty);
  weight = weight - random(1);
  
  if (nexty < height && weight > 0){
    lightningContinue(nextx,nexty,weight);
    if (weight < random(5)){
      lightningContinue(nextx,nexty,weight);
    }
  }
}
