#!/bin/bash

set -e

pscircle \
    --output-width=1920 \
    --output-height=1080 \
    --tree-font-size=12 \
    --toplists-font-size=12 \
    --tree-radius-increment=200 \
    --dot-radius=3 \
    --cpulist-center=200:0 \
    --memlist-center=600:0 \
    --tree-sector-angle=3.1415 \
    --tree-rotate=true \
    --tree-rotation-angle=1.5708 \
    --tree-center=-950:0 \
    --root-pid=0 \
    --max-children=50 \
