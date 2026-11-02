#!/bin/bash
killall x64 &> /dev/null; x64 +confirmonexit $(ls -1t *.prg | head -n1)
