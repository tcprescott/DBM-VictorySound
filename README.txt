DBM-VictorySound

Plays a victory or defeat song when exiting combat with a boss recognized by Deadly Boss Mods. It will also play a song when entering combat which will loop until a victory or defeat song is played. This song can also be ended by typing "/script StopMusic()" into your chatbox.
This is 100% configurable ingame. Simply open the DBM GUI (via /dbm, etc) and goto the options tab. Click on "Victory Sound" and configure it to your liking. If you wish to add your own songs, just drag the .wav or .mp3 file to the "sounds" folder and type the name of the file in the provided edit box. Please note that you must completely exit and re-enter World of Warcraft before you can play the sound file.
Again, if you encounter any errors feel free to post them so I can take a stab at them. This has been tested with DBM 4.42 (3.3.2 release). Enjoy!

Known Issue
Victory and Defeat music is really soft, due to a change in the Blizzard API with PlaySoundFile. I'll probably run these thru Audacity and up the volume on the clips for the next release.

Update on PlayMusic() getting pushed off
It appears that in 4.0.3 Blizzard finally fixed PlayMusic() so it is not pushed off, or play alongside the zone music. As always, its a good idea to keep your number of sound channels to "High" if your system can support it. PlaySoundFile, which is what the victory/defeat music relies on, STILL uses the Sound volume, not Master volume. Hopefully this will be fixed in a later patch.

Version 1.8 Feature
Version 1.8 has a feature that will automatically enable and disable the game music as needed. This feature can be disabled, however it is on by default. This simply "remembers" your music settings when going into raid combat, and enables game music so the combat music will play correctly. Once combat is finished the game music will be returned to its previous setting. Reloading the UI while in combat may break this, leaving your game music on, as it had no opportunity to shut it off. There may be other unknown situations that may cause the music settings to not be restored correctly. If you do not want DBM-VictorySound to mess with your sound settings, simply disable the feature.

Plans for the future:
Add ability to add entries to the dropdown menu automatically. Add ability to play specific sounds for specific boss encounters. Add ability to pick sounds to play at random from pre-determined lists.