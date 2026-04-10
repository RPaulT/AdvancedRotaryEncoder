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

  rotaryEncoder

	// Number of valid quadrature steps per one "logical" step.
	// Typical values:
	//   4 → full resolution (default for most encoders)
	//   2 → one step per detent (common for UI knobs)
	.setStepsPerDetent(4)

	// Enables double click detection and sets the maximum time (in ms)
	// between two clicks to be recognized as a double click.
	//
	// Behavior:
	//   value > 0 → double click enabled
	//   value = 0 → double click disabled
	//
	// Note:
	// Single click events are delayed until the double click timeout expires.
	.enableDoubleClick(450)

	// Enables auto-repeat when the button is held down.
	// After an initial delay, repeat events are generated periodically.
	.enableRepeat()

	// Enables rotation acceleration.
	// Faster turning results in larger step values (e.g. 2 or more per tick).
	.enableAcceleration()

	// Enables long press detection and sets the required hold time (in ms).
	//
	// Behavior:
	//   value > 0 → long press enabled
	//   value = 0 → long press disabled
	//
	// When enabled, a long press event is triggered once after the given time.
	.enableLongPress(600)

	// Configures auto-repeat timing:
	//   delayMs    → time before repeat starts after button press
	//   intervalMs → time between repeat events while holding
	.setRepeatTiming(500, 150)

	// Configures acceleration behavior:
	//   windowMs   → max time between steps to be considered "fast rotation"
	//   slowFactor → step multiplier for slow rotation
	//   fastFactor → step multiplier for fast rotation
	.setAcceleration(70, 1, 2);

  rotaryEncoder.begin();
  
  Serial.println("Encoder example started.");
}

void loop() {
  rotaryEncoder.update();

  int delta = rotaryEncoder.read();

  if (delta > 0) Serial.println("CW");
  if (delta < 0) Serial.println("CCW");

//  if (rotaryEncoder.press())       Serial.println("Pressed");
//  if (rotaryEncoder.release())     Serial.println("Released");
  if (rotaryEncoder.click())       Serial.println("Clicked");
  if (rotaryEncoder.doubleClick()) Serial.println("Double clicked");
  if (rotaryEncoder.longPress())   Serial.println("Long press");
//  if (rotaryEncoder.repeat())      Serial.println("Repeat");
}