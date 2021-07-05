---
layout: post
title: "OpenDeck software v2.0"
date: "2018-05-28"
categories: 
  - "development"
tags: 
  - "opendeck"
image: "post_default_header.jpg"
comments: true
---

OpenDeck software has finally reached a [new milestone: v2.0](https://github.com/paradajz/OpenDeck/releases/tag/v2.0.1), so in this post, I'll write about new features in it.

## MIDI channels

Until now, assignment of MIDI channels was only possible globally, per MIDI message. For instance, you could define MIDI channels for MIDI notes, for MIDI CC messages etc, but not individually per component. Well, this is possible as of now, so it's possible to assign any MIDI channel to any button, potentiometer, encoder or LED! This required some trickery with underlying database system that I'm using in OpenDeck since otherwise I wouldn't have enough EEPROM memory. Keep in mind that the brain behind OpenDeck features only 1024 bytes of EEPROM. Basically, given that MIDI channels have values 1-16 it's possible to store them as values 0-15, which fits in 4 bits. Since one byte has 8 bits, it's possible to store two channels in a single byte, hence the introduction of HALFBYTE\_PARAMETER type in database system. Because of this, I can store all MIDI channels I need (176 in total for OpenDeck board) in only 88 bytes. This ability really extends configurability of OpenDeck and I'm sure many will find it useful.

## Encoders

OpenDeck has supported standard quadrature encoders for quite a while now. These encoders work by emitting A and B signals which are [90 degrees out of phase](https://en.wikipedia.org/wiki/Rotary_encoder#/media/File:Quadrature_Diagram.svg). Usually, encoders generate 4 pulses per step (or single movement), so I hardcoded this into OpenDeck firmware without ability to configure this. Recently I came across encoders with buttons on them that don't really work this way - instead, they generate only 2 pulses per step, so obviously this hardcoded approach didn't work. Because of this, it's now possible to configure this to 2, 3 or 4 pulses per step. I'm hoping it's enough for now.

## Daisy chaining

As of v2.0, it's possible to daisy chain OpenDeck boards via DIN MIDI connectors. The number of daisy chained boards is unlimited, however, keep in mind that this is done via usual DIN MIDI interface which isn't really fast, so there is some overhead introduced by each new board.

## Other stuff

v2.0 is really big update. Apart from new features, this release focused more on clean-ups and refactoring of entire codebase. Here's copy paste from GitHub release notes (since I'm lazy):

Improvements:

- 4x faster analog readout
- 5x faster button readout
- Added backup script in doc directory for backing up entire OpenDeck configuration
- Improved handling of RGB LEDs
- Overall memory footprint reduction, misc performance optimizations, internal code refactoring, file number reduction

Fixes:

- Fixes in underlying database system for NRPN values
- Fixed potential reboot loop after firmware update
- Fixed incorrect encoder configuration (setting of new values)

## Web UI

One more thing - Web UI is now [open-sourced](https://github.com/Shantea/paradajz/tree/master/webui) and it's merged into main OpenDeck GitHub repository. I'm not a Web developer and Web UI wasn't done by me, so if anyone is interested in contributing to it I'll be more than happy to accept changes!
