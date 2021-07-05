---
layout: post
title: "OpenDeck software v3.1.0 - Presets"
date: "2018-11-19"
categories: 
  - "development"
  - "programming"
tags: 
  - "midi"
  - "opendeck"
  - "presets"
  - "webmidi"
image: "43b3a-presets_global.png"
comments: true
---

**Presets** are one of features I've been asked the most about. In this post I'll talk about the implementation of presets in OpenDeck software.

## Implementation

If you don't care about the implementation feel free to just skip to next section!

Since the first version of OpenDeck, database (configuration) has been split into blocks and sections. Block is a logical unit unit of data containing one or more sections. I've created library to handle this, [available on GitHub](https://github.com/paradajz/LESS-DB). For instance, blocks on OpenDeck are buttons, LEDs, encoders etc. Entire structure is listed in [Layout database file](https://github.com/paradajz/OpenDeck/blob/c0bfd5140d82772d80c347d660f1cf06937b8c57/src/application/database/Layout.cpp). If we take button block for example, some of the sections it contains are MIDI channel, MIDI message, type etc. To read or write to database in the OpenDeck software, block, section and index are the required parameters. Example:

```
database.read(DB_BLOCK_ANALOG, dbSection_analog_lowerLimit, analogID);
database.update(DB_BLOCK_ANALOG, dbSection_analog_lowerLimit, analogID, 127);
```

This means that it's really easy to access parameters in OpenDeck database without knowing the low-level details, such as how the database is accessed or what the address of the parameter really is. Library handles this.

One of the goals when I was implementing the presets was to introduce minimum amount of changes to code. Basically, I wanted to retain the same read/write API as it is now.

To implement presets, I needed to copy entire configuration to another address, that is, the last address of the previous preset, since the software calculates the size needed dynamically, and therefore, number of supported presets is calculated dynamically as well. No need for hardcoding! Setting the start address in memory was the only required addition to database-handling library in order for this to work, so when preset is changed, only thing that actually changes is that database reads/writes data starting from specified address.

On the top/start of the database is something called system block, which is just another database block, but the one not accessible to user. This block contains preset settings and database signature, which is checked in initialization phase. If the signature isn't correct, factory reset is performed. Changing the preset in the software is done by calling `Database::setPreset()` function, which simply sets new start address in the database, so the example call above remains the same - the data is read from another preset and read/write API isn't disrupted. Entire implementation is available [here](https://github.com/paradajz/OpenDeck/blob/master/src/application/database/Database.cpp).

## Options

Preset options are now located in "Global" section in the OpenDeck web configuration tool. MIDI settings are here as well. One word of caution: since the MIDI settings now share the configuration screen with presets, this means that any OpenDeck board with the software before v3.1.0. won't be able to configure the MIDI settings via the configuration tool. This is because the tool will ask the board for information about the presets which older firmware knows nothing about, so the tool will just throw bunch of errors in the activity section. I really wish the tool didn't behave like this, but since I haven't wrote it, I can't really change the underlying logic how it works as I don't understand it at all. I'd be really happy if someone could take maintenance of the tool, since it's merged to OpenDeck GitHub repository.

Anyways, there are only two new options with the introduction of the presets: the active preset and preset preservation.

![]({{ site.baseurl }}/images/blog/43b3a-presets_global.png)

Active preset switches the active preset (doh!). Preset preservation controls whether or not the selected preset will be remembered once the board reboots. This is disabled by default, so the board will always start in preset 1. Using the toggle that behavior can be changed.

I've made sure there are lots of ways the preset can be changed. As mentioned above, preset can be changed simply in the configuration tool.

In the tool, any button can be assigned to preset change function.

![]({{ site.baseurl }}/images/blog/8bedb-presets_button.png)

If the button is set to change the preset, MIDI ID parameter is used to set the preset, so if MIDI ID is 2, 3rd preset will be set on once the button is pressed (0 is first preset).

Preset can also be changed with encoder.

![]({{ site.baseurl }}/images/blog/cdceb-presets_encoder.png)

There is one caveat when using buttons or encoders to change the preset. In order for this to work fully as expected, buttons and encoders intended to change the preset need to be configured in each preset, which may not be obvious at first. Think about it. Preset is entire configuration copy. If you configure the button to switch to preset 2, preset 2 is in default state initially (on fresh board or after factory reset), which means that same button will send usual MIDI message in that preset.

Another way preset can be changed is by sending MIDI program change message via DIN MIDI or USB MIDI to the board.

One final thing - LEDs can be configured to indicate the currently active preset! Simply set their control type to Local - Program change (when using buttons or encoders on board to change the preset) or MIDI In - Program change (if using USB MIDI to change the preset) and set the activation ID to preset number you want to indicate (again, numbering starts from 0). The same caveat as for buttons and encoders applies here - make sure to configure the LEDs for preset indication in every preset!

## Bad news

I need to mention that the presets aren't supported on official OpenDeck board, unfortunately. They are supported on every other OpenDeck-enabled board (Arduino Uno, Arduino Pro Micro, Arduino Leonardo, Arduino Mega and Teensy++ 2.0). The reason for this is that OpenDeck board lacks the EEPROM memory required for multiple presets, which is a shame. This will be improved on the next major OpenDeck board redesign in which I'll switch to different MCU.
