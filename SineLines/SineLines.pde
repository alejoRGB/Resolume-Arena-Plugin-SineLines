import spout.*; 

Spout spout;

Line [] l = new Line[65];

String sendername;

// CONTROL ARRAYS
String[] controlName;
int[] controlType;
float[] controlValue;
String[] controlText;

// CONTROL VARIABLES
boolean bRotate = true;
float RotationSpeed = 1.0;
float RotX = 0;
float RotY = 0;
String UserText = "";

//variables que modifican las lineas 
  float amplitude1 = 1200;
  float VELOCIDAD_LINEAS =0 ;
  float VELOCIDAD_HORIZONTAL = 500;
  
  

void setup() {
  spout = new Spout(this);
  sendername = "SineLines";
  
  frameRate(60);
  size(600, 600, P2D);
  for (int i =1; i<l.length-1; i++) {
    l[i]=new Line(i);
  }
  spout.createSender(sendername, width, height);
    // CREATE CONTROL ARRAYS
  controlName = new String[20];
  controlType = new int[20];
  controlValue = new float[20];
  controlText = new String[20];

  // CREATE CONTROLS TO BE USED
  ///spout.createSpoutControl("Show Lines", "bool", 1);
  spout.createSpoutControl("VELOCIDAD_LINEAS", "float", 0, 600, 100);

  spout.createSpoutControl("amplitude1", "float", 0, 600, 100);
  // OPEN THE CONTROLS FOR THE CONTROLLER
  // Must use the same name as the sketch and sender
  spout.openSpoutControls(sendername);
}


void draw() {
  
  
    background (0);
    
    // CHECK FOR UPDATED CONTROLS FROM THE CONTROLLER
  int nControls = spout.checkSpoutControls(controlName, controlType, controlValue, controlText);
  if (nControls > 0) {
    // For all controls
    for (int i = 0; i < nControls; i++) {
      // Check each control by name
      
      if (controlName[i].equals("VELOCIDAD_LINEAS")) {
        float newNum = controlValue[i];
        //VELOCIDAD_LINEAS =newNum ;
        VELOCIDAD_LINEAS = map(newNum, 0, 0.008,  0, 0.008);
      }
      
  
      if (controlName[i].equals("amplitude1")) {
        int amp = int(controlValue[i]);
        //amplitude1 = amp;
        amplitude1 = map(amp, 0, 600, 0, 300);
      }
    }
  }
  
  
  
  
//Dibuja cada linea en su posucion actual segun los parametros
  for (int i =1; i<l.length-1; i++) {
    l[i].update(i, VELOCIDAD_LINEAS, VELOCIDAD_HORIZONTAL, amplitude1);
    l[i].show();
  }
//Manda la pantalla por spout
  spout.sendTexture();
  
}

void exit() {
  spout.closeSpoutControls();
  super.exit();
}
