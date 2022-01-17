---
layout: post
title: "Marching forward with OpenDeck: The hardware"
date: "2015-10-26"
tags: 
  - "opendeck"
image: "eagleup_opendeck-r1_board_top.png"
comments: true
---

This post will shed some light on the development of OpenDeck platform, since it's been quite some time I've done any updates on this project. Don't let the silence fool you - project is very active.

For those who don't know what OpenDeck is (there are couple of posts about it on this site) - it's a MIDI platform designed to relieve you of doing tedious stuff in the build-process of a MIDI controller. Those who want to build their own controllers quickly find out that it's not really a small thing to accomplish, even if there are some great platforms out there which can make the job much easier, such as Teensy or Arduino. You need to know how to write code, choose the right hardware, install software development tools on your computer, deal with all kinds of errors (both hardware and software) etc. OpenDeck allows you to forget about all of that. It's a system which allows you to pick basic components of your MIDI controller - such as potentiometers, buttons, encoders, LEDs etc. - plug them into the OpenDeck board, and actually use them in your MIDI controller in a matter of minutes. Neat, right? So, how does it work? I'm going to talk about it in a couple of posts, since the project has several layers. In this one, I'll try to do a hardware architecture breakdown of the project.

## The board

The board is 10x10cm in size. It's 1.6mm thick and the current color is green. It has four M2 mounting holes, one in each corner. I don't have pictures of the board since I'm currently waiting for it to arrive from ITead studio, but here's render of front and back (the holes in the corners are not displayed):

![]({{ site.baseurl }}/images/blog/eagleup_opendeck-r1_board_top.png)

![]({{ site.baseurl }}/images/blog/eagleup_opendeck-r1_board_bottom.png)

## Specifications

You can connect various components which are the building blocks of your MIDI controller into OpenDeck board. It allows you to connect:

1. 64 buttons or 32 encoders max (one encoder is kinda like having two buttons)
2. 32 potentiometers or FSRs (force-sensitive resistors)  - support for other analog sensors is planned as well
3. 48 single color or 16 RGB LEDs

The board also contains DIN MIDI in and out ports. MIDI in port can be used in two ways:

1. MIDI to USB converter, allowing you to receive data from MIDI gear and translate it to USB MIDI to control your MIDI software on a computer
2. LED control, allowing you to receive data from MIDI gear and control LEDs connected to OpenDeck board.

### Power

The board has only one power connector - USB (B type). Board can be used either using computer or standalone, in which case USB wall charger is required - any one will do, as long as it meets USB power spec (5V/500mA).

### ESD protection

USB data and voltage lines have [ESD protection diodes](http://www.nxp.com/documents/data_sheet/PRTR5V0U2X.pdf). There's a nice article on electro-static discharge on [Wikipedia](https://en.wikipedia.org/wiki/Electrostatic_discharge).

### Indicator LEDs

There are two LEDs on board - power and bootloader LEDs. Power LED is constantly on when board is powered on, while bootloader LED is only active when firmware update is in progress.

### Microcontroller

The brain of OpenDeck board is same microcontroller used in Arduino Leonardo and Teensy 2.0 - Atmel ATmega 32u4. That little microcontroller has USB hardware built right into the chip which allows your computer to recognize it as generic MIDI device, so that there are no drivers required on any major platform (Linux, Mac OS X, Windows).

### Button/encoder hardware

In order to read buttons and encoders, a matrix setup is used. There are 8 input rows controlled by [74HC165](http://www.nxp.com/documents/data_sheet/74HC_HCT165.pdf) shift register and 8 columns controlled by [74HC238](http://www.nxp.com/documents/data_sheet/74HC_HCT238.pdf) decoder. Matrix uses column-switching to read data and there is only one active column at time during which all 8 rows are being read. There is more info on how button (and LED) matrix works on this [link](http://pcbheaven.com/wikipages/How_Key_Matrices_Works/).

### LED hardware

LED setup also uses matrix. It has 6 rows and 8 columns. Driving LED matrix directly from microcontroller is generally un-advisable, since the microcontroller isn't really meant to be current source (or sink) so its capabilities are quite limited in that regard. Matrix can draw a lot of current, so if not careful, you can easily damage the microcontroller. In order to solve this, several components are used:

1. LED hardware uses dedicated voltage regulator, [LP2985-N](http://www.ti.com/lit/ds/symlink/lp2985-n.pdf). Regulator outputs stable 4V.
2. Each LED row has a [MOSFET transistor](https://www.fairchildsemi.com/datasheets/FD/FDC6312P.pdf) which turns the row on or off, triggered by a state of digital pin on microcontroller. This way, very little current is required to turn the MOSFET on, and when it is on, transistor draws the current from 4V voltage regulator instead of microcontroller, and feeds it into LED.
3. Each column is connected to [ULN2803](http://www.ti.com/lit/ds/symlink/uln2803a.pdf) current sink, since 6 rows of LEDs can generate about 200mA of current and absolute maximum microcontroller can handle is 40mA.
4. Current sink inputs are connected to another [74HC238](http://www.nxp.com/documents/data_sheet/74HC_HCT238.pdf) decoder so that only 3 pins are required to handle column switching instead of 8.

The big question here was which resistors to choose for LED rows. In order to achieve full brightness, most LEDs require 20mA of current. In matrix, LEDs get switched on and off very fast without you noticing it. Current flawing through LEDs in matrix is called "pulse" current, since it flaws for a very short period of time. If you would pick a resistor for 20mA of current in LED matrix, you would notice that LED isn't really set to maximum brightness, since the current is actually lower. Because of this, we will calculate the value of resistor to achieve 30mA of current. Another problem rises here: each color of LED has different voltage drop. For instance, red LED usually has voltage drop around 1.7V. Green has around 2.2V. In order to select resistor value, I took the average voltage drop for most popular colors, based on [this table](http://stompville.co.uk/wp-content/uploads/2012/02/103SV.png). The average drop is 2.3V. For 30mA current, 4V voltage source and 2.3V of voltage drop, a resistor value of 56 ohms is chosen. Since this calculation is based on average voltage drop, the current will vary depending on chosen color.

### Analog hardware

For analog components to work reliably, stable voltage is absolutely required. Like LED hardware, analog part of the board also has dedicated 3.3V voltage regulator, [MCP1825](http://ww1.microchip.com/downloads/en/DeviceDoc/22056b.pdf). To read values from 32 analog components, two [4067](http://www.ti.com/lit/ds/symlink/cd74hc4067.pdf) analog multiplexers are used.

### MIDI hardware

MIDI in hardware requires the use of opto-coupler - I've selected [6N138](http://www.vishay.com/docs/83605/6n138.pdf) as recommended on MIDIbox forums and official MIDI documentation. MIDI out circuit is the same as recommended on [Teensy web site](https://www.pjrc.com/teensy/td_libs_MIDI.html).

That would be all in this post - in the next one I'll talk about the software running on the board.
