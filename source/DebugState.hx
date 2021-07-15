package;

import flixel.FlxG;

using StringTools;

class DebugState extends MusicBeatState
{
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

		FlxG.sound.playMusic(Paths.inst("flight-of-the-bumblebee"), 1, false);

		super.create();
	}

	override function update(elapsed:Float)
	{
		if(FlxG.keys.pressed.ESCAPE || FlxG.keys.justPressed.ENTER)
			FlxG.switchState(new TitleState());

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

	function truncateFloat( number : Float, precision : Int): Float 
	{
		var num = number;
		num = num * Math.pow(10, precision);
		num = Math.round( num ) / Math.pow(10, precision);
		return num;
	}
}
