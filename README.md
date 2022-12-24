# GTNH Tweaks

My setup of GTNH and shitcoded python patcher for configs

## JAVA
-Xmx6144m
-Xmx6g
-Xmx6144m
-Xmx6g
(no more than 6G)
Set max threads to your CPU count
https://discord.com/channels/181078474394566657/234936569360809996/537728390363348992
```bash
-XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:MaxGCPauseMillis=80 -XX:+UseStringDeduplication -XX:+UseCompressedOops -XX:+UseCodeCacheFlushing -XX:ParallelGCThreads=6
```
Add this to fix `Timed out`
```bash
-Dfml.readTimeout=180
```
## config/
### GregTech/Client.cfg
Due to lack of glowing textures upgrade in Stellar Fusion
```
B:GlowTextures_true=true
B:GlowTextures_true=false
```
### GregTech/GregTech.cfg
Due to recommendation from https://www.gtnewhorizons.com/forum/m/36844562/viewthread/32547244-stellar-fusion-gregtech-32x32-v034/post/137314941#p137314941
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
- [JourneyMap with radar](https://www.curseforge.com/minecraft/mc-mods/journeymap/files/all?filter-game-version=2020709689%3A4449)
- https://www.curseforge.com/minecraft/mc-mods/fullscreen-windowed-borderless-for-minecraft
- [Russian font fix](https://github.com/gamerforEA/Minecraft-ClientFixer/releases/tag/1.0)
### Remove
journeymap-1.7.10-5.1.4p2-fairplay.jar

## resourcepacks/
- [Stellar Fusion](https://s3.amazonaws.com/files.enjin.com/1172307/modules/forum/attachments/%C2%A7f%C2%A7lS%C2%A7e%C2%A7lte%C2%A76%C2%A7lll%C2%A74%C2%A7lar+%C2%A7f%C2%A7lFusion+V0.3.4_1550833036.zip)
- [Faithful 32 Modded Edition](http://www.f32.me/old/F32-1.7.10.zip)
- [Ztones xBR upscale to 32x](https://discord.com/channels/181078474394566657/224191655375273985/453546192794550272)
### F32 patch
#### Remove
- F32-1.7.10.zip\assets\appliedenergistics2
- F32-1.7.10.zip\assets\appliedenergistics2\textures\guis\interface.png
- chisel

## TODO
- Generate HardcoreDarkness.cfg\Dimension Blacklist
- Upgrade InGameInfo.xml to 2.2.0.0
- World with debug bag
- options.txt
- OPTIFINE
  - optionsof.txt
  - Choose verison
  - [OptiFine](https://optifine.net/adloadx?f=OptiFine_1.7.10_HD_U_E7.jar)
  - [FastCraft 1.23](https://www.curseforge.com/minecraft/mc-mods/fastcraft/files/2292386)
- Sync
  - sync journeymap/data/ and TCNodeTracker/ and visualprospecting/ and saves/NEI/global/bookmarks.ini
  - sync logs/ and screenshots/ and saves/
  - check shaderpacks
  - check saves
  - check invtweaks
  - client.dat
  - servers.dat
- borderless mod
- patch faithful
- config GT++
