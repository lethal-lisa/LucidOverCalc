# LSDj Overclocked Guide By Infu

## How to Overclock

1. Open up your LSDj rom in the hexadecimal editor of your choice.

2. Find sequence of hex vaules "`3E04E007`" and change it to "`3E07E007`" (second value `04` to `07`).

3. Your LSDj's tempo should be multiplied by four now! This works with all LSDj versions from from 2.6.0 (included) till the latest one available!

## Amplitude Modulation

* Rapidly making any channel quiet.

* [Notes](/NOTES.md)

### Pre-8.8.0 - ADSR Tempo Related Drift

While using v8 I noticed that ADSR tends to not be consistent, and *drifts* in relation to the engine's tempo (user might hear ADSR being slightly shorter in regular, LFO like manner).

This behaviour is more noticeable with the overclocked version.
(REPRODUCING INSTRUCTIONS HERE)
It is mostly undesired and not very controllable unless the user tunes the TEMPO *and* starts the song at a very specific moment.

Version 8.8.0 and onwards keeps the envelopes very stable.

### `T` Command

LSDj allows the user to change the engine tempo, therefore affecting the OC hum pitch.
The problem is that whole sequencer needs to be properly adjusted.

Though I haven't done it properly myself, I think that grooves will do the work correctly!
Because we are overclocking quite high, I think we could accurately adjust groove to the song (or make it swing a bit but still fit the song).

I would recommend placing extra `G` commands before `T` to even out the tempo change,
(pre `T` groove with old and new groove timing for the smoothest effect - Placing new groove before/after tempo change can make song hiccup for a brief moment)
and put the new proper groove in all patterns when there's an empty space in the sequencer.

#### Other Pages
* **[Extra Notes](/NOTES.md)**
* **[Back to Main Page](/README.md)**
