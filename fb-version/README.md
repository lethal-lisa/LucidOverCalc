# LucidOverCalc - FreeBASIC Version

The FreeBASIC version of the AM frequency calculator is by far the most efficient of the ports so far.
It supports Linux, Windows, and DOS,
but should also work on anything that can run FreeBASIC 1.07.1.
So far it has been tested with:
* Manjaro Linux x86_64
* Windows 10 Home 64-bit
* MS-DOS 6.22

## Minimum Requirements

Part | Grade
---- | -----
CPU | Intel 386 (i386) compatible or higher.
FPU | 387 or SSE compatibles. SSE is not available on machines with processors that don't support the i686 (Intel Pentium III) instruction set.
RAM | 1MB (probably less, but usage depends on version and build).
Disk Space | About 100KB

## Build Requirements

* [FreeBASIC 1.07.1 or newer.](https://www.freebasic.net/)
* Intel 386 or higher CPU.
* (DOS Version Only) CWSDPMI.

### To Build:

Navigate to the FB version's source directory (`LucidOverCalc/fb-version`).
Make sure your path environment variable contains the path to the FreeBASIC compiler
(`fbc` on \*nix and `fbc.exe` on Windows/DOS),
and run the command `fbc lucidoc.bas` to build the executable.

#### Setting Build Options

These parameters control the default settings of the built executable.
The defaults are set in the file [exopts.bi](/fb-version/inc/exopts.bi),
but can be overridden with fbc's `-d` parameter at compile time.

Name | Effect | Values | Default
---- | ----- | ------ | -------
`STEP_SIZE` | Changes the amount used to iterate steps. | Any number between -1 and 1. | 0.5
`OFFTIME_MIN` | Sets the lowest amount of OFF time to calcualte for. | Any positive integer. | 1
`OFFTIME_MAX` | Sets the highest amount of OFF time to calculate for. | Any number greater than the value of `OFFTIME_MIN` | 8
`TABS_COUNT` | Changes the amount of whitespace characters placed between columns of the output. | Any integer >= 15 | 15
`NEGATIVE_OUTPUT` | Enables or disables the program from outputting negative frequencies. | 1=all, 2=hide (places an "N/A" in the frequency column), and 3=omit | 2
`ENABLE_COLOR` | Enables color output. | TRUE/FALSE | TRUE
`BARE_OUTPUT` | Enables or disables bare output mode. | TRUE/FALSE | FALSE

#### Selecting an Floating Point Unit

While by default, Lucid uses the traditional x87 FPU,
it can also make usage of SSE instructions on i686 or greater platforms.
In order to enable support for SSE, add the flag `-fpu sse` to your build command.
SSE does not work under DOS.
