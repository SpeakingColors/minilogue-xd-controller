# Roadmap: minilogue xd controller

Controller and librarian for the Korg minilogue xd.

## Next
- [ ] Playable joystick, toggle stems that follow the cap, step button lights that follow state (done in the mockup)
- [ ] LCD shows the parameter value and the waveform follows the patch
- [ ] Real MIDI I/O, program edit, sequencer and motion, librarian, microtuning

## Every cat plugin
- Draw through `catui::RenderGate` so meters and animations stop when the window is not in front (audio, automation and MIDI keep running)
- Settings page with MIDI filters on by default, selectable preset/backup folders, UI size reset to 100%
