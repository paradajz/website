---
layout: post
title: "Display support on OpenDeck"
date: "2018-03-02"
tags: 
  - "announce"
  - "opendeck"
image: "63cee-10-1.jpg"
comments: true
---

So far, OpenDeck has been really good (IMO, at least) at handling the common components used to build MIDI controllers. What I’ve been wanting to do for quite some time already is to support displays on OpenDeck. Displays can be quite useful to give you visual representation of what is happening on the device, which is often times faster way than checking the software on your PC or other MIDI hardware. So, I’m happy to announce that OpenDeck software now officially supports LCD and OLED displays, with some limitations at the moment.![]({{ site.baseurl }}/images/blog/68251-1.3-i2c-oled.jpg)

![]({{ site.baseurl }}/images/blog/24235-20180218_1923490.jpg)

On OpenDeck, displays are used to display incoming and outgoing MIDI data.

## Hardware

On a hardware level, displays are handled using I2C protocol. I’ve chosen it because of its wiring simplicity as I2C only requires two lines for communication, called SDA and SCL. On top of that, I2C is expandable since it supports up to 127 devices on a bus, which is great since that gives me possibility to support other I2C capable hardware on OpenDeck in the future using those same two wires.

## Software

On the software side of things, I’m using [U8X8 library](https://github.com/olikraus/u8g2/wiki) since it already supports every relevant display controller out there, so why reinvent the wheel? Great thing about this library is that it writes data to displays directly, making it very lightweight and fast. Another great thing about it is that it allows custom hardware access to the displays. I’ve  written a simple wrapper for the library for easier access, and to allow me to define a display resolution and controller in run-time. Because of this, it’s really simple to configure the display in the Web interface.

## Web interface configuration

As with all the supported components, display configuration is really simple. There’s a new option called Display on the sidebar in the interface. There are several configurable settings:

- Display state - Used to enable or disable the display.
- Display controller - Used to select controller which controls the display. Currently, only SSD1306 is tested because it's the only one I have, but as I've said already, I'm supporting everything U8X8 library supports, so this isn't a big issue.
- Display resolution - Used to select display resolution in pixels. I've tested 128x64 and 128x32 resolutions and they both work without issues.
- Welcome message on startup - When enabled, "Welcome!" text will be printed out letter by letter when the board is turned on.
- Version info on startup - When enabled, firmware and hardware version will be printed out when the board is turned on. If welcome message is enabled, this message will be printed after it.
- MIDI event retention - When this is enabled, last incoming or outgoing MIDI message will stay on display indefinitely, until new event happens. When disabled, last MIDI event stays for defined amount of time.
- Message retention time - Specifies time in seconds during which last MIDI message will be displayed. After this time, MIDI event will be cleared from display.
- Alternate note display - When this is enabled, MIDI notes will be displayed in "nicer" format, ie. C#2. Otherwise, raw MIDI note number will be displayed (0-127).
- Octave normalization value - Various software has different way of calculating MIDI octave, since there's no really standardized way to do it. For instance, if we take MIDI note 0, "nicer" format of it is C (or C0). However, some software will display this note as C-1, and some as C-2. Instead of forcing my own preferred way of calculating it, user has a choice of octave "normalization". For instance, if normalization is set to 0, than C0 will really be shown as C0. If normalization value is 2, C0 will be displayed as C-2.

![]({{ site.baseurl }}/images/blog/17763-28335931_765190873674155_4257037372266251220_o.png)

## Limitations

Currently, displays aren't supported on official OpenDeck board, which may seem confusing and possibly dumb, but I’ve used all the pins already so I have none of them left, and of top of that, I don’t have enough memory or RAM to implement it, which isn’t ideal and will result in complete redesign of the OpenDeck board some time in the future. I've pretty much maxed out possibilities of ATmega32u4 that I'm using on OpenDeck boards. Because of this, displays are supported only on Arduino Mega and Teensy++ 2.0 boards at the moment, since they have much more memory and RAM, as well as free I2C pins.
