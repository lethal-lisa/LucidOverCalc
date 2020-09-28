# LSDj Overclocked Guide By Infu

## How to Overclock

1. Open up your LSDj rom in the hexadecimal editor of your choice.

2. Find sequence of hex vaules "`3E04E007`" and change it to "`3E07E007`" (second value `04` to `07`).

3. Your LSDj's tempo should be multiplied by four now! This works with all LSDj versions from from 2.6.0 (included) till the latest one available!

## History + Benefits of Overclocking nowadays

Software overclocking of LSDj was first explored by Pain Perdu in 2017 using version 5.3.5 Results were impressive, but due to CPU usage of LSDj while overclocked users would experience serious drawbacks, making it less than desireable to use.

Version 8 improved dramatically in those terms, and now in heavy modulation situaltions where previous versions would slow down the tracker, now there's no hint of slowdown!
Consequently, overclocking LSDj from version 8 onwards should be more than pleasureable experience, providing much greater headroom than previous versions!

Software Overclocking LSDj will
unlock you new wicked ways of sound design,
enable multitimbrality(!) of each channel,
but
will require something stronger than DMG (GBC or GBASP/BGB for best results)
Won't play correctly any of your non-OC saves (gonna be 4x too fast)

4x speed of whole engine means that every table modulation, grooves and whole sequencer will play 4times faster. Guide below will explain you many tips and tricks regarding OC, but it's designed for advanced LSDj users who are confident in normal LSDj operation and seek to get out more out of it.

[to add: ask Pain perdu to fuse both guides]

### Amplitude Modulation Synthesis, grooves

Magic of OC is dependant mostly on LSDj's `TEMPO`. When performing extremely rapid modulation of particular commands/effects (For example, table with O`--`, O`LR` and H`00`) you will hear hum of specific pitch. This hum is generated with *"Amplitude Modulation"* type synthesis (or simply, *AM*). The higher the tempo, the higher the initial pitch. *Initial*, because you can achieve even more by manipulating with the table (increasing the OFF/O`--` time)

Because of that, simply multiplying your grooves from `06/06` to `18/18` tho would even out with the multiplied tempo, it's probably not gonna be compatible with the tempo setting you selected, so adjust grooves til you achieve tempo you desire (good practice is to make sure your grooves are divisible by 2 to achieve half tempo if desired)
[note: is there an way to calculate ACTUAL song BPM with those crazy grooves? :thinking:]

### Choosing your version: word about Pre-8.8.0 - ADSR Tempo Related Drift

While using v8 I noticed that ADSR tends to not be consistent, and *drifts* in relation to the engine's tempo (user might hear ADSR being slightly shorter in regular, LFO like manner).

This behaviour is more noticeable with the overclocked version.
[REPRODUCING INSTRUCTIONS HERE]
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

### CPU USAGE

* `V` command is much more resource intensive than having transpose done in the table.
* Longer tables are easier on the CPU.
* `O` modulation looks like pulse waveform.
* Is influenced by the width of the pulse - shortest one - best sound for hum, whereas 75% makes it sound almost inaudible.
* One of the ways to control its volume is to move around the steps where the `O` is active, where it's not, and make sure it hits those thinner waves if we want the hum to be quieter.
* `O` command may be used anywhere.
* `W` command adds overtones + hum.
* `E` is heavy on the CPU.


* **[Back to Main Page](/README.md)**
