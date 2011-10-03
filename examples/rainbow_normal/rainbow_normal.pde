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

  for (int i = 0; i < LEDS; i++) {
    int colourIdx = i / (COLOURS-1);
    strip.setPixelColor(LEDS_END - 1 - i, Wheel((int) (384.0 * colourIdx / COLOURS)));  
  }
  
  strip.show();
}

void loop() {

}

uint32_t Wheel(uint16_t WheelPos) {
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
  return(strip.Color(r,g,b));
}
