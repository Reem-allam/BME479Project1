void screen1_intro() {
  pushStyle();
  background(120, 10, 255);
  fill(255);
  
  //Reset Scatterplot
  lineChartX = new FloatList();
  lineChartY = new FloatList();
  count = 0;
  
  //Reset Bar Chart
  for (int i = 0; i < zoneCounts.length; i++) {
    zoneCounts[i] = 0;
  }  
  
  textSize(40);
  textAlign(CENTER, CENTER);
  text("Welcome to Lab 1, Hit ENTER to start", width/2, 90);
  textSize(30);
  textAlign(CENTER,CENTER);
  text("\n By:Sohaib, Naveed, Hafsa, Reem",width/2,130);
  popStyle();
}
