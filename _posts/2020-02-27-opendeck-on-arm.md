---
layout: post
title: "OpenDeck on ARM"
date: "2020-02-27"
tags: 
  - "opendeck"
  - "stm32"
  - "announce"
image: "stm32f4discovery.jpg"
comments: true
---

A little over two years ago, I've announced that [OpenDeck firmware started supporting various Arduino boards](https://shanteacontrols.com/2017/12/14/opendeck-on-arduino/). It was a major milestone - the firmware design was modular enough that it could support various targets instead of just official OpenDeck board. Now, it's time to announce another major milestone: OpenDeck can now run on 32-bit STM32 microcontrollers!

## Rationale

You might be wondering why OpenDeck needs to support ARM when everything works fine as is. Perhaps ironically, over the last few months the target with which I had the most issues supporting it was my own official OpenDeck board. That board is based on ATmega32u4 AVR microcontroller. Let's get over the specs of that particular MCU:

- 8-bit architecture
- 16MHz
- 32KB flash program memory
- 2.5KB SRAM
- 1KB EEPROM
- 10-bit A/D-converter
- USB 2.0

Its specs are quite poor, however, it was a good choice when I first started developing OpenDeck, since Arduino Leonardo used that same MCU, and I was using Arduino Leonardo for prototyping. Over the time, as the amount of OpenDeck features grew, the memory requirements also grew. I've managed to mitigate this by writing more compact code when possible and by enabling more and more compiler optimizations. With each optimization, I bought myself some more memory and more time until I couldn't optimize the code anymore so that it could fit inside the MCU. Here are the results when building the firmware I've released today for OpenDeck board:

```
AVR Memory Usage
----------------
Device: atmega32u4

Program: 28392 bytes (86.6% Full)
(.text + .data + .bootloader)

Data: 2326 bytes (90.9% Full)
(.data + .bss + .noinit)
```

Program usage is a bit misleading, though, since 4kB of flash is reserved for bootloader, which brings the total memory usage to 99%. I've only got 280 bytes left which means it has become impossible to add any more features to the official board. On top of this, ATmega32u4 only has 1kB of EEPROM memory, which means I cannot support presets on official board since the current configuration takes almost the entire EEPROM as well.

## Solution

I could've solved most of these issues simply by making new OpenDeck board with another beefier AVR MCU, such as AT90USB1286. That MCU has 128kB of flash, 8kB of RAM and 4kB of EEPROM. Even though I could get along with 128kB of flash and 8kB of RAM, this MCU still has same 8-bit architecture, runs on same 16 MHz clock so it has fairly limited processing power and limited EEPROM. I don't really need more processing power right now, but I might in the future. There's also the issue of pricing (this thing costs about 7$) and with AVR loosing on all fronts compared to vastly more powerful ARM MCUs, it is a question for how long these MCUs are going to be available. I want my next flagship board to be based on something I can count on for the next decade. It's still probably going to be around by then, however, OpenDeck firmware might eat the resources of that MCU as well. Therefore, the only logical choice was to move to something powerful enough that I won't need to worry about resources for a very long time. I had some prior experience with STM32 line from ST so I've picked STM32F4 Discovery board to be the first supported OpenDeck target.

![]({{ site.baseurl }}/images/blog/stm32f4discovery.jpg)

This particular board has STM32F407VG MCU with the following specs:

- 32 bit architecture
- 168MHz clock
- 1MB of flash
- 192kB of RAM
- 12-bit ADC
- USB
- Loads of peripherals

Even though most modern ARM MCUs don't have EEPROM, it can be simulated using flash memory. Because of this, I have currently dedicated 16kB of flash to virtual EEPROM on this MCU, which means that I can support many presets.

Compared to even the most powerful AVR, this thing is a beast. The great thing about this board is that it also features on-board programmer/debugger so it's really easy to develop on. This entire board is fairly cheap as well - less than 20$.

Currently, most of the things work on this board:

- USB MIDI
- Virtual EEPROM
- Configuration via web interface
- I/O

The only thing I'm missing at the moment is bootloader support which will come in the coming weeks. Other stuff works for now, but I still consider this experimental since it it has undergone limited amount of testing.

Since I still consider this experimental, there is currently no documentation on OpenDeck wiki on how to flash this board - this will come soon hopefully. Good news is that it's much simpler to flash this board than any other Arduino board simply because this board already has integrated programmer so no external components are needed.

## The future

Later this year I am planning on releasing OpenDeck board v2 which will feature STM32F405 MCU. It will come most likely some time after summer. It will feature exactly the same amount of inputs and outputs as the current board. It will also have exactly the same dimensions. I have also managed to include some more stuff on it:

- I2C connector
- SPI connector
- Additional UART connector

I want this board to support many peripherals which is why I have included these connectors.

Every other supported board variant will be still supported, but the firmware for current OpenDeck board won't receive any new features (other than the bug fixes) since I simply have no more memory to use as mentioned above. I am also planning on releasing OpenDeck Mega, which will have support for at least:

- 128 buttons
- 128 LEDs
- 64 analog components
- Dual DIN MIDI connectors
- Probably some more stuff

If anyone has some suggestions for Mega board, let me know! I get loads of requests asking for board which supports many components, so OpenDeck Mega will be the long awaited answer to that.
