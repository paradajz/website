---
layout: post
title: "Creating custom OpenDeck board variants"
date: "2020-06-11"
tags: 
  - "opendeck"
  - "announce"
  - "programming"
comments: true
---

One of the questions I get asked a lot is: "How do I create my own custom board which uses OpenDeck firmware?". There was never really a stable way of doing that - just in the last year alone I've changed the way new targets/variants are added at least 3 times, each time a bit simpler, so it would make no sense for me to offer detailed answer to that question either here or on the [OpenDeck wiki](https://github.com/shanteacontrols/OpenDeck/wiki) - it would get completely changed soon after that anyways.  Obviously, what I needed was stable interface of defining variant which wouldn't depend on copying the source files to some directory or modifying the build system. No, I needed something very simple and very generic, defined in one file if possible. Well, good news, everyone! There's now a way of doing exactly that.

During the last few weeks, I've completely revamped the build system. Board variants aren't discovered anymore by build system looking for some specific source files in specific directories - instead, [single YAML file](https://github.com/shanteacontrols/OpenDeck/tree/master/targets) is used to describe the entire board variant. Below is an example of [DubFocus](https://shanteacontrols.com/2019/08/06/building-dubfocus-controllers/) board configuration, which uses 4 analog multiplexers, 2 input shift registers and 2 output shift registers:

```
---
  arch: "avr"
  mcuFamily: "avr8"
  mcu: "atmega32u4"
  usb: true
  dinMIDI:
    use: false
  display:
    use: false
  touchscreen:
    use: false
  buttons:
    type: "shiftRegister"
    shiftRegisters: 2
    pins:
      data:
        port: "D"
        index: 3
      clock:
        port: "D"
        index: 4
      latch:
        port: "D"
        index: 5
  analog:
    extReference: true
    type: "4067"
    multiplexers: 4
    pins:
      s0:
        port: "B"
        index: 3
      s1:
        port: "B"
        index: 1
      s2:
        port: "E"
        index: 6
      s3:
        port: "B"
        index: 2
      z0:
        port: "F"
        index: 7
      z1:
        port: "F"
        index: 6
      z2:
        port: "F"
        index: 5
      z3:
        port: "F"
        index: 4
  leds:
    internal:
      present: false
    external:
      type: "shiftRegister"
      shiftRegisters: 2
      invert: true
      pins:
        data:
          port: "D"
          index: 2
        clock:
          port: "D"
          index: 0
        latch:
          port: "D"
          index: 1
        enable:
          port: "C"
          index: 7
  usbLink:
    type: "none"
  bootloader:
    use: true
    buttonIndex: 12
  release: true
  test: true
```

Build system parses this file, adds needed defines for compiler and additional script generates source code with pins. Very simple - parsing process is done automatically by build system so other than to define configuration in YAML file, there is nothing else to do for user. Complete guide on how to define your own board variant is now [available on OpenDeck wiki](https://github.com/shanteacontrols/OpenDeck/wiki/Creating-custom-board-variant).
