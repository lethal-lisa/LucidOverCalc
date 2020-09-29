# Guide to Overclocked LSDj by Infu

## How to Create an Overclocked LSDj ROM

1. Open up your LSDj ROM in the hexadecimal editor of your choice.

2. Find sequence of hex vaules "`3E04E007`" and change it to "`3E07E007`" (second value `04` to `07`). [To add: ROM address(es) for this value.]

3. Your LSDj's tempo should be multiplied by four now!
This works with all LSDj versions from from 2.6.0 (included) all the way up to the latest one available!

[To add: Pictures of this process (ex: picture of a hex editor showing the addresses and the old value)]

## History and the Benefits of Overclocking Nowadays

Software overclocking of LSDj was first explored by Pain Perdu in 2017 using version 5.3.5. [Citation needed: Add a link to one of these early examples.]
Results were impressive, but due to heavier CPU usage while overclocked,
users would experience serious drawbacks,
making usage less than desirable.
However, version 8 improved dramatically in those terms,
and now, even in heavy modulation situations where previous versions would slow down,
there's no hint of slowdown!
Consequently, overclocking LSDj from version 8 onwards should be more than pleasureable experience, providing much greater headroom than previous versions!

Software Overclocking LSDj will unlock new wicked types of sound design,
enabling multitimbrality on each channel and amplitude modulation synthesis!
But it willll require something stronger than an original model GameBoy (GameBoy Color, GameBoy Advance, or an emulator like BGB for the best results).
Also note than an overclocked LSDj will not correctly play any of your non-OC saves; anything played will be four times too fast.

Four times engine speed means that every table modulation, grooves, and whole sequencer will play four times faster.
The guide below will explain many tips and tricks regarding overclocking,
but it is designed for advanced LSDj users who are confident in normal LSDj operation and seek to get out more out of it.

[To add: Ask Pain Perdu to fuse both guides.]

### Amplitude Modulation Synthesis and Grooves

The magic of overclocking is largely dependant on LSDj's `TEMPO` parameter.
When performing extremely rapid modulation of particular commands/effects
(for example: a table with O`--`, O`LR` and H`00`)
a hum of a specific pitch will be produced.
This hum is generated with *Amplitude Modulation* synthesis, or simply, AM synthesis.
AM synthesis, in the context of LSDj, works by rapidly turning a channel on and off at a certain frequency.
This frequency is created by using a looping table.
The rate at which the table loops is dependent on the `TEMPO` parameter,
but the actual produced frequency is dependent on how long the table is.
The higher the tempo, the faster the table will be cycled through,
thus the higher the initial pitch.
*Initial*, because you can achieve even more by manipulating the table by increasing/decreasing the OFF/O`--` time.

Because of that, simply multiplying your grooves from `06/06` to `18/18` would even out with the multiplied tempo,
it probably won't be compatible with the actual selected tempo setting,
so adjust grooves until you achieve a tempo you desire.
A good practice is to make sure your grooves are divisible by two in order to achieve half tempo if desired.

[Note: Is there a way to calculate ACTUAL song BPM with those crazy grooves?]
[To add: breif explanation of "grooves".]

#### Tempo Command `T`

LSDj allows the user to change the engine tempo on the fly using the `T` command.
This affects the entire sequencer, 
therefore affecting the overclock hum pitch.
The problem is that whole sequencer needs to be properly adjusted for this to work.

Though I haven't done it properly myself, I think that grooves will do the work correctly!
Because we are overclocking quite high,
I think we could accurately adjust groove to the song, or make it swing a bit but still fit the song.

I would recommend placing extra `G` commands before `T` in order to even out the tempo change,
(pre `T` groove with old and new groove timing for the smoothest effect - Placing new groove before/after tempo change can make song hiccup for a brief moment)
and put the new proper groove in all patterns when there's an empty space in the sequencer.

## Choosing Your Version: A Word About Pre-8.8.0 - ADSR Tempo Related Drift

While using version 8 I noticed that the ADSR envelope tends to not be consistent,
and "drifts" in relation to the engine's tempo.
The user might hear the ADSR being slightly shorter in a regular, LFO-like manner.
This behaviour is more noticeable when using the overclocked version.

[To add: Reproducing instructions here.]

This effect is mostly undesired and somewhat uncontrollable unless the user tunes the `TEMPO` *and* starts the song at a very specific moment.

Version 8.8.0 and onwards keeps the envelopes very stable,
so this becomes a non-issue when using those versions.

## Notes on CPU Usage

* The `V` command is much more resource intensive than having transpose done in the table.
* Longer tables are easier on the CPU.
* Modulation using the `O` command looks like a pulse waveform.
* Is influenced by the width of the pulse - shortest one - best sound for hum, whereas 75% makes it sound almost inaudible.
* One of the ways to control the AM effect's volume is to move around the steps where the `O` is active and where it's not,
and make sure it hits thinner waves if we want the hum to be quieter.
* The `O` command may be used anywhere.
* Using the `W` command adds overtones and hum.
* The `E` command is heavy on CPU usage.

##### Other Pages
* **[Back to Main Page](/README.md)**
