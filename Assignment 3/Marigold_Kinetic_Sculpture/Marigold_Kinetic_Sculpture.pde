// frontRotationSpeed is the angular speed of rotation of the front portion of the sculpture
float frontRotationSpeed = 0.005;
// backRotationSpeed is the angular speed of rotation of the front portion of the sculpture
float backRotationSpeed = -0.01;
// startFrontAngle is the angle w.r.t. the x-axis where the first middle circular spoke of the front side should be created
float startFrontAngle = 0;
// startFrontAngle is the angle w.r.t. the x-axis where the first middle circular spoke of the back side should be created
float startBackAngle = 0;
// innerArcRadius is the radius of the middle circular spikes, the circle of the middle circular spikes passes through the center of the figure
float innerArcRadius = 90;
// maxArcRadius is the Maximum value of the radius of the middle circular spike
float maxArcRadius = innerArcRadius *1.2;
// minArcRadius is the Minimum value of the radius of the middle circular spike
float minArcRadius = innerArcRadius * 0.8;
// radiusChangeRate is the rate at which the figure expands or collapses
float radiusChangeRate = 0.1;
// numberSides defines the number of the middle circular spokes to be used to create the Marigold Structure
int numberSides = 10;
// widthOfSpikes is the width of the wooden blocks used to create the Marigold
int widthOfSpikes = 12;
// Center of the Marigold Structure
int[] figureOrigin = {500, 500};

void setup() {
  fullScreen();
  ellipseMode(RADIUS);
  //noLoop();
}

void draw() {
  background(130);
  // Create the Marigold structure
  drawMarigold(figureOrigin[0], figureOrigin[1], innerArcRadius, numberSides, widthOfSpikes, startFrontAngle, startBackAngle, color(120, 50, 50),
                          color(100, 45, 35), color(100, 35, 45), color(80, 20, 20), color(60, 30, 30));

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
}

// drawMarigold is the function to create the Marigold Kinetic Sculpture
//    centerX , centerY is the center of the Marigold structure
//    radiusInner is the radius of the middle circular spikes, the circle of the middle circular spikes passes through the center of the figure
//    sides defines the number of the middle circular spokes to be used to create the Marigold Structure
//    thetaFront is the angle w.r.t. the x-axis where the first middle circular spoke should be created
//    colors is the colors martix used to color the different parts of the scultpures
//    strokeWt is the width of the wooden blocks used to create the Marigold
void drawMarigold( int centerX, int centerY, float radiusInner, int sides, float strokeWt, float thetaFront, float thetaBack, color... colors) {
  
  // Generate the colors out of the color matrix colors
  // if colors have only one color, then entire figure will be of that color
  // if colors matrix have two colors, then first is the central portion color and second is the color of the rest of the figure
  // if colors matrix have three colors, then first is the central portion color and second is the color of the middle circular spikes, and the third one is the color of outer spikes
  // if colors matrix have four colors, then first is the central portion color and second is the color of the middle circular spikes of front portion, 
  //      the third one is the color of outer spikes of front portion and the fourth one is the color of back portion
  // if colors matrix have five colors, then first is the central portion color and second is the color of the middle circular spikes of front portion, 
  //      the third one is the color of outer spikes of front portion, the fourth one is the color of the middle circular spikes of back portion and 
  //      the fifth one is the color of outer spikes of back portion
  color centerColor, frontOuterColor, frontInnerColor, backOuterColor, backInnerColor, centerEdge;
  switch(colors.length) {
  case 1: 
    centerColor = colors[0];
    frontOuterColor = colors[0];
    frontInnerColor = colors[0];
    backOuterColor = colors[0];
    backInnerColor = colors[0];
    break;
  case 2: 
    centerColor = colors[0];
    frontOuterColor = colors[1];
    frontInnerColor = colors[1];
    backOuterColor = colors[1];
    backInnerColor = colors[1];
    break;
  case 3: 
    centerColor = colors[0];
    frontOuterColor = colors[2];
    frontInnerColor = colors[1];
    backOuterColor = colors[2];
    backInnerColor = colors[1];
    break;
  case 4: 
    centerColor = colors[0];
    frontOuterColor = colors[2];
    frontInnerColor = colors[1];
    backOuterColor = colors[3];
    backInnerColor = colors[3];
    break;
  case 5: 
    centerColor = colors[0];
    frontOuterColor = colors[2];
    frontInnerColor = colors[1];
    backOuterColor = colors[4];
    backInnerColor = colors[3];
    break;
  default:
    centerColor = 0;
    frontOuterColor = 0;
    frontInnerColor = 0;
    backOuterColor = 0;
    backInnerColor = 0;
  }
  noFill();
  strokeWeight(strokeWt);

  // Create in back portion
  createArcs(false, centerX, centerY, radiusInner, sides, thetaBack, backOuterColor, backInnerColor);

  // Create the front portion
  createArcs(true, centerX, centerY, radiusInner, sides, thetaFront, frontOuterColor, frontInnerColor);

  // Create the central region of the Kinetic Sculpture
  noStroke();
  centerEdge = color(abs(red(centerColor)-20), abs(green(centerColor)-20), abs(blue(centerColor)-20));
  fill(centerEdge);
  ellipse(centerX, centerY, 0.6*radiusInner, 0.6*radiusInner);
  strokeWeight(radiusInner*0.1);
  stroke(color(abs(red(centerColor)-10), abs(green(centerColor)-10), abs(blue(centerColor)-10)));
  fill(centerColor);
  ellipse(centerX, centerY, 0.6 * radiusInner * 0.8, 0.6 * radiusInner * 0.8);
}