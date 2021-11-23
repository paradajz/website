---
layout: post
title: "OpenDeck software v2.1.1"
date: "2018-08-22"
categories: 
  - "development"
tags: 
  - "new-release"
  - "opendeck"
  - "update"
image: "post_default_header.jpg"
comments: true
---

Yesterday I've released [OpenDeck v2.1.1](https://github.com/shanteacontrols/OpenDeck/releases/tag/v2.1.1). Time for another OpenDeck release feature roundup!

_There's been a few releases on GitHub since [v2.0](https://shanteacontrols.com/2018/05/28/opendeck-software-v2-0/), however I don't really write here about every release since most of them contain only a handful of fixes and new features. This post covers all the news since [v2.0](https://github.com/shanteacontrols/OpenDeck/releases/tag/v2.0.1)._

## Pitch bend

Pitch bend is now supported analog mode - just select it for any analog component in web interface. Since this is a 14-bit MIDI value, and ADC on all OpenDeck boards is actually 10-bit, to get 14 bit resolution code is converting lower range to higher range of values. As an result, not all values are actually available.

## Program change

Buttons now support incrementing or decrementing Program change mode. When configured, each successive button press will send next or previous program value on specified channel. For instance, if a button is configured to send Program change 1 on channel 1, and incrementing program change mode is selected, next press will send program 2 on same channel, then program 3 etc.. Same is valid for decrementing type (values decrease by 1 on each press).

Encoders can now also be configured to increase the program value in one direction and decrease it in another.

## LEDs

Multiple LED control types are now available:

- MIDI In: Note + CC - Notes are used to control LED state/color and CC messages to control blink state.
- MIDI In: CC + note - CC messages are used to control LED state/color and notes to control blink state.
- MIDI In: Note / S+B - Notes are used to control both LED state/color and blinking.
- MIDI In: CC / S+B - CC messages are used to control both LED state/color and blinking.
- MIDI In: Program change - Program change messages are used to control LED state/color. On RGB LEDs, color depends on MIDI program value. In this mode, LED activation value is ignored. Blink state setting isn't possible in this mode.
- Local control: Note - Buttons and FSR sensors connected to the board which are configured to send Note messages are used to control LED state/color only (no blinking).
- Local control: CC - Buttons and FSR sensors connected to the board which are configured to send CC messages are used to control LED state/color only (no blinking).
- Local control: Note / S+B - Same as MIDI In: Note / S+B, only components on board (buttons/FSRs) are controlling the LEDs.
- Local control: CC / S+B - Same as MIDI In: CC / S+B, only components on board (buttons/FSRs) are controlling the LEDs.
- Local control: Program change - Same as MIDI In: Program change, only components on board (buttons/FSRs) are controlling the LEDs.

Global LED option "blink time" has been removed since blink speed can now be set individually per LED using MIDI messages.

### MIDI clock

Another thing: LEDs can now blink in sync with MIDI clock! Global option called "Blinking via MIDI clock" has been added to configuration tool. Once enabled, the board listens to incoming MIDI clock messages and depending on received MIDI note/CC message, divider is then used to determine on which MIDI clock pulse the LEDs should toggle state. More info can be found on [LED control wiki page](https://github.com/Shantea/OpenDeck/wiki/LED-control) on GitHub.

## Other

As always, there's also been many performance improvements and bug fixes - you can find further info on [releases page](https://github.com/shanteacontrols/OpenDeck/releases) on GitHub.

## Future plans

Recently I've started with initial work on supporting touch screen displays on OpenDeck. Plan is to support entire [Nextion line from ITead](https://nextion.itead.cc/). I have also started drawing next revision of OpenDeck board which will feature STM32F4 MCU - much more memory and processing power which will allow me to continue advancing the OpenDeck further, as I've currently nearly maxed out all the capabilities of MCU found on OpenDeck (ATmega32u4).
