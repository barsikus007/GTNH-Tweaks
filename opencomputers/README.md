# barsikus007's OC scripts

## [Power Monitor (NIDAS Lite)](power.lua)

### Proposals

1. Be simple as f
   1. Place `Adapter` to LSC
   2. Place `Redstone I/O` to reactor
   3. Wear `AR Glasses`
   4. ???
   5. PROFIT!
2. Be consistent with `/xu_tps` and `IgiXML`

### Installation

Paste with middle-click in OC terminal:

1. `wget https://raw.githubusercontent.com/barsikus007/GTNH-tweaks/master/opencomputers/power.lua power.lua`
2. `power`

Monitors the power usage of the computer and displays it on the AR glasses

Also controls redstone output based on power usage. Base values are stop at 90% and start at 80%

### TODO

- `/xu_tps` like shadows
- Average EU/t mode

## [TPS](tps.lua)

Shows per-world tick-time on the screen

Credits: @_Pandoro

## Cheat Sheet

```sh
echo "" > main.lua && edit main.lua && main
```
