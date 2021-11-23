---
layout: post
title: "Custom controller for Conscious Youth"
date: "2018-07-16"
categories: 
  - "build-log"
  - "design"
  - "development"
tags: 
  - "custom"
  - "diy"
  - "kodama"
  - "midi-controller"
  - "opendeck"
  - "woodland"
image: "540b3-20180713_080821.jpg"
comments: true
---

Last time I've built a custom MIDI controller for someone was [quite a while ago](https://shanteacontrols.com/2014/09/06/sensimidia-midi-controller/). Actually, I've been so focused on [OpenDeck](https://github.com/shanteacontrols/OpenDeck) in the last few years I barely even mention to anyone that I do actually build entire controllers as well - and why bother? Most of the conversations about that look almost exactly like this:

> Someone: Hi! So you can build a custom MIDI controllers?
> 
> Me: Yes.
> 
> Someone: So, I need <insert big list of requirements>.
> 
> Me: That will cost you $$$.
> 
> Someone: Oh, hear you later then.

Obviously, I never hear from those people again. Building a custom controller is a big undertaking, takes a lot of time and effort and then people expect to pay 100$ for it. Get off my lawn!

Anyways, the unexpected turn of events was when Matt from [Woodland Records](https://woodlandrecordsdub.bandcamp.com/)/[Conscious Youth dub collective](https://consciousyouth.bandcamp.com/) approached me sometime earlier this year (thanks to Karlo from [Homegrown sound](https://soundcloud.com/homegrown_sound) - same Karlo for whom I've built Sensimidia controller) and that same conversation from above actually continued. His requirements were the following:

- 12x faders
- 12x4 potentiometers
- 12x buttons with LEDs

Really big controller then - in fact, largest I've ever built. Design was quite simple as Matt didn't want any special name or logo for controller - except for mine, which was also updated.

![]({{ site.baseurl }}/images/blog/226af-kodama-dub.png)

Designing the electronics took me some time. Pictures below!

![]({{ site.baseurl }}/images/blog/873a2-20180626_180013-1.jpg)

There is one PCB for each group of 8 potentiometers. There are actually two variants of those PCBs - one "master" and second one "slave". Since I've used 16-channel multiplexers in this controller, one PCB had that multiplexer and second one ("slave") didn't - the point was to connect the slave board to the master, and then from master potentiometer board to main PCB. In total - only three cables to main PCB. All the boards are also screwed to plexiglas holder.

![]({{ site.baseurl }}/images/blog/b7ca8-20180509_232808.jpg)

There is one PCB per fader as well - those boards contain connector to main board only. Main board is soldered directly to middle two faders and every other board connects to it.

![]({{ site.baseurl }}/images/blog/2436f-20180518_163508.jpg)

Each button has a small PCB. Two lines go straight to main board, and GND connection is achieved by soldering the button/LED PCB to the nearest fader board.

![]({{ site.baseurl }}/images/blog/7f0cc-20180712_230958.jpg)

Everything wired up.

The final product looks like this:

![]({{ site.baseurl }}/images/blog/11619-img_20180629_141909_573.jpg)

![]({{ site.baseurl }}/images/blog/15792-img_20180616_135043_162.jpg)

![]({{ site.baseurl }}/images/blog/540b3-20180713_080821.jpg)

![]({{ site.baseurl }}/images/blog/7c9ff-20180617_001417.jpg)

I'm really happy with how everything turned out, even though it took me more time than I anticipated - those things happen when you mess up PCB design, plate design, order the wrong components etc. Feels like I did everything twice for this controller!

On the software side of things, OpenDeck runs the show, of course, which means it's configurable just as any other OpenDeck board. There are only few lines of code specific for this controller.

Here's to hoping it's going to serve Matt well in his live shows.

Thanks for reading!
