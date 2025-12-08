# GTNH Tweaks

(target 2.8.2)

My GTNH setup and shitcoded python patcher for configs

## Java

I prefer GraalVM EE JDK 23:

`scoop install graalvm-oracle-jdk` on Windows, find it yourself on Linux

### RAM

```bash
-Xms8G -Xmx8G
```

### Args

(if it is **failed to reserve and commit memory**, remove last line or download more RAM (or enable large/huge pages in your OS, you need 4400 for 8G))

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

- `diff -u /home/$USER/{Downloads/GTNH/,.local/share/PrismLauncher/instances/GTNH-6.6.6/.minecraft/}config/{<file>} > diff`

### adventurebackpack.cfg

To disable useless tanks and potions overlay

```diff
@@ -63,7 +63,7 @@
 
     status {
         # Show player status effects on screen? [default: true]
-        B:"Enable Overlay"=true
+        B:"Enable Overlay"=false
 
         # Horizontal indent from the window border [range: 0 ~ 1000, default: 2]
         I:"Indent Horizontal"=2
@@ -83,7 +83,7 @@
 
     tanks {
         # Show the different wearable overlays on screen? [default: true]
-        B:"Enable Overlay"=true
+        B:"Enable Overlay"=false
 
         # Horizontal indent from the window border [range: 0 ~ 1000, default: 2]
         I:"Indent Horizontal"=2
```

### defaultworldgenerator.cfg

To allow create flat worlds for testing

```diff
@@ -16,7 +16,7 @@
 
 general {
     # Enable this to lock world generator to one specified [default: false]
-    B:"Lock World Generator"=true
+    B:"Lock World Generator"=false
 
     # Enabling this will display all world generators installed, useful for debug [default: false]
     B:"Show World Generators in Log"=true
```

### DraconicEvolution.cfg

Fix GUI mess at endgame

```diff
@@ -160,7 +160,7 @@
         0
         1
         1
         1
-        1
+        0
      >
 }
```

### GregTech/Goggles.cfg

Move GT goggles HUD under TPS (run game at least once to apply)

```ini
    I:"Render Offset X"=10
    I:"Render Offset X"=0
    I:"Render Offset Y"=40
    I:"Render Offset Y"=430
```

### hodgepodge.cfg

fix for <https://github.com/GTNewHorizons/GT-New-Horizons-Modpack/issues/22096>

```diff
@@ -89,7 +107,7 @@
     B:fixCaseCommands=true
 
     # Fix the vanilla method to open chat links not working for every OS [default: true]
-    B:fixChatOpenLink=true
+    B:fixChatOpenLink=false
 
     # Fix wrapped chat lines missing colors [default: true]
     B:fixChatWrappedColors=true
```

### InGameInfoXML/InGameInfo.xml

Blood and warp monitoring for IGIXML. Paste after these lines

```diff
@@ -167,6 +167,20 @@
         </line>
         <line>
             <icon>
+                <str>AWWayofTime:weakBloodOrb</str>
+            </icon>
+            <str> {white}Blood: {red}{bmlp} </str>
+            <str> {white}Max Blood: {red}{bmmaxlp} </str>
+        </line>
+        <line>
+            <icon>
+                <str>Thaumcraft:ItemSanityChecker</str>
+            </icon>
+            <str> {white}TC Warp: {darkpurple}{tcwarptotal} </str>
+            <str> {white}(Perm: {gold}{tcwarpperm}, {white}Sticky: {gold}{tcwarpsticky}, {white}Temp: {gold}{tcwarptemp}{white})</str>
+        </line>
+        <line>
+            <icon>
                 <str>witchery:mooncharm</str>
             </icon>
 		<str> Moon phase: </str>

```

### InGameInfoXML.cfg

Make IGIXML to use default font size

```diff
@@ -44,7 +44,7 @@
     B:replaceDebug=false
 
     # The overlay will be scaled by this amount.(use this one, the other is deprecated)
-    I:"scale(new)"=5
+    I:"scale(new)"=10
 
     # Display the overlay in chat.
     B:showInChat=false
```

### RandomThings.cfg

To fix my eyes at some nights at endgame

```diff
@@ -79,7 +79,7 @@
     B:BloodMoonNoSleep=true
 
     # Whether light will be tinted red on a Bloodmoon
-    B:BloodMoonRedLight=true
+    B:BloodMoonRedLight=false
 
     # Whether the moon will be red on a Bloodmoon
     B:BloodMoonRedMoon=true
```

### betterquesting.cfg

Book settings and design

