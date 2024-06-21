import processing.serial.*;
import org.gicentre.utils.stat.*;

int screen = 0; // Keeps track of the current screen
int startSec, startMin, startHr;

Serial myPort; // Create a serial object
float heartRate;
float oxygenLevel;
float confidence;
float prevHeartRate = 0;
float prevOxygenLevel = 0;
float prevConfidence = 0;


void setup() {
  size(800, 450);
  String portName = "/dev/cu.usbmodem123456781";
  myPort = new Serial(this, portName, 115200);
  myPort.bufferUntil('\n');
}

void draw() {//loops through the screens
  background(255);

  if (screen == 0) {
    screen1_intro();
    startSec = second();//sets the initial time each time the enter is pressed
    startMin = minute();
    startHr = hour();  
  }else if (screen == 1) {
    screen2();
  }else if (screen == 2) {
    screen3();
  }else if (screen == 3) {
    BarChart_screen();
  }else if (screen == 4) {
    screen4();
  }
}

void serialEvent(Serial myPort) {
  String serialData = myPort.readStringUntil('\n');
  if (serialData != null) {
    serialData = trim(serialData);
    
    // Check if the line contains heart rate data
    if (serialData.startsWith("Heartrate:")) {
      // Extract heart rate value
      String[] parts = serialData.split(":");
      if (parts.length == 2) {
        try {
          float value = Float.parseFloat(parts[1].trim());
          if (value != 0) { // Check if heart rate value is not zero
            heartRate = value;
            prevHeartRate = value; // Update previous non-zero heart rate
            println("Heart rate: " + heartRate);
            lineChartY.append(heartRate);
          } else {
            heartRate = prevHeartRate; // Use previous non-zero heart rate
          }
        } catch (NumberFormatException e) {
          println("Error parsing heart rate value: " + parts[1]);
        }
      }
    }
    
    // Check if the line contains oxygen level data
    else if (serialData.startsWith("Oxygen:")) {
      // Extract oxygen level value
      String[] parts = serialData.split(":");
      if (parts.length == 2) {
        try {
          float value = Float.parseFloat(parts[1].trim());
          if (value != 0) { // Check if heart rate value is not zero
            oxygenLevel = value;
            prevOxygenLevel = value; // Update previous non-zero heart rate
          } else {
           oxygenLevel = prevOxygenLevel; // Use previous non-zero heart rate
          }
          println("Oxygen level: " + oxygenLevel);
          // Add oxygen level to your data visualization
        } catch (NumberFormatException e) {
          println("Error parsing oxygen level value: " + parts[1]);
        }
      }
    }
    
    // Check if the line contains confidence level data
    else if (serialData.startsWith("Confidence:")) {
      // Extract confidence level value
      String[] parts = serialData.split(":");
      if (parts.length == 2) {
        try {
          float value = Float.parseFloat(parts[1].trim());
          // You can add similar checks and processing for confidence level data
          if (value != 0) { // Check if heart rate value is not zero
            confidence = value;
            prevConfidence = value; // Update previous non-zero heart rate
          } else {
           confidence = prevConfidence; // Use previous non-zero heart rate
          }
          println("Confidence level: " + confidence);
          // Add confidence level to your data visualization
        } catch (NumberFormatException e) {
          println("Error parsing confidence level value: " + parts[1]);
        }
      }
    }
  }
}
