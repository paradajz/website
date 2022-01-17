---
layout: post
title: "Building Anandamidi controller, part 1"
date: "2014-04-12"
tags: 
  - "anandamidi"
  - "buildlog"
image: "anandamidi_nice.jpg"
comments: true
---

Anandamidi, MIDI controller with a strange name, is my latest project. Guy for whom I'm building it sent me basic layout and a name, while I'm working on everything else, from design (which always come first) to electronics and programming.

## Name

Let's explain the name first. "Anandamide is a molecule that plays a role in many bodily activities, including appetite, memory, pain, depression, and fertility - hence its name, which is derived from the word 'ananda' which means 'extreme delight' or 'bliss' in the Sanskrit language" ([Source](http://www.chm.bris.ac.uk/motm/anandamide/ananh.htm)). The molecule looks like this:

![]({{ site.baseurl }}/images/blog/640px-anandamide_skeletal-svg.jpg)

## Layout

Moving on to layout. Project is fairly simple, as far as component number is concerned. It consists of 8 switches, 2 rows and 4 columns on the left side of controller and another 8 on the right side. Middle part consists of two vertically placed faders, with 5 LEDs in column next to each of them. Next to each LED column are 3 potentiometers. Below that is another horizontally placed fader. That's it actually.

## Design

After few days of playing in CorelDraw, this is what I've come up with:  

![]({{ site.baseurl }}/images/blog/anandamidi_nice.jpg)

I'm very fond of Ace Futurism font, so I'm using it almost exclusively in my designs. You can get font for free [here](http://www.dafont.com/ace-futurism.font). Anandamide molecule is used around the controller name, along with the logo from the guy who ordered it inside it.

Shantea Controls is a name for a imaginary company which builds custom MIDI controllers, and the sole employee is me.) The leaf represents Camelia Sinensis leafs, a plant used for production of green, black and white teas (hence the "tea" in Shantea).

## Plate

The plate actually consists of two parts. First is black 3mm thick plexiglass on which black Gravoply plate is glued, resulting in a very professional looking product. The Gravoply board is then engraved with laser CNC, so the final look is pretty much identical to the picture posted above.

That would be it for part 1, next time I'll talk about some quirks and hacks involved into placement of components, among other things.
