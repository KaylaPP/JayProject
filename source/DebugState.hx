package;

import sys.io.File;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;

#if desktop
import Discord.DiscordClient;
#end

using StringTools;

class DebugState extends MusicBeatState
{
    public function new()
    {
        #if sys
        trace("you can read SM files!");
        #end

        super();
    }

	override public function create():Void
	{
		var song:String = "grass-skirt-crowdkill";
        var SMString = File.getContent("assets/stepmania/" + song + "/" + song +  ".sm");
		var SMContent:Array<String> = new Array<String>();

		var tempstr:String = "";
		for(i in 0...SMString.length)
		{
			if(SMString.charAt(i) != '\n')
			{
				tempstr += SMString.charAt(i);
			}
			else
			{
				SMContent.push(tempstr);
				tempstr = "";
			}
		}

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
