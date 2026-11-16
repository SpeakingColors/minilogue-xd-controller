# minilogue xd: MIDI implementation

Source: Korg "minilogue xd MIDI Implementation", Revision 1.01 (2020.2.10), text file from korg.com (Support, Downloads, minilogue xd, MIDI Implimentation). Sections: 1-1 transmitted channel messages, 2-1 recognized channel messages, NRPN table (*3). Everything here is from that document unless marked UNVERIFIED. Nothing is tested on hardware yet ("untested on hardware").

The earlier version of this file and of map/params.csv were built from the owner's manual chart only and had wrong numbers (Delay and Reverb on/off, Delay Depth, Reverb Time and Depth, a "Voice Mode Type" CC 52). These are corrected below.

## CC map (official: Implementation rev 1.01, section 1-1 / 2-1; untested on hardware)

Plain CCs carry 7 bits (0 to 127). The synth treats some as 10-bit values with the low 3 bits sent first on CC 63; sending only the 7-bit part is allowed.
Stepped controls are sent as a few set values (shown in the name). On receive the document says any value inside a band works (for example 0 to 42, 43 to 85, 86 to 127 for three-way switches).

| CC | Function |
|---|---|
| 5 | Portamento Time |
| 16 | Amp EG Attack |
| 17 | Amp EG Decay |
| 18 | Amp EG Sustain |
| 19 | Amp EG Release |
| 20 | EG Attack |
| 21 | EG Decay |
| 22 | EG Int |
| 23 | EG Target (0, 64, 127) |
| 24 | LFO Rate |
| 26 | LFO Int |
| 27 | Voice Mode Depth |
| 28 | Mod FX Time |
| 29 | Mod FX Depth |
| 33 | Multi Level |
| 34 | VCO1 Pitch |
| 35 | VCO2 Pitch |
| 36 | VCO1 Shape |
| 37 | VCO2 Shape |
| 39 | VCO1 Level |
| 40 | VCO2 Level |
| 41 | Cross Mod Depth |
| 43 | Cutoff |
| 44 | Resonance |
| 48 | VCO1 Octave (0, 42, 84, 127) |
| 49 | VCO2 Octave (0, 42, 84, 127) |
| 50 | VCO1 Wave (0, 64, 127) |
| 51 | VCO2 Wave (0, 64, 127) |
| 53 | Multi Type (0, 64, 127) |
| 54 | Multi Shape |
| 56 | LFO Target (0, 64, 127) |
| 57 | LFO Wave (0, 64, 127) |
| 58 | LFO Mode (0, 64, 127) |
| 64 | Hold (Damper) |
| 80 | Sync (0 or 127) |
| 81 | Ring (0 or 127) |
| 83 | Cutoff Keytrack (0, 64, 127) |
| 84 | Cutoff Drive (0, 64, 127) |
| 88 | Mod FX Type (0, 38, 64, 84, 127) |
| 89 | Delay Sub Type |
| 90 | Reverb Sub Type |
| 92 | Mod FX On/Off (0 or 127) |
| 93 | Delay On/Off (0 or 127) |
| 94 | Reverb On/Off (0 or 127) |
| 96 | Mod FX Sub Type |
| 103 | Multi Sub Type Select |
| 104 | Multi Shift Shape |
| 105 | Delay Time |
| 106 | Delay Depth |
| 107 | Delay Dry/Wet |
| 108 | Reverb Time |
| 109 | Reverb Depth |
| 110 | Reverb Dry/Wet |

Other CCs in the document, not in the plugin map (they pass through the plugin untouched): 0 / 32 Bank Select (LSB 0 to 4), 1 and 2 joystick, 59 Voice Mode Depth (no display), 63 low-bits value, 118 and 119 CV In (sent only, with Poly Chain Master), 120 All Sound Off, 122 Local Switch, 123 All Notes Off.

Document inconsistency: for SYNC and RING the sent values are 0 = off, 127 = on, but the receive notes (6-08, 6-09) list 0 to 63 as "ON". The plugin sends 0 or 127 as in the sent table. UNVERIFIED on hardware.

