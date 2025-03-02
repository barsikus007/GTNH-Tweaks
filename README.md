# GTNH Tweaks

(target 2.7.3)

My GTNH setup and shitcoded python patcher for configs

## JVMArgs

Check <https://github.com/brucethemoose/Minecraft-Performance-Flags-Benchmarks>

### RAM

```bash
-Xms8G -Xmx8G
```

### Network

Add this to fix `Timed out` (need to set this both on client and server)

```bash
-Dfml.readTimeout=180
```

### Old args for JVM8

Set max threads to your CPU count

<https://discord.com/channels/181078474394566657/234936569360809996/537728390363348992>

```bash
-XX:+UseConcMarkSweepGC -XX:+DisableExplicitGC -XX:MaxGCPauseMillis=80 -XX:+UseStringDeduplication -XX:+UseCompressedOops -XX:+UseCodeCacheFlushing -XX:ParallelGCThreads=6
```

## config/

### defaultworldgenerator.cfg

To allow create flat worlds for testing

```ini
B:"Lock World Generator"=true
B:"Lock World Generator"=false
```

### HardcoreDarkness.cfg

To fix my eyes at all nights at endgame

```ini
I:Mode=0
I:Mode=1
S:"Dimension Blacklist"=7
S:"Dimension Blacklist"=-1,0,1,7,180,230
```

### InGameInfoXML/InGameInfo.xml

Blood and warp monitoring for IGIXML. Paste after these lines

```xml
            <var>lightfeet</var>
            <str>{white})</str>
        </line>
```

```xml
        <line>
            <icon>
                <str>AWWayofTime:weakBloodOrb</str>
            </icon>
            <str> {white}Blood: {red}{bmlp} </str>
            <str> {white}Max Blood: {red}{bmmaxlp} </str>
        </line>
        <line>
            <icon>
                <str>Thaumcraft:ItemSanityChecker</str>
            </icon>
            <str> {white}TC Warp: {darkpurple}{tcwarptotal} </str>
            <str> {white}(Perm: {gold}{tcwarpperm}, {white}Sticky: {gold}{tcwarpsticky}, {white}Temp: {gold}{tcwarptemp}{white})</str>
        </line>
```

### InGameInfoXML.cfg

Normal config for IGIXML

```ini
I:"scale(new)"=5
I:"scale(new)"=10
```

### RandomThings.cfg

To fix my eyes at some nights at endgame

```ini
B:BloodMoonRedLight=true
B:BloodMoonRedLight=false
```

### betterquesting.cfg

Book settings and design

```ini
B:"Lock tray"=false
B:"Lock tray"=true
S:Theme=betterquesting:light
S:Theme=betterquesting:vanilla
B:"View mode"=false
B:"View mode"=true
```

## serverutilities/

### client/serverutilities.cfg

To show NBT data with shift

```ini
    B:item_nbt=false
    B:item_nbt=true
```

## mods/

### Add

- [JourneyMap with radar](https://www.curseforge.com/minecraft/mc-mods/journeymap/files?version=1.7.10)
- [Cyrillic font fix](https://github.com/gamerforEA/Minecraft-ClientFixer/releases/tag/1.0)
  - [temporary broken](https://github.com/GTNewHorizons/Angelica/issues/497)

### Remove

journeymap-1.7.10-5.2.8-fairplay.jar

## resourcepacks/

- Round Large Turbine Overlay (recheck)
- Hidden Galacticraft Thermal Padding GT V1.0.0
- Round Large Turbine Overlay
- [GTNH Faithful Textures](https://github.com/Ethryan/GTNH-Faithful-Textures/releases/latest)
- Realistic Sky GT New Horizons

### F32 fix (recheck)

- rollback fonts for ClientFixer(Cyrillic font fix)
  - GTNH-Faithful-x32.0.9.15/assets/minecraft/textures/font/
  - GTNH-Faithful-x32.0.9.15/assets/minecraft/

## TODO

- Core
  - migrate patcher to diff/sed-like syntax
- Patch
  - generate HardcoreDarkness.cfg/Dimension Blacklist
    - is it working?
  - add page with test tools to bookmarks
  - journeymap settings
- Sync
  - journeymap/data/
  - TCNodeTracker/
  - visualprospecting/
  - logs/
  - screenshots/
  - saves/
    - NEI/global/bookmarks.ini
  - ../instance.cfg
