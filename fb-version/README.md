# FreeBASIC Version Compilation Instructions

### You'll Need:

* [Newest version of the FreeBASIC compiler for your platform.](https://www.freebasic.net/)
* Some knowledge of how to use the command line for your platform.

### To Build:

Navigate to the FB version's source directory (`LucidOverCalc/fb-version`). Make sure your path environment variable contains the path to the FreeBASIC compiler (`fbc` on \*nix and `fbc.exe` on Windows/DOS), and run the command `fbc lucidoc.bas` to build the executable.

### Optional and Experimental Parameters:

Name | Effect | Values | Default
---- | ----- | ------ | -------
`STEP_SIZE` | Changes the amount used to iterate steps. | Any number between -1 and 1. | -0.5
`TABS_COUNT` | Changes the amount of whitespace characters placed between columns of the output. | Any integer > 9 | 10
`NEGATIVE_OUTPUT` | Enables or disables the program from outputting negative frequencies. | "all", "hide" (places an "N/A" in the frequency column), and "omit" | "none"
`ENABLE_COLOR` | Enables color output. | TRUE/FALSE | FALSE

In order to use these additional parameters add `-d <parameter name>=<value>` to your build command after `fbc` and before `lucidoc.bas`.
