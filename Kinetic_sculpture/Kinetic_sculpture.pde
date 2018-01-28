// frontRotationSpeed is the angular speed of rotation of the front portion of the sculpture
float frontRotationSpeed = 0.005;
// backRotationSpeed is the angular speed of rotation of the front portion of the sculpture
float backRotationSpeed = -0.01;
// startFrontAngle is the angle w.r.t. the x-axis where the first middle circular spoke of the front side should be created
float startFrontAngle = 0;
// startFrontAngle is the angle w.r.t. the x-axis where the first middle circular spoke of the back side should be created
float startBackAngle = 0;
// innerArcRadius is the radius of the middle circular spikes, the circle of the middle circular spikes passes through the center of the figure
float innerArcRadius = 40;
// maxArcRadius is the Maximum value of the radius of the middle circular spike
float maxArcRadius = innerArcRadius *1.1;
// minArcRadius is the Minimum value of the radius of the middle circular spike
float minArcRadius = innerArcRadius * 0.9;
// radiusChangeRate is the rate at which the figure expands or collapses
float radiusChangeRate = 0.1;
// numberSides defines the number of the middle circular spokes to be used to create the Marigold Structure
int numberSides = 10;
// widthOfSpikes is the width of the wooden blocks used to create the Marigold
int widthOfSpikes = 8;

//Number of birds in the structure
Bird[] birds = new Bird[5];

//Variables for Zinnia structure
float angularSpeed = 0.0174533*30; // 30 degrees/epoch ( deg(0.0174533) = 1 )
float decay = 0.2; // displacement dampening
float displacementClockwise; // revolutions per oscillation
float displacementCounterclockwise; 
float time; // in seconds
int wavePeriodClockwise; // numbered oscillation
int wavePeriodCounterclockwise;

void setup() {
  fullScreen();
  ellipseMode(RADIUS);
  noFill();

  // Initialize variables for Zinnia structure
  decayClockwise = 0.2;
  decayCounterclockwise = 0.2;
  displacementClockwise = 2*TWO_PI;
  displacementCounterclockwise = 2*TWO_PI;
  angularSpeed = 0.0174533*30;
  time = 0;
  wavePeriodClockwise = 1;
  wavePeriodCounterclockwise = 1;

  // Initialize bird objects with a random location on the sketch
  for (int i = 0; i < birds.length; i++ ) {
    birds[i] = new Bird(random(width), random(height/3)+15, random(1, 6));
  }
}


void draw() {
  background(#e09432);
  
  // create tree structure
  createTree();
  
  // create Zinnia Kinetic structure
  drawZinnia();
  // Create the Marigold structure
  drawMarigold(int(width/4), int(3*height/5), innerArcRadius, numberSides, widthOfSpikes, startFrontAngle, startBackAngle, color(120, 50, 50), 
    color(120, 40, 40), color(100, 30, 30), color(80, 20, 20), color(60, 15, 15));

  drawMarigold(int(3*width/4), int(3* height/5), innerArcRadius, numberSides, widthOfSpikes, startFrontAngle, startBackAngle, color(120, 50, 50), 
    color(120, 40, 40), color(100, 30, 30), color(80, 20, 20), color(60, 15, 15));

  // adjust the startFrontAngle so that the front side has a movement effect
  startFrontAngle +=frontRotationSpeed;
  if (startFrontAngle > TWO_PI)
    startFrontAngle -= TWO_PI;

  // adjust the startBackAngle so that the front side has a movement effect
  startBackAngle +=backRotationSpeed;
  if (startBackAngle > TWO_PI)
    startBackAngle -= TWO_PI;

  //  Adjust the innerArcRadius to expand or collapse the marigold structure
  innerArcRadius += radiusChangeRate;
  if (innerArcRadius>maxArcRadius || innerArcRadius<minArcRadius)
    radiusChangeRate = -radiusChangeRate;

  for (int i = 0; i < birds.length; i++ ) {
    birds[i].drive(random(height/3)+15);
  }
}