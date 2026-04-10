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

// Simple menu example:
// - turn to select an item
// - click to open/confirm
// - long press to go back

// CLK -> Pin A (here: 6)
// DT  -> Pin B (here: 7)
// SW  -> Button (here: 5)

RotaryEncoder rotaryEncoder(6, 7, 5);

const char* menuItems[] = {
  "Start",
  "Settings",
  "Info"
};

const int menuCount = sizeof(menuItems) / sizeof(menuItems[0]);

int menuIndex = 0;
bool inSubmenu = false;

void printMenu() {
  Serial.println();
  Serial.println("Main menu:");

  for (int i = 0; i < menuCount; i++) {
    if (i == menuIndex) Serial.print(" > ");
    else                Serial.print("   ");

    Serial.println(menuItems[i]);
  }
}

void printSubmenu() {
  Serial.println();
  Serial.print("Opened: ");
  Serial.println(menuItems[menuIndex]);
  Serial.println("Long press to go back.");
}

void setup() {
  Serial.begin(115200);

  rotaryEncoder.enableLongPress(700);

  rotaryEncoder.begin();
  
  Serial.println("Menu example started.");
  printMenu();
}

void loop() {
  rotaryEncoder.update();

  if (!inSubmenu) {
    int delta = rotaryEncoder.read();

    if (delta > 0) {
      menuIndex++;
      if (menuIndex >= menuCount) menuIndex = 0;
      printMenu();
    }

    if (delta < 0) {
      menuIndex--;
      if (menuIndex < 0) menuIndex = menuCount - 1;
      printMenu();
    }

    if (rotaryEncoder.click()) {
      inSubmenu = true;
      printSubmenu();
    }
  } else {
    if (rotaryEncoder.longPress()) {
      inSubmenu = false;
      printMenu();
    }
  }
}