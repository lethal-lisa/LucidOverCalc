LSDJ OVERCLOCKED GUIDE BY INFU

1. HOW TO OVERCLOCK

-Open up your LSDj rom in any hex editor of your choice

-Find sequence of hex vaules "3E04E007" and change it to "3E07E007". (second value 04 to 07)

Your LSDj's tempo should be multiplied 4 times now!
(works with all LSDJ versions from from 2.6.0 (included) till the latest one available!)

2. Amplitude Modulation

Rapidly making any channel quiet 

[notes] (to be tidied up)
V command is much more resource intensive than having transpose done in the table

Longer tables are easier on the CPU

O modulation looks like pulse waveform
Is influenced by the width of the pulse - shortest one - best sound for hum, whereas 75% makes it sound almost unaudile
one of the ways to control it's volume is to move around the steps where the O is active, where's not, and make sure it hits those thinner waves if we want the hum quieter.
O command may be used anywhere
W command adds overtones + hum
E is heavy on the CPU
[end of notes]

**PRE 8.8.0 - ADSR TEMPO RELATED DRIFT**

while using v8 I noticed that ADSR tend to not be consistent, and *drift* in relation to engine tempo (user might hear ADSR being slightly shorter in regular, LFO like manner)

This behaviour is more noticeable with Overclocked version.
(REPRODUCING INSTRUCTIONS HERE)
It is mostly undesired and not very controllable unless user tunes the TEMPO *and* starts the song at very specific moment.

Version 8.8.0 and onwards keeps the envelopes very stable.

**T COMMAND**

LSDj allows the user to change the engine tempo, therefore affect the OChum pitch. The problem is that whole sequencer needs to be properly adjusted.

Tho I haven't done it properly myself, I think that grooves will do the work correctly!
Because we are OC quite high, I think we could accurately adjust groove to the song (or make it swing a bit but still fit the song)

I would recommend placing extra G command before T to even out the tempo change (pre T groove with old and new groove timing for the smoothest effect - Placing new groove before/after tempo change can make song hiccup for brief moment) ,and put the new proper groove in all patterns when there's an empty space in the sequencer
