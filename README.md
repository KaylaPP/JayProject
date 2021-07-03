![JK Engine](JKEngineWitBackground.png)

This mod is a collection of songs chosen and charted by Jay, with some changes to the input system I added to make the game's input system closer to that of OpenITG.

## Song Names
```
- 16 Night is a Long Time					IRON ATTACK!			n/a
- Armageddon [Remix]						LeaF				https://soundcloud.com/leaf-7/armageddon
- The 2017 Bad Apple Rock Cover (Sam Luff Ver.)			Studio Yuraki			https://youtu.be/dNE9oa3pTIc
- Everything will freeze					Undead Corporation		n/a
- Flight of the Bumblebee[Metal arrangement]			Leo Terents			https://youtu.be/9Te10RBel6s
- FREEDOM DiVE							Xi				https://youtu.be/k-3y2LVF_SE
- From Nothing							kEvin & Davie Paige		https://soundcloud.com/kevinpdoesmusic/from-nothing
- Galaxy Collapse						Kurokotei			https://soundcloud.com/dialgadu77
- Night Of Nights [NITRO Remix]					Nick Nitro			https://www.youtube.com/watch?v=l3EPExPBKw4
- Printer Jam							Mistabishi			https://youtu.be/6q0oV4dYcCE
- The Big Black							The Quick Brown Fox		https://youtu.be/kyUtGNIFx5c
- Through The Fire and The Flames				Dragonforce			https://youtu.be/0jgrCKhxE1s
- Tune Out							Azrael				https://youtu.be/P9y77czgtBA

```
## Reference Charts
```
Freedom Dive (Hard)						Nandii, Zaia
Galaxy Collapse							Mat
Printer Jam (Hard)						WinDEU
Through The Fire and The Flames (Hard)				B. Abear
The Big Black (Normal)						Rynker
```
**HUGE NOTICE**

This is a **MOD**. This is not Vanilla and should be treated as a **MODIFICATION**. This will probably never be official, so don't get confused.

## Credits / shoutouts

- [ninjamuffin99](https://twitter.com/ninja_muffin99) - Programmer
- [PhantomArcade3K](https://twitter.com/phantomarcade3k) and [Evilsk8r](https://twitter.com/evilsk8r) - Art
- [Kawaisprite](https://twitter.com/kawaisprite) - Musician
- [Kade M](https://github.com/KadeDev) - Creator of the Kade Engine, what JK Engine is based on
- [Jaymes "Jay" Hayward](https://www.youtube.com/c/JAiZYouTube/videos) - Charter
- [kEvin](https://kevinp.carrd.co) - Main Programmer for this Mod
- [Toumi](https://soundcloud.com/toumitunes) - Creator of the boom sound effect (also a really cool guy)
- [Steve](https://arciwithnoh.newgrounds.com/) - Artist/Animator/Playtester
- [ClockShaft](https://clockshaft.newgrounds.com/) - Arist/Animator
- [0th](https://reddit.com/u/mest0shai) - Artist/Animator/Playtester
- Fia - Artist/Animator
- [ChazbillYT](https://www.youtube.com/channel/UC8SJ69agmZMWOQfLpxD7omQ) - Artist
- [Davie Paige](https://www.instagram.com/daviepaige/) - The guy I collaborated with to make "From Nothing"
- Spook - Playtester
- Dreaming - Playtester

**If I am missing credits, please email me! I read my emails every day and I'm happy to give credits where credit is due.**

This game was made with love to Newgrounds and it's community. Extra love to Tom Fulp.

## Build instructions

THESE INSTRUCTIONS ARE FOR COMPILING THE GAME'S SOURCE CODE!!!

IF YOU WANT TO JUST DOWNLOAD AND INSTALL AND PLAY THE GAME NORMALLY, GO TO ITCH.IO TO DOWNLOAD THE GAME FOR PC, MAC, AND LINUX!!

https://ninja-muffin24.itch.io/friday-night-funkin

IF YOU WANT TO COMPILE THE GAME YOURSELF, CONTINUE READING!!!

### Installing the Required Programs

First you need to install Haxe and HaxeFlixel. I'm too lazy to write and keep updated with that setup (which is pretty simple). 
1. [Install Haxe 4.1.5](https://haxe.org/download/version/4.1.5/) (Download 4.1.5 instead of 4.2.0 because 4.2.0 is broken and is not working with gits properly...)
2. [Install HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/) after downloading Haxe

Other installations you'd need is the additional libraries, a fully updated list will be in `Project.xml` in the project root. Currently, these are all of the things you need to install:
```
flixel
flixel-addons
flixel-ui
hscript
newgrounds
```
So for each of those type `haxelib install [library]` so shit like `haxelib install newgrounds`

You'll also need to install polymod. To do this, you need to do a few things first.
1. Download [git-scm](https://git-scm.com/downloads). Works for Windows, Mac, and Linux, just select your build.
2. Follow instructions to install the application properly.
3. Run `haxelib git polymod https://github.com/larsiusprime/polymod.git` in terminal/command-prompt after your git program is installed.

You should have everything ready for compiling the game! Follow the guide below to continue!

At the moment, you can optionally fix the transition bug in songs with zoomed out cameras.
- Run `haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons` in the terminal/command-prompt.

You also need Discord RPC to compile the game, get it by using the following command:
- Use `haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc` in the terminal/command-prompt.

### Ignored files

I gitignore the API keys for the game, so that no one can nab them and post fake highscores on the leaderboards. But because of that the game
doesn't compile without it.

Just make a file in `/source` and call it `APIStuff.hx`, and copy paste this into it

```haxe
package;

class APIStuff
{
	public static var API:String = "";
	public static var EncKey:String = "";
}

```

and you should be good to go there.

### Compiling game

Once you have all those installed, it's pretty easy to compile the game. You just need to run 'lime test html5 -debug' in the root of the project to build and run the HTML5 version. (command prompt navigation guide can be found here: [https://ninjamuffin99.newgrounds.com/news/post/1090480](https://ninjamuffin99.newgrounds.com/news/post/1090480))

To run it from your desktop (Windows, Mac, Linux) it can be a bit more involved. For Linux, you only need to open a terminal in the project directory and run 'lime test linux -debug' and then run the executible file in export/release/linux/bin. For Windows, you need to install Visual Studio Community 2019. While installing VSC, don't click on any of the options to install workloads. Instead, go to the individual components tab and choose the following:
* MSVC v142 - VS 2019 C++ x64/x86 build tools
* Windows SDK (10.0.17763.0)
* C++ Profiling tools
* C++ CMake tools for windows
* C++ ATL for v142 build tools (x86 & x64)
* C++ MFC for v142 build tools (x86 & x64)
* C++/CLI support for v142 build tools (14.21)
* C++ Modules for v142 build tools (x64/x86)
* Clang Compiler for Windows
* Windows 10 SDK (10.0.17134.0)
* Windows 10 SDK (10.0.16299.0)
* MSVC v141 - VS 2017 C++ x64/x86 build tools
* MSVC v140 - VS 2015 C++ build tools (v14.00)

This will install about 22GB of crap, but once that is done you can open up a command line in the project's directory and run `lime test windows -debug`. Once that command finishes (it takes forever even on a higher end PC), you can run FNF from the .exe file under export\release\windows\bin
As for Mac, 'lime test mac -debug' should work, if not the internet surely has a guide on how to compile Haxe stuff for Mac.

### Additional guides

- [Command line basics](https://ninjamuffin99.newgrounds.com/news/post/1090480)


Sidenote: If you're reading this in a text editor and the spacing is a bit wacky, set your tab size to 8
