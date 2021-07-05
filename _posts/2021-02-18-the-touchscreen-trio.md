---
layout: post
title: "The touchscreen trio"
date: "2021-02-18"
image: "post_default_header.jpg"
comments: true
---

About a year ago I’ve started sketching the new controller for myself, since I’ve found myself a bit limited by the Bergamot controller. Eventually, I made three different controllers (or two, depending on how you count).

## Cardamom

Cardamom project started out with specs: 16 pots (standard by now), 7 encoders, 2 channel faders and one crossfader and big, 10″ touchscreen display. Reason I wanted such large screen (by contrast, Bergamot has 5″ one) was to avoid juggling between various screen – there’s only so much you can fit on 5″ display. For this I’ve selected the Nextion. The goal with this controller anyways to add official support for touchscreens, so this served as a great testing ground. This was also the very first controller I’ve started working on with STM32 MCU, which is by now in all my controllers as well as in official OpenDeck board. I also wanted something exotic for the wooden case – my go-to wood guy showed me some time back stunning african wood called Padauk. I immediately fell in love with it and decided Cardamom would have it. So, all in all, very experimental controller with lots of unknowns. Below are some pictures of it.

![]({{ site.baseurl }}/images/blog/109956535_147772146897016_6430408931493065490_o.jpg)

![]({{ site.baseurl }}/images/blog/109800995_147773196896911_7581733213845568884_o.jpg)

![]({{ site.baseurl }}/images/blog/108232583_146912143649683_232275445360695707_o.jpg)

![]({{ site.baseurl }}/images/blog/107933249_146911963649701_2622829847782104751_o.jpg)

As is tradition with my controllers, this one also has reference to teas – the controller is named Cardamom after a spice giving many Ayurvedic teas their spicy taste, and also a source of vitamin B6, which is the chemical on the plate.
As far as Nextion support is concerned, OpenDeck now supports CDC mode, or more simply, the board can now act as USB to serial device, if you choose to reboot into it from Web UI. This allows you to upload your design to the screen from Nextion GUI without detaching screen from OpenDeck board and then plugging it into FTDI or some other converter. This feature is available on all STM32 based boards.

<iframe width="560" height="315" src="https://www.youtube.com/embed/TPc6ETIsVTM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


## Rooibos

I seriously don’t know what I was thinking when I was designing Cardamom. The thing is huge! Actually it was so large that it wouldn’t fit in my small suitcase, which annoyed me greatly. Otherwise it did everything I wanted it to do. So, I decided to build virtually the same controller, but smaller. This one was named Rooibos. I’ve removed crossfader since I barely even use that, and also there are 5 encoders instead of 7, which is also fine. Touchscreen is also 10″, but this one is made by Viewtech – the same company that produced the screen for Bergamot controller. This was another experiment – I wanted to see how they behave and I also wanted official support for them in OpenDeck firmware. I’m very happy with the screen quality. In my opinion, touch sensitivity is bit better than on Nextion, however, their software tooling leaves a lot to be desired. If you want convenience, go with Nextion. If you want industrial quality and reliability, go with Viewtech (or Stone HMI, their global brand). Anyways, this is my main controller now.

![]({{ site.baseurl }}/images/blog/129955349_198098805197683_6067196513235935820_o.jpg)

![]({{ site.baseurl }}/images/blog/129588734_198100081864222_1509632558569520269_o.jpg)

![]({{ site.baseurl }}/images/blog/129474055_198111261863104_8315209481913533469_o.jpg)


Rooibos is a red bush native to South Africa. Leaves from it are used to make one of my favorite teas with the same name. Perfect for any time of the day since it doesn’t contain theine, so it won’t keep you awake, unlike black and green (and anything made from Camellia Sinensis, really) teas do.

<iframe width="560" height="315" src="https://www.youtube.com/embed/B4JwPd6Kib4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


## Bergamot

Having built Rooibos I’ve filled all my controller needs, however, I still had that old Bergamot controller lying around. It irked that it was based on, by now, unsupported hardware (ATmega32u4) and it also had worn-out wooden case, which just wasn’t up to the standard of Padauk (but then again, what is?). So I’ve just rebuilt the whole thing, leaving mostly everything as it. I did change the screen, however. It’s 7″ one from Stone HMI.

![]({{ site.baseurl }}/images/blog/138267756_224522002555363_4414520917304436623_o.jpg)

![]({{ site.baseurl }}/images/blog/138222362_224522509221979_5499731080639708385_o.jpg)

![]({{ site.baseurl }}/images/blog/138047851_224522602555303_6505723444698743035_o.jpg)
 

## X/Y support
There is one more thing I’ve added to OpenDeck firmware in latest release – the ability to define custom regions on screen to serve as analog components. Defining is done in Web Ui, just like everything else. This could enable some really cool use-cases. Sadly, all I could think of and show off was controlling two effects at the same time in Traktor DJ. Here’s to hoping I get to see more use cases of this!

<iframe width="560" height="315" src="https://www.youtube.com/embed/K29GrrtvoAA" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>