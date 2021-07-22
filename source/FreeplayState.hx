package;

import flixel.tweens.FlxTween;
import flixel.FlxSubState;
import flixel.effects.FlxFlicker;
import flixel.FlxCamera;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;


#if desktop
import Discord.DiscordClient;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	public static var optionSubstateClosed:Bool = false;
	public static var loadSMSong:Bool = false;
	public static var SMDifficulties:Array<String> = ['Novice', 'Easy', 'Medium', 'Hard', 'Challenge', 'Edit'];
	public static var SMGalaxyDifficulties:Array<String> = ['Easy', 'Medium', 'Hard', 'Edit'];

	var songs:Array<SongMetadata> = [];

	public var selector:FlxText;
	public static var curSelected:Int = 0;
	public static var curDifficulty:Int = 1;

	public var scoreText:FlxText;
	public var diffText:FlxText;
	public var lerpScore:Int = 0;
	public var intendedScore:Int = 0;

	private var artistNames:Array<String>;
	private var artistText:FlxText;
	private var curSongSelected:FlxSprite;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	private var mainSelectCam:FlxCamera;
	private var optionsCam:FlxCamera;
	private var bgCam:FlxCamera;
	private var songSelected:Bool = false;
	private var menuTweened:Bool = false;
	private var selectElapsed:Float = 0.0;
	private var acceptedCount:Int = 0;
	private var timeLeftUntilSongBar:FlxSprite;
	private var pressEnter:Alphabet;
	private var songLoaded:Bool = false;

	override function create()
	{
		PlayState.isSMSong = false;
		bgCam = new FlxCamera(0, 0);
		bgCam.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(bgCam);

		mainSelectCam = new FlxCamera(0, 0);
		mainSelectCam.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(mainSelectCam);

		optionsCam = new FlxCamera(0, 0);
		optionsCam.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(optionsCam);

		timeLeftUntilSongBar = new FlxSprite(0, FlxG.height - 100).makeGraphic(1, 1, FlxColor.TRANSPARENT);
		timeLeftUntilSongBar.camera = optionsCam;
		add(timeLeftUntilSongBar);

		pressEnter = new Alphabet(0, FlxG.height - 200, "Press ENTER for options menu", true);
		pressEnter.y = timeLeftUntilSongBar.y - pressEnter.height;
		pressEnter.camera = optionsCam;
		pressEnter.alpha = 0;
		add(pressEnter);

		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));

		var artistIndex:Int = 0;
		artistNames = new Array<String>();

		for (i in 0...initSonglist.length)
		{
			if(initSonglist[i].indexOf('--') != 0)
			{
				artistIndex = initSonglist[i].indexOf('--') + 2;
				artistNames.push(initSonglist[i].substr(artistIndex));
			}
			else 
			{
				artistNames.push("");
			}

			if(artistIndex == 0)
				songs.push(new SongMetadata(initSonglist[i], 1, 'gf'));
			else
				songs.push(new SongMetadata(initSonglist[i].substr(0, artistIndex - 2), 1, 'gf'));
		}

		/* 
			if (FlxG.sound.music != null)
			{
				if (!FlxG.sound.music.playing)
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
			}
		 */

		 #if desktop
		 // Updating Discord Rich Presence
		 DiscordClient.changePresence("In the Menus", null);
		 #end

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

			//addWeek(['Bopeebo', 'Fresh', 'Dadbattle'], 1, ['dad']);
			//addWeek(['Spookeez', 'South', 'Monster'], 2, ['spooky', 'spooky', 'monster']);
			//addWeek(['Pico', 'Philly', 'Blammed'], 3, ['pico']);

			//addWeek(['Satin-Panties', 'High', 'Milf'], 4, ['mom']);
			//addWeek(['Cocoa', 'Eggnog', 'Winter-Horrorland'], 5, ['parents-christmas', 'parents-christmas', 'monster-christmas']);
			
			//addWeek(['Senpai', 'Roses', 'Thorns'], 6, ['senpai', 'senpai', 'spirit']);

		// LOAD MUSIC

		// LOAD CHARACTERS

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		bg.camera = bgCam;
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		grpSongs.camera = mainSelectCam;
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);

			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			icon.camera = mainSelectCam;
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}

		artistText = new FlxText(0, 0, ".");
		artistText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		artistText.camera = mainSelectCam;
		add(artistText);

		scoreText = new FlxText(5, 5, 0, "", 32);
		// scoreText.autoSize = false;
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		// scoreText.alignment = RIGHT;

		var scoreBG:FlxSprite = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * 0.35), 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		scoreBG.camera = mainSelectCam;
		add(scoreBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		diffText.camera = mainSelectCam;
		add(diffText);

		scoreText.camera = mainSelectCam;
		add(scoreText);

		changeSelection();
		changeDiff();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		super.create();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter));
	}

	public function addWeek(songs:Array<String>, weekNum:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);

			if (songCharacters.length != 1)
				num++;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.4));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		scoreText.text = "PERSONAL BEST:" + lerpScore;

		var upP = controls.UP_P && acceptedCount == 0;
		var downP = controls.DOWN_P && acceptedCount == 0;
		var accepted = controls.ACCEPT && acceptedCount <= 2;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		changeDiff(0);

		if (controls.LEFT_P && acceptedCount == 0)
			changeDiff(-1);
		if (controls.RIGHT_P && acceptedCount == 0)
			changeDiff(1);

		artistText.x = curSongSelected.x;
		artistText.y = curSongSelected.y + 75;

		if (controls.BACK && acceptedCount <= 2)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
			FlxG.switchState(new MainMenuState());
		}

		if (accepted)
		{
			acceptedCount++;

			if(acceptedCount <= 2)
				FlxG.sound.play(Paths.sound('confirmMenu'));

			songSelected = true;

			FlxFlicker.flicker(curSongSelected, 0.5, 0.06, false, false, function(flick:FlxFlicker)
			{
				
			});

			FlxTween.tween(mainSelectCam, {x: -1.0 * FlxG.width}, 0.5);
		}

		if(songSelected)
		{
			selectElapsed += elapsed;
			if(selectElapsed > 2.5 && !songLoaded)
			{
				songLoaded = true;
				var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);

				#if debug
				trace(poop);
				#end

				PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
				trace('jsonloaded');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = curDifficulty;

				PlayState.storyWeek = songs[curSelected].week;
				#if debug
				trace('CUR WEEK' + PlayState.storyWeek);
				#end
				
				PlayState.SMSONG = new SMSong(songs[curSelected].songName.toLowerCase());
				PlayState.SMSONG.parseSM();
				trace('smparsed');
				trace(SMDifficulties[curDifficulty + 1]);
				trace('smdiffloaded');
			}
			if(acceptedCount == 1 && selectElapsed > 2.5)
			{
				#if debug
				trace('music time');
				#end
				LoadingState.loadAndSwitchState(new PlayState());
			}
			if(acceptedCount >= 2 && selectElapsed > 2.5 && !optionSubstateClosed)
			{
				#if debug
				trace('select options!');
				#end
				trace("subStateOpened");
				openSubState(new FNFSongOptionSubState());
			}
		}

		if(optionSubstateClosed)
		{
			optionSubstateClosed = false;
			LoadingState.loadAndSwitchState(new PlayState());
		}

		if(selectElapsed > 0.5)
		{
			timeLeftUntilSongBar.x = 0;
			timeLeftUntilSongBar.y = FlxG.height - 100.0;
			timeLeftUntilSongBar.makeGraphic(Math.ceil(FlxG.width * (selectElapsed - 0.5) / 2.0), 100, FlxColor.GREEN);
			timeLeftUntilSongBar.alpha = 1.0;
			pressEnter.alpha = 1.0;
		}
		if(selectElapsed > 2.5)
		{
			pressEnter.alpha = 0;
		}
		if(acceptedCount >= 2)
		{
			timeLeftUntilSongBar.alpha = 0.0;
			if(accepted)
			{
				FlxFlicker.flicker(pressEnter, 2.0, 0.06);
			}
		}
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if(songs[curSelected].songName.toLowerCase() == "galaxy-collapse")
		{
			if (curDifficulty < 2)
				curDifficulty = 5;
			if (curDifficulty > 5)
				curDifficulty = 2;
		}
		else 
		{
			if (curDifficulty < 0)
				curDifficulty = 2;
			if (curDifficulty > 2)
				curDifficulty = 0;
		}

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		#end

		switch (curDifficulty)
		{
			case 0:
				diffText.text = "EASY";
			case 1:
				diffText.text = 'NORMAL';
			case 2:
				diffText.text = "HARD";
			case 3:
				diffText.text = "HARDER";
			case 4:
				diffText.text = "HARDEST";
			case 5:
				diffText.text = "CATACLYSMIC";
		}
	}

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end

		// NGio.logEvent('Fresh');
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		// lerpScore = 0;
		#end

		#if PRELOAD_ALL
		FlxG.sound.playMusic(Paths.inst(songs[curSelected].songName), 0);
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				curSongSelected = item;
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}

		if(songs[curSelected].songName.toLowerCase() == "galaxy-collapse")
		{
			if (curDifficulty < 2)
				curDifficulty = 2;
			if (curDifficulty > 5)
				curDifficulty = 5;
		}
		else 
		{
			if (curDifficulty < 0)
				curDifficulty = 0;
			if (curDifficulty > 2)
				curDifficulty = 2;
		}

		artistText.text = artistNames[curSelected];
		artistText.screenCenter();
		artistText.updateHitbox();
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";

	public function new(song:String, week:Int, songCharacter:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
	}
}
