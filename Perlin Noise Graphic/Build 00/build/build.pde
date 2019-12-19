//**********************************************************************
// Author            : Bryan Costanza (GitHub: TravelByRocket)
// Date created      : 
// Purpose           : 
// Revision History  : 
// YYYYMMDD --  
//**********************************************************************

String dataDir    = "../../data/";

void settings() {
  size(600,600);
}

void setup() {
	float noiseScale = 0.01;
  for (int i = 0; i < width; ++i) {
  	for (int j = 0; j < height; ++j) {
  		float noiseValue = noise(i*noiseScale,j*noiseScale);
  		stroke(255,255*(noiseValue),50*(noiseValue));
  		point(i,j);
  	}
  }
  save("perlin_noise.png");
}

void draw() {
  
}
