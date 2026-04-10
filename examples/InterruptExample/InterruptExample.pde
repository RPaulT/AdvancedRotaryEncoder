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

// Example for interrupt-based encoder handling.
// Important:
// Your board must support interrupts on both encoder pins.
//
// Example wiring:
// CLK -> Pin A (here: 2)
// DT  -> Pin B (here: 3)
// SW  -> Button (here: 5)
//
// On many boards, not every pin supports interrupts.
// Please check your board documentation.

RotaryEncoder rotaryEncoder(2, 3, 5);

void setup() {
  Serial.begin(115200);

  rotaryEncoder
    .enableDoubleClick(450)
    .enableLongPress(600);

  if (rotaryEncoder.begin(true)) {
    Serial.println("RotaryEncoder started in interrupt mode.");
  } else {
    Serial.println("Interrupt mode not available on these pins.");
    Serial.println("Falling back to polling mode.");
    rotaryEncoder.begin(false);
  }
}

void loop() {
  rotaryEncoder.update();

  int delta = rotaryEncoder.read();

  if (delta > 0) Serial.println("CW");
  if (delta < 0) Serial.println("CCW");

  if (rotaryEncoder.click())       Serial.println("Click");
  if (rotaryEncoder.doubleClick()) Serial.println("Double click");
  if (rotaryEncoder.longPress())   Serial.println("Long press");
}