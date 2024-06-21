int count = 0;
String durationString;
XYChart scatterPlot;
FloatList lineChartX = new FloatList();
FloatList lineChartY = new FloatList();
int[] zoneCounts = new int[5]; // Array to store counts for each heart rate zone
int timeElapsed1,timeElapsed2,timeElapsed3,timeElapsed4,timeElapsed5 = 0;

// define time interval 
int timeInterval = 1; 

String time(){
  // Get the current time
  int currentSec = second();
  int currentMin = minute();
  int currentHr = hour();
  
  // Calculate the duration
  int durationSec = currentSec - startSec;
  int durationMin = currentMin - startMin;
  int durationHr = currentHr - startHr;
  
  // Adjust for negative values
  if (durationSec < 0) {
    durationSec += 60;
    durationMin--;
  }
  if (durationMin < 0) {
    durationMin += 60;
    durationHr--;
  }
  if (durationHr < 0) {
    durationHr += 24; // Assuming a 24-hour clock
  }
  
  // Display the duration
  return nf(durationHr, 2) + ":" + nf(durationMin, 2) + ":" + nf(durationSec, 2);
}

int averageBPM() {
    // Calculate the sum of all elements in lineChartY
    float sum = 0;
    float nonZero = 0;
    for (int i = 0; i < lineChartY.size(); i++) {
      if (lineChartY.get(i) !=0){
        sum += lineChartY.get(i);
        nonZero++;
      }
    }

    // Calculate and return the average
    if (lineChartY.size() > 0) {
        return Math.round(sum / nonZero); // Rounded to the nearest integer
    } else {
        return 0; // Return 0 if the list is empty to avoid division by zero
    }
}
// Function to detect and process heartbeats

void createScatterPlot(float val) {
  
  // range for x axis
  float minX = 0;
  float maxX = 500; // adjust as needed
  
  scatterPlot = new XYChart(this);
  scatterPlot.setMinY(0); // Set minimum y-value
  scatterPlot.setMaxY(120); // Set maximum y-value
  scatterPlot.showXAxis(true); // Show x-axis
  scatterPlot.showYAxis(true); // Show y-axis
  scatterPlot.setXFormat("0"); // Format for x-axis labels
  scatterPlot.setYFormat("0"); // Format for y-axis labels
  scatterPlot.setPointSize(5); // Set point size
  
  float[] yVal = lineChartY.array();
  float[] xVal = new float[lineChartY.size()];
  for (int i = 0; i < xVal.length; i++) {
    xVal[i] = i * timeInterval;
  }
  scatterPlot.setData(xVal, yVal); // Set data for scatter plot
  
  
  for (int i = 0; i < yVal.length; i++) {
   val = yVal[i]; // Get the value at the current index
  
  // Set color based on value range
  if (val <= 60 && val != 0) {
    
    scatterPlot.setPointColour(color(0, 0, 0)); // Black color
    timeElapsed1++;
    if (timeElapsed1 == 1000){
      zoneCounts[0]++;
      timeElapsed1 = 0;
    }
    
  } else if (val > 60 && val <= 75) {
    scatterPlot.setPointColour(color(0, 0, 255)); // Blue color
    timeElapsed2++;
    
    if (timeElapsed2 ==1000){
    zoneCounts[1]++;
    timeElapsed2 =0;
    }
    
  } else if (val > 75 && val <= 89) {
    scatterPlot.setPointColour(color(0, 255, 0)); // Green color
    timeElapsed3++;
    if (timeElapsed3 == 1000){
    zoneCounts[2]++;
    timeElapsed3 =0;
    }
  } else if (val > 90 && val <= 100) {
    scatterPlot.setPointColour(color(255, 165, 0)); // Orange color
    
    timeElapsed4++; 
    if (timeElapsed4 == 1000){
    zoneCounts[3]++;
    timeElapsed4 = 0;
    }
  } else if (val >100 && val != 0){
    scatterPlot.setPointColour(color(255, 0, 0)); // Red color
    
    timeElapsed5++;
    if (timeElapsed5 ==1000){
    zoneCounts[4]++;
    timeElapsed5 = 0;
    }
  }
  // Set data for scatter plot
}

 //set range for x-axis
  scatterPlot.setMinX(minX);
  scatterPlot.setMaxX(maxX);
  
  textSize(20);
  textAlign(LEFT, TOP);
  int x  = averageBPM();
  String z = String.valueOf(x);
  text ("Average BPM: "+z,610,20);
  String oxy = String.valueOf(oxygenLevel);
  text ("Oxygen Level: " + oxy ,610,50);
  String conf = String.valueOf(confidence);
  text ("Confidence Level: " + conf,610,80);
  textAlign(CENTER,RIGHT);
  scatterPlot.draw(100, 100, width - 200, height - 200); // Draw the scatter plot
  count++;
}

void screen2() {
  pushStyle();
  textSize(20);
  fill(204, 102, 0);
  textSize(20);
  textAlign(LEFT, TOP);
  createScatterPlot(3);
  text ("Press 'r' to Reset\n                      Press 'e' for an Exercise list \n              Press 'o' for the Mode 1\n        Press 'm' for Mode 2",90,20);

  textAlign(CENTER,RIGHT);
  
  textAlign(CENTER, CENTER);
  textSize(32);
  fill(0);
  String durationString = time();

  text("Timer: "+ durationString, width/2, 30);//prints the duration on the screen
  
  // x-axis title
  textAlign(CENTER, CENTER);
  textSize(20);
  fill(0);
  text("Time (seconds)", width/2, height - 50); // Adjust height as needed
  
  // Draw y-axis title (rotated)
  pushMatrix();
  translate(50, height/2); // Adjust position as needed
  rotate(-HALF_PI);
  textAlign(CENTER, CENTER);
  textSize(20);
  fill(0);
  text("Heart Rate (BPM)", 0, 0);
  popMatrix();
}
