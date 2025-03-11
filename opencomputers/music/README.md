# YT music player

## Launch converter server

```sh
cd server/ && bun i && bun run build && bun start
```

## [ffp.lua](ffp.lua)

This is POC of original [ffp.lua](https://github.com/OpenPrograms/Fingercomp-Programs/blob/master/ffp/ffp.lua) with multiple sound cards support

## TODO

- ffmpeg 64k vs 65365
  - freq vs bitrate
- playlist mode (id,id,id)
  - handle end of tape
