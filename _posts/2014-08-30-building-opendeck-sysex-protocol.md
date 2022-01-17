---
layout: post
title: "Building OpenDeck - SysEx protocol"
date: "2014-08-30"
tags: 
  - "opendeck"
  - "programming"
comments: true
---

MIDI is a great protocol. One if its best features is System Exclusive message - the only type of message in MIDI protocol which doesn't have defined message length, that is, it can be dozens of bytes long, or more, given that data bytes have MSB bit set to zero (byte value is 0-127). Only thing that is defined is its start, `0xF0` and end, `0xF7`. Manufacturer ID byte (or three bytes) is what usually follows after start byte, so that only specific devices accept the message and respond to it. Everything else is optional, which means you can create your own protocol for configuring your MIDI device using nothing more than a SysEx message. Because of its undefined nature, you can even use it to add more features to MIDI itself, if you find MIDI protocol too limiting for your needs, which is kind of hard to imagine, but oh well.

SysEx is also the basis of configuring OpenDeck platform. I've tried to make protocol as simple as possible, so that it's easy to understand and remember. This is the main message format:

`F0 ID ID ID WISH AMOUNT MESSAGE_TYPE MESSAGE_SUBTYPE PARAMETER_ID NEW_PARAMETER_ID F7`

Whoosh! What's all that? I'll try to explain every byte. As you can see, there are three ID bytes after the SysEx message start. Back when MIDI was new standard, specification said only the first byte after SysEx start is ID byte, which due to the SysEx limitation of maximum value of data byte being 127 meant that there could only be 127 MIDI manufacturers in the world (ID 0 is unassigned). That was true in first couple of years, but after a while, single byte just wasn't enough anymore, so it was decided that three bytes could be used as ID as well. Those three bytes are actually two, since first byte is always zero. Even two bytes (just one byte more than what original specification said) are enough for more than 16k combinations, so there shouldn't be any reason ever to increase those three bytes to four, or more. Furthermore, there is an ID reserved for educational and development purposes, which is what I should use, or at least what I thought I'd use. However, that ID prohibits use in any product released to the public, commercial or not, so that was not a deal. On the other hand, to use any other ID, you have to register and pay anual price od 200$ to MIDI Manufacturers Association. So, I decided to just use 3-byte ID and hope nobody will complain about it. I've checked [official manufacturer ID list](http://www.midi.org/techspecs/manid.php) and luckily, nobody is using the ID I wanted. Also, given how my SysEx system works, it's basically impossible to use it on any other device, even if it has same ID. I settled for `0x00 0x53 0x43` ID sequence. That ID, as well as some other parts of my SysEx protocol is based on ASCII table. `0x53` in hexadecimal system means "S" in ASCII table, and `0x43` is "C", SC for Shantea Controls. Easy.

## `WISH`

Wish can have three meanings:

* `GET`: Request data from controller. Code for this is `0x00`.
* `SET`: Store new data in controller. Code is `0x01`.
* `RESTORE`: Restores default configuration for specified data, or restores every setting to factory default. Code is `0x02`.

## `AMOUNT`

This byte specifies whether we want to get/set/restore single parameter, or all parameters for specified message type. Single code is `0x00`, and all is `0x01`. Again, really easy.

## `MESSAGE_TYPE`

There are several message types, and their codes are all based on ASCII table, just like ID:

### MIDI Channel

Code: `0x4D`.

There are 5 channels in total (Button press, long button press, CC channel for pots, CC for encoders and input channel). These are their parameter codes:

```
#define SYS_EX_MC_BUTTON_NOTE 0x00
#define SYS_EX_MC_LONG_PRESS_BUTTON_NOTE 0x01
#define SYS_EX_MC_POT_CC 0x02
#define SYS_EX_MC_ENC_CC 0x03
#define SYS_EX_MC_INPUT 0x04
```

### Hardware parameter

Code: `0x54`

3 hardware parameters in total. Codes:

```
#define SYS_EX_HW_P_LONG_PRESS_TIME 0x00
#define SYS_EX_HW_P_BLINK_TIME 0x01
#define SYS_EX_HW_P_START_UP_SWITCH_TIME 0x02
```

### Software feature

Code: `0x53`

7 features. Codes:

```
#define SYS_EX_SW_F_RUNNING_STATUS 0x00
#define SYS_EX_SW_F_STANDARD_NOTE_OFF 0x01
#define SYS_EX_SW_F_ENC_NOTES 0x02
#define SYS_EX_SW_F_POT_NOTES 0x03
#define SYS_EX_SW_F_LONG_PRESS 0x04
#define SYS_EX_SW_F_LED_BLINK 0x05
#define SYS_EX_SW_F_START_UP_ROUTINE 0x06
```

### Hardware feature

Code: `0x48`

4 main hardware features. Codes:

```
#define SYS_EX_HW_F_BUTTONS 0x00
#define SYS_EX_HW_F_POTS 0x01
#define SYS_EX_HW_F_ENC 0x02
#define SYS_EX_HW_F_LEDS 0x03
```

### Buttons

Code: `0x42`

### Potentiometers

Code: `0x50`

### Encoders

Code: `0x45`

### LEDs

Code: `0x4C`

## `MESSAGE_SUBTYPE`

Several types of message require more specific info abut their type: buttons, pots, LEDs and encoders. Subtypes are following:

**Buttons**:
  * **Type**: `0x00`
  * **Note**: `0x01`

**Type** is for getting/setting info about type of button. Type can either be momentary (`0x00`), meaning that button will send note off right after it's released, or it can be "toggle" type (`0x01`), which means that pressing button will send note on, releasing it will do nothing, and pressing it again will send note off.

**Note** is MIDI note number which button sends.

**Potentiometers**:
  * **Enabled**: `0x00`
  * **Inverted**: `0x01`
  * **CC #**: `0x02`

All of these are pretty self-explanatory. Setting enabled bit to 1 enables the potentiometer, and 0 disables it. When potentiometer is disabled, it will not send any data. Setting inverted bit to 1 inverts the CC data coming from the pot, which means that usual 0-127 CC range transforms to 127-0. Useful when you reversed the power/ground lines on potentiometer. CC code can be anything from 0-127.

**Encoders**: Same logic as potentiometers.

**LEDs**: For now, LEDs don't have any sub-type, which is probably going to be changed as I develop the protocol further.

Every other message type doesn't have sub-type, which means that they require setting of sub-type byte to `0x00`.

## `PARAMETER_ID`

ID of component we want to manipulate. Allowed IDs:

* MIDI channels: 0-4
* Hardware parameters: 0-2
* Software features: 0-6
* Hardware features: 0-3
* Buttons: 0-63
* Potentiometers: 0-63
* Encoders: 0-31
* LEDs: 0-63

## `NEW_PARAMETER_ID`

Only needed when setting new value of specified parameter. Allowed IDs:

* MIDI channels: 1-16
* Hardware parameters: 4-15 for long-press time (400-1500 miliseconds), 1-15 for LED blink time (100-1500 miliseconds), 1-150 for start-up LED switch time (10-1500 miliseconds).
* Software features: 0-1 (enabled/disabled)
* Hardware features: 0-1 (enabled/disabled)
* Buttons: 0-127
* Potentiometers: 0-127
* Encoders: 0-127
* LEDs: 0-127

## Examples

This is the scenario: we want to find out on which MIDI channel are buttons sending Note data for regular presses (note that all example bytes are in fact in hexadecimal system, not decimal):

`F0 00 53 43 00 00 4D 00 00 F7`

Message starts with start code. After that, there are 3 bytes reserved for ID. Next comes `WISH` byte. Since we want to get data, code is `0x00`. We only want single parameter, so `AMOUNT` byte is also `0x00`. Message type for MIDI channel is `0x4D`, so that is next byte. MIDI channels don't have sub-type code, so we set next byte to `0x00`. Finally, since we want button channel for regular press, we set the last byte to `0x00`.

Response is handled in very similiar way as request. After sending that message to controller, result is following:

`F0 00 53 43 41 4D 00 01 F7`

Response also starts with three ID bytes. After that comes `0x41` byte. `0x41` in hex system is "A", and it's chosen since it represents ACK signal, meaning that received message is correct request, and that there haven't been any errors during data retrieval. After ACK signal, response sends message type and subtype, that is, `0x4D` and `0x00` in this case. Final byte is wanted data. Since default MIDI channel is 1, byte is also `0x01`.

Next example: We want to get all MIDI channels at once.

`F0 00 53 43 00 01 4D 00 F7`

Very similiar to previous example, except that now we're setting `AMOUNT` (6th byte) to `0x01`, because we want all parameters. Note that in this message, parameter ID isn't needed.

Result is following:

`F0 00 53 43 41 4d 00 01 02 01 02 01`

Again, similiar result as previous message, except that now there are 5 values after subtype signal, because there are 5 MIDI channels.

Now, we want to set CC channel for potentiometers to channel 2 (default is 1).

`F0 00 53 43 01 00 4D 02 02 F7`

5th byte (`WISH`) is now `0x01`, because we are setting a value. 6th byte (`AMOUNT`) is `0x00`, because we are setting only one value. Following bytes are `MESSAGE_TYPE` and `MESSAGE_SUBTYPE`, parameter of channel we want to change (code for CC channel for pots is `0x02`), and a new value for channel, `0x02`.

`F0 00 53 43 41 4d 00 01 F7`

Again, ID followed by ACK, followed by `MESSAGE_TYPE`/`MESSAGE_SUBTYPE` and final byte `0x01`, which means controller has successfully written one new value. Note that these are permanent changes, that is, all values are written to microcontroller EEPROM, meaning that they won't be replaced by defaults next time controller starts-up.

There is another type of message, "hello world", used for setting up SysEx communication with controller:

`F0 00 53 43 F7`

If we send this message to controller, the response we would get is:

`F0 00 53 43 41 F7`

Which is ID followed by ACK signal. This is used for checking the device ID. If this check fails, no further SysEx communication will be allowed until the "hello world" message has correct ID.

## Error messages

Each SysEx message goes through rigorous testing of each supplied byte, so it's impossible to mess up controller with wrong values. Every time message format is wrong, controller will send error message with error code. For now, these are error codes:

### Error 0

`F0 46 00 F7`

This is error code for wrong device ID. When you supply wrong ID code, first byte after the start is 46, which is "F" in ASCII table (F for failure), which means something has gone wrong. After error byte, next byte is error number, in this case 0. This error is the only one in which device ID isn't sent, for obvious reasons.

### Error 1

Example: `F0 00 53 43 46 01 F7`

Error code for wrong WISH command. Note the presence of ID in response.

### Error 2

Example: `F0 00 53 43 46 02 F7`

Wrong single/all command.

### Error 3

Example: `F0 00 53 43 46 03 F7`

Wrong message type.

### Error 4

Example: `F0 00 53 43 46 04 F7`

Wrong message sub-type.

### Error 5

Example: `F0 00 53 43 46 05 F7`

Wrong parameter ID.

### Error 6

Example: `F0 00 53 43 46 06 F7`

Wrong new parameter ID.

### Error 7

Example: `F0 00 53 43 46 07 F7`

Message too short.

### Error 8

Example: `F0 00 53 43 46 08 F7`

Error while writing new data to microcontroller.

## Keeping data integrity

OpenDeck code makes sure that new data is actually written to EEPROM without issues. Here is example of checking for whether MIDI channel has been written successfully:

```
bool OpenDeck::sysExSetMIDIchannel(uint8_t channel, uint8_t channelNumber)
{
    switch (channel)
    {
        case SYS_EX_MC_BUTTON_NOTE:
        _buttonNoteChannel = channelNumber;
        eeprom_update_byte((uint8_t*)EEPROM_MC_BUTTON_NOTE, channelNumber);
        return (channelNumber == eeprom_read_byte((uint8_t*)EEPROM_MC_BUTTON_NOTE));
        break;
        ...
    }
}
```

Function first overwrites channel currently in RAM. After that, it writes new value to EEPROM. Finally, it checks if received channel is equal to the one just written in EEPROM, so that it's impossible to get ACK message if this step fails.

That would be all for now. Protocol is still in heavy development, and some of the stuff I’ve talked about here isn’t even implemented yet.
