/*
 * RotaryEncoder Library
 *
 * A lightweight and user-friendly rotary encoder library
 * for Arduino-compatible platforms.
 *
 * Developed by Paul Thomsen
 *
 * Copyright (c) 2026 Ruben Paul Thomsen
 *
 * This library is open-source and released under the MIT License.
 * You are free to use, modify, and distribute this software
 * in accordance with the terms of the license.
 *
 * If you find this library useful, please consider supporting
 * open source development by sharing your projects or contributing.
 *
 * Full license text available in the LICENSE file.
 * All text above must be included in any redistribution.
 */

#include <RotaryEncoder.h>

// CLK -> Pin A (here: 6)
// DT  -> Pin B (here: 7)
// SW  -> Button (here: 5)

RotaryEncoder rotaryEncoder(6, 7, 5);

void setup() {
  Serial.begin(115200);
  rotaryEncoder.begin();
  
  Serial.println("Basic encoder example started.");
}

void loop() {
  rotaryEncoder.update();

  int delta = rotaryEncoder.read();

  if (delta > 0) Serial.println("CW");
  if (delta < 0) Serial.println("CCW");

  if (rotaryEncoder.click()) {
    Serial.println("Click");
  }
}