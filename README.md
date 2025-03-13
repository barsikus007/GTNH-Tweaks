# GTNH Tweaks

(target 2.7.3)

My GTNH setup and shitcoded python patcher for configs

## Java

I prefer GraalVM EE JDK 23:

`scoop install graalvm-oracle-jdk` on Windows, find it yourself on Linux

### RAM

```bash
-Xms8G -Xmx8G
```

### Args

(if it is **failed to reserve and commit memory**, remove last line or download more RAM)

```sh
-Dfml.readTimeout=9001
-XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+AlwaysActAsServerClassMachine -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:NmethodSweepActivity=1 -XX:ReservedCodeCacheSize=400M -XX:NonNMethodCodeHeapSize=12M -XX:ProfiledCodeHeapSize=194M -XX:NonProfiledCodeHeapSize=194M -XX:-DontCompileHugeMethods -XX:+PerfDisableSharedMem -XX:+UseFastUnorderedTimeStamps -XX:+UseCriticalJavaThreadPriority -XX:+EagerJVMCI -Dgraal.TuneInlinerExploration=1
-XX:+UseG1GC -XX:MaxGCPauseMillis=37 -XX:+PerfDisableSharedMem -XX:G1HeapRegionSize=16M -XX:G1NewSizePercent=23 -XX:G1ReservePercent=20 -XX:SurvivorRatio=32 -XX:G1MixedGCCountTarget=3 -XX:G1HeapWastePercent=20 -XX:InitiatingHeapOccupancyPercent=10 -XX:G1RSetUpdatingPauseTimePercent=0 -XX:MaxTenuringThreshold=1 -XX:G1SATBBufferEnqueueingThresholdPercent=30 -XX:G1ConcMarkStepDurationMillis=5.0 -XX:GCTimeRatio=99 -XX:AllocatePrefetchStyle=3
-XX:+UseLargePages -XX:LargePageSizeInBytes=2m
```

<details>
  <summary>Info</summary>

  Default GTNH tunes GC a little bit, but my memory is leaking by default. [They wiki references](https://gtnh.miraheze.org/wiki/Installing_and_Migrating#Java_Arguments_for_Java_8) to repo with JVM args research, [but it wasn't updated for long](https://github.com/brucethemoose/Minecraft-Performance-Flags-Benchmarks/issues/53), so someone made fork and then remastered it:

  <https://github.com/Mukul1127/Minecraft-Java-Flags>

  For my case I used these sections

  0. `-Dfml.readTimeout=9001` for fixing `Timed out` errors if enabled on server
  1. #GraalVM 17+
  2. #Client G1GC
  3. #Large Pages

</details>

## config/

### adventurebackpack.cfg

To disable useless tanks and potions overlay

```ini
        B:"Enable Overlay"=true
        B:"Enable Overlay"=false
```

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

Make IGIXML to use default font size

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
