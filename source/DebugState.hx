package;

import flixel.FlxG;

using StringTools;

class DebugState extends MusicBeatState
{
    public static var doSong:Bool = false;
    public static var songLoaded:Bool = false;

	public static var totalElapsed:Float = 0.0;

	var song:SMSong;

    public function new()
    {
        #if sys
        trace("you can read SM files!");
        #end

        super();
    }

	override public function create():Void
	{
		song = new SMSong("Bumblebee");
		song.parseSM();
		song.loadDifficulty("Hard");

		for(note in song.notes)
		{
			if(note.noteType == '1' || note.noteType == '2')
				add(note);
		}

		super.create();
	}

	override function update(elapsed:Float)
	{
		totalElapsed += elapsed;
		song.curStep = elapsedAndBPMToBeat(totalElapsed, song.metadata.BPMS[0].VAL);

		if(FlxG.keys.pressed.ESCAPE || FlxG.keys.justPressed.ENTER)
			FlxG.switchState(new TitleState());

		if(doSong && !songLoaded)
		{
			songLoaded = true;
			FlxG.sound.playMusic(Paths.inst("flight-of-the-bumblebee"), 1, false);
		}

		if(FlxG.keys.pressed.UP)
		{
			for(note in song.notes)
			{
				note.y -= 500.0 * elapsed;
			}
		}
		if(FlxG.keys.pressed.DOWN)
		{
			for(note in song.notes)
			{
				note.y += 500.0 * elapsed;
			}
		}
		if(FlxG.keys.justPressed.RIGHT)
		{
			for(note in song.notes)
			{
				note.y -= 500.0;
			}
		}
		if(FlxG.keys.justPressed.LEFT)
		{
			for(note in song.notes)
			{
				note.y += 500.0;
			}
		}

		super.update(elapsed);
	}

	function getDifficulties(sm:String):Array<String>
	{
		var difficulties:Array<String> = new Array<String>();

		return difficulties;
	}

	// This function will have to be expanded much further later to accomodate variable bpm
	public static function elapsedAndBPMToBeat(elapsed:Float, BPM:Float):Float
	{
		var beat:Float = 0.0;

		beat = BPM * (elapsed / 60.0);

		return beat;
	}

	function truncateFloat( number : Float, precision : Int): Float 
	{
		var num = number;
		num = num * Math.pow(10, precision);
		num = Math.round( num ) / Math.pow(10, precision);
		return num;
	}
}
