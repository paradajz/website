---
layout: post
title: "OpenDeck boards v3 in development"
date: "2022-04-09"
tags: 
  - "opendeck"
  - "announce"
image: "od3/2.png"
comments: true
---

The new OpenDeck boards are coming. Not yet, but soon enough!

It's been 4 months now since the OpenDeck boards have been sold out. [Few posts ago](https://shanteacontrols.com/2021/11/23/opendeck-6-what-comes-next/) I wrote on why the future of the boards looks bleak. In short: high prices and general electronics shortage make it very hard to design anything involving MCU right now.

I've found a workaround and started to design the new OpenDeck board. It's quite different from my previous boards. It's gonna be big! These are the main features:

* 128 digital inputs
* 64 digital outputs
* 64 analog inputs
* DIN MIDI
* USB MIDI
* DMX
* Bluetooth*
* Accelerometer / gyroscope / magnetometer*

Why it's so big? Well, since OpenDeck firmware supports many other boards, some with the amount of I/O similar to the original board, this design feels like a more compelling proposition, compared to the boards you can buy off the shelf. Many people have been asking for more I/O, so here we are.

Due to the chip shortage, the idea is revised a bit - this board will accept either [Arduino Nano 33 BLE](https://store.arduino.cc/products/arduino-nano-33-ble) (OpenDeck variant A) or [STM32F4 Black Pill](https://www.aliexpress.com/item/1005001456186625.html) boards (OpenDeck variant B). The main difference is Bluetooth and acc/gyro/mag sensors are available only on Arduino board, otherwise for end users it's the same thing. This has many advantages compared to my previous design which was fully my own:

* I don't have to lock the design to a specific MCU
* Shortage affects me much less this way (if at all)
* This makes the board compatible with 5 (!) boards: there's two variants of Arduino 33 BLE board and 3 variants of Black Pill boards. Even if one becomes unavailable, there are many others to choose from.
* These boards are actually available to buy unlike standalone MCUs

Price *should* be somewhat similar to the previous board, and availability - who knows? Hopefully in 2-3 months. This is also my first design in KiCAD after 10 years of using EAGLE, so just learning the software alone should take a while.

Some renders of the board below (Arduino should obviously be blue, not sure why it's brown in render).

![]({{ site.baseurl }}/images/blog/od3/1.png)

![]({{ site.baseurl }}/images/blog/od3/2.png)
![]({{ site.baseurl }}/images/blog/od3/3.png)
![]({{ site.baseurl }}/images/blog/od3/4.png)

This board also addresses some of the shortcomings of the previous board - there's more space between pin headers now, connectors for +5V and +3V have been added and there are also real connectors now for I2C and touchscreen.