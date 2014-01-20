ArrayList <Vibrator> vibrators = new ArrayList<Vibrator>() ;


int colorShift;
int timeOut;

class Vibrator {
  
  float amplitude;
  float amplitudeMax;
  float a;
  float inc;
  float damp;
  int black;
  int col;
  int knots;
  
  float vaihe;
  float dDamp;
  
  Vibrator(int c, int k, int b){
    inc = TWO_PI/width;
    a = 0.0;
    damp = 0;
    amplitude = 125;
    amplitudeMax = 75;
    knots = k;
    col = c;
    black = b;
    
    vaihe = random(180);
    dDamp = 1 + random(1);
  }
  
  void reset(){
    inc = TWO_PI/width;
    a = 0.0;
    damp = 0;
    amplitude = 125 + random(50);
    amplitudeMax = 75 + random(50);
    knots = int(random(10));
    vaihe = random(180);
    dDamp = 1 + random(1);
  }
  
  void display(int colorShift)
  {
    float prev_x = 0;
    float prev_y = height/2;
    float x = 0;
    float y = 0;
    if(black != 1){
      stroke(color((col+colorShift) % 100, 100, 100));
      strokeWeight(1.5);
      if(timeOut == -1)
        return;
    }
    else {
      stroke(color(0,0,0));
      strokeWeight(1.7);
    }
    damp += dDamp;
    
    amplitude = amplitudeMax * sin(damp/5);
    /*
    while(++x < width) {
      a = (2 * knots * x) / 400;
      y = height/2 + sin(a) * amplitude * (width/2-abs(width/2-x))/width ;
      line(prev_x, prev_y, x, y);
      prev_x = x;
      prev_y = y;
    }
    */

    beginShape();
    curveVertex(0,height/2);
    
    for(x = 0;x <= width; x += width/10 ) {
      a = (2 * knots * x) / 400;
      y = height/2 + sin(a) * amplitude * (width/2-abs(width/2-x))/width ;
      curveVertex(x, y);
//      prev_x = x;
//      prev_y = y;
    }
    curveVertex(x, y);
    endShape();
    
    beginShape();
    vertex(30, 20);
    bezierVertex(80, 0, 80, 75, 30, 75);
    
    if(amplitudeMax > 0)
      amplitudeMax -= 4;
    else amplitudeMax = 0;
  }
}

void keyPressed(){
  for(Vibrator vibr : vibrators)
    vibr.reset();
 timeOut = 36;
 colorShift = int(random(180));
}

void setup()
{
  size(750, 100);
  colorMode(HSB,100);
  noFill();
  frameRate(36);

  int z = int(random(100));

  vibrators.add(new Vibrator(0, 5, 0));
  vibrators.add(new Vibrator(25, 7, 0));
  vibrators.add(new Vibrator(50, 11, 0));
  vibrators.add(new Vibrator(0, 3, 1));
  timeOut = -1;
}

void draw()
{
  background(0,0,100);
  if(abs(mouseY - height/2) < 5 && timeOut <= 0)
    keyPressed();
  
  if(0 < timeOut)
   timeOut--; 
  
  for(Vibrator vibr : vibrators)
    vibr.display(colorShift);
}


