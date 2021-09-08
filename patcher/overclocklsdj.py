#!/bin/python
import glob
for filename in glob.glob("*.gb"):
	data = open(filename, "rb").read()
	open(filename, "wb").write(data.replace(b"\x3E\x04\xE0\x07", b"\x3E\x07\xE0\x07", 1))
