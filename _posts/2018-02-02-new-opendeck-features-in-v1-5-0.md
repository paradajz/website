---
layout: post
title: "New OpenDeck features in v1.5.0"
date: "2018-02-02"
categories: 
  - "development"
tags: 
  - "midi"
  - "opendeck"
  - "webmidi"
image: "post_default_header.jpg"
comments: true
---

Last time I talked about features in OpenDeck was, well, long time ago. I have released OpenDeck [firmware v1.5.0](https://github.com/shanteacontrols/OpenDeck/releases/tag/v1.5.0) so it's time to fix this!

## NRPN

Many people have been asking me about NRPN support on OpenDeck. I've never used it, so I haven't implemented it before, but now OpenDeck official supports it. For those who don't know, NRPN stands for _Non-registered Part Number_. Behind this cryptic acronym lies solution to a problem which is very specific to how MIDI operates. Since MIDI is actually 7-bit protocol, that is, each MIDI message is composed of bytes containing values 0-127, there isn't much room left for user-defined CC messages, many of them being [already mapped to specific task](http://nickfever.com/music/midi-cc-list) by MIDI specification. So, even though CC message IDs can range 0-127, in reality you can have much less if your software or controller is hardcoded to respond to specific CCs. NPRN solves this problem by doubling CC resolution to 14-bit. Now, instead of only 127 CC IDs, you can map your CC up to 16383. That's ridiculously large. Drawback to this is that instead of sending single MIDI message for CC, three messages are needed to send NRPN message, so MIDI traffic is much larger. This can become obstacle on older MIDI gear, but in practice you really shouldn't have any problems with it. As an example, I'll illustrate the difference between sending MIDI CC and NRPN message.

Standard CC message:

- CC ID, CC value, channel

NPRN message:

- CC 99, upper 7-bits of wanted ID (MSB), channel
- CC 98, lower 7-bits of wanted ID (LSB), channel
- CC 6, value, channel

There's a bit of bit-shifting involved to convert 14-bit number to two 7-bit values.

But wait! There's more! Not only does NRPN double the resolution of CC IDs, it can also double the resolution of control value itself. This way, you can send very precise values from potentiometers, pressure sensors etc.. This NPRN message is very similar to 3-byte one, with one minor difference:

- CC 99, upper 7-bits of wanted ID (MSB), channel
- CC 98, lower 7-bits of wanted ID (LSB), channel
- CC 6, upper 7-bits of value (MSB), channel
- CC 38, lower 7-bits of value (LSB), channel

To configure NRPN, simply select NPRN 7-bit or NPRN 14-bit in Web interface:

![]({{ site.baseurl }}/images/blog/ed7e6-webui_nrpn_7bit.png)

![]({{ site.baseurl }}/images/blog/59fda-webui_nrpn_14bit.png)

Notice how interface displays additional info depending on selected option.

## Buttons

Buttons can now be mapped to additional MIDI messages:

![]({{ site.baseurl }}/images/blog/f3fe7-webui_buttons_msg_types.png)

These messages can be really handy when controlling MIDI gear. Also, notice the "CC" and "CC/0 off" messages. First one is used when you only want to send CC messages from buttons once button has been pressed. On release, nothing happens. Second one (0 off) is similar, but the difference is that buttons will send same CC ID on release with value 0. This option also depends on button type (momentary or latching), so there's actually lot of possibilities.

On the bottom you can also notice something new - "On velocity". With this option you can select velocity which button sends on press. This used to be hardcoded to value 127. Note that if buttons are configured to send CC messages, "On velocity" becomes CC value.

## LEDs

I have added a new parameter to LED configuration - activation velocity.

![]({{ site.baseurl }}/images/blog/05206-webui_leds_act_vel.png)

This option is used only for single-color LEDs and you can define which velocity will turn the LED on. For RGB LEDs, [velocity-table](https://github.com/shanteacontrols/OpenDeck/wiki/LED-control) is used as before.

## Version info

Since I added [support for Arduino boards](https://shanteacontrols.com/2017/12/14/opendeck-on-arduino/), the info window now displays board name (variant) which is being used.

![]({{ site.baseurl }}/images/blog/8c2b8-webui_version_info.png)

![]({{ site.baseurl }}/images/blog/5e7ff-webui_version_info_2.png)

## Software updating

For now, updating the software is done using special mass-storage mode. Since it's sometimes unstable, doesn't work in Finder on Mac OS X and it's quite large, I've replaced it with new, HID-based bootloader. This could or could not mean something to you, but the point here is that Chrome can access USB HID devices directly, just like USB MIDI devices, so soon, it will be possible to update the firmware directly from web interface. Stay tuned!
