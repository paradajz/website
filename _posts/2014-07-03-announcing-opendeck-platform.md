---
layout: post
title: "Announcing OpenDeck platform"
date: "2014-07-03"
categories: 
  - "development"
  - "programming"
tags: 
  - "midi"
  - "opendeck"
image: "post_default_header.jpg"
comments: true
---

In the last few days, I've finally put all of my ideas into one, coherent project called OpenDeck. For those of you who don't already know, [OpenDeck](https://www.youtube.com/watch?v=aMAuzVOpdlI) [started](https://www.youtube.com/watch?v=ChQUkpFITrs) as my vision of open source MIDI controller. I didn't mean open source as just the code - it was a complete open hardware project, with vector design, electronic circuit, PCB schematic and last, but not least, the code itself freely available on my [GitHub](https://github.com/paradajz/) account. Eventually, OpenDeck source code got transformed into a helper library, which I happily use (it's the base of Anandamidi and Tannin, two controllers I've built). I've spent few years tweaking it until I finally got super-stable code, so that when I build controllers, and something doesn't really work, I am sure it's not the code, but something hardware-related. Therefore, OpenDeck as a platform is really the only logical next step. What the hell am I talking about? Let's see.

## OpenDeck backend

The backend is actually the software which I already have. It's split into few distinct parts:

### OpenDeck library

This library (for now) can handle:

- LED and button matrices
- blink and constant mode on each LED
- LED control via MIDI in
- start-up animation generation
- reading potentiometers directly connected to ATmega chip or multiplexed via external multiplexer
- inverting the potentiometer data
- turning potentiometers into 6-way switches (expandable)
- both digital and analogue debouncing
- MIDI channels selection
- long-press button mode (buttons can be configured to send a MIDI event after they're pressed for defined time)

For now, that's it. As you can see, it already has lots of options, however, the features I'm planning to add are:

- rotary encoder support
- RGB LED support
- anything else?

### HardwareReadSpecific library

This library talks directly with OpenDeck library. The only thing it contains is hardware-specific code. As an example, let's see how OpenDeck library gets reading from whole column in button matrix:

```
void OpenDeck::readButtons()
{
    uint8\_t buttonState = 0; uint8\_t rowState = HardwareReadSpecific::readButtons();
    ...
}
```

And readButtons() in HardwareReadSpecific looks like this (example taken from Tannin controller):

```
uint8\_t HardwareReadSpecific::readButtons()
{
    //get the readings from all the rows
    return (PINB &amp; 0x0F);
}
```

So, OpenDeck library contains only generic stuff, while HardwareReadSpecific deals directly with the hardware. This kind of implementation allows for extremly simple change of microcontroller used in the project.

Apart from dealing with hardware directly, HardwareReadSpecific library also contains lots of switches. Using them, you can easily enable or disable LED or button matrix altogether, define debouncing time, blink duration and much more. Code is up on my GitHub account, so can check it yourself.

### MIDI library

This is the only part of the code which isn't written by myself, although I've trimmed out the parts from it which I don't need. This library is responsible for actually sending and receiving MIDI data. The most powerful part of it is exactly the incoming data parser. Library is written by Francois Best, and you can find the latest version of it on his [GitHub](https://github.com/FortySevenEffects/arduino_midi_library) account. It's worth of mention that latest version is 4.2, while I'm using older-but-proven modification of 3.2 version (also available on my GitHub, redistibuted under GPLv3 conditions).

### main file

If you're ever done any programming in your life, you already know what main file is. If you haven't, then you've also probably skipped this entire section. But, simply put, main is where your code starts. In microcontroller programming, it usually has two distinctive parts: setup, in which you call constructors, initialise everything you need, and run some code which only runs on start-up, such as LED animation, and loop, which runs until you disconnect power from your microcontroller. This file calls OpenDeck functions. After OpenDeck library gets stable data from inputs, it uses callbacks to MIDI library to actually send the data, or store the incoming stuff.

I'm really happy about the modularity of my code, since this way, I can develop each of the four parts independently, without breaking whole code.

## OpenDeck frontend

Okay, [how about we make it interesting](http://youtu.be/GhqXWybI6xQ?t=1m21s)? Even though I've went through pretty-much all of the code which powers my MIDI controllers, I consider it only to be backend. So, what would be frontend? GUI application, of course! If all of this sounds familiar, well then, it should, because Livid Instruments makes everything I'm talking about in this entire post. [Go check it yourself](http://lividinstruments.com/hardware_builder.php). What they've done is pretty amazing. They've got a PCB board on which you can connect anything you like, pots, encoders, LEDs etc. It all comes pre-programmed, it's MIDI compliant, and it also has GUI configuration. There's only two problems really:

1) Only two PCB sizes (one costs 49 and other is 189$, which makes for quite a gap for projects of mid-size)

2) It's not open-sourced

Therefore, I'm basically building [clean-room](http://en.wikipedia.org/wiki/Clean_room_design) implementation based on what I already have. As I've already explained, my backend is very modular, so adapting it for other hardware only requires small changes in HardwareReadSpecific library. As far as PCB is concerned, I've created design for reference board, which I'll send to manufacturing after I'm done checking for any errors. The board contains total of 16 analogue inputs, 32 digital inputs (32 buttons or 16 enoders, once I'm done implementing it in software), and 32 digital outputs for LEDs. What powers that board is Arduino Pro Mini, great little tool (also very, very cheap). Board also has headers for my USB MIDI PCB board, which I've talked about in my last post. Notice, however, that this is only reference board. Final version will have both ATmega and AU-123 chip integrated into one board, so that there's no messing with drivers or converters, straight plug-and-play. I'm also planning to have ICSP header, for those feeling adventurous, so that even the ATmega chip is reprogrammable. Of course, board design, as with circuit schematic is going to be freely available, just like software itself.

### GUI

I'm only laying ideas here, I don't even have design mockups yet, however, these are the features which I'm initially planning to have in my configuration software:

- Testing of whole controller, that is, checking for whether all buttons, encoders, LEDs and pots actually work
- Controller configuration, which would involve everything from MIDI channel selection, flipping of potentiometer data (or anything else), start-up animation generation etc.
- Controller programming via custom SysEx messages (that could be a challenge)

I am planning to have GUI running across all platforms, but since I only use Windows, that's going to be a priority. Also, because of cross-platform availability, source is probably going to be written in Java, unless someone has better ideas. While we're at it, this whole thing is a pretty big project, so I am looking for contributors. If you're feeling you can help me developing modular, open hardware MIDI building platform, please let me know!
