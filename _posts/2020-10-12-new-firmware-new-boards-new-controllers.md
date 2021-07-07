---
layout: post
title: "New firmware, new boards, new controllers"
date: "2020-10-12"
categories: 
  - "development"
  - "info"
tags: 
  - "opendeck"
image: "IMG_3135_web.jpg"
comments: true
---

Due to everything that's going on right now it feels like ancient history the last time I've talked about new OpenDeck firmware. Or new boards. Or new controllers. In fact, I think the past few months have been the busiest months for OpenDeck ever since the project started. If you're interested on what's going on with the project, keep reading!

## OpenDeck firmware v5

After more than a year of work, I've finally released [new firmware, called v5](https://github.com/shanteacontrols/OpenDeck/releases). This has been almost a total rewrite of the build system, total rewrite of board support subsystem and really, complete refactoring of most of the code to make it even more modular and testable. Which doesn't mean there aren't new features - far from it.

### Official support for STM32

The support for STM32 is now finally stable and official. Not just that, I am now using STM32F405 as my primary MCU for all new designs - including for [DubFocus controller.](https://shanteacontrols.wpcomstaging.com/2019/08/06/building-dubfocus-controllers/) I will talk about the next-gen DubFocus controllers in another post.

### New SysEx protocol

One of the major limitations of previous firmware releases was the SysEx protocol. As with other MIDI messages, SysEx bytes are limited to maximum value of 127. This means that with my old protocol, you couldn't configure more than 128 components per block. For instance, in OpenDeck firmware, every analog input can be configured as button, which is why the interface presents total number of buttons as sum of physical digital inputs and analog inputs. If the board, for example, had 64 digital inputs and 80 analog inputs, that's total of 144 buttons to configure. With old protocol, there was no way to configure any component with index larger than 127. This also meant that you couldn't configure NRPN index or pitch bend ranges without introducing ugly hacks in the interface - both NRPN index and pitch bend range can have upper value of 16383. So, how do you configure this with my protocol? To solve this I've introduced ugly hack in the interface so the interface was showing LSB and MSB parameters - lower and upper byte, respectively. You had to do some mental gymnastics in order to configure this in the right way.

I've actually designed SysEx protocol with this in mind - there was an option to use it in a way described above, or, it could work in two-byte mode: in this mode, each parameter index and its value were represented by two bytes. This gives the ability to use 14-bit ranges instead of measly 7-bit ones. There was a caveat, though: the web interface was designed only with one-byte protocol in mind, and it was no longer possible to add the support for it since the code has been obfuscated and the original developer moved on to other things. The solution here was to completely redesign the interface. More on this later, but long story short: OpenDeck v5 now uses two-byte protocol by default. The entire protocol is documented in the [OpenDeck wiki](https://github.com/shanteacontrols/OpenDeck/wiki/SysEx-Configuration).

### MIDI bootloader

There's nothing that normal people like better than to open terminal to update the firmware on their devices. I'm kidding, of course. Each time I was asked for help on how to update the firmware on the OpenDeck boards, I shook my head, took a deep breath, stretched my fingers and started typing something along these words: "Well, first you need to open terminal and type the following...".

I hated it. Here I was, explaining to users, that in order to update their supposedly simple to use board they need to launch terminal to update it. That irked me for very long until I came up with very obvious solution: why wouldn't I reuse the same USB MIDI stack I already use and make the bootloader show up as just another MIDI device? Users would update it with special SysEx file. I couldn't find anything similar anywhere else so I had to do this from scratch. I do remember reading somewhere about someone trying out something similar but it supposedly didn't work for some reason. I decided to try it anyways since, if it would work, that would be a giant step forward for the project and its ease of use. This turned out to be more complex that I hoped, but eventually I've managed to make it work.

The biggest part of making this work was to actually convert the compiled binary to normal SysEx messages. I did this with [bash script](https://github.com/shanteacontrols/OpenDeck/blob/e3b88457fbd712ee6348f3dab65e7f213690442f/scripts/sysex_fw_create.sh). The script reads binary file byte by byte and converts that byte into two bytes in SysEx format. If you're wondering why two bytes, well, byte range is 0-255, and as I've explained above, SysEx byte can only have range 0-127. The script also adds some more messages with headers and metadata, but this is basically it. The [bootloader](https://github.com/shanteacontrols/OpenDeck/tree/master/src/bootloader) on the board parses this file and updates the firmware.

No more terminal! Bonus: firmware update is now possible within web configurator.

### Touchscreen support

Two years ago I've build [Bergamot](https://shanteacontrols.wpcomstaging.com/2018/10/14/bergamot-touchscreen-midi-controller/) - a controller based on a touchscreen. The code was a bit specific for that particular controller and for that particular screen, but now, there's official support for every single [Nextion](https://nextion.tech/) touchscreen in OpenDeck firmware! Not only that, [Stone HMI](http://www.stone-hmi.com/) screens are supported as well. Currently, the firmware supports touchscreen buttons and touchscreen icons. These icons are, as far as user and firmware are concerned - just normal LEDs. Icon configuration is actually LED configuration, so every option available right now for LEDs is available for touchsreen icons as well - blinking, MIDI in control, local control etc. Same thing goes for buttons - buttons are also configured just like normal physical buttons. There's detailed guide on how to configure touchscreens in the [wiki](https://github.com/shanteacontrols/OpenDeck/wiki/Configuring-touchscreens).

I've also built myself a brand new controller which features 10" Nextion display called Cardamom.

![]({{ site.baseurl }}/images/blog/109956535_147772146897016_6430408931493065490_o.jpg)

![]({{ site.baseurl }}/images/blog/109800995_147773196896911_7581733213845568884_o.jpg)

![]({{ site.baseurl }}/images/blog/108232583_146912143649683_232275445360695707_o.jpg)

The stunning red wood is african Padouk. The controller is also based on STM32F405 MCU, the one I am now using for all new designs. I don't think I've ever spent more time and resources on a controller than on this one - one way or another I've been building it for more than a year.

I've also recorded a video of me mixing on this controller.

<div class="videoWrapper">
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/TPc6ETIsVTM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

### SysEx programmer

I've been asked this question a lot - how do I use OpenDeck board as SysEx programmer? The answer was, unfortunately, you can't. [Well, well, well, how the turntables](https://www.youtube.com/watch?v=6FwmGLzyRDk)! There is now ability to do just that. Transform your OpenDeck board into SysEx programmer with single toggle in the web interface.

### New UI

UI has been totally rewritten and redesigned by [Tomislav Glavas](https://github.com/wyrd-code). If you're looking for WebMIDI expert, well, here's brand new one. ;) I'll let the screenshots below do the talking.

![]({{ site.baseurl }}/images/blog/new_webui_13.png)

![]({{ site.baseurl }}/images/new_webui_12.png)

![]({{ site.baseurl }}/images/new_webui_11.png)

![]({{ site.baseurl }}/images/blog/new_webui_10.png)

![]({{ site.baseurl }}/images/new_webui_09.png)

![]({{ site.baseurl }}/images/blog/new_webui_08.png)

![]({{ site.baseurl }}/images/blog/new_webui_07.png)

![]({{ site.baseurl }}/images/blog/new_webui_06.png)

![]({{ site.baseurl }}/images/blog/new_webui_05.png)

![]({{ site.baseurl }}/images/blog/new_webui_04.png)

![]({{ site.baseurl }}/images/blog/new_webui_03.png)

![]({{ site.baseurl }}/images/blog/new_webui_02.png)

![]({{ site.baseurl }}/images/blog/new_webui_01.png)

New UI supports both the old and new SysEx protocol, it supports column view so that it's easy to see all options for specific block at once, it supports firmware updates, backup and restore, activity log is showing much more detailed info than the old one, there's more helpful information for available options now, the UI doesn't crash if some parameters aren't supported etc. I think it's really phenomenal - Tomislav did [great job](https://www.youtube.com/watch?v=hQRv0qM_5rQ) here, and more than that, did some things I didn't even ask for which improved the entire application. We both have same mindset regarding the things we build so the entire collaboration went really smoothly. Oh, the entire thing is also [open-source](https://github.com/shanteacontrols/OpenDeckUI).

Another great thing about the UI is that it separates buttons into physical, analog inputs and touchscreen buttons. UI does the same thing for LEDs - section is separated into physical LEDs and touchscreen icons / LEDs.

### Other things

There is also a new ability which allows users to configure the button to send different velocity on each successive press in any desired step. Also, the firmware now supports full backup and restore - something which never worked right in previous firmware.

Sadly, there are some bad news as well - due to large amount of new features, OpenDeck no longer supports ATmega328P and ATmega32u4 - so boards like Arduino Uno, Arduino Leonardo, Arduino Pro Micro etc. aren't supported anymore as a result of this. This is not an arbitrary decision - the firmware simply doesn't fit anymore into the flash memory of this boards. However, last [v4](https://github.com/shanteacontrols/OpenDeck/releases/tag/v4.1.3) firmware release can still be loaded on these boards and will work just fine.

New build system which allows defining of custom board variants is also part of this release. I've written about this in the [previous post](https://shanteacontrols.wpcomstaging.com/2020/06/11/creating-custom-opendeck-board-variants/).

### New boards

![]({{ site.baseurl }}/images/blog/IMG_3141_web.jpg)

![]({{ site.baseurl }}/images/blog/IMG_3135_web.jpg)

Lastly, I want to talk about new boards. Some really good news here - new boards are in production as I type this post! The OpenDeck v2 board features STM32F405 MCU, has support for 10 presets, has support for touchscreens, OLED displays and also the ability to work with I2C and SPI sensors in the future (there are connectors present on board) and other than that, it has same amount of I/O as the v1 board. Dimensions are the same, as well as the pinouts - with one change regarding the analog inputs - there are now both ground and power supply pins for each of 32 analog inputs.

New boards will be available on [Tindie](https://www.tindie.com/products/paradajz/opendeck-diy-midi-platform/) in few weeks at the same price as old board.
