#!/bin/bash

est="`acpi | cut -f 5 -d ' ' | cut -d ':' -f 1,2`"
sta="`acpi | cut -f 3 -d ',' | sed 's/remaining/r/g' | sed 's/until charged/c/g' | cut -f 3 -d ' '`"

echo $est$sta
