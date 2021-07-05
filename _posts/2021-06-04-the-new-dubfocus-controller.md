---
layout: post
title: "The new DubFocus controller"
date: "2021-06-04"
categories: 
  - "development"
  - "info"
tags: 
  - "dubfocus"
image: "post_default_header.jpg"
comments: true
---

After some deliberation, I’ve decided to build few new DubFocus controllers. There are several differences between these and previous models:

1. DubFocus 12 became DubFocus 16 in same case – the horizontal spacing between components is now 29mm instead of 40mm.
2. PCBs have been totally redesigned so now, the entire controller is made from 3 large PCBs, connected by two flat cables. There is also one small USB board as before.
3. I am now using STM32F411 Black Pill board as the “brain” of the controller since hand soldering of STM32 MCUs is a major pain.
4. No more holders and holding plate – everything is screwed to Plexiglas plate and then Gravoply plate is screwed on top of that. Before, Plexiglas and Gravoply plates have been glued together. Plexiglas plate is now also thicker since it caries all the electronics on itself (5mm vs. 3mm before).
5. I’ve used metal pots for these builds. No particular reason – I still can’t decide which ones I prefer.

So, without further ado, check the pictures below to see how DubFocus 16C (C = compact) came into life!

![]({{ site.baseurl }}/images/blog/172542229_220702589727822_618265503888699395_n.jpg)

![]({{ site.baseurl }}/images/blog/173199660_221392879658793_9034175403378905046_n.jpg)

![]({{ site.baseurl }}/images/blog/174163217_223865929411488_3903818462814472629_n.jpg)

![]({{ site.baseurl }}/images/blog/174633403_224150579383023_3984727542828117320_n.jpg)

![]({{ site.baseurl }}/images/blog/178580180_231869485277799_5282707656067592910_n.jpg)

![]({{ site.baseurl }}/images/blog/180033747_234501895014558_1655514314867501703_n.jpg)

![]({{ site.baseurl }}/images/blog/180321888_234501448347936_1144560035242290225_n.jpg)

![]({{ site.baseurl }}/images/blog/180611525_234501701681244_4111231124521419647_n.jpg)

![]({{ site.baseurl }}/images/blog/183117105_239682507829830_3719657556997011817_n.jpg)

![]({{ site.baseurl }}/images/blog/184056315_242353007562780_9047760974017905916_n.jpg)

![]({{ site.baseurl }}/images/blog/187945877_251376923327055_3222605484840057158_n.jpg)

![]({{ site.baseurl }}/images/blog/188305862_251376619993752_775288677915221130_n.jpg)

![]({{ site.baseurl }}/images/blog/188423488_251376816660399_8975519552491615412_n.jpg)

![]({{ site.baseurl }}/images/blog/188534875_251377606660320_8726075325443042313_n.jpg)

![]({{ site.baseurl }}/images/blog/188690883_251378013326946_8034703593923187815_n.jpg)

![]({{ site.baseurl }}/images/blog/189018428_251377426660338_7769020329510105453_n.jpg)

![]({{ site.baseurl }}/images/blog/191646335_255734162891331_7987082116862482261_n.jpg)

![]({{ site.baseurl }}/images/blog/193474182_259492185848862_7612030630368761512_n.jpg)

![]({{ site.baseurl }}/images/blog/193475565_259492395848841_4401799299658561406_n.jpg)

![]({{ site.baseurl }}/images/blog/193667083_259708545827226_3189400619628564506_n.jpg)

![]({{ site.baseurl }}/images/blog/194179722_259919012472846_6560917822354076836_n.jpg)

![]({{ site.baseurl }}/images/blog/194278674_259918892472858_8013798929619142178_n.jpg)

![]({{ site.baseurl }}/images/blog/194505585_259491659182248_1741719934655752292_n.jpg)

![]({{ site.baseurl }}/images/blog/194555994_259491585848922_5660892228912734232_n.jpg)

![]({{ site.baseurl }}/images/blog/195514057_259708709160543_493190385348544288_n.jpg)