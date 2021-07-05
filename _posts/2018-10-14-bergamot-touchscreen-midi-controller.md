---
layout: post
title: "Touchscreen-based MIDI controller"
date: "2018-10-14"
categories: 
  - "build-log"
  - "design"
tags: 
  - "bergamot"
  - "midi"
  - "opendeck"
  - "touchscreen"
image: "98b26-bergamot_full_angle.jpg"
comments: true
---

I've built myself a new controller - Bergamot, which is my first controller based on a touchscreen.

## New controller - again?

I never do things for the sake of doing them. Bergamot is purely a result of frustration with [Tannin 2](https://shanteacontrols.wpcomstaging.com/2015/08/13/building-tannin-2/). When I've built Tannin 2, I've been using it happily for quite some time. Then, as I was really busy with [Zvuk9](https://shanteacontrols.wpcomstaging.com/2017/08/20/zvuk9/), I've barely touched it anymore it so I've borrowed it to [Jah Billah](https://jahbillah.bandcamp.com). Few months ago, he returned it to me and I've started using it again. I've come to realize that it's not really as good as I'd like it to be.

## Issues with Tannin 2

The metal potentiometers on Tannin 2 were quite hard to rotate, as I've grown accustomed to plastic ones over the last few years. Also, the [silicone buttons](https://www.adafruit.com/product/1611) were not as tactile as I wanted them to be. There were also few other things - Tannin 2 was based on custom hardware which wasn't compatible with current OpenDeck software. As an result I couldn't really configure it the way I'd like to. All of this made me realize that I actually do need a new controller.

## Touchscreen

I've been thinking what kind of buttons do I want on the updated version of controller. I wanted something with fast response, which lead me to small tactile buttons you can buy everywhere. They really do work great, however, I would need to design custom caps for them. As I was thinking about this, it occurred to me that I could simply replace all the buttons on the controller with touchscreen. First, it would solve tactility issue. Second, it would eliminate the need for more hardware (LEDs, caps, etc.). Third, I could design any layout I want and change it on the fly, instead of being locked in whatever layout was already present on the controller.

## Name and design

Following the tradition with naming my controllers (and my entire endeavour - Shan**tea** Controls) with something tea-inspired, I've decided to name this controller Bergamot. [Bergamot](https://en.wikipedia.org/wiki/Bergamot_orange) is a citrus probably best known as the ingredient giving the Earl Grey tea its specific taste. I've been drinking lots of Earl Grey lately, and also watching [Star Trek TNG](https://www.youtube.com/watch?v=R2IJdfxWtPM) for who knows which time already, so Bergamot seemed like a fine, no, wait, I mean, [_splendid_](https://www.youtube.com/watch?v=76uIoL2qma4) choice. I've also re-used the theme I had already used on [Ceylon](https://shanteacontrols.wpcomstaging.com/2015/02/24/building-ceylon/) controller with geographical coordinates - this time the numbers are representing coordinates of [Reggio di Calabria](https://en.wikipedia.org/wiki/Reggio_Calabria) city in Italy - city also known as "Bergamot city" due to most of the world's Bergamot production being based there.

![]({{ site.baseurl }}/images/blog/d8c3f-bergamot_plate.jpg)

The plate is standard 1.5mm thick gravoply with additional 3mm plexiglas plate glued below it. I've been using this scheme for very long now since it's very sturdy and also very cool looking. This time plate is in beautiful orange. Other than the touchscreen, the layout is the same as on Tannin controller - 16 potentiometers and 4 encoders.

## Electronics

The PCBs for potentiometers are the same as for the controller I've built for [Conscious Youth.](https://shanteacontrols.wpcomstaging.com/2018/07/16/conscious-youth-custom-controller/) Main PCB contains MCU, connector for potentiometer boards, connector for touchscreen, power supply (as touchscreen requires +12V) and encoders. Inside the controller there are only few wires, which I'm very pleased with.

![]({{ site.baseurl }}/images/blog/5898d-bergamot_assembly.jpg)

## Finished build

![]({{ site.baseurl }}/images/blog/c5a9f-bergamot_full_top.jpg)

The case for this controller is the same as for Tannin 2 - it's actually re-purposed since I didn't need Tannin 2 anymore.

![]({{ site.baseurl }}/images/blog/d050e-bergamot_back_no_cables.jpg)

The back plate has additional connector for DC power, given that USB alone isn't enough to power the display.

On the touchscreen, there are 4 buttons which I'm using to select the layout I need:

![]({{ site.baseurl }}/images/blog/0cab5-bergamot_display_1.jpg)

![]({{ site.baseurl }}/images/blog/768b7-bergamot_display_2.jpg)

![]({{ site.baseurl }}/images/blog/38cbf-bergamot_display_3.jpg)

![]({{ site.baseurl }}/images/blog/f9b73-bergamot_display_4.jpg)

Layout was drawn using CorelDraw and exported into 640x480 images directly to the touchscreen. Touchscreen handles image loading and display which is really handy (no need to process anything on the main MCU other than touch events).

## Software

Bergamot is based on [latest version of OpenDeck](https://github.com/paradajz/OpenDeck/releases/tag/v3.0.0) which has initial support for touchscreens. I haven't made it official yet since the plan is to support [Nextion Line from ITead](https://nextion.itead.cc). This specific touchscreen I've used on Bergamot is an industrial screen I was already familiar with, but it's not something available for consumers in larger quantities.

## Demo

Here's demo video of Bergamot controller in action! I'm really happy with - in fact, it could be my first controller on which I haven't felt the urge to change something as soon as I've finished it. That's probably a very good sign. There's also a [longer mix you can check out on my Mixcloud](https://www.mixcloud.com/enigmatik/impressions/) - made using Bergamot, of course.

<div class="videoWrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/O12u3A11dXg" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>