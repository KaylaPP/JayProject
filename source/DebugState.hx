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
		song = new SMSong("grass-skirt-crowdkill");
		song.parseSM();
		song.loadDifficulty("Hard");

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
