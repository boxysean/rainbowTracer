#include "LPD8806.h"

#define LEDS_START 40
#define LEDS_END 96
#define LEDS (LEDS_END - LEDS_START)

#define COLOURS 8

int dataPin = 2;
int clockPin = 3;

int thickness = 4;
int state = 0;

LPD8806 strip = LPD8806(LEDS_END, dataPin, clockPin);

void setup() {
  strip.begin();
  strip.show();
}

void loop() {
  if (++state == thickness * 4) {
    state = 0;
  }
  
  int idx = state / thickness;
  
  boolean low = idx != 2;
  boolean high = idx != 0;
  
  for (int i = 0; i < LEDS; i++) {
    int colourIdx = i / (COLOURS-1);
    int where = i - colourIdx * (COLOURS-1);
    int stage = (i - colourIdx * (COLOURS-1)) / thickness;
    
    if (where < 1) {
      stage = -1;
    }
    
    if ((stage == 0 && low) || (stage == 1 && high)) {
      float progress = (float) i / LEDS;
      strip.setPixelColor(LEDS_END - 1 - i, Wheel((int) (384.0 * colourIdx / COLOURS), progress));  
    } else {
      strip.setPixelColor(LEDS_END - 1 - i, 0);
    }
  }
  
  strip.show();
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

