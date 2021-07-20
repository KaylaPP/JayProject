package;

import flixel.FlxG;
import flixel.FlxSprite;

using StringTools;

class DebugState extends MusicBeatState
{
	var sprite:FlxSprite;
	var index:Int = 0; // max 48

    public function new()
    {
        #if sys
        #if debug
		trace("you can read SM files!");
		#end
        #end

        super();
    }

	override public function create():Void
	{
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.switchState(new TitleState());
	}
}
