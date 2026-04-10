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

// Demonstrates two encoders at the same time.
//
// Encoder 1:
// CLK -> Pin A (here: 2)
// DT  -> Pin B (here: 3)
// SW  -> Button (here: 4)
//
// Encoder 2:
// CLK -> Pin A (here: 6)
// DT  -> Pin B (here: 7)
// SW  -> Button (here: 8)

RotaryEncoder rotaryEncoder1(2, 3, 4);
RotaryEncoder rotaryEncoder2(6, 7, 8);

int value1 = 0;
int value2 = 100;

void setup() {
  Serial.begin(115200);

  rotaryEncoder1.begin();
  rotaryEncoder2.begin();

  Serial.println("Multi encoder example started.");
}

void loop() {
  rotaryEncoder1.update();
  rotaryEncoder2.update();

  int delta1 = rotaryEncoder1.read();
  if (delta1 != 0) {
    value1 += delta1;
    Serial.print("Encoder 1 value: ");
    Serial.println(value1);
  }

  int delta2 = rotaryEncoder2.read();
  if (delta2 != 0) {
    value2 += delta2;
    Serial.print("Encoder 2 value: ");
    Serial.println(value2);
  }

  if (rotaryEncoder1.click()) {
    Serial.println("Encoder 1 click");
  }

  if (rotaryEncoder2.click()) {
    Serial.println("Encoder 2 click");
  }
}