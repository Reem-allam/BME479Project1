void screen4() {
  pushStyle();
   
  textSize(50); 
  textAlign(CENTER, CENTER);
  
  if (heartRate > 90) {
    background(255, 0, 0);
    fill(255); // Set text color to white
    text("YOU ARE STRESSED!\nYour Heart Rate is: " + heartRate,  width/2, height/2);
  } else {
    background(0, 255, 0);
    fill(255); // Set text color to white
    text("YOU ARE CALM!\nYour Heart Rate is: " + heartRate, width/2, height/2);
  }
  
  fill(0);
  textSize(40); 
  textAlign(CENTER, CENTER); 
  text("MODE II: RELAXED VS. STRESSED MODE", width/2, 30); 
  
 
  popStyle(); // Pop the style changes back to default
  
  // add resting heart rate in corner if we are able to calcualte that. 
}
