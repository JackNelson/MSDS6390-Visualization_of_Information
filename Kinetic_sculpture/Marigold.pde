

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


// createArcs creates the front or the back portion of the Marigold based on the parameter isFront
// x,y is the center of the Marigold
// radiusInner is the radius of the middle portion of the figure
// sides is the number of sides required in the sculpture
// theta is the starting angle of the figure
// outerColor is the color of the outermost circular spikes
// innerColor is the color of inner circular spikes
void createArcs(boolean isFront, float x, float y, float radiusInner, int sides, float theta, color outerColor, color innerColor) {

  noFill();
  // rotAmount is the distance between 2 middle circular spikes
  float rotAmount = TWO_PI/sides;
  // x2, y2 is the center of the circles used for creating the middle circular spikes
  // (x3, y3) is the coordinate of the point on the middle circular spike thats connected with the outer arcs along the circumference
  // (x4, y4) and (x5, y5) are the coordinates on the outer circumference that connected with the middle circular spike
  // (x6, y6) and (x7,y7) will be used to have the extra filled material around the portion connecting the middle circular spikes with the outer circular spikes
  float x2=0, y2=0, x3=0, y3=0, x4=0, y4=0, x5=0, y5=0, x6=0, y6=0, x7=0, y7=0;
  // interval is the angular width of the outer arc
  float interval = TWO_PI / 20;
  float radiusOuterArc_1 =  radiusInner/2.25;
  float radiusOuterArc_2 = radiusInner/2.5;
  noFill();
  for (int i=0; i<sides; i++) {

    stroke(outerColor);
    // Create the acrs along the outer circumference
    if (isFront) {
      arc(x, y, 4*radiusInner, 4*radiusInner, theta + 3* interval, theta + 4* interval);
      x4 = x + cos(theta + 3 * interval)* (4*radiusInner);
      y4 = y + sin(theta + 3 * interval)* (4*radiusInner);
      x5 = x + cos(theta + 4 * interval)* (4*radiusInner);
      y5 = y + sin(theta + 4 * interval)* (4*radiusInner);
    } else {
      arc(x, y, 4*radiusInner, 4*radiusInner, (theta - 3 * interval), ( theta -2 * interval));
      x4 = x + cos((theta - 3 * interval))* (4*radiusInner);
      y4 = y + sin((theta - 3 * interval))* (4*radiusInner);
      x5 = x + cos((theta - 2 * interval))* (4*radiusInner);
      y5 = y + sin((theta - 2 * interval))* (4*radiusInner);
    }

    if (isFront) {    
      x2 = x + cos(theta)*radiusInner;
      y2 = y + sin(theta)*radiusInner;
    } else {
      x2 = x + cos(theta)*radiusInner;
      y2 = y + sin(theta)*radiusInner;
    }

    stroke(innerColor);
    // Create the middle portion of the kinetic sculpture - circular spikes around the center
    if (isFront) {
      arc(x2, y2, radiusInner, radiusInner, theta + 0.125 * PI, theta + PI );
      x3 = x2 + cos(theta + 0.125 * PI)* (radiusInner);
      y3 = y2 + sin(theta + 0.125 * PI)* (radiusInner);
    } else {
      arc(x2, y2, radiusInner, radiusInner, theta + PI, theta + 1.875 * PI );
      x3 = x2 + cos(theta + 1.875 * PI )* (radiusInner);
      y3 = y2 + sin(theta + 1.875 * PI )* (radiusInner);
    }

    // Create the two arcs joining the middle portion to the arcs created along the circumference
    // Arc 1
    stroke(outerColor);
    beginShape();
    curveVertex(x3, y3);
    curveVertex(x3, y3);
    if (isFront)
      curveVertex((x3+x4)/2+radiusOuterArc_1*cos(theta), (y3+y4)/2 +radiusOuterArc_1*sin(theta));
    else
      curveVertex((x3+x4)/2-radiusOuterArc_1*cos(theta), (y3+y4)/2 -radiusOuterArc_1*sin(theta));
    curveVertex(x4, y4);
    curveVertex(x4, y4);
    endShape();
    //Arc 2
    beginShape();
    curveVertex(x3, y3);
    curveVertex(x3, y3);
    if (isFront)
      curveVertex((x3+x5)/2+radiusOuterArc_2*cos(theta), (y3+y5)/2 +radiusOuterArc_2*sin(theta));
    else
      curveVertex((x3+x5)/2-radiusOuterArc_2*cos(theta), (y3+y5)/2 -radiusOuterArc_2*sin(theta));
    curveVertex(x5, y5);
    curveVertex(x5, y5);
    endShape();

    // Create the additional material filling around the portion joining the middle and outer region
    if (isFront) {
      x6 = (x3+ (x3+x4)/2+radiusOuterArc_1*cos(theta))/2;
      y6 = (y3+ (y3+y4)/2 +radiusOuterArc_1*sin(theta))/2;
      x7 =  (x3+x5)/2+radiusOuterArc_1*cos(theta);
      y7 =  (y3+y5)/2 +radiusOuterArc_1*sin(theta);
    } else {
      x6 = (x3+ (x3+x4)/2 -radiusOuterArc_1*cos(theta))/2;
      y6 = (y3+ (y3+y4)/2 -radiusOuterArc_1*sin(theta))/2;
      x7 =  (x3+x5)/2 - radiusOuterArc_1*cos(theta);
      y7 =  (y3+y5)/2 - radiusOuterArc_1*sin(theta);
    }
    strokeCap(ROUND);
    noStroke();
    fill(outerColor);
    triangle(x3, y3, x6, y6, x7, y7);
    stroke(outerColor);
    line(x3, y3, x6, y6);
    theta += rotAmount;
    noFill();
  }
}