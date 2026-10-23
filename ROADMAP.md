# Roadmap: minilogue xd controller

Controller and librarian for the Korg minilogue xd.

## Done
- [x] Plugin skeleton: parameter map from the manual, CC and NRPN send/receive, host automation, cat-ui look, CI on three systems
- [x] Release packaging: installers (Windows, macOS, Linux Flatpak extension), uninstallers and PDF manual built by the release workflow (test builds, not tested on real machines)

## Next
- [ ] Test every map entry on the real device and flip it to verified (`hw` column in map/params.csv)
- [ ] Test the VST3 in Bitwig and Studio One on Linux
- [ ] Two-CC controls: find out which CC is the coarse one on the device

- [ ] Playable joystick, toggle stems that follow the cap, step button lights that follow state (done in the mockup)
- [ ] LCD shows the parameter value and the waveform follows the patch
- [ ] Real MIDI I/O, program edit, sequencer and motion, librarian, microtuning

## Every cat plugin
- Draw through `catui::RenderGate` so meters and animations stop when the window is not in front (audio, automation and MIDI keep running)
- Settings page with MIDI filters on by default, selectable preset/backup folders, UI size reset to 100%
