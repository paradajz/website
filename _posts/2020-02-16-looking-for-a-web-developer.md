---
layout: post
title: "Looking for a Web developer"
date: "2020-02-16"
categories: 
  - "development"
  - "info"
tags: 
  - "opendeck"
  - "webui"
image: "webui-9.png"
comments: true
---

Web configurator is among the most loved features of OpenDeck. It's basically its selling point. Without it, OpenDeck would be just another open-source project where you need to mess with low level stuff like sending and receiving raw SysEx bytes. Configurator makes the configuration easy, and most importantly, low level details become invisible. In my opinion, great technology should always be invisible.

Unfortunately, the UI has some drawbacks. Since the time it was introduced, several major shortcomings have become visible, such as:

1. There's no way for the user to update the firmware directly from the interface - instead, users need to launch shell scripts (terminal!) to update to the latest firmware.
2. User interface cannot handle errors and missing features on board gracefully - when I add new configurable feature to the interface and the currently plugged in board doesn't have that feature, entire screen on the interface crashes.
3. User interface doesn't support 2-byte variant of the configuration protocol - translated, this means that the interface supports only up to 127 components per block (max 127 buttons, max 127 encoders etc.) even though my protocol supports this from the very first version. In the near future, I want to build OpenDeck Mega board, which would feature 256 button connections (among other things) so that would be impossible to configure using the UI in its current form.
4. Core UI code is a mess. This has happened because the original source code was lost, and the version that was uploaded to the server was run through obsfucator.
5. I am not a web developer so I can't fix any of this (UI code was written by another developer).

If you think you have what it takes to build a new version of the configurator, let me know! Of course, I am not expecting anyone to do this for free (might be obvious, but doesn't hurt to mention it). The current source code is available in [OpenDeck repository on GitHub](https://github.com/shanteacontrols/OpenDeck/tree/master/webui).
