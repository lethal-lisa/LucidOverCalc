# (ADVANCED) Soft-Overclocked LSDj Guide by Infu
[**Sound sample/set video here!**](https://youtu.be/HDLD6zdxt2E)<br>
<br>
![CursedBoy](https://user-images.githubusercontent.com/66220663/99196146-5cbc2d00-2782-11eb-9b35-2709d25b2b4c.png)


Chapters are ordered as it follows:

01. [History and the Benefits of Soft-Overclocking Nowadays](#1-history-and-the-benefits-of-soft-overclocking-nowadays)
02. [How to Overclock LSDj ROM](#2-how-to-overclock-lsdj-rom-up-to-91c)
03. [Amplitude Modulation Synthesis - Overclocking Hum](#3-amplitude-modulation-synthesis---overclocking-hum)
04. [Workflow changes (Groove/Tempo/BPM relation)](#4-workflow-changes)
05. [Controlling the Extra Hum](#5-controlling-the-extra-hum)
06. [Hum Pitch table](#6-hum-pitch-table)
07. [Commands generating Hum](#7-commands-generating-hum)
08. [MultiHum](#8-multihum)
09. [PITCH TICK mode](#9-pitch-tick-mode)
10. [CPU usage](#10-cpu-usage)
11. [**Quickstart** mini guide *(for impatient ones)*](#11-quickstart-mini-guide-for-impatient-ones)
12. [Actual Clockspeed Modifier](#12-actual-clockspeed-modifier)
13. [Expanded Noise Channel](#13-expanded-noise-channel)
14. [WAV channel](#14-wav-channel)
15. [Another look at the Tables - Summary](#15-another-look-at-the-tables---summary)
16. [Extra notes,Credits](#16-extra-notes)<br>

For some practical examples I provided the LSDj .sav file (version 8.9.3) *for study only*, included in the same folder next to the guide!

**=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-**
**=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-**

# IMPORTANT OVERCLOCKING NOTE! 

### VERSIONS 9.2.0 - 9.2.H BREAKS OVERCLOCK!

New timer-driven sample playback breaks the overclocking -
New samples sound fantastic but overclock is not compatible
I tried couple solutions, and none work as good, but I'm still investigating!

**Latest one you can overclock is 9.1.C**

Version 9.1.I HAS 2 HIGHER TEMPOS built-in! No hex editing needed!

**detailed follow-up is still being uploaded as you read this!**

**=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-**
**=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-**

<br>

-----------------
 > ===== Todo: ===== <br>
 > ----- OldOC vs built in (even compatibility of saves) ----- <br>
 > ----- Redo emulator recommendations ----- <br>
 > ----- Redo mentioned versions ----- <br>
 > ----- Add F kit command usage ----- <br>
 > ----- Mentioning Player and its performance ----- <br>
 > ----- Overclocked Emulator Mention ----- <br>
 > ----- Multiply groove with higher $x OCs ----- <br>
 > ----- M command mention ----- <br>
 > ----- Recategorise commands ----- <br>
 > ----- Redo screenshots ----- <br>
 > ----- Hex edit bash line(?) ----- <br>
 > ----- Do not discriminate DMG performance ----- <br>
 > ----- Spreadsheet Groove Calc ----- <br>
 > ----- Spreadsheet Tempo Table ----- <br>
-----------------

<br>

------------------------

## 1. History and the Benefits of Soft-Overclocking Nowadays

**History** of Software overclocking LSDj starts by Pain Perdu in 2017 using version 5.3.5.[(Archived link for the article here)](https://web.archive.org/web/20200601005830/https://chiptuneswin.com/blog/pauls-tech-talk-lsdj-5-3-5_4x-part-2-sandpaper-vs-eardrums/) 
Results were impressive, but due to heavier CPU usage while overclocked,
users would experience serious drawbacks,
making usage less than desirable and unstable.
*However*, version 8 improved dramatically in those terms,
and now, even in heavy modulation situations where previous versions would crash or stop,
Here there's no hint of any slow-down!
Consequently, overclocking LSDj from version 8 onwards should be more than pleasureable experience,
providing much greater headroom than previous versions!

**Benefits** of Software Overclocking LSDj are new wicked types of sound design,
enabling multitimbrality on each channel and amplitude modulation synthesis!
Overclocked LSDj will play any of your non-OC saves four times faster:
4x speed of LSDj engine means that every table modulation, synths, and whole sequencer will play four times faster.
Because of increased CPU usage here, it's recommended to use GameBoy Color or above,
Original gray brick may work to some extend, but it's easy to crash it.
NO hardware mods are required, you only need to edit the LSDj ROM file!
BGB, Sameboy and Gambatte as accurate emulators also provide fantastic experience!
The guide below will explain many tips and tricks regarding overclocking,
but it is designed for advanced LSDj users who are confident in normal LSDj operation and seek to get out more out of it.

**Update**: 20.04.2021 Johan Kotlinski, LSDj Developer, announced new sample playback routine improving the quality of samples - 
unfortunately this broke possibility to overclock the every LSDj version after 9.1.C.
I've been trying various codes provided by Johan,
I tried to hack the tempo table,
I tried tricks but nothing really worked - 
if something did, then in very hacky manner where rest of tempo values were broken or the results just unsatisfying.
I've been investigating also other issues regarding the newer LSDj versions,
only to discover that it actually has irregular ticks - 
Therefore throwing off the perfect ballance that was usually provided as default with overclockable LSDj versions. 
Keep in mind that problem I'm talking about is something a casual user would probably never notice, 
but that little discovery opened up the subject of overclocking LSDj!<br>
01.09.2021 new update comes out, version 9.2.I (ending with I, like Infu!), 
brings back insane tempos again, but this time as the native feature! 
This ultimately motivated me to update the guide once again, and include all the knowledge I gathered till now!


*Note note: all notes below were observed while using **BGB emulator** in **GBC mode** on Windows, and just recently Sameboy with it's broad selection of various models, and I'm in the middle of noting down the differences!

### 1b. Terminology used in the guide

-Each time I mention "Overclock" I talking about "software overclock" variant,<br>
not hardware one *unless stated so in the sentence*;

-Since Overclocking refers to modifying the clockspeed above supported values,<br>
this means that new high tempos aren't "overclocked" in theory.<br>
Now they are just normal "high-speed tempos".<br>
For the sake of consistency, also because behaviour is exactly the same,<br>
I still call them same way, differenciating only by versions!<br

-Naming of the tempo elements have been changed over time:<br>
9.1.C "75", "112", "224"; (since every value is x4)<br>
9.2.I "299", "448", "896"; (actual tempo representation)<br>
9.2.J "2X", "3X", "6X"; (to mark these are multiples of screen refresh rate)<br>

## 1c. Which LSDj version to choose?

**9.2.I** and newer (the new way) has extremely limited tempo options (and also limited overclocking capabilities) but doesn't involve hacking at all!

**9.1.C** (the old way) gives you full control of what LSDj soft-overclock has to offer, customisable up to your absolute preference!
This one requires little bit of effort to overclock it (well described step-by-step here!), and lacks fancy features new version offers.<br>

*(more on the differences in one of the last bonus chapters!)*

## 2. How to Overclock LSDj ROM (up to 9.1.C)

(Versions 9.2.I and above have higher tempos available **without** editing the ROM at all!)

-----------------
 > ===== Todo: ===== <br>
 > ----- present Game Genie code option for old OC ----- <br>
 > ----- find option to hack a rom on Android, and in browser ----- <br>
 > ----- Mention failed OC methods, for archiving purposes ----- <br>
-----------------


Modifying your ROM to be overclocked is actually fairly easy, possible to do on any platform that has Hex Editor.<br>
This will not affect any other data of LSDj: your kits, palettes, all are safe.<br>
Still, remember to backup your ROM before you modify your precious tracker!

===== **VERSIONS 9.2.0 to 9.2.G WILL FAIL!** =====

![HxD_2Searching2](https://user-images.githubusercontent.com/66220663/99194099-583d4780-2775-11eb-8362-c82aea4adeed.png)<br>
*(picture showcasing step 2)*


===== **Step by step instructions:** =====

1. Open up your LSDj ROM (preferably 9.1.C) in the hex editor of your choice (I used HxD on Windows);
2. Search first *hex-value* string **`3E04E007`**;
3. Replace it with **`3E07E007`**; (Notice: We are changing esensially only second value `04` to `07`)
4. Save;

Your LSDj's tempo should be *multiplied* by **four** now!

## 3. Amplitude Modulation Synthesis - Overclocking Hum

The magic of soft-overclocking is largely dependant on LSDj's **`TEMPO`** parameter.
It's responsible for LSDj's engine speed, therefore increasing it will speed up all modulation happening,
and slowing it down will make your tables much slower.<br>
When performing extremely rapid modulation (high tempo) of particular commands/effects
(for example: a table with **"O`--`"**, **"O`LR`"** and **"H`00`"**)
**a hum of a specific pitch will be produced**!<br>
It happens because of Gameboy's natural behavior:<br>
while switching between **"`E`"**, **"`O`"** or **"`W`"** command, a click happens
which when done in rapid succession generates the hum you can hear.
This hum is generated with *Amplitude Modulation* synthesis, (or simply, AM synthesis)
which can be thought of as an extra oscillator in the channel.

*Said Hum is actually a Square Wave but for the purpose of this guide I don't call it "square wave" to prevent confusion with Pulse channels*

AM synthesis, in the context of LSDj, works by rapidly changing volume, note or pulse width at a certain frequency.
This frequency is generated by  placing mentioned above commands in the Table.
The **Table speed** is dependent on the **`TEMPO`** parameter,
but the actual produced **Hum frequency** is dependent on how long the modulation is.
The higher the tempo, the faster the table will be cycled through,
thus the higher the initial pitch.
*Initial*, because you can achieve even more by manipulating the table by increasing/decreasing the **"OFF/O`--`"** time.

Said hum does not come out of nowhere, but shares the channel together with other sounds happening there,
each one "fighting each other, and one may strip other from some frequencies to fit in, which is absolutely normal behaviour,
and you can design your sounds around that, giving one or the other more priority.

# 4. Workflow changes 

There's multiple differences between normal stock LSDj and overclocked one that you'll need to get used to,
especially when transferring your previous songs and using them there.
Major change in OC version is that whole LSDJ **`TEMPO`** is multiplied by 4.
That means that your standard 6tick-Groove song tempo 150 will play like it was 600!<br>
Because tempo is tied to many parameters, you need to adjust your:

![bgb_Uf0q7VEqT3](https://user-images.githubusercontent.com/66220663/99181572-27362600-2727-11eb-8884-2d84d3aff9fe.png)

- Grooves;
- Tables (Placing appropiate **"`G`"** command somewhere inside them so your modulation plays correctly);
- Commands like D,K,R,W;
- Instrument Command rate;
- Wave instrument speeds;
- Speech words;

Because the tempo dictates the actual pitch of the hum,
you will find yourself adjusting **`TEMPO`** to achieve desired pitch,
so you need to separate the **`TEMPO = BPM`** workflow - Tempo is your instrument now!
Instead, to actually achieve BPM you want (or precisely tell which one you're using) use following formula:

### **`BPM = (Tempo x 96)/[4 rows of your groove setting]`**<br>

*[Note: 96 comes from having default 6 ticks per step groove, times 4 to achieve `ticks per beat`(24),
then times 4 to reach actual value that OverClocked LSDj is using (96)]*<br>
Using the formula above you should calculate that picture above runs actually 138 BPM!<br>
*A good practice* is to make sure your grooves are divisible by two in order to achieve 2x tempo if desired - Even better if main groove if divisible by 4!


For **9.2.I users** the formula is much more simplified here, here's 896 variant:<br>

===== **`BPM = 21504 / [4 rows of your groove setting]`** =====<br>

For 448 variant, simply divide by 2 = 10752

It is highly recommended to use GBC and above for optimal performance,
(or make sure your emulator is running in GBC mode) as DMG
cannot handle intense modulation well in high speed on more than 1 channel.
It is possible to make OC song using DMG, thought lower speeds are recommended!

If you thought about using **2xOC-LSDj** synced together, don't expect a lot of stability -
Each Intense moment in your song will slightly desync them little by little, so very high **`TEMPO`** should be avoided to prevent that, and keep them somewhat stable.
Having synced LSDjs on high tempo and fully equipped 4 channel songs will simply fail, or make the other instance play back the absolute end of the song mode. Best to introduce channels as they happen, rather than starting it all at once. (empty /non busy chains should be fine)

If you weren't naming instruments before, there's never been better time for it!<br>
Organisation here matters, and least you can do is put the hum note in the instrument name, that will help you reduce duplicate instruments, but also may save duplicated tables in a silly way!

*Also small note*, as for now, using official LSDj patcher and upgrading ROM will overwrite the overclock,
making you redo the process in hex editor, but that's not big issue!


## 5. Controlling the Extra Hum

Commands below enable you to create extra hum sharing the channel you're using it on.<br>
The length of the modulation will decide the pitch of the hum.
Minimal usable modulation is 2 step one, using **`O`** command *as an example*:<br>
0 `00`  `00` **O**`LR`<br>
1 `00`  `00` **O**`--`<br>
2 `00`  `00` **H**`00`<br>
where modulation takes 2 steps, and on 3rd one we **`H`**-op to the beginning of our table.<br>
it should look like on picture:<br>
![2stepH0](https://user-images.githubusercontent.com/66220663/99184993-dd593a00-273e-11eb-9f58-609a79d87e71.png)<br>
2 step modulation will decide the highest Hum pitch you can achieve using this tempo,
any longer modulation will decrease pitch by certain amount of semitones.<br>
Now tune your **"TEMPO"** value for highest Hum pitch you want available,
and reach the other lower Hum notes using more steps in modulation, or by H1 command explained below.

### H10 - hop between steps

Use loops like **"H`10`"** and **"H`00`"** right below to achieve modulation in between rows, by rapidly switching between two steps. Another way to call it is half step (e.g. 2,5step)
It works best between first couple steps very well, but longer 6+ step modulations can sound like an arp instead of stable tone, especially on lower TEMPOs<br>
![3stepH1](https://user-images.githubusercontent.com/66220663/99185036-0ed20580-273f-11eb-8f57-2b729d880c0e.png)<br>
*(picture showing **3 step H1** modulation)*<br>
(side note: loop demonstrated above is slightly CPU intensive than it's **3 step H0** variant)

## 6. Hum Pitch table

Regardless of the tempo, relation between Hum notes stay same!<br>
Table below represents part of usable Hum frequencies combinations you can use in table,<br>
where *step 0* is **O**`LR`, *all next steps* are **O**`--`<br>
*finishing* whole steps with **"H"** **0**0;<br>
and half steps with H **1**0 command followed by **"H"** **0**0.<br>

| up to 9.1.C |  | Tempo 295 | v9.2.I and above | Tempo 896 |
|:---:|:---:|:---:|:---:|:---:|
| Soft-OC (4x)<br>Modulation step | Semitones<br>down | Note +<br>Finetune Up | Predefined TEMPO<br>Modulation step | Note +<br>Finetune Up |
| *2  step H00* | *0*  | *A#4+40* | *2  step H00* | *F_4+70* |
| 2  step H**1**0 | 4  | F#4+30 | 2  step H**1**0 | C#4+90 |
| 3  step H00 | 7  | D#4+40 | 3  step H00 | A#3+70 |
| 3  step H**1**0 | 10 | C_4+50 | 3  step H**1**0 | G_3+C0 |
| *4  step H00* | *12* | *A#3+40* | *4  step H00* | *F_3+70* |
| 4  step H**1**0 | 14 | G_3+F0 | 4  step H**1**0 | D#3+70 |
| 5  step H00 | 16 | F#3+40 | 5  step H00 | C#3+A0 |
| 5  step H**1**0 | 18 | E_3+50 | 5  step H**1**0 | B_2+F0 |
| 6  step H00 | 19 | D#3+40 | 6  step H00 | A#2+70 |
| 6  step H**1**0 | 21 | C#3+D0 | 6  step H**1**0 | A_2+10 |
| 7  step H00 | 22 | C_3+90 | 7  step H00 | G_2+C0 |
| *8  step H00* | *24* | *A#2+40* | *8  step H00* | *F_2+70* |
| 9  step H00 | 26 | G#2+30 | 9  step H00 | D#2+70 |
| 10 step H00 | 28 | F#2+60 | 10 step H00 | C#2+90 |
| 11 step H00 | 30 | E_2+B0 | 11 step H00 | C_2+10 |

*Error margin 7%/$10 note off*

(Pitch for TEMPO 448 is same as 896 one but octave lower) 

Notice how 2,4,8step H0 share same note, but are lowered by an octave, as modulation is exactly /2 each time!<br>
Some steps will sound more detuned than others, so make sure to tune your tempo accordingly<br>
Note :*Modulations including half steps may sound particulary distorted and off tune*

For precise frequency of every step check out AM calculators available in this repository
made by Lisa and Pator, props for their hard work!


# 7. Commands generating Hum

## **"`O`"** command (any channel)

**"`O`"** command generates hum **idependently** from the instrument's ADSR.<br>
Note may be silent, but as long as instrument is still on, the *hum will continue*.<br>
**``To enable``**, place **"O`LR`"** and **"O`--`"** commands in the table and loop them,<br>
Can be stopped when you change instrument, **"`K`"** ill it or direct it to **"A`20`"**.<br>
Hum will even appear if you pan left or right side, creating stereo hum.<br>
**"`O`"** command hum will duck in the volume if wave width is set to 75%, therefore **works best with wave width 12.5%**<br>
The **"`O`"** command may be used on **any** channel you like.<br>
One of the ways to control the hum's volume is to move around the steps where the **"`O`"** is active and where it's not.<br>
Another way to look at the hum effect, think that every **"O`LR`"** step represents square wave at it's top,
and every **"O`--`"** is square at it's bottom.<br>
Try mixing in active and panned notes in between to shape the Hum's pitch and timbre!<br>

## **"`W`"** command (pulse channels only)

![4stepWave](https://user-images.githubusercontent.com/66220663/99185631-0aa7e700-2743-11eb-8291-837d70a2f084.png)<br>
*(Picture showing 4step H0 **"W"** table)*<br>
**"`W`"** command generates hum **tied to** instrument's ADSR.<br>
If your note goes silent, the *hum will go silent too*.<br>
**``To enable``**, place minimum 2 W commands of different width in the table and loop them,<br>
Changing from thin to wide waveform will result in the loudest and grittiest hum.<br>
Place more in between in various setups to alter the timbre and adjust the width to your liking.<br>
**"`W`"** command also will produce high overtones that sounds like clicking!

## **"`E`"** command / VOL column (any channel)

![gaemboi_cWyW6aPk5Z](https://user-images.githubusercontent.com/66220663/100933220-ee4acf00-34e4-11eb-9f8d-fa65cf160640.png)<br>
**"`E`"** command or VOL column generates hum **overwriting** instrument's ADSR.<br>
**``To enable``**, there are 2 ways you can take:
  1) place minimum 2 **"E"** commands of different volume in the table and loop them, *(CPU intense)*<br>
  2) place 2 different volume levels in VOL column and loop them. *(unable to perform H10 halfsteps this way)*<br>
Hum will be louder as the distance between lowest and highest volume values rises.<br>
**Works best on the wave width 75%**<br>
Performing this in WAV channel with only use it's own 4 steps only <br>
Different volumes will be affecting the timbre of the channel in different way!<br>

## **Transpose** (any channel) (this one actually does FM wait gotta fix it)

Using the transpose column in the table with minimum 2 step modulation (just H itself) will split the instrument pitch into 3,
creating FM-like metallic sound.<br>
3, because you have *Transposed* step next to another one (can be transposed or not) AND *tempo dependant hum* inbetween!<br>
Using this on **Noise** channel can yeld new metalic pitch values this way!<br>
Using different step modulation and different transpose values will affect in even differently on channel of your choice!

IF POSSIBLE consider using it without a table, just using a **`C`** command in the phrase:<br>
It simulates 3 step modulation from the table, and it's much less CPU intense!

## **"`R`"** command (any channel)

Use **"R`00-0F`"** in phrase to retrigger the long hum tables,
giving you additional way to loop them without changing the table itself!<br>
(Be careful, because it's more resource intensive to loop tables this way!)<br>
First F digits of **"`R`"** commands will play the table up to chosen digit of the command<br>
(i.e. **"R`04`"** will play first 4 steps of the table and *hop* back to the beginning)<br>
Adjusting CMD rate of the instrument will make it work twice slower per value<br>
(i.e using **`CMD 1`**, command **"R`04`"** will behave like **"R`08`"**)<br>

## **"`T`"** command

LSDj allows the user to change the engine tempo on the fly using the **"`T`"** command.
This affects the entire sequencer, therefore affecting the overclock hum pitch.
The problem is that whole sequencer needs to be properly adjusted for this to work.
Though I haven't done it properly myself, I think that grooves will do the work correctly!
Because we are overclocking quite high,
I think we could accurately adjust groove to the song, or make it swing a bit but still fit the song.
I would recommend placing extra **"`G`"** commands before **"`T`"** in order to even out the tempo change,
(pre **"`T`"** groove with old and new groove timing for the smoothest effect -
placing new groove before/after tempo change can make song hiccup for a brief moment)
and put the new proper groove in all patterns when there's an empty space in the sequencer.

# 8. Multihum

[Twitter video of 3 tones singing from one Pulse channel](https://twitter.com/Infu_av/status/1301578269435801602?s=20)<br>

![Multihum](https://user-images.githubusercontent.com/66220663/99185266-910ef980-2740-11eb-9bf0-aaaffd46d15d.png)<br>
*(picture above showing table used for first 4 notes in the Twitter video above)*<br>
Using combinations of **"`W`"** and **"`O`"** can yeld you multiple hums (O and E/VOL overlap each other in functionality),
*but beware* that this technique makes the tuning even more difficult, and is extra taxing on the CPU. (refer to [CPU usage](#10-cpu-usage) section for best tips how to manage CPU usage better!)
Adding Transpose in the table adds ever more harmonics.
When using both **"`W`"** and **"`O`"** commands, try moving around commands so *active* **"O`LR`"** commands hit thinner waves if we want the hum to be quieter, or experiment with their placement for differences in timbre.

## 9. PITCH TICK mode

![Thetick](https://user-images.githubusercontent.com/66220663/100926126-d3735d00-34da-11eb-9d8f-b9b95f48620f.jpg)<br>
*(Picture showcasing example settings for `P` effect, set groove to around 28 for optimal listening)*<br>

Setting `PITCH` mode of your instrument to **TICK** will greatly affect command **`P`** and **`V`**, making **`P`** command scroll so fast and so greatly that it'll have smooth spring'ish / squelch'ish 303 / Acid-like sound at particular intensity:
Wave width/duty will affect the sound timbre and volume, and you can affect the "phase" where the springy sounds starts with note at low, or high octave!<br>
You control the squelch sound you make using different value of `P` command
V command benefits from increasing the speed, but intensity stays the same.<br>
Try affecting the vibrato wave in the PITCH mode, each value might influence sound in different way!<br>
**`L`** command doesn't present any changes.<br>

## 10. CPU USAGE

-----------------
 > ===== Todo: ===== <br>
 > ----- Sort the commands from most resource hungry to not ----- <br>
 > ----- Check if something changed for latest version ----- <br>
-----------------



Overclocking can be very taxing on the Gameboy's CPU, and reaching the "TOO BUSY!" state is more than easy.
The faster the **"`TEMPO`"**, the faster the modulation, therefore CPU has to work harder to keep up.
If you're maintaining high **"`TEMPO`"** and using multiple effects/techniques playing at once
this can lead to sequencer desync/slowdown, or crash Gameboy/LSDj! Here's couple factors I noticed:
* **Stacking exactly same Command/Value in tables puts extra pressure**
(i.e. Having multiple **"O`LR`"** in a row does no good and only the 1st one is needed);
* Even empty table adds pressure, especially when `H`opped tighter;
* Table is the lightest in STEP mode;
* Transposing does nothing to CPU;
* If possible, use commands in Phrase instead of using a table 
* lIVE MODE is more taxing than simple SONG mode;
* Holding B button when sequence is playing puts pressure on CPU, because LSDj gets ready to mute/solo channels;
* **"`E`"** command next to **"`V`"** and **"`R`"** are most CPU taxing commands;
* **"`O`"** and **"`W`"** don't put as much pressure;
* **`V`** there's almost no difference between x1-xF, left side does little impact on CPU each value;
* Slower songs are also easier for CPU;
* If you can, try to end tables with **"A`20`"** or `K`ill instead of **"`H`"**-opping over nothingness;<br>
**WAVE CHANNEL CPU USAGE:**
* MANUAL wave instrument almost do no impact;
* ONCE/LOOP/PINGPONG do visibly more;
* KITS are heavy as long as they are playing;
* moving MODEs tax CPU more the lower SPEED parameter is;
* Interesting enough, high notes affect the CPU more than lower ones!

Most of the notes were taken during *max tempo intense multi channel* modulations,
leavning very little headroom before reaching "TOO BUSY!" state.<br>
Once again, it's highly recommended to use GBC and GBA if available,
DMG brick cannot endure even half of what GBC can take.

#### Easier on CPU modulations

As said above, tightly looped Tables tax CPU more than those with `H` command placed much lower.
There is a way to create same few-step modulation easier for CPU:<br>
![2 same modulations](https://user-images.githubusercontent.com/66220663/100679058-91290f00-3366-11eb-8e89-94ce4d7ce917.jpg)<br>
*(Each table is presenting 2 variations of SAME EXACT SOUNDING modulation. It's because the distance betweeen ON and OFF is exactly the same!)*<br>
Maint point is that the *longer variation* is actually easier on CPU!<br>
If you're struggling with CPU then think about extending your modulaitons if possible!

* * * * * * * * 


# 11. Quickstart mini guide (for impatient ones)

-----------------
 > ===== Todo: ===== <br>
 > ----- Redo the quickstart to consider newest version ----- <br>
-----------------


1. Replace LSDj's value **`3E04E007`** with **`3E07E007`** using hex editor, save
2. Turn on LSDj, put down one note in Pulse channel, press play
3. Apply table to this instrument, place commands one under another **"O`LR`"**, **"O`--`"**, **"H`00`"**<br>
(just like **"[Controlling the Extra Hum](#5-controlling-the-extra-hum)"** chapter picture)<br>
4. Manipulate the tempo, and later the note itself, matching it to the hum (notice how they are separate sound sources, how they can phase); 
5. In instrument table move **"H`00`"** one row lower (notice sound getting lower);
6. Replace those 2 **"O"** commands with **"W"**, make them 2 different width;
7. Again, play with the tempo, note and **"H"** placement in the table
8. Adjust main groove to slow down sequence, place more notes,
9. Copy the instrument and table, make second table have **"H`00`"** placed in different spot,
10. Play those 2 instruments in 1 phrase (notice the hum changes when instruments/tables switch)

**Check the [table of Content on the top of the page](#advanced-soft-overclocked-lsdj-guide-by-infu) and redirect yourself to chapter that interests you,
or would answer questions you have regarding Overclocked LSDj!**

For some practical examples I provided the LSDj .sav file (version 8.9.3) *for study only*, included in the same folder next to the guide!

* * * * * * * * 

-----------------
 > ===== Todo: ===== <br>
 > ----- list speed modifier chapter  ----- <br>
 > ----- place hum table below hum commands? ----- <br>
 > ----- mention more benefits from changing emulation speed ----- <br>
-----------------

## 12. Actual Clockspeed Modifier

or "Emulation Speed modifier", *or "hey mom look, I put software overclocked LSDj on hardware underclocked console!"*


![BGBspeed](https://user-images.githubusercontent.com/66220663/132315591-d1449b1b-a5c0-4d91-8b58-8894ce86a7b5.png)
<br>*(BGB's own emulation speed modifier)*

Since the newest version takes approach of being fixed speed rather than customisable one, I thought about way to enable more power to the musician.
BGB has option to slow down or speed up entire console, together with tempo and pitch of every note - if your emulator has slow down option you're probably able to set it to whatever speed you want!

**Pitch wise** you choose emulation speed based on the 2step modulation, or whatever step you're looking for.<br>
regardless of emulation speed you choose, it should still follow the hum table above!<br>

Tempo wise it may vary per emulator:<br>

-BGB uses Gameboy's original refresh rate 59.73fps as default (0) though I recommend keeping it 60fps clean calculation & post processing reasons, tempo formula looks like this:<br>
(new fps / 60) * LSDj actual tempo = Your new tempo!<br>
*Values below 60 will slow down the emulation, and above 60 will speed it up!*


-for emulators using "1.00x" multiplier for emulation speed, it's even easier:<br>
(Emulation speed multiplier) x LSDj actual tempo = Your new tempo!<br>
*Values below 1x will slow down the emulation, and above 1x will speed it up!*


# 13. Expanded Noise Channel

Gameboy metalic version of the noise provides little under 60 useful notes, about 4 per octave.<br>
**Overclocking changes that!**, and depending on tempo we can get tons of notes in between!

![ExtendedNoise](https://user-images.githubusercontent.com/66220663/133930810-502a1d42-f5c7-4456-a371-a4e559553e6a.gif)

On the gif above you can see normally available noise notes on the left,<br>
on the right we got expanded, proper full octave while on tempo 896!<br>

We are using **C**hord commands to rapidly play 2 noise notes, allowing us to carefully tune additional noise notes in between, in FM style!

Results are heavily dependant on the tempo we are on, and each note will be reacting differently to each chord command!<br>
Red flashing boxes show the distance between each noise note occuring naturally - keep it in mind! - Each note will react differently to C31 (chord/arp command):<br>

| Note<br>used | C cmd | 3 | semi<br>tones | 1 | semi<br>tones |
|---|---|---|---|---|---|
| C 3 | root/0 | G#3 | +7 | D#3 | +2 |
| F 3 | root/0 | D 4 | +9 | G#3 | +3 |

Because of those irregular distance between notes, each note might require to be tuned up accordingly!

You probably noticed the F3 being redone as D3 with arp on it - Noise notes tend to be off tune and I found personally this one being tuned more accurate.<br>


| Step | Effect | Notes and observations |
|---|---|---|
| 0 | --- |  |
| 1 | C01 | Here's more/less how Chord commands |
| 2 | C10 | progress one after another, |
| 3 | C11 | While on Tempo 896, using **C 3**! |
| 4 | C02 | You will notice how changing **C 3** to other notes |
| 5 | C12 | can affect the intensity/pitch of the chord used |
| 6 | C03 | in some particular rows! |
| 7 | C22 |  |
| 8 | C13 | Some combinations will make the noise note |
| 9 | C04 | phase slowly with itself in FM like way! |
| A | C30 | Best to be heard using: |
| B | C32 | **C 3** with chord 30,14/33 |
| C | C14 | **D 3** with chord 25/34 |
| D | C33 | **F 3** with chord 10,32/14 |
| E | C25 | **G#3** with chord 11,33 |
| F | C34 | (slash indicating almost same sound) |



# 14. WAV Channel

![gaemboi_p3XF18LkmA](https://user-images.githubusercontent.com/66220663/99191684-1b1d8900-2766-11eb-85d2-c060c3f96977.png)<br>

Original guide from Pain Perdu only briefly described the WAV channel possibilities,
and in the beginning I was sceptical to even put much modulation there
because WAV channel is already powerful on its own, but here is something I discovered:
You can create "Distortion effect" on your kick with **"O"** Hum modulation,
(to preserve the "kick" part place think about placing the OC modulation lower in the Table,
i.e. make it 4 steps lower and loop it with H04)
while and on synths can help create acidy melody,
or just serving as another layer for your bass, choice is yours!
**"O"** plays with it's full loud potential when instrument finished playing in "ONCE" mode 
(Newest LSDj turns off WAV channel once intrument finished playing, enabling Hum to continue on its own)
OR while SYNTH is playing make it louder when you turn WAV's volume down (like in pic above).
When Hum plays over your waveforms, it's gonna be the loudest where
distance between middle and top/bottom of the waveform is the greatest.<br>
The smaller the waveform, the quieter the Hum.<br>
All various ways to make sound in WAV channel tax the CPU differently,
I noted down what I have noticed in [CPU usage](#10-cpu-usage)!

Thanks to the Overclock WAV instrument gets 4 additional faster SPEED values,
worth keeping in mind while designing our SYNTHs!<br>
In original Pain Perdu's guide, the "Phase Bass" was first suggested SYNTH for the user,
all you need to do is to change Instrument mode to anything else than MANUAL,
and in the SYNTH menu set PHASE end (right side) to 1E,
then play around with it, experiment with expanded SPEED range!

-----------------
 > ===== Todo: ===== <br>
 > ----- Redo the WAV channel a bit  ----- <br>
 > ----- Test Recync ----- <br>
 > ----- Add entire Noise channel section ----- <br>
-----------------


# 15. Another look at the tables - Summary

Looking at it the other way, 1 row of the Table in stock LSDj is split into 4 in Overclocked version!
Any modulation squished into those will let you achieve interesting results.
At extremely high tempos its even more, so any commands you put there and loop it tightly with **"H"** commands
will create an interesting result usually unique for Overclocked LSDj only!

This guide does not represent every single possibility, but tries to make known ways clear
while engaging the exploration of sound design and pushing the limits!

------------------------



# 16. Extra notes

## Other Overclock Multipliers

![rsz_index](https://user-images.githubusercontent.com/66220663/99615327-22b58a00-2a13-11eb-90b9-ff45cbbb5fb9.png)<br>
*(picture showing from left to right Stock LSDj, 4x, 8x, 16x playing sequence all in the same way)*

As you already know, to achieve 4x overclock you need to find first string of hex values **`3E04E007`**, 
then change second value value `04` to `07`. What if we tried other values?<br>
Using `06` multiplies tempo by 8, and `05` by 16! This greatly expands the pitch range of possible hums,
but unfortunately the 8x version cannot reach even half of LSDj available tempo with 2step `O`Hum
before reaching "TOO BUSY" state, and that's while using just 1 channel!
16x overclock version performs the poorest even on the lowest tempo, increased grooves, 2step 'O'Hum crashes Gameboy!

-----------------
 > ===== Todo: ===== <br>
 > ----- Pitch table for speeds there? at least 8x ----- <br>
 > ----- Fix the groove calculation ----- <br>
-----------------



Though in theory they have greater potential than 4x overclock, their stability is almost nonexistant in current state.

## LSDj Version Overclock differences:

-----------------
 > ===== Todo: ===== <br>
 > ----- Sort versions there, mention this part in previous section ----- <br>
 > ----- advantages or disadvantages of each ----- <br>
-----------------


Guide was written while using LSDj 8.9.6 which may differ from future versions in some way,
so I recommend to take a look at the changelog to see if there hasnt been any major changes!

9.1.C is the **last** overclockable version, and overclocking anything beyond it (9.2.0 and later ones) will fail!

Software Overclock technique works with all LSDj versions from 2.6.0 (included)

Earliest overclockable LSDj version that actually benefits from LSDj optimisations is... TO BE RESEARCHED!

Software Overclock technique works with all LSDj versions from 2.6.0 (included)
That said, this guide is written based on
optimisations found in v8 and above allowing for comfortable and stable use - 
This means that any version below v8 won't perform well.

### 8.7.7
(This is version where I started using OC project!)
Most noticeable difference is that WAV doesn't turn off compared to newer versions - 
which means no hum after instrument mode "ONCE" finishes playing.

##### Pre-8.8.0 - ADSR Tempo Related Drift

While using version 8.7.7 I noticed that the ADSR envelope tends to not be consistent -
while it was sounding mostly correctly, on some chains like hihats or short pulse instruments placed one by one in a row,
Lenght of each ADSR instrument "drifts" in relation to the engine's tempo.

```
To reproduce on LSDj (8.7.7):

- In Noise Channel create phrase with 16 steps of FD hihats
- Make ADSR for that instrument 61/00/--
- Set tempo to 195

The user might hear the ADSR getting slightly shorter or longer in a regular, LFO-like manner.
```

This behaviour is more noticeable when using the overclocked version.
This effect is mostly undesired and somewhat uncontrollable unless
the user tunes the `TEMPO` *and* starts the song at a very specific moment (Though extremely not recommended)<br>
Version 8.8.0 and onwards keeps the envelopes very stable, and it's drift is not an issue anymore

Use version 8.8.7 if you wish to retain the old ADSR system, that is compatible with plenty of emulators and all Gameboy consoles.

### Feature wishlist (outdated)

1. Asymmetric tables (to reuse OC Tables in other instruments);
2. Even higher tempo limit (for higher pitch range of Hum);
3. Separate engine speed from tempo, or per table;
4. CPU usage indicator;
5. Alternative way to obtain Hum, in maybe more precise ways;
6. Integrate Overclocking feature into patcher, prevent patcher from changing the OC value (or ask to replace);

# Credits

**ABOC** and **Chiptune Cafe** for being best Chiptune communities I know, motivated and supported me to finish this guide;<br>
**Pain Perdu** for writing the initial Overclocking Guide for LSD;j<br>
**Aquellex** and **DBOYD** for direct help with the project early on;<br>
**Lisa** and **Pator** for coding their Overclocked Hum Pitch Finder programs and motivating me to finish this guide;<br>
multiple lovely and helpful peeps over **GBdev** Discord server
