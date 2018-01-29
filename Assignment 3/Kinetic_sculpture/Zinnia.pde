void drawZinniaHalf(int x, int y, int sides, float displacement, float time, float delay, float scale, float mirror, color zinniaColor, int strokeWt){  
  stroke(zinniaColor);
  strokeWeight(strokeWt);
  noFill();
  
  pushMatrix();
  translate(x, y);
  rotate(mirror*displacement*cos(angularSpeed*time/2 - delay)); //rotates to cosine wave (y = A * cosine((omega * t) / period - phi) 
  scale(mirror*scale, scale);
  
  //drawing zinnia flower circle
  for(int i = 0; i < sides; i++){ 
    rotate(TWO_PI/sides);
    beginShape();
    vertex(0, 30);
    bezierVertex(0, 50, -10, 90, -30, 100);
    vertex(0, 135);
    bezierVertex(-30, 150, -50, 150, -80, 125);
    endShape();
  }
  //drawing zinnia flower center
  fill(30);
  strokeWeight(4);
  ellipse(0,0,30,30);
  noStroke();
  fill(50);
  ellipse(0,0,15,15);
  noFill();
  stroke(0);
  popMatrix();
  
  //damping displacement with each oscillation
  if (displacement*cos(angularSpeed*time/2 - delay) == 0){
    displacementClockwise *= decay;
  }
}