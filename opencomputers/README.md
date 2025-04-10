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
   6. *Optional:* Add another `Adapter` with `Database Upgrade` for fancy icons
2. Be consistent with `/xu_tps` and `IgiXML`

### Installation

Paste with middle-click in OC terminal:

1. Download with `wget https://raw.githubusercontent.com/barsikus007/GTNH-tweaks/master/opencomputers/power.lua -f`
2. Launch with `power`
3. *Optional:* Add to autorun with `echo "power" >> .shrc`

### TODO

- Make icons dynamic
- Convert this script to InGameInfoLUA with LSC module

## [TPS](tps.lua)

### Abstract

Shows per-world tick-time on the screen

### Installation

Paste with middle-click in OC terminal:

1. Download with `wget https://raw.githubusercontent.com/barsikus007/GTNH-tweaks/master/opencomputers/tps.lua`
2. Launch with `tps`
3. *Optional:* Add to autorun with `echo "tps" >> .shrc`

### Credits

@_Pandoro

## [Printty](printty/printer.lua)

### Abstract

PNG splitter and printer (with line merging)

### Installation

```shell
wget https://raw.githubusercontent.com/barsikus007/GTNH-tweaks/master/opencomputers/hpm-patcher.lua && hpm-patcher
hpm install libpngimage

wget https://raw.githubusercontent.com/barsikus007/GTNH-tweaks/master/opencomputers/printty/printer.lua
# example image
wget https://raw.githubusercontent.com/barsikus007/GTNH-tweaks/master/opencomputers/printty/amogus64x.png

printer
```

## [YT Music to Tape](music/ytdl.lua)

### Abstract

Downloads music from YouTube and converts it to tape DFPWM format

### Installation

1. run server with `cd server/ && bun i && bun run build && bun start`
2. `wget https://raw.githubusercontent.com/barsikus007/GTNH-tweaks/master/opencomputers/music/ytdl.lua`
3. `ytdl dQw4w9WgXcQ`

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
