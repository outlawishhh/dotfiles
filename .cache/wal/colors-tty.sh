#!/bin/sh
[ "${TERM:-none}" = "linux" ] && \
    printf '%b' '\e]P0000000
                 \e]P16F6F6F
                 \e]P28F8F8F
                 \e]P3B0B0B0
                 \e]P4D0D0D0
                 \e]P5E8E8E8
                 \e]P6F3F3F3
                 \e]P7f4f4f4
                 \e]P8aaaaaa
                 \e]P96F6F6F
                 \e]PA8F8F8F
                 \e]PBB0B0B0
                 \e]PCD0D0D0
                 \e]PDE8E8E8
                 \e]PEF3F3F3
                 \e]PFf4f4f4
                 \ec'
