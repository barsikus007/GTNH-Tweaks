# barsikus007's OC scripts

## [Power Monitor (NIDAS Lite)](power.lua)

### Abstract

Monitors the power usage of the computer and displays it on the AR glasses

Also controls redstone output based on power usage (base values are stop at 90% and start at 80%)

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

1. Download with `wget https://raw.githubusercontent.com/barsikus007/GTNH-tweaks/master/opencomputers/power.lua`
2. Launch with `power`
3. *Optional:* Add to autorun with `echo "power" >> .shrc`

### TODO

- Use decimal notation

## [TPS](tps.lua)

### Abstract

Shows per-world tick-time on the screen

### Credits

@_Pandoro

## Cheat Sheet

### Paste with middle-click and run

```sh
echo "" > main.lua && edit main.lua && main
```

### Host with python server, download and run

```sh
# server
python -m http.server 23456
# client
wget http://example.com:23456/test.lua -f && test
```
