---
layout: post
title: "OpenDeck on Arduino"
date: "2017-12-14"
categories: 
  - "development"
tags: 
  - "arduino"
  - "diy"
  - "midi"
  - "midi-controller"
  - "opendeck"
  - "usb"
image: "post_default_header.jpg"
comments: true
---

There's an old saying which goes "if you can't beat them - join them". That kind of sums up latest OpenDeck development efforts.

## Selling OpenDeck boards

Selling pre-assembled OpenDeck boards turned out to be not-so-profitable business. Actually, I was losing money on it. Once I've added up all the ridiculous taxes, import fees, PayPal fees, shipment etc. it turned out everyone else is making money on me, and I was losing money in the process. Granted, I was ordering small amount of OpenDeck boards, and ordering small amount of PCBs is never quite cheap, however I can't really order hundreds of boards at this moment since demand isn't that high yet. Instead, I've came up with other tactic.

## Arduino

Pretty much anyone involved in some kind of electronic DIY project owns at least one of the [Arduino boards](https://www.arduino.cc/en/Main/Boards). They are really cheap and good enough for most simple projects. One of those projects is often [building a MIDI controller](https://trends.google.com/trends/explore?q=arduino%20midi). So, how do people build MIDI controllers with Arduino? That's actually not so simple task. Arduino doesn't have easy to use USB MIDI support unless you code it yourself. You need to be a decent programmer to write MIDI controller software. You need to debug problems more often than not. All things considered, building MIDI controller with Arduino can quickly become a daunting task. There is, however, an alternative.

## OpenDeck software + Arduino hardware

OpenDeck is [really simple to use](https://ask.audio/articles/review-shantea-controls-opendeck-custom-midi-controller-platform). Plug in the board to PC, PC immediately recognises new USB MIDI device and you're pretty much good to go. Thing is, you need OpenDeck board for this, and there aren't really that many boards around. What if you could run OpenDeck software on Arduino instead? Well, that's exactly what I've done.

### Arduino Leonardo and Pro Micro

First I've started with Arduino Leonardo and Pro Micro boards. They actually use exactly the same microcontroller as official OpenDeck boards - Atmel ATmega32u4. Making OpenDeck run on these boards was a simple matter of correctly defining pin addresses in firmware and I was good to go.

![]({{ site.baseurl }}/images/blog/7230d-23800061_723673337825909_7076454715108837225_o.jpg)

### Arduino Uno and Mega2560

Getting OpenDeck to run on these boards was a bit more complex. In case you're not familiar, these boards actually come with two microcontrollers on board - one main MCU, for which you actually write software (for Uno that is ATmega328 and for Mega that is ATmega2560) and other one (ATmega16u2) which actually serves as USB interface between your PC and main MCU on Arduino board. This MCU enumerates as Virtual COM port on PC, so, when you program the Arduino or read serial input from it, this MCU acts like a gateway between main MCU and your PC. The good thing about this is that Arduino boards actually have header on board which you can use to program this MCU, so, I've programmed it to act like a USB MIDI hardware. Entire communication process between PC and Arduino boards running OpenDeck software is really similar to original solution: all MIDI data sent from PC to Arduino first goes to ATmega16u2 MCU which then simply passes that same data to main Arduino MCU using serial link (also vice-versa), just like before.

![](http://46.101.124.26/wp-content/uploads/2017/12/24210352_727052300821346_3201283979179968047_o.jpg)

## Outcome

Now, Arduino Micro, Leonardo, Uno and Mega2560 can all run OpenDeck software. Plug your reprogrammed Arduino into PC, and PC recognises it as class-compliant USB MIDI device. Also, [OpenDeck configurator](https://config.shanteacontrols.com/) recognises the board immediately and you can start configuring your brand new Arduino/OpenDeck board, just like with the official setup. The same I/O pins that you use on Arduino boards are used in OpenDeck firmware, so supported number of components is same as in original Arduino boards.

## Availability

To get OpenDeck on Arduino, there are three options:

1. Buy pre-configured Arduino board directly from me. This saves you a lot of hassle with compiling and uploading the code to Arduino (you will also need AVR programmer such as [USBasp](http://www.fischl.de/usbasp/) or [AVRISP mkII](http://www.atmel.com/tools/avrispmkii.aspx)). The pricing for this option is listed on my new [website.](https://shanteacontrols.wpcomstaging.com/)
2. Buy pre-compiled firmware and upload it to Arduino yourself. If you already happen to have Arduino boards laying around together with AVR programmer, you can buy pre-compiled firmware from me for 20€.
3. Download the source code from [GitHub](https://github.com/paradajz/OpenDeck), compile it and upload to Arduino yourself. This is for brave souls only - you will need Linux-based environment to compile the code, as well as familiarity with command-line tools.

## Future

Based on interest, I plan to make OpenDeck available on more powerful ARM-based development boards, such as ST STM32 series. Also, plan is to add support for more complex components, such as OLED/LCD screens, accelerometers, gyroscopes and other more advanced sensors.

## EDIT:

As of OpenDeck v3.0.0 pre-compiled Arduino binaries are part of the [release on GitHub](https://github.com/paradajz/OpenDeck/releases). Also, pre-configured Arduino boards are now available on [Tindie](https://www.tindie.com/stores/paradajz/).
