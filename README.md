This directory contains code for ECE 545 - Digital System Design with VHDL

I'm not sure why I decided to take a hardware design course as an elective without knowing any VHDL or Verilog... Wish me luck lol

# XTEA-Cipher
## Background
In cryptography, XTEA (eXtended TEA) is a block cipher designed to correct weaknesses in TEA.
Like TEA, XTEA is a 64-bit block Feistel cipher with a 128-bit key and a suggested 64 rounds. Several differences from TEA are apparent, including a somewhat more complex key-schedule and a rearrangement of the shifts, XORs, and additions.

## Objective
Mini-Project 01 covers:
- The production of a XTEA block cipher in RTL VHDL code
- The creation of a testbench that is able to verify the cipher via behavioral simulation
- The synthesis and implementation of the cipher
- Post-synthesis timing analysis to further verify the operation of the cipher

## Implementation Notes
- Compiled using VHDL 2008 syntax, due to depreciations
- DK_pkg may flag as circular logic upon first compile, dependencies/order seem to sort themselves out on future runs



