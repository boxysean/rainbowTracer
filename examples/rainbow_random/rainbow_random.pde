#include "LPD8806.h"

#define LEDS_START 42
#define LEDS_END 96
#define LEDS (LEDS_END - LEDS_START)

#define COLOURS 8

float colours[COLOURS];
int pos[COLOURS];
int startPos[COLOURS];

int dataPin = 2;
int clockPin = 3;

LPD8806 strip = LPD8806(LEDS_END, dataPin, clockPin);

void setup() {
//  Serial.begin(9600);
  
  for (int i = 0; i < COLOURS; i++) {
    colours[i] = i * 383.9 / (COLOURS - 1);
    startPos[i] = pos[i] = (int) ((float) i * LEDS / (COLOURS - 1));
  }
  
  strip.begin();
  strip.show();
}

void loop() {
  for (int i = 1; i < COLOURS-1; i++) {
    int flip = random(3) - 1;
    
    switch (flip) {
    case -2:
    case -1:
      pos[i] = max(max(startPos[i-1] + 1, pos[i] + flip), pos[i-1]+2);
      break;
    
    case 0:
      // do nothing
      break;
    
    case 1:
    case 2:
      pos[i] = min(min(startPos[i+1]-1, pos[i] + flip), pos[i+1]-2);
      break;
    }
  }
  
//  int idxx = 0;
//  int idxxsp = 0;
//  
//  for (int i = 0; i < LEDS; i++) {
////    if (startPos[idxxsp] == i) {
////      Serial.print('X');
////    } else
//    if (pos[idxx] == i) {
//      Serial.print('x');
//    } else {
//      Serial.print('.');
//    }
//    
//    if (i >= pos[idxx]) {
//      idxx++;
//    }
//    
//    if (i >= startPos[idxxsp]) {
//      idxxsp++;
//    }
//  }
//  
//  Serial.println();
  
  int idx = 0;
  
  for (int i = 0; i < LEDS; i++) {
    if (i == pos[idx+1]) {
      idx++;
    }
    
    float percent = ((float) i - pos[idx]) / (pos[idx+1] - pos[idx]);
//    float colour = (1.0 - percent) * colours[idx] + percent * colours[idx+1];
    float colour = colours[idx];
    float progress = (float) i / LEDS;
    strip.setPixelColor(LEDS_END - 1 - i, Wheel((int) colour, progress));
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

