int frameCounter;
String filePrefix;
String fileSuffix;
String timeCode;

void settings() {
  size(600, 600);
}

void setup() {
  frameCounter = 0;
  filePrefix = "data/capture";
  timeCode = year() + nf(month(),2) + nf(day(),2) + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
  fileSuffix = ".png";
  makeTheLand();
}

void draw() {
  
}

void makeTheLand() {
  background(204, 234, 255);
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  makeLightning(0, (int) random(height), 12);
  makeLightning(0, (int) random(height), 12);
  makeLightning(0, (int) random(height), 12);
  makeLightning(0, (int) random(height), 12);
  makeLightning(0, (int) random(height), 10);
  makeLightning(0, (int) random(height), 10);
  makeLightning(0, (int) random(height), 10);
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  drawSun();
  
  String imagePath = filePrefix + timeCode + "_" + nf(frameCounter,4) + fileSuffix;
  save(imagePath);
  frameCounter++;
}

void drawSun(){
  noStroke();
  fill(245, 201, 232);
  ellipseMode(RADIUS);
  int radius = (int) random(width/20,  width/10);
  int xloc = (int) random(width);
  int yloc = (int) random(height);
  ellipse(xloc, yloc, radius, radius);
}

void makeLightning (int xloc, int yloc, float weight) {
  int nextx = (int) random(xloc, xloc+width/10);
  int nexty = (int) random(yloc-height/10, yloc+height/10); 
  stroke(87, 67, 45);
  strokeWeight(weight);
  line(xloc, yloc, nextx, nexty);
  weight = weight - random(1);
  if(weight > 0 && nextx < width) {
    makeLightning(nextx, nexty, weight);
    if(1 > random(10)) {
     makeLightning(nextx, nexty, weight);
    }
  }
}

void mouseClicked(){
 makeTheLand(); 
}
