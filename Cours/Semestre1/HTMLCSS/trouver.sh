#!/bin/bash
grep -r $1 $2|cut -d : -f 1
exit 0
