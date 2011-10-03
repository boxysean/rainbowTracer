#include "LPD8806.h"

#define RAINBOW_ROWS 7

String rainbow[RAINBOW_ROWS] = {
  "########.....###....####.##....##.########...#######..##......##",
  "##.....##...##.##....##..###...##.##.....##.##.....##.##..##..##",
  "##.....##..##...##...##..####..##.##.....##.##.....##.##..##..##",
  "########..##.....##..##..##.##.##.########..##.....##.##..##..##",
  "##...##...#########..##..##..####.##.....##.##.....##.##..##..##",
  "##....##..##.....##..##..##...###.##.....##.##.....##.##..##..##",
  "##.....##.##.....##.####.##....##.########...#######...###..###.",
};

#define LEDS_START 46
#define LEDS_END 96
#define LEDS (LEDS_END - LEDS_START)

int dataPin = 2;   
int clockPin = 3; 

LPD8806 strip = LPD8806(LEDS_END, dataPin, clockPin);

void setup() {
  strip.begin();
  strip.show();
//  Serial.begin(9600);
  pinMode(12, INPUT);
}

int rainbowLength = rainbow[0].length();

void loop() {
//  Serial.println(digitalRead(12));
  
  if (digitalRead(12) == 1) {
    return;
  }
  
  for (int i = 0; i < rainbowLength; i++) {
    int idx = 0;
    
    for (int j = 0, k = 0; j < LEDS; j++, k++) {
      if (k == LEDS / RAINBOW_ROWS) {
        k = 0;
        idx++;
      }
      
      if (rainbow[RAINBOW_ROWS - idx - 1][i] == '#') {
  //        Serial.print("#");
        float progress = (float) j / LEDS;
        strip.setPixelColor(LEDS_END - j - 1, Wheel((int) (progress * 384.0), progress));
      } else {
//        Serial.print(".");
        strip.setPixelColor(LEDS_END - j - 1, strip.Color(0, 0, 0));
      }
    }
    
//    Serial.println(" ");
    
    strip.show();
//    delay(10);
  }
}

uint32_t Wheel(uint16_t WheelPos, float progress)
{
  byte r, g, b;
  switch(WheelPos / 128)
  {
    case 0:
      r = 127 - WheelPos % 128;   //Red down
      g = WheelPos % 128;      // Green up
      b = 0;                  //blue off
      break; 
    case 1:
      g = 127 - WheelPos % 128;  //green down
      b = WheelPos % 128;      //blue up
      r = 0;                  //red off
      break; 
    case 2:
      b = 127 - WheelPos % 128;  //blue down 
      r = WheelPos % 128;      //red up
      g = 0;                  //green off
      break; 
  }
  
  int intensity = 0;
  
  if (progress > 0.75) {
    intensity = 3;
  } else if (progress > 0.5) {
    intensity = 2;
  } else if (progress > 0.25) {
    intensity = 1;
  }  
  
  return(strip.Color(r >> intensity,g >> intensity,b >> intensity));
}

