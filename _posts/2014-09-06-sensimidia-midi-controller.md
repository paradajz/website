---
layout: post
title: "Sensimidia MIDI controller"
date: "2014-09-06"
categories: 
  - "build-log"
  - "design"
tags: 
  - "opendeck"
  - "sensimidia"
image: "post_default_header.jpg"
comments: true
---

Sensimidia is third Shantea Controls controller, and also my second commercial project. I've been working on it for the last two months, but most of that time I did nothing, because of some delivery issues with faders and box. Now that it's finally over, I'd like to present it here.

![]({{ site.baseurl }}/images/blog/sensimidia.png)

In many ways, Sensimidia is similiar to Anandamidi controller. Same buttons, same pots, same faders, same mounting techniques - except for the faders, which I've done right this time. It features 24 buttons, 12 LEDs, 6 rotary potentiometers and 2 faders. I've also added two additional mounting screws to the plate to avoid its bending, although I should've added two more - one in the middle left, and one in the middle right. Design features logo from the guy who ordered the controller. It turned very cool, but then again, that board has magical capability of turning everything into something super-nice.

This controller is first controller I've built using my recently-announced OpenDeck platform, therefore, if you're interested what hardware does this run, scroll few posts below. Worth of note is that even though it's based on OpenDeck design, it doesn't mean Sensimidia runs full version of OpenDeck software. Yes, buttons, pots, MIDI input - all of that works, but full controller configuration via MIDI System Exclusive messages doesn't work yet. Luckily, that is nothing to worry about in this case, since the guy really wanted something simple that works out-of-the-box. I can always update the firmware on controller later - once the OpenDeck platform is finished, and also assuming the guy would actually want the extra features.

Anyways, here's how Sensimidia looks all wired-up:

![]({{ site.baseurl }}/images/blog/p1010018.jpg)

As I said, it's all very similiar to Anandamidi construction. This OpenDeck board connects to my MIDI USB PCB via pin header right above that electrolytic cap.

![]({{ site.baseurl }}/images/blog/p1010003.jpg)

This is how it looks in case. Very nice, but a bit too dark for my taste.

![]({{ site.baseurl }}/images/blog/p1010005_cr.jpg)

And standard USB plate for the cable.

All in all, very fun project again, even though it's not been really that much different from Anandamidi. Here's a quick video I've taken demonstrating some of controller functionality (really sorry for the lack of good camera and tripod):

<div class="videoWrapper">
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/1DqVZFMmq94" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
