void drawZinnia() {
  stroke(0);
  strokeWeight(6);
  noFill();
  pushMatrix();
  stroke(0);
  translate(width/2, height/2-height/8);
  rotate(displacementClockwise*/*exp(-1*decay*time)*/cos(angularSpeed*time/2 - PI/8));
    scale(1.2);
    for (int i = 0; i < 12; i++) { 
    rotate(TWO_PI/12);
    beginShape();
    vertex(0, 30);
    bezierVertex(0, 50, -10, 90, -30, 100);
    vertex(0, 135);
    bezierVertex(-30, 150, -50, 150, -80, 125);
    endShape();
  }
  
  fill(30);
  ellipse(0,0,30,30);
  noStroke();
  fill(50);
  ellipse(0,0,15,15);
  noFill();
  stroke(0);
  popMatrix();  

  pushMatrix();
  translate(width/2, height/2-height/8);
  stroke(0);
  //rotate(TWO_PI/360 + speedClockwise);
  rotate(-displacementCounterclockwise*/*exp(-1*decay*time)*/cos(angularSpeed/2*time));
    scale(1.2, -1.2);
  for (int i = 0; i < 12; i++) { 
    rotate(TWO_PI/12);
    beginShape();
    vertex(0, 30);
    bezierVertex(0, 50, -10, 90, -30, 100);
    vertex(0, 135);
    bezierVertex(-30, 150, -50, 150, -80, 125);
    endShape();
  }
  time += 0.016667;
  popMatrix();

  if (displacementClockwise*/*exp(-1*decay*time)*/cos(angularSpeed*time/2 - PI/8) == 0) {
    displacementClockwise *= decayClockwise;
  }

  if (-displacementCounterclockwise*/*exp(-1*decay*time)*/cos(angularSpeed*time/2) == 0) {
    displacementCounterclockwise *= decayCounterclockwise;
  }
  scale(1);
}