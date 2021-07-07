---
layout: post
title: "OpenDeck SysEx protocol - stable!"
date: "2014-10-09"
image: "post_default_header.jpg"
comments: true
---

Last time I wrote about OpenDeck SysEx protocol, there were still many unsolved problems and issues, together with lack of functionality. Since I actually released OpenDeck software on GitHub couple of days ago, it's time to write a new post, explaining all current features, and announcing some new ones.

## Hello World

Back when I first wrote about SysEx protocol, I explained how SysEx programming doesn't work until "Hello World" message has been received. That bit wasn't implemented then, but it is now. Hello message consists of three ID bytes only (hex code):

**F0 00 53 43 F7**

After the message is sent to controller, it responds with those same ID bytes, and ACK at the end (0x41).

**F0 00 53 43 41 F7**

When this message is received, controller can be programmed using System Exclusive.

## Message format

Main message format for SysEx is left untouched, as it proved efficient and reasonably easy to use:

**F0 ID ID ID WISH AMOUNT MESSAGE\_TYPE MESSAGE\_SUBTYPE PARAMETER\_ID\* NEW\_PARAMETER\_ID\* F7**

Bytes marked with asterisk are optional, since their use depends on WISH and AMOUNT bytes.

# Message types

Since last post, only thing changed here are MESSAGE\_TYPE codes:

- SYS\_EX\_MT\_MIDI\_CHANNEL
- SYS\_EX\_MT\_HW\_PARAMETER
- SYS\_EX\_MT\_FREE\_PINS,
- SYS\_EX\_MT\_SW\_FEATURE
- SYS\_EX\_MT\_HW\_FEATURE
- SYS\_EX\_MT\_BUTTON
- SYS\_EX\_MT\_POT
- SYS\_EX\_MT\_ENC
- SYS\_EX\_MT\_LED
- SYS\_EX\_MT\_ALL

MIDI channel has code 0, HW parameter 1, and every next byte has next incremented value.

## Additions

Pots now have additional sub-types: lower and upper CC limit. Using those message, each pot can have defined CC range. After you define custom range, ie. 40-120, CC message won't be "cut-off", it will be interpolated across whole pot range instead.

Another addition from last time is the "Free pins" message, that is, you can now configure those four free pins available on reference PCB. Due to the mistake in design, pin C can only be configured as output, since it's connected to pin 13 on Arduino. It has nothing to do with pin 13 itself, it's just the fact that pretty much every Arduino out there has LED and resistor connected to that pin, so using it as input is harder, but not impossible. It would require usage of some extra components, but for convenience sake I've decided that it can only be configured as output. Because of that, you cannot increase number of inputs to 64 (four extra rows in button matrix), but 56 instead. No big deal, but I'll most certainly pick another pin for user configuration on next PCB design.

Example of free pin configuration:

Let's set pin A as output, which will result in increase of maximum number of LEDs to 40:

**F0 00 53 43 01 00 02 00 00 02 F7**

F0 is usual SysEx message start, followed by three ID bytes. We want to configure (set) pin, so WISH byte is 01. Since we only want to set one pin, amount it 0 (single). Message type for free pin message is 02, with no sub-type. Pin A parameter code is 00, and since we want to set it as output, new parameter code is 02. Setting it to 0 disables it, and setting it to 1 would configure that pin as extra button row.

Response from the controller is the following message:

**F0 00 53 43 01 00 02 00 41 F7**

Response has been also re-modeled a bit since last time. It copies everything from the original message, except the parameter and new parameter (if message wish is set, that is). It also places ACK (0x41) on the end of message, so that it's easier to notice if the message has been handled properly.

## Data restoration

Data restoration is now possible as well. You can use it to restore single parameter, all parameters within message type or everything back to default.

Some examples of restoration:

Setting button channel back to default (1): **F0 00 53 43 02 00 00 00 00 F7**

Setting all channels to default: **F0 00 53 43 02 01 00 00 F7**

Setting all pots to their default state (disabled): **F0 00 53 43 02 01 06 00 F7**

Complete factory reset: **F0 00 53 43 02 01 09 00 F7**

If entire controller is restored to defaults, first thing that needs to be configured is board type. Board type for OpenDeck reference board is 01, and you need to set it using the following message:

**F0 00 53 43 01 00 01 00 00 01 F7**

## LED configuration

LEDs configuration is another thing that still wasn't possible when I wrote first SysEx post. LEDs now have several sub-types of message:

- SYS\_EX\_MST\_LED\_ACT\_NOTE
- SYS\_EX\_MST\_LED\_START\_UP\_NUMBER
- SYS\_EX\_MST\_LED\_STATE

Again, LED\_ACT\_NOTE has code 0, START\_UP\_NUMBER is 1, and LED\_STATE is 2. Using the first subtype it's possible to select which MIDI note will turn on or off the LED. Start-up number is used only during the start-up routine. Since that routine deals with LEDs one-by-one, you can use that message sub-type to use any LED order you want. LED\_STATE subtype is used to test the LEDs. You can set them to off state, constantly on, blinking and blinking off state.

### Start-up routine

Start-up routine won't work until total number of LEDs has been specified. To set it, use the following message:

**F0 00 53 43 01 00 01 00 03 TOTAL\_NUMBER\_OF\_LEDS F7**

There are currently four routines user can select for start-up:

**F0 00 53 43 01 00 01 00 05 START\_UP\_PATTERN F7**

Pattern can be anything 0-4. Setting pattern to 0 will disable start-up routine.

Changing order of LEDs during start-up routine:

**F0 00 53 43 01 00 08 01 LED\_NUMBER LED\_START\_UP\_NUMBER F7**

## More examples

There are many more examples listed on [OpenDeck GitHub](https://github.com/shanteacontrols/OpenDeck/tree/master/examples) repository, so feel free to check them out.

## Planned features

At the moment, I am adding support for encoders in OpenDeck software. Due to their unreliability, it's really tricky to deal with them in software and getting stable values, but I'm working hard on it, and code should be finished soon.

## Demonstration

I recorded a video to show-off all the mentioned features:

<div class="videoWrapper">
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/3T1-x4B77nw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>