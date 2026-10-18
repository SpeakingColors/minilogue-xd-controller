# minilogue xd: MIDI implementation

Source: Korg minilogue xd Owner's Manual (E 1) with its MIDI Implementation Chart, version 1.00, dated 2018-12-06 (Korg document, in our project files). Everything below is taken from that document. Nothing is inferred unless marked **(check)**.

## CC map

The chart lists CC numbers per function group, in the order printed. The pairing below follows that order. The chart does not print value ranges or switch value mappings for the CCs.

| Function | CC numbers (in printed order) |
|---|---|
| Bank Select (MSB, LSB) | 0, 32 |
| Portamento | 5 |
| Voice Mode Depth, Voice Mode Type | 27, 52 |
| VCO1 Wave, Octave, Pitch, Shape | 50, 48, 34, 36 |
| VCO2 Wave, Octave, Pitch, Shape | 51, 49, 35, 37 |
| Multi Type, Sub Type, Shape, Shift Shape | 53, 103, 54, 104 |
| Mixer VCO1, VCO2, Multi | 39, 40, 33 |
| Cutoff, Resonance | 43, 44 |
| Cutoff Drive, Keytrack | 84, 83 |
| Amp EG Attack, Decay, Sustain, Release | 16, 17, 18, 19 |
| EG Attack, Decay, EG Int, EG Target | 20, 21, 22, 23 |
| LFO Wave, Mode, Rate | 57, 58, 24 |
| LFO Int, Target | 26, 56 |
| Mod FX Type, Sub Type, Time, Depth | 88, 96, 28, 29 |
| Delay Type, Time, Depth, Dry/Wet | 89, 105, 112, 107 |
| Reverb Type, Time, Depth, Dry/Wet | 90, 114, 115, 110 |
| Sync, Ring, Cross Mod Depth | 80, 81, 41 |
| Mod FX On/Off, Delay On/Off, Reverb On/Off | 92, 94, 95 |
| Damper | 64 |
| All Sound Off, Reset All Controllers | 120, 121 |

Notes:
- Control changes need Global "MIDI Rx CC" On to be received and "MIDI Tx CC" On to be sent.
- Per the manual: CC#1 (mod wheel), CC#64 (damper) and CC#120 onward are not affected by the "MIDI Rx CC" setting.
- The chart footnotes say "prologue" in several places. That is a Korg template error; the chart is headed "Model: minilogue xd".

## Other messages (chart)

- Basic channel 1 to 16 (Global "MIDI Ch").
- Note number 0 to 127; note on velocity 1 to 127.
- Pitch bend: yes (Global "MIDI Rx/Tx Pitch Bend").
- Program change 0 to 99 (Global "MIDI Rx/Tx Prog Chg"). With Bank Select this reaches 500 programs; the bank value range is not in the chart **(check)**.
- System exclusive: yes. Korg exclusive messages plus MIDI Inquiry.
- Clock and transport: received only when Global "Clock Source" is Auto (MIDI) or Auto (USB); not when Internal. "En Rx Transport" controls start/stop/continue.
- Aftertouch: no.

## SysEx (from the manual)

- Program Dump: sends the current program over MIDI OUT and USB (PROGRAM EDIT, button 14).
- All Dump: programs, live set and global data. About 10 s over USB, about 30 s over MIDI DIN.
- User Scale and User Octave dumps (GLOBAL EDIT buttons 13 and 15). While a USER SCALE or USER OCTAVE page is shown, the unit receives SysEx microtuning messages and overwrites the scale being edited, whatever number the message carries.
- The byte layout of these messages is **not** in this document. It is in Korg's separate "minilogue xd MIDI Implementation" PDF. TODO: obtain it and add the program data format here.

## Global MIDI settings (GLOBAL EDIT)

| Page | Setting | Values |
|---|---|---|
| GLOBAL 4 | MIDI Route | USB+MIDI, USB |
| GLOBAL 4 | MIDI Ch | 1 to 16 |
| GLOBAL 4 | Clock Source | Auto (USB), Auto (MIDI), Internal |
| GLOBAL 4 | En Rx Transport | Off, On |
| GLOBAL 5 | MIDI Rx Prog Chg, Rx CC, Rx Pitch Bend | Off, On |
| GLOBAL 5 | MIDI Tx Prog Chg, Tx CC, Tx Pitch Bend | Off, On |
| GLOBAL 2 | Local SW | Off, On (set Off with a DAW echoing notes back) |
| GLOBAL 3 | Sync In/Out Unit | 16th Note, 8th Note |

Our plugin should read or warn about Route, Channel, Rx/Tx CC and Local SW, since they decide whether it can control the synth at all.

## Front panel parameter ranges (manual)

| Parameter | Range |
|---|---|
| Tempo | BPM 56.0 to 240.0 (knob); sequencer BPM 10.0 to 300.0 (SEQ EDIT) |
| Portamento | 0 to 127 |
| Voice Mode Depth | 0 to 1023 (POLY/DUO); Detune 0 to 50 cent (UNISON); chord type list; arp type list |
| VCO Pitch | -1200 to +1200 cent |
| VCO Shape, Cross Mod Depth, Mixer levels | 0 to 1023 |
| Cutoff, Resonance | 0 to 1023 |
| Drive, Keytrack | 0%, 50%, 100% (3-way switches) |
| Amp EG A/D/S/R, EG A/D | 0 to 1023 |
| EG Int | -100% to +100% |
| LFO Rate | 0 to 1023, or note values in BPM mode |
| LFO Int | 0 to 511 (0 to -511 with Shift) |
| Effects Depth | 0.0% to 100% |
| Program Level | -18.0 dB to +6.0 dB |
| Program Tuning | -50 to +50 cent |
| Swing | -75% to +75% |
| Step Length | 1 to 16 |

The panel uses 10-bit values; CCs carry 7 bits. Whether the synth scales CC values to the full range is not stated **(check on hardware)**.

## Open items

1. SysEx byte layout (Korg minilogue xd MIDI Implementation PDF).
2. CC value mapping for switch parameters (wave, octave, target, mode, effect types) and how Multi Type/Sub Type values map to engine and effect lists.
3. Bank value range for Bank Select.
4. Whether NRPN is used anywhere; the chart lists none.