## NRPN (official: same document, NRPN table; untested on hardware)

The table prints the MSB column as "--". The plugin reads it as MSB 0. UNVERIFIED until captured on the device. Sent as CC 99 (MSB), CC 98 (LSB), CC 6 (data).

| LSB (hex) | Function | Range |
|---|---|---|
| 10 | Voice Mode Type (0 Arp Latch, 1 Arp, 2 Chord, 3 Unison, 4 Poly) | 0 to 4 |
| 11 | Multi Select Noise | 0 to 3 |
| 12 | Multi Select VPM | 0 to 15 |
| 13 | Multi Select User | 0 to 15 |
| 20 | Bend Range + | 0 to 12 |
| 21 | Bend Range - | 0 to 12 |
| 31 | Scale Key | 0 to 24 |
| 32 | Program Tuning | 0 to 100 |
| 34 | LFO Key Sync | 0 to 1 |
| 35 | LFO Voice Sync | 0 to 1 |
| 36 | LFO Target Osc | 0 to 3 |
| 38 | EG Velocity | 0 to 127 |
| 39 | Amp Velocity | 0 to 127 |
| 3A | Multi Octave | 0 to 3 |
| 3B | Multi Routing (0 Pre VCF, 1 Post VCF) | 0 to 1 |
| 3C | EG Legato | 0 to 1 |
| 3D | Portamento Mode (0 Auto, 1 On) | 0 to 1 |
| 3E | Portamento BPM Sync | 0 to 1 |
| 3F | Program Level | 0 to 120 |
| 50 | Program Transpose | 1 to 25 |

Defaults for Program Level (90 = 0 dB) and Program Transpose (13 = 0) are our reading of the printed ranges (0 to 120 = -18 to +6 dB; 1 to 25 = -12 to +12 notes).
Not in the plugin yet: program name (LSB 01 to 0C, ASCII), values that need more than 7 bits (Multi Shape and Shift Shape per type, 14, 15, 16, 17, 18, 19 hex, 0 to 1023), joystick and CV In assign or range, micro tuning (0 to 127, with values 112 to 123 for user scales), VPM and user params, Master Volume (7F hex, 14-bit). Reason: the 8-bit to 14-bit sending order (low part on CC 63 first) is not implemented and not tested.

## Program change and bank

Program Change 0 to 99, Bank Select MSB 0, LSB 0 to 4 (official, sections 1-1 / 2-1). Needs MIDI Tx/Rx Prog Chg On. The plugin does not send these yet.

## Other messages (official)

- Channel Pressure received. Pitch bend both ways. Clock, Start, Stop, Continue received when Clock is Auto (USB) or Auto (MIDI).
- Device Inquiry: reply carries Korg ID 42, family 51 01.
- SysEx function IDs (official, section 1-4 / 2-5): 40 current program dump, 4C program dump (1 prog), 51 global dump, 44 tuning scale dump, 45 tuning octave dump, 47 to 4A user API/module/slot, 60 and 61 Poly Chain note on/off, requests 10, 1C, 0E, 14, 15, 17 to 1B. Byte layouts of the program data are in the same document (section 3 onwards); the plugin does not use SysEx.

## Global MIDI settings (owner's manual)

CC receive needs Global "MIDI Rx CC" On, sending needs "MIDI Tx CC" On. Also: MIDI Route (USB+MIDI or USB), MIDI Ch 1 to 16, Clock Source, En Rx Transport, Rx/Tx Prog Chg, Rx/Tx Pitch Bend, Local SW.

## How the plugin uses this

- One MIDI channel (parameter "MIDI channel"). Incoming CC on other channels is ignored and passed through. CCs that are not in the map pass through unchanged.
- "Send all" sends every value including the defaults (mostly 0). Use it with care.
- Every row in map/params.csv has a source column. hw = 0 everywhere: nothing has been tested on a real minilogue xd.
