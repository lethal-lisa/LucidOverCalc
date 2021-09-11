#!/bin/bash

markdown GUIDE.md | cat header.html - footer.html > GUIDE.html