```diff
@@ -27,7 +30,7 @@
     B:"Load the default quest DB on world startup."=false
 
     # Is quest chapters list locked and opened on start. [default: false]
-    B:"Lock tray"=false
+    B:"Lock tray"=true
 
     # Posts useful information in the log when encountering a null quest during loading. [default: true]
     B:"Log null quests"=true
@@ -54,7 +57,7 @@
     S:"Text Width Correction"=1.0
 
     # The current questing theme [default: betterquesting:light]
-    S:Theme=betterquesting:light
+    S:Theme=betterquesting:vanilla
 
     # If true, all users can use /bq_admin commands regardless of op-status. Useful for single-player without cheats. [default: false]
     B:"Unrestrict Admin Commands"=false
@@ -63,7 +66,7 @@
     B:"Use Quest Bookmark"=true
 
     # If true, user can view not-yet-unlocked quests that are not hidden or secret. This property can be changed by the GUI. [default: false]
-    B:"View mode"=false
+    B:"View mode"=true
 
     # If true, view mode will display the quest line regardless of whether the quest line is unlocked yet. [default: true]
     B:"View mode all quest line"=true
```

### AppliedEnergistics2/AppliedEnergistics2.cfg

Remember my terminal setup

```diff
@@ -20,36 +20,39 @@
 
 client {
     # Possible Values: NAME, AMOUNT, CRAFTS, MOD, PERCENT
-    S:CRAFTING_SORT_BY=NAME
+    S:CRAFTING_SORT_BY=PERCENT
 
     # Possible Values: BUTTON, TILE
     S:CRAFTING_STATUS=TILE
 
     # Possible Values: YES, NO, UNDECIDED
-    S:HIDE_STORED=NO
+    S:HIDE_STORED=YES
 
     # Possible Values: NATURAL, ALPHANUM
     S:INTERFACE_TERMINAL_SECTION_ORDER=NATURAL
     I:InterfaceTerminalSmallSize=6
     I:MEMonitorableSmallSize=6
 
     # Possible Values: ACTIVE, DISABLED
     S:PINS_STATE=DISABLED
 
     # Possible Values: AE, EU, WA, RF, MK
-    S:PowerUnit=AE
+    S:PowerUnit=EU
 
     # Possible Values: YES, NO, UNDECIDED
     S:SAVE_SEARCH=NO
 
     # Possible Values: MANUAL_SEARCH, AUTOSEARCH, NEI_AUTOSEARCH, NEI_MANUAL_SEARCH
-    S:SEARCH_MODE=AUTOSEARCH
+    S:SEARCH_MODE=MANUAL_SEARCH
 
     # Possible Values: YES, NO, UNDECIDED
     S:SEARCH_TOOLTIPS=YES
 
     # Possible Values: ASCENDING, DESCENDING
-    S:SORT_DIRECTION=ASCENDING
+    S:SORT_DIRECTION=DESCENDING
+
+    # Possible Values: ALWAYS, NO_AUTOSEARCH, NEVER
+    S:SearchBoxFocusPriority=NEVER
 
     # Possible Values: SMALL, DYNAMIC, LARGE
     S:TERMINAL_FONT_SIZE=SMALL
```

### NEI/client.cfg

Fix anti overlapping case I hate it

```ini
	ignorePotionOverlap=false
	ignorePotionOverlap=true
```

### witchery.cfg

Fix GUI mess

```diff
@@ -37,7 +37,7 @@
     I:DiseaseBlockRemovalChance=10
     B:DoubleFumeFilterChance=false
     I:DreamDimensionID=55
-    B:GUIOnLeft=true
+    B:GUIOnLeft=false
     B:GenerateApothecaries=true
     B:GenerateBookShops=true
     B:GenerateCovens=true
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

- [DistantHorizons](https://github.com/DarkShadow44/DistantHorizonsStandalone/releases)
- [FPS BG reducer](https://modrinth.com/mod/fps-reducer/versions?g=1.7.10)
- [JourneyMap with radar](https://www.curseforge.com/minecraft/mc-mods/journeymap/files?version=1.7.10)
- [MineMenu](https://www.curseforge.com/minecraft/mc-mods/minemenu/files?version=1.7.10)

### Remove

- journeymap-1.7.10-5.2.10-fairplay.jar

### Alt

- [Angelica 2.0 alpha](https://github.com/barsikus007/Angelica)

## resourcepacks/

- [Russian font](https://github.com/Eldrinn-Elantey/GTNH-FTI-Standard-Font/releases/latest)
- Realistic Sky GT New Horizons
- [GTNH Faithful Textures](https://github.com/Ethryan/GTNH-Faithful-Textures/releases/latest)

## TODO

- Patch
  - generate HardcoreDarkness.cfg/Dimension Blacklist
    - is it working?
  - add page with test tools to bookmarks
  - journeymap settings
- Sync
  - ../instance.cfg
    - [General].name
  - Distant_Horizons_server_data/
  - journeymap/data/
  - logs/
  - saves/
    - NEI/global/bookmarks.ini
  - screenshots/
  - TCNodeTracker/
  - visualprospecting/
