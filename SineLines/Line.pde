class Line {
  PVector line;
  float amplitude;
  float angularVel;
  float angularAcel;
  float angle;


  Line(float x /*float amplitude_*/) {
    x = map(x, 0, l.length-1, 0, width);

    line = new PVector (x, height/2);
    angle =0;
    amplitude = height/2 ;
    angularVel = 0.00005;
    angularAcel = 0.0001;
    //println(amplitude);
  }

  void update (float fase, float constrain, float var1, float amplitude_) {

    constrain = map(constrain, 0, width, 0, 0.008);
    var1 = map(var1, 0, width, 0, 20);
    fase = map(fase, 1, 64, 0, var1);


    amplitude = amplitude_;

    line.y = amplitude * sin(fase*angle);

    angle+=angularVel;
    angularVel+=angularAcel;


    angularVel = constrain(angularVel, 0, constrain);
  }

  void show() {
    pushMatrix();
    translate(0, height/2);
    stroke(255);
    strokeWeight(4);
    line(line.x, 0, line.x, line.y);
    popMatrix();
  }
}
