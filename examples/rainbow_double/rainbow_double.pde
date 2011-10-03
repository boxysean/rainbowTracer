#include "LPD8806.h"

#define LEDS_START 40
#define LEDS_END 96
#define LEDS (LEDS_END - LEDS_START)

#define COLOURS 7
#define SPACE 10

int dataPin = 2;
int clockPin = 3;

LPD8806 strip = LPD8806(LEDS_END, dataPin, clockPin);

void setup() {
  strip.begin();

  int firstEnd = (LEDS - SPACE) >> 1;
  int secondBegin = firstEnd + SPACE;

  for (int i = 0; i < firstEnd; i++) {
    int colourIdx = COLOURS * i / firstEnd;
    float progress = (float) i / LEDS;
    strip.setPixelColor(LEDS_END - 1 - i, Wheel((int) (384.0 * colourIdx / (COLOURS+1)), progress));  
  }
  
  for (int i = secondBegin; i < LEDS; i++) {
    int colourIdx = COLOURS * (i - secondBegin) / (LEDS - secondBegin);
    float progress = (float) (secondBegin + i) / LEDS;
    strip.setPixelColor(LEDS_END - 1 - i, Wheel((int) (384.0 * colourIdx / (COLOURS+1)), progress));  
  }
  
  strip.show();
}

void loop() {

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

