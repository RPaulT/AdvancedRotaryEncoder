# RotaryEncoder

A lightweight and user-friendly rotary encoder library for Arduino-compatible platforms.

Designed for responsive UI applications with minimal overhead and maximum flexibility.

---

## Features

- Rotary encoder A/B decoding (robust state machine)
- Encoder push button support
- Click / Double Click / Long Press / Repeat events
- Optional acceleration for fast rotation
- Polling-first design (simple & reliable)
- Optional interrupt support
- Multiple encoder instances
- Event queue + simple one-shot API
- Fully configurable timing
- No dynamic memory, no `String`, no STL required

---

## Installation

### Arduino IDE

1. Download or clone this repository
2. Place it in your `Arduino/libraries/` folder
3. Restart the Arduino IDE

## BasicExample:
```cpp
#include <RotaryEncoder.h>

RotaryEncoder rotaryEncoder(6, 7, 5);

void setup() {
  Serial.begin(115200);
  rotaryEncoder.begin();
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