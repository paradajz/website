---
layout: post
title: "OpenDeck software v4.0.0 - What's new?"
date: "2019-06-21"
tags: 
  - "opendeck"
  - "programming"
  - "announce"
comments: true
---

There were few interesting additions to OpenDeck software from my last post which was about v3.1.0, so I'll recap everything noteworthy in this post, as well as some other stuff.

## Pitch bend

This was something that a few people have asked me about in the past and I'm happy to say that the OpenDeck firmware now supports pitch bend for analog components. Before you ask, no, it's not real 14-bit resolution since the ADC currently present on the MCUs that I'm using is 10-bit only. Still, the range is much higher than the usual 7-bit.

## Encoders

Sick of endless rotation on encoders to reach the desired value? Acceleration is now supported feature with 3 selectable acceleration speeds (slow, medium and fast). Also, I have added another nice feature to encoders: remote sync. When enabled, it will sync the last sent encoder value with the one from DAW. If the encoder is configured in CC mode and the board receives CC message with channel and ID being the same as on the configured encoders on board, CC value will be applied to encoder, so next rotation of encoder will either increment or decrement received value by 1.

Encoders now also support pitch bend, but unlike analog components, encoders support full 14-bit range. While I was at it, I've also added NRPN (both 7 and 14-bit) support for encoders as well.

## Arduino binaries coming with bootloader

Since v3.1.1, the official OpenDeck repository now contains merged bootloader and application binary for all supported boards. The flashing script will now flash those binaries, which means the bootloader is installed on the board as well, removing the need to reflash the board with external programmer once the new OpenDeck firmware is released.

## WebUI

WebUI can now run locally, without Google Chrome or even Internet connection. Many people have been asking about this and now it's possible. Just download the version you need for your OS from the [GitHub releases](https://github.com/shanteacontrols/OpenDeck/releases) page. I have also added WebUI retroactively for every version of OpenDeck since the first version which had WebUI in repository (v2.0.1)

## v4.0.0

The only major thing in this version is the fix for incorrect handling of RGB LEDs in certain scenarios. However, the code has underwent major refactoring which is why I've decided to bump the major version this time.

## The official boards

I'm happy to say that the new batch of OpenDeck boards has finally arrived and you can order yours right now on [Tindie](https://www.tindie.com/products/paradajz/opendeck-diy-midi-platform/).

## Bonus

The gerber files needed to produce the OpenDeck boards are now [available in repository](https://github.com/shanteacontrols/OpenDeck/tree/master/bin/sch/opendeck), which means you can download the BOM and gerbers and send them to a PCB house if you don't want to buy them from me (although, I would be grateful if you did).
