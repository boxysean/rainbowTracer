== Hello

We used Adafruit's LPD8806 RGB LED strand and library, couldn't be more happy with it. There is one LED in our three metre strand that lost its red component, but besides that, a great product to use. The waterproofing helped us immensely when we deployed outdoors at a festival.

In particular, we used this for light painting. We placed frosted plexiglass a few inches away from the LEDS to diffuse the light, which was essential for good esthetics. A writeup of our implementation is [here](http://www.boxysean.com/projects/rainbow-tracer.html).

There's [a fork](https://github.com/cjbaar/LPD8806) out there that claims to be 34x faster than the Adafruit code offering. I believe the claim because there is a clear attempt to use bit operations rather than multiplication and division. However, we did not use the high speed library because we were on a time limit, but will investigate it in the future. The 34x speed upgrade will take you a long way over the original Adafruit lib.

== Changes

Added our sketches to the examples photo. They are quick examples on further implementations of the library. Please contact me if you have any questions.

Besides that, no other changes.

== Original Readme

This is an Arduino library for LPD8806 (and probably LPD8803/LPD8809) PWM LED driver chips, strips and pixels

Pick some up at http://www.adafruit.com/products/306

To download. click the DOWNLOADS button in the top right corner, rename the uncompressed folder LPD8806. Check that the LPD8806 folder contains LPD8806.cpp and LPD8806.h

Place the LPD8806 library folder your <arduinosketchfolder>/libraries/ folder. You may need to create the libraries subfolder if its your first library. Restart the IDE.
