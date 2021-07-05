---
layout: post
title: "Building Anandamidi, part 2"
date: "2014-05-05"
categories: 
  - "build-log"
tags: 
  - "anandamidi"
  - "buttons"
  - "plate"
image: "post_default_header.jpg"
comments: true
---

Lots of progress since my last post. I got the plate, already placed most of the components, finished software and just today I made some final adjustments to PCB.

Here's how the plate looked after I got it and after I've put some stuff on it:

![]({{ site.baseurl }}/images/blog/p4200085.jpg)

That board is really awesome, sometimes I feel it's not worth even designing anything since the board alone looks so good with anything engraved on it. The fader screws in this picture were not actually those I prepared for Anandamidi. They're only here since at the time I did not have them yet. LED holders are here, but they don't contain any LEDs yet. Buttons were originally mechanical buttons, but not anymore. More on that later.

One of the advantages of having 2-plate board (plexiglass+gravoply in this case) is that you can make two different layouts for each board. I used that advantage to make holes for screws bigger on engraved board, and smaller on plexi, so that they don't stick out. I made the same thing with buttons: round hole on plexi, square hole on top. I only wish I made those squares for buttons 0.2mm smaller so that they truly don't move at all, even tho it's fine like this as well, when I screwed them I hardly noticed anything.

![]({{ site.baseurl }}/images/blog/10262113_453034611509841_5139434176467412658_n.jpg)

## Tweaking the buttons

Here's the thing with those buttons. I had a bunch of them, back when I first started doing all this and was unaware of many different types of switches (hey, a button is a button, right?). These were mechanical, and they're truly awful, atleast if you intend to use them on DJ controller where you need instant reaction. However, unlike most of mechanical buttons I've seen, these can actually be disassembled. Let's see what's inside!

![]({{ site.baseurl }}/images/blog/p4080090.jpg)

Lots of stuff inside. They're really hard-to-press because of those strings. When you press them, you push them until that small metal circle touches the pins on the cap. Some buttons react better, some worse, some react just random (no reaction at all on hard press, reaction on light press, etc.). In short, pretty crappy. However, given that they can be hacked into, plus they look really nice,  I figured I must somehow use those things instead of throwing them to garbage can (where they almost did end up few years ago when I bought over 30 of them only to find out they're crap - they were not cheap, that's the worst part). So, just for the kicks, I removed all that stuff inside the button and tried to put a tactile switch underneath it to see if they fit.

![]({{ site.baseurl }}/images/blog/p4080108.jpg)

 Awesome! Now all I needed was something to put inside the button instead of those strings, and something to keep that tactile switch from falling. Simple metal screws proved as great replacement. It turned out you can even screw them inside the switch, so that they don't fall out. Wow, these buttons are truly awesome for tweaking! That's the first part of problem, the second was to keep tactile switch below the button. It's the best to take a look at the pictures, instead of reading an explanation:

![]({{ site.baseurl }}/images/blog/10151967_452628478217121_7552256885835806934_n.jpg)

 Great. Nice looking buttons with even nicer tactile switches below them.

## LEDs

LEDs were a lot simpler task. I had lots of both LEDs and metal holders for them, however, those [holders](http://i.ebayimg.com/00/s/MTYwMFgxNTk1/$(KGrHqR,!lYE8F!qvQs0BPPJ7yf!)g~~60_35.JPG) don't actually "hold" the LED in place as they should, as they tend to move a lot. Simple solution was adding a bit of heat-shrinkable tube between that plastic cap in which LED goes and LED itself. LED does need to be pushed a bit harder into the holder after that, but you don't have to worry about whether will it move or fall out - because it won't.

## Pots

Only thing I added to pots are pin headers. That way the wiring is a lot easier, and if for some reason pot fails, or you (for whatever reason) want to unplug it, then you just do. No need to unsolder, then solder again etc. Plug and play.

![]({{ site.baseurl }}/images/blog/1925296_451801791633123_6057736853610738043_n.jpg)

I already did some soldering work to LEDs. Since they work in matrix (like buttons), each column of LEDs on Anandamidi has a single row, which simplifies soldering a lot.

Only components not there yet are faders. They are kind of tricky, and I had some issues with deciding how to screw them, but more on that in next part.
