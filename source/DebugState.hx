//ShowStatState
package;

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
    var testSprite:FlxSprite;
    var upperSprite:FlxSprite;
    var amount:Float = 120.0;

    var scaletext:FlxText;
    var heighttext:FlxText;

    public function new()
    {
        super();
    }

	override public function create():Void
	{
		super.create();

        testSprite = new FlxSprite(0, 0);
        testSprite.frames = Paths.getSparrowAtlas('NOTE_assets', 'shared');
        testSprite.animation.addByPrefix('piece', 'green hold piece');
        testSprite.animation.play('piece');
        add(testSprite);
        testSprite.screenCenter();

        upperSprite = new FlxSprite(0, 0);
        upperSprite.frames = Paths.getSparrowAtlas('NOTE_assets', 'shared');
        upperSprite.animation.addByPrefix('end', 'green hold end');
        upperSprite.animation.play('end');
        add(upperSprite);
        upperSprite.screenCenter();

        scaletext = new FlxText(0, 0, 0, "");
        add(scaletext);

        heighttext = new FlxText(0, 10, 0, "");
        add(heighttext);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
        if(FlxG.keys.pressed.ESCAPE)
            FlxG.switchState(new TitleState());
        if(FlxG.keys.pressed.UP)
            upperSprite.y += amount * elapsed;
        if(FlxG.keys.pressed.DOWN)
            upperSprite.y -= amount * elapsed;
        testSprite.scale.y = upperSprite.y - testSprite.y;
        testSprite.screenCenter();
        testSprite.y = FlxG.height / 2;
        testSprite.updateHitbox();

        upperSprite.x = testSprite.x;

        scaletext.text = "SCALE: " + testSprite.scale.y;
        heighttext.text = "HEIGHT: " + testSprite.height;
	}

	function truncateFloat( number : Float, precision : Int): Float 
	{
		var num = number;
		num = num * Math.pow(10, precision);
		num = Math.round( num ) / Math.pow(10, precision);
		return num;
	}

}
