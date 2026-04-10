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

// Typical UI use case:
// Turn the encoder to change a value.
// Press the button to reset the value.

// CLK -> Pin A (here: 6)
// DT  -> Pin B (here: 7)
// SW  -> Button (here: 5)

RotaryEncoder rotaryEncoder(6, 7, 5);

int value = 50;
const int minValue = 0;
const int maxValue = 100;

void printValue() {
  Serial.print("Value: ");
  Serial.println(value);
}

void setup() {
  Serial.begin(115200);

  rotaryEncoder.begin();

  Serial.println("Value example started.");
  printValue();
}

void loop() {
  rotaryEncoder.update();

  int delta = rotaryEncoder.read();
  if (delta != 0) {
    value += delta;

    if (value < minValue) value = minValue;
    if (value > maxValue) value = maxValue;

    printValue();
  }

  if (rotaryEncoder.click()) {
    value = 50;
    Serial.println("Reset to default.");
    printValue();
  }
}