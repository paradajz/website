---
layout: post
title: "Status of OpenDeck on Arduino"
date: "2019-07-02"
tags: 
  - "opendeck"
  - "arduino"
  - "announce"
comments: true
---

This will be short post clearing up the confusion around the status of Arduino boards and OpenDeck firmware on them.

[1.5 years ago](https://shanteacontrols.com/2017/12/14/opendeck-on-arduino/) I've made the OpenDeck firmware run on Arduino boards. At the time, I was selling Arduino boards with OpenDeck preinstalled. I was also selling the precompiled firmware for the people who didn't want to bother with compiling the firmware on their own. Compiling and flashing the firmware was free, of course, with [OpenDeck firmware being open](https://github.com/shanteacontrols/OpenDeck).

I am no longer selling any of the Arduino boards with OpenDeck preloaded on them through Tindie, nor am I selling the precompiled firmware for them. Since OpenDeck firmware v3.0.0 precompiled binares are part of the [official release of OpenDeck](https://github.com/shanteacontrols/OpenDeck/releases). I have also added guides for both [compiling](https://github.com/shanteacontrols/OpenDeck/wiki/Building-the-OpenDeck-firmware) and [flashing](https://github.com/shanteacontrols/OpenDeck/wiki/Flashing-the-OpenDeck-firmware) the firmware on all OpenDeck-supported boards. Basically, there's nothing to sell here anymore. Grab the binary from the GitHub, read the flashing guide and that's it.

I am still selling the official OpenDeck boards [through Tindie](https://www.tindie.com/products/paradajz/opendeck-diy-midi-platform-m/) - that will not change.

EDIT: 2021.11.23

OpenDeck firmware no longer supports Arduino Uno / Leonardo / Pro Micro. This is due to the low amounts of flash, EEPROM and RAM on those microcontrollers. Supported AVR boards are Arduino Mega2560 and Teensy++ 2.0.