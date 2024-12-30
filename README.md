# GTNH Tweaks

(target 2.6.1)

My setup of GTNH and shitcoded python patcher for configs

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

### GregTech/Client.cfg

Due to lack of glowing textures upgrade in Stellar Fusion [source: GTNH discord](https://discord.com/channels/181078474394566657/234936569360809996/962740879217541120) (recheck)

```ini
B:GlowTextures_true=true
B:GlowTextures_true=false
```

### GregTech/GregTech.cfg

Due to recommendation from [source: GTNH forum (died)](https://www.gtnewhorizons.com/forum/m/36844562/viewthread/32547244-stellar-fusion-gregtech-32x32-v034/post/137314941#p137314941) (recheck)

```ini
B:use_machine_metal_tint=true
B:use_machine_metal_tint=false
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
S:"Dimension Blacklist"=-1,0,1,7,180
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

### serverutilities.cfg

To enable NBT editing

```ini
B:nbtedit=false
B:nbtedit=true
```

### client/serverutilities.cfg

To show NBT data with shift

```ini
B:item_nbt=false
B:item_nbt=true
```

## mods/

### Add

- [JourneyMap with radar](https://www.curseforge.com/minecraft/mc-mods/journeymap/files?version=1.7.10)
- [Russian font fix](https://github.com/gamerforEA/Minecraft-ClientFixer/releases/tag/1.0)
  - [temporary broken](https://github.com/GTNewHorizons/Angelica/issues/497)

### Remove

journeymap-1.7.10-5.2.3-fairplay.jar

## resourcepacks/

- [Ztones xBR upscale to 32x](https://discord.com/channels/181078474394566657/224191655375273985/453546192794550272)
  - (worse than usual due to fucked up upscaler, will delete it)
- Round Large Turbine Overlay (recheck)
- Hidden Galacticraft Thermal Padding GT V1.0.0
- Round Large Turbine Overlay
- [Stellar Fusion](https://s3.amazonaws.com/files.enjin.com/1172307/modules/forum/attachments/%C2%A7f%C2%A7lS%C2%A7e%C2%A7lte%C2%A76%C2%A7lll%C2%A74%C2%A7lar+%C2%A7f%C2%A7lFusion+V0.3.4_1550833036.zip) => [GTNH Faithful Textures](https://github.com/Ethryan/GTNH-Faithful-Textures/releases/latest)
- [Faithful 32 Modded Edition](http://www.f32.me/old/F32-1.7.10.zip)
- Realistic Sky GT New Horizons

### F32 fix (recheck)

- rollback fonts
  - GTNH-Faithful-Textures.0.9.6\assets\minecraft\textures\font\
  - GTNH-Faithful-Textures.0.9.6\assets\minecraft\
- ae2 new items fix
  - GTNH-Faithful-Textures.0.9.6\assets\appliedenergistics2\textures\guis\states.png
    - copy from mod
  - GTNH-Faithful-Textures.0.9.6\assets\appliedenergistics2\textures\guis\newinterfaceterminal.png
  - GTNH-Faithful-Textures.0.9.6\assets\appliedenergistics2\textures\guis\pattern3.png
  - GTNH-Faithful-Textures.0.9.6\assets\appliedenergistics2\textures\guis\pattern4.png
- chisel
  - idk

## TODO

- Core
  - migrate patcher to diff/sed-like syntax
  - update journeymap settings
- Patch
  - generate HardcoreDarkness.cfg\Dimension Blacklist
    - is it working?
  - add bag with test tools to bookmarks
  - journeymap settings
- Shaders
  - Angelica is temporary doesn't support shaders
  - use OF-U7 with FC-1.25
    - [OptiFine U7](https://optifine.net/adloadx?f=OptiFine_1.7.10_HD_U_E7.jar)
    - FastCraft 1.25 preinstalled
  - shaderpacks/
    - <https://www.curseforge.com/minecraft/customization/complementary-shaders>
    - <https://www.curseforge.com/minecraft/customization/bsl-shaders>
- Sync
  - journeymap/data/
  - TCNodeTracker/
  - visualprospecting/
  - logs/
  - screenshots/
  - saves/
    - NEI/global/bookmarks.ini
  - ../instance.cfg
