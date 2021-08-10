package;

import flixel.FlxG;
import flixel.FlxSprite;

using StringTools;

class DebugState extends MusicBeatState
{
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
