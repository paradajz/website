---
layout: post
title: "OpenDeck v6 - what comes next?"
date: "2021-11-23"
categories: 
  - "development"
  - "info"
tags: 
  - "opendeck"
image: "cover_opendeck_v6.jpg"
comments: true
---

OpenDeck v6 was released a while ago, it's just that I haven't written a blog post about it. Let's correct that.

## DMX

OpenDeck now supports DMX output through [OLA (Open Lighting Architecture)](https://www.openlighting.org/ola/). OLA implements interface which various lighting software can use (such as [QLC+](https://qlcplus.org/)). This is done via additional USB interface which enumerates once the OpenDeck boards are plugged in - serial port. DMX support involves adding some circuitry to the board. This information is available [on the wiki](https://github.com/shanteacontrols/OpenDeck/wiki/Connections#dmx). Once the circuitry is added, the only thing left is to click "Enable DMX" in OpenDeck configurator. Simple as that.

## Support for more boards

OpenDeck now supports more boards than ever. These are the newly added boards on which OpenDeck firmware can be loaded:

* [Waveshare Core405R](https://www.waveshare.com/core405r.htm)
* [Waveshare Core407V](https://www.waveshare.com/core407v.htm)
* [Waveshare Core407I](https://www.waveshare.com/core407i.htm)
* [STM32F4VE](https://stm32-base.org/boards/STM32F407VET6-STM32-F4VE-V2.0) ([eBay](https://www.ebay.com/itm/401956886691?hash=item5d967f58a3:g:fFcAAOSw4fhdy2rk))
* [TPyBoard (PyBoard clone)](http://www.chinalctech.com/m/view.php?aid=338) ([eBay](https://www.ebay.com/itm/183887614794?hash=item2ad08e534a:g:bmsAAOSwrSpdLtFM))

Flashing instructions have been updated for all these boards and also greatly improved for other boards (such as Arduino Mega). Check the docs [on the wiki](https://github.com/shanteacontrols/OpenDeck/wiki/Flashing-the-OpenDeck-firmware).

## Other stuff

* Analog components can now be used to control LED state in local mode. I've been asked about this for a while, and now it's possible due to the major redesign of some components.
* Program change and preset change LED control modes are now separated. Preset change using MIDI in message has been removed to avoid confusion.
* Smoother analog readouts due to the improved analog filtering
* All kinds of minor fixes and improvements

# What next?

I only have about 10 more OpenDeck boards to sell via Tindie and then I'm out of stock. Due to the various factors, I probably won't be ordering new batches of boards, which is why there was a great focus on adding support for more boards in the past few months. On top of this, OpenDeck source code is now in a state where I can basically call it finished - as much as I hate to say that since I've been doing this for the past 6 years. I just don't know what else to add to it! It runs on various boards, custom boards can be created by users, it supports all the stuff you'd expect and then some, it has great configurator, I've done my best to document the project properly etc. I'm sure I (or someone else) will find some bugs from time to time, which will be fixed, of course. As for the future features - you tell me!