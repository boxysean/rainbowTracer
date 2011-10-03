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

int colourPos[7];
int colours[7];

void setup() {
  strip.begin();
  strip.show();
  
  for (int i = 0; i < 7; i++) {
    colourPos[i] = LEDS * i / 7;
    colours[i] = 384 * i / 7;
  }
}

int offset = 0;

void loop() {
  
  for (int i = 0; i < 7; i++) {
    int pos = (colourPos[i] + offset) % LEDS;
    strip.setPixelColor(pos + LEDS_START, Wheel(colours[i], 1.0 - (float) pos / LEDS));
  }
  
  strip.show();
  
  for (int i = 0; i < 7; i++) {
    int pos = (colourPos[i] + offset) % LEDS;
    strip.setPixelColor(pos + LEDS_START, strip.Color(0, 0, 0));
  }
  
  if (++offset == LEDS) {
    offset = 0;
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

