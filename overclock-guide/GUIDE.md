# Guide to Overclocked LSDj by Infu

Chapters as they are naturally ordered:
1-History and the Benefits of Overclocking Nowadays
2-How to Create an Overclocked LSDj
  --Choosing Your Version
3-ROM Amplitude Modulation Synthesis and Groove/Tempo/BPM relation (commands)
  --Other commands
4-CPU usage

## History and the Benefits of Overclocking Nowadays

Software overclocking of LSDj was first explored by Pain Perdu in 2017 using version 5.3.5. https://web.archive.org/web/20200601005830/https://chiptuneswin.com/blog/pauls-tech-talk-lsdj-5-3-5_4x-part-2-sandpaper-vs-eardrums/
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

## How to Create an Overclocked LSDj ROM

Step by step instructions:
  1. Open up your LSDj ROM in the hexadecimal editor of your choice (I used HxD on Windows);
  2. Search *hex-value* string `3E04E007`;
  3. Replace it with `3E07E007`; (Notice: We are changing esensially only second value `04` to `07`)
  4. Save;

Your LSDj's tempo should be multiplied by four now!
This works with all LSDj versions from from 2.6.0 (included) all the way up to the latest one available!

## Choosing Your Version
### Pre-8.8.0 - ADSR Tempo Related Drift

While using version 8 I noticed that the ADSR envelope tends to not be consistent,
and "drifts" in relation to the engine's tempo.

``To reproduce on LSDj (8.7.7):
-In Noise Channel create phrase with 16 steps of FD hihats
-Make ADSR for that instrument 61/00/--
-Set tempo to 195
The user might hear the ADSR getting slightly shorter or longer in a regular, LFO-like manner.``

This behaviour is more noticeable when using the overclocked version.
This effect is mostly undesired and somewhat uncontrollable unless the user tunes the `TEMPO` *and* starts the song at a very specific moment (Tho extremely not recommended)

Version 8.8.0 and onwards keeps the envelopes very stable, and is drift is not an issue anymore

Use version 8.8.7 if you wish to retain the old ADSR system, that is compatible with plenty of emulators and all Gameboy consoles.

### Amplitude Modulation Synthesis and Groove/Tempo/BPM relation

The magic of overclocking is largely dependant on LSDj's `TEMPO` parameter.
When performing extremely rapid modulation of particular commands/effects
(for example: a table with O`--`, O`LR` and H`00`)
a hum of a specific pitch will be produced.
LSDj between each E,O,W command generates a click,
which when done in rapid succession generates the hum you can hear.
This hum is generated with *Amplitude Modulation* synthesis, or simply, AM synthesis, which can be thought of as an extra oscillator in the channel.
AM synthesis, in the context of LSDj, works by rapidly turning a channel on and off at a certain frequency.
This frequency is created by using a looping table.
The rate at which the table loops is dependent on the `TEMPO` parameter,
but the actual produced frequency is dependent on how long the table is.
The higher the tempo, the faster the table will be cycled through,
thus the higher the initial pitch.
*Initial*, because you can achieve even more by manipulating the table by increasing/decreasing the OFF/O`--` time.
[To add: ask Pain Perdu to fuse both guides] = OOP THEIR GUIDE IS DEAD MIGHT AS WELL WRITE EVERYTHING ON MY OWN

Because the tempo dictates the actual pitch of the hum, simply multiplying your grooves 4 times may not be satisfactory, so it's best to separate the `TEMPO = BPM` workflow. Instead, to actually achieve BPM you want (or precisely tell which one you're using) use following formula:
`BPM = (Tempo x 96)/[4 rows of your groove setting]`
[Note: 96 comes from having default 6 ticks per step groove, times 4 to achieve `ticks per beat`(24), then times 4 to reach actual value that OverClocked LSDj is using (96)]
A good practice is to make sure your grooves are divisible by two in order to achieve half tempo if desired.

# Controlling the Extra Hum

Commands below enable you to create extra hum sharing the channel you're using it on. The lenght of the modulation will decide the pitch of the hum. Use loops like H`10` to achieve modulation in between rows.

## O command (any channel)

`O` command generates hum **idependently** from the instrument's ADSR. Note may be silent, but as long as instrument is still on, the *hum will continue*. Can be stopped when you change instrument, `K`ill it or direct it to `A`20.
Hum will even apear if you pan left or right side, creating stereo hum.
`O` command hum will duck in the volume if wave width is set to 75%, therefore **works best with wave width 12.5%**
The `O` command may be used on **any** channel you like.
One of the ways to control the hum's volume is to move around the steps where the `O` is active and where it's not.
Another way to look at the hum effect, think that every O`LR` step represents square wave at it's top, and every O`--` is square at it's bottom.

## W command (pulse channels only)

`W` command generates hum **tied to** instrument's ADSR. If your note goes silent, the *hum will go silent too*.
Changing from thin to wide waveform will result in the loudest and grittest hum. Adjust the width to your liking. `W` command also will produce high overtones that sounds like clicking.


## E command (any channel)

`E` command generates hum **overwriting** instrument's ADSR. Hum will be louder as the distance between lowest and highest `E` command values rises. **Works best on the wave width 75%**

## Transpose

Using the transpose column in the table will split the instrument pitch into 3, creating FM kinda sound. 3, because you have *Transposed* part, *Untransposed* one AND *tempo dependant hum* inbetween.

## Multihum

Using combinations of W and O can yeld you multiple hums, but beware that this technique makes the tuning even more difficult, and is extra taxing on the CPU. Adding Transpose in the table adds ever more harmonics. When using both `W` and `O` commands, make sure the *active* O`LR` commands hit thinner waves if we want the hum to be quieter.


# Other Commands

## R command (any channel)

Use `R`00-0F in phrase to retrigger the long hum tables, giving you additional control over them without changing the table itself!
First F digits of `R` commands will play the table up to chosen digit of the command (i.e. R04 will play first 4 steps of the table and *hop* back to the beginning)

### Tempo Command `T`

LSDj allows the user to change the engine tempo on the fly using the `T` command.
This affects the entire sequencer, therefore affecting the overclock hum pitch.
The problem is that whole sequencer needs to be properly adjusted for this to work.
Though I haven't done it properly myself, I think that grooves will do the work correctly!
Because we are overclocking quite high,
I think we could accurately adjust groove to the song, or make it swing a bit but still fit the song.
I would recommend placing extra `G` commands before `T` in order to even out the tempo change,
(pre `T` groove with old and new groove timing for the smoothest effect - Placing new groove before/after tempo change can make song hiccup for a brief moment)
and put the new proper groove in all patterns when there's an empty space in the sequencer.


## CPU USAGE

Overclocking is very taxing on the Gameboy's CPU, and reaching the "TOO BUSY!" state is more than easy.
The faster the actual tempo, the faster the modulation, therefore CPU has to work harder to keep up.

`E` command next to `V`are most CPU taxing commands. O and W don't put as much pressure.
* The `V` command is much more resource intensive than having transpose done in the table, no matter how intense the modulation is.
* Longer tables are easier on the CPU.
* If you can, try to end tables with A20 instead of `H`opping over nothingness.
