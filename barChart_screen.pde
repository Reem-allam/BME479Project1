void BarChart_screen() {
  pushStyle();
  textSize(20);
  fill(204, 102, 0);
  textSize(20);
  textAlign(LEFT, TOP);
  text ("Press 'r' to reset\nPress 'e' for an exercise list\nPress 'b' to go back",20,20);
  textAlign(CENTER,RIGHT);
  
  textAlign(CENTER, CENTER);
  textSize(32);
  fill(0);
  String durationString = time();

  text("Timer: "+ durationString, width/2, 30);//prints the duration on the screen
  
  // Draw bar chart
  int startX = 100;
  int spacing = 20;
  int startY = 100;
  int barHeight = 50;
  int maxBarWidth = width - startX - 20; // Adjust for margins

  // Calculate the maximum count to scale the bars within the screen
  int maxCount = max(zoneCounts);

  for (int i = 0; i < zoneCounts.length; i++) {
    fill(0);
    textAlign(RIGHT, CENTER);
    textSize(16);
    text("Zone " + (i + 1), startX - 10, startY + i * (barHeight + spacing) + barHeight / 2); //zone labels

    // Calculate the width of the bar proportional to the maximum count
    int barWidth = (int) map(zoneCounts[i], 0, maxCount, 0, maxBarWidth);

    fill(getZoneColor(i));
    rect(startX, startY + i * (barHeight + spacing), barWidth, barHeight);

    fill(0);
    text(zoneCounts[i], startX + barWidth + 10, startY + i * (barHeight + spacing) + barHeight / 2); //counts how many points in that zone
  }
  
}

color getZoneColor(int zoneIndex) {
  // Define colors for each zone
  color[] zoneColors = {color(0, 0, 0), color(0, 0, 255), color(0, 255, 0), color(255, 165, 0), color(255, 0, 0)};
  
  return zoneColors[zoneIndex];
}
