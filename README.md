# GTNH Tweaks

## JAVA
min 1024
min 6144
```bash
-XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:MaxGCPauseMillis=80 -XX:+UseStringDeduplication -XX:+UseCompressedOops -XX:+UseCodeCacheFlushing -XX:ParallelGCThreads=6
```
## config/
### GregTech/GregTech.cfg
```
# Due to recommendation from https://www.gtnewhorizons.com/forum/m/36844562/viewthread/32547244-stellar-fusion-gregtech-32x32-v034/post/137314941#p137314941
B:use_machine_metal_tint=true
B:use_machine_metal_tint=false
```
### GregTech/Client.cfg
```
# Due to lack of glowing textures upgrade in Stellar Fusion
B:GlowTextures_true=true
B:GlowTextures_true=false
```
### defaultworldgenerator.cfg
```
# To allow create flat worlds for testing
B:"Lock World Generator"=true
B:"Lock World Generator"=false
```
### InGameInfo.xml
```xml
# Normal config for IGIXML
LINE 140:
    <line>
        <icon>
            <str>AWWayofTime:weakBloodOrb</str>
        </icon>
        <str> $rBlood: $c{bmlp} </str>
        <str> $rMax Blood: $c{bmmaxlp} </str>
    </line>
    <line>
        <icon>
            <str>Thaumcraft:ItemSanityChecker</str>
        </icon>
        <str> $rTC Warp: $5{tcwarptotal} </str>
        <str> $r(Perm: $6{tcwarpperm}, $rSticky: $6{tcwarpsticky}, $rTemp: $6{tcwarptemp}$r)</str>
    </line>
```
### InGameInfoXML.cfg
```
# Normal config for IGIXML
I:"scale(new)"=5
I:"scale(new)"=10
```
### HardcoreDarkness.cfg
```
# To fix my eyes at all nights at endgame
I:Mode=0
I:Mode=1
S:"Dimension Blacklist"=7
S:"Dimension Blacklist"=7,0
```
### RandomThings.cfg
```
# To fix my eyes at some nights at endgame
B:BloodMoonRedLight=true
B:BloodMoonRedLight=false
```
## mods/
### Add
? https://github.com/MoeBoy76/NBTEdit/releases/tag/1.7.10
https://www.curseforge.com/minecraft/mc-mods/forge-nbtedit-for-1-7-10
https://www.curseforge.com/minecraft/mc-mods/journeymap
https://www.curseforge.com/minecraft/mc-mods/fullscreen-windowed-borderless-for-minecraft
### Remove
journeymap-1.7.10-5.1.4p2-fairplay.jar

## resourcepacks/
[Stellar Fusion](https://s3.amazonaws.com/files.enjin.com/1172307/modules/forum/attachments/%C2%A7f%C2%A7lS%C2%A7e%C2%A7lte%C2%A76%C2%A7lll%C2%A74%C2%A7lar+%C2%A7f%C2%A7lFusion+V0.3.4_1550833036.zip)
[Faithful 32 Modded Edition](http://www.f32.me/old/F32-1.7.10.zip)
Ztones upscale to 32x

## TODO
NEI
options.txt
OPTIFINE
optionsof.txt

sync journeymap and TCNodeTracker
check shaderpacks
check saves
client.dat
servers.dat

config GT++