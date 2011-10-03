#include "LPD8806.h"

#define LEDS_START 40
#define LEDS_END 96
#define LEDS (LEDS_END - LEDS_START)

#define COLOURS 8

int dataPin = 2;
int clockPin = 3;

int steps = 10;
int offset = 0;
boolean forward = true;

int masterCount = 3;

LPD8806 strip = LPD8806(LEDS_END, dataPin, clockPin);

void setup() {
  strip.begin();
  strip.show();
}

void loop() {
  if (forward) {
    if (++offset == steps) {
      forward = false;
    }
  } else {
    if (--offset == 0) {
      forward = true;
    }
  }
  
  int count = masterCount;
  int lastIdx = -1;
  
  for (int i = 0; i < LEDS; i++) {
    int ledIdx = LEDS_END - 1 - i;
    if (i < offset || i >= offset + LEDS - steps) {
      strip.setPixelColor(ledIdx, 0);
    } else if (i < offset + LEDS - steps) {
      int idx = (i - offset) / (COLOURS - 1);
      
      if (count-- >= 0 || idx != lastIdx) {
        int colour = idx * 384.0 / (COLOURS - 1);
        float progress = (float) i / LEDS;
        strip.setPixelColor(ledIdx, Wheel(colour, progress));
        if (idx != lastIdx) {
          count = masterCount-1;
          lastIdx = idx;
        }
      } else {
        strip.setPixelColor(ledIdx, 0);
      }
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

