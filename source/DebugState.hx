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
		song = new SMSong("from-nothing");
		song.parseSM();

		song = new SMSong("grass-skirt-crowdkill");
		song.parseSM();

		song = new SMSong("metronome");
		song.parseSM();

		song = new SMSong("omae-wa-mou-tiny-little-adiantum-remix");
		song.parseSM();

		song = new SMSong("smooth-criminal-pal-version");
		song.parseSM();

		song = new SMSong("the-disappearance-of-hatsune-miku");
		song.parseSM();

		super.create();
	}

	override function update(elapsed:Float)
	{
		if(FlxG.keys.justPressed.ESCAPE)
			FlxG.switchState(new TitleState());

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
