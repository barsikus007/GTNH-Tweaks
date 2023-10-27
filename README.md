# GTNH Tweaks

My setup of GTNH and shitcoded python patcher for configs

## JAVA

- Xms1024m
- Xms1g
- Xmx6144m
- Xmx6g
(no more than 6G)

Set max threads to your CPU count

<https://discord.com/channels/181078474394566657/234936569360809996/537728390363348992>

TODO remove `-XX:+UseConcMarkSweepGC` if java version >= 19

```bash
-XX:+UseConcMarkSweepGC -XX:+DisableExplicitGC -XX:MaxGCPauseMillis=80 -XX:+UseStringDeduplication -XX:+UseCompressedOops -XX:+UseCodeCacheFlushing -XX:ParallelGCThreads=6
```

Add this to fix `Timed out` (need to set this both on client and server)

```bash
-Dfml.readTimeout=180
```

Check <https://github.com/brucethemoose/Minecraft-Performance-Flags-Benchmarks>

## config/
### GregTech/Client.cfg
Due to lack of glowing textures upgrade in Stellar Fusion [source: GTNH discord](https://discord.com/channels/181078474394566657/234936569360809996/962740879217541120) (recheck)
```
B:GlowTextures_true=true
B:GlowTextures_true=false
```
### GregTech/GregTech.cfg
Due to recommendation from [source: GTNH forum (died)](https://www.gtnewhorizons.com/forum/m/36844562/viewthread/32547244-stellar-fusion-gregtech-32x32-v034/post/137314941#p137314941) (recheck)
```
B:use_machine_metal_tint=true
B:use_machine_metal_tint=false
```
### defaultworldgenerator.cfg
To allow create flat worlds for testing
```
B:"Lock World Generator"=true
B:"Lock World Generator"=false
```
### HardcoreDarkness.cfg
To fix my eyes at all nights at endgame
```
I:Mode=0
I:Mode=1
S:"Dimension Blacklist"=7
S:"Dimension Blacklist"=-1,0,1,7,180
```
### InGameInfo.xml
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
```
I:"scale(new)"=5
I:"scale(new)"=10
```
### RandomThings.cfg
To fix my eyes at some nights at endgame
```
B:BloodMoonRedLight=true
B:BloodMoonRedLight=false
```

## mods/

### Add

- [NBTEdit](https://www.curseforge.com/minecraft/mc-mods/forge-nbtedit-for-1-7-10)
- [NBTEdit alt](https://github.com/MoeBoy76/NBTEdit/releases/tag/1.7.10)
- [JourneyMap with radar](https://www.curseforge.com/minecraft/mc-mods/journeymap/files?version=1.7.10)
- [Russian font fix](https://github.com/gamerforEA/Minecraft-ClientFixer/releases/tag/1.0)

### Remove

journeymap-1.7.10-5.1.4p6-fairplay.jar

## resourcepacks/

- [Ztones xBR upscale to 32x](https://discord.com/channels/181078474394566657/224191655375273985/453546192794550272)
  - (worse than usual due to fucked up upscaler, will delete it)
- Round Large Turbine Overlay (recheck)
- [Stellar Fusion](https://s3.amazonaws.com/files.enjin.com/1172307/modules/forum/attachments/%C2%A7f%C2%A7lS%C2%A7e%C2%A7lte%C2%A76%C2%A7lll%C2%A74%C2%A7lar+%C2%A7f%C2%A7lFusion+V0.3.4_1550833036.zip) => [GTNH Faithful Textures](https://github.com/Ethryan/GTNH-Faithful-Textures/releases/latest)
- [Faithful 32 Modded Edition](http://www.f32.me/old/F32-1.7.10.zip)
- Realistic Sky GT New Horizons

### F32 fix (recheck)

- rollback fonts
  - GTNH-Faithful-Textures.0.9.6\assets\minecraft\textures\font\
  - GTNH-Faithful-Textures.0.9.6\assets\minecraft\
- ae2 new items fix
  - GTNH-Faithful-Textures.0.9.6.zip\assets\appliedenergistics2\textures\guis\states.png
- chisel
  - idk

## TODO

- migrate patcher to diff-like syntax
  - add regex support or smth like that to fix strict md formatting
- Generate HardcoreDarkness.cfg\Dimension Blacklist
- add bag with test tools to bookmarks
- OPTIFINE
  - (with shaders) OF-U7 with FC-1.25 is only option for Java 17-20
    - [OptiFine U7](https://optifine.net/adloadx?f=OptiFine_1.7.10_HD_U_E7.jar)
    - FastCraft 1.25 preinstalled
  - (without shaders) OF-D6 with FC-1.23 should work better
    - [OptiFine D6](https://optifine.net/adloadx?f=OptiFine_1.7.10_HD_U_D6.jar)
    - [FastCraft 1.23](https://www.curseforge.com/minecraft/mc-mods/fastcraft/files/2292386)
  - (without shaders) NotFine with FC-1.23 (untested)
    - [NotFine](https://github.com/jss2a98aj/NotFine)
  - shaderpacks/
    - <https://www.curseforge.com/minecraft/customization/complementary-shaders>
    - <https://www.curseforge.com/minecraft/customization/bsl-shaders>
  - replace optifine ?
    - <https://gtnh.miraheze.org/wiki/Additional_Mods>
    - <https://github.com/TheUsefulLists/UsefulMods>
- Sync
  - mods folders
    - journeymap/data/
    - TCNodeTracker/
    - visualprospecting/
  - default folders
    - logs/
    - screenshots/
    - saves/
      - NEI/global/bookmarks.ini
  - servers.dat
  - check invtweaks and questbook ?
  - journeymap/data/ merger
  - sync ../instance.cfg
- borderless mod check
