---
layout: post
title: "Building DubFocus controllers"
date: "2019-08-06"
tags: 
  - "dubfocus"
  - "buildlog"
image: "5900f-67627252_159582195172459_3813637260394364928_o.jpg"
comments: true
---

I've built two new controllers which I've named DubFocus (dub producers are really keen into very knobby MIDI controllers), even though the name can't be seen anywhere on them.

The controllers feature 12 faders, 48 pots, 12 buttons with LEDs... Oh wait, [you've heard this before, right](https://shanteacontrols.com/2018/07/16/conscious-youth-custom-controller/)? What's the point of this post then? Let me explain.

Ben ([Alpha Steppa](https://www.steppas.com/steprec/)), the man to whose tunes I've jammed on countless times, contacted me few months ago because he wanted the same controller I've already built for Conscious Youth. I was thrilled. The only difference would be the color of the plate and LEDs. Then some short time after that, Matt from [PurpleFade](https://purplefaderecords.bandcamp.com/) records contacted me as well requesting the same controller. So, three same controllers in a row, by my standards this was moving into mass production! Hence, new, simpler electronics was needed. As an reminder, this is what the inside of the original controller looked like:

![]({{ site.baseurl }}/images/blog/7f0cc-20180712_230958.jpg)

Lots of wires which needed to be manually crimped, cut and connected. Tedious and quite possibly prone to breaking due to the loose contact. This was not something I was ready to deal with again, so I've designed brand-new electronics this time.

There are now 16 potentiometers on a single board, compared to the two last time, so I needed only three boards for all the pots. Also, there is now a single board for 4 faders, so three of those boards in total as well. The main board sits on top of the middle board for faders. The buttons/LEDs boards (three of them) connect via short cable onto faders boards. I'm then using a single cable from faders board to transmit both the fader signals and signals for buttons and LEDs, which is a much cleaner solution than the last time. The biggest change as far as the wiring is concerned is that now everything is connected via flat cables (other than the cable connecting main board with USB connector board). Plug them in and done. No cutting, no crimping, no loose connections.

![]({{ site.baseurl }}/images/blog/08956-66605393_154496359014376_8940239069623877632_o.jpg)

There is now also a single holder plate for both the pots and buttons/LEDs. I am so pleased with this, in fact, that I've completely replaced all the electronics inside of the original controller since I don't want to live in a fear of something breaking in a crucial moment.

Of course, as always, all controllers run the latest and greatest [OpenDeck firmware](https://github.com/shanteacontrols/OpenDeck).

Here are some pictures of completed controllers.

![]({{ site.baseurl }}/images/blog/5f866-67731323_158878478576164_1112745268123533312_o.jpg)

![]({{ site.baseurl }}/images/blog/312f4-67600368_158879411909404_9059137765970542592_o.jpg)

![]({{ site.baseurl }}/images/blog/0b711-67881568_159521458511866_6187519195891105792_o.jpg)

![]({{ site.baseurl }}/images/blog/5900f-67627252_159582195172459_3813637260394364928_o.jpg)

I am currently offering these controllers in 4, 8 and 12 channel variants, with 16 channel being available on demand.
