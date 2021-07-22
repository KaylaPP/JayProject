import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxSound;

enum SMNoteColor
{
    RED;
    BLUE;
    PURPLE;
    GREEN;
    ORANGE;
    PINK;
    CYAN;
    GRAY;
}

class SMNote extends FlxSprite
{
    public static var colors:Array<String> = ['orange', 'magenta', 'gray', 'purple', 'red', 'blue', 'green', 'cyan'];
	public static var anim:Array<String> = ['left arrow', 'up arrow', 'down arrow', 'right arrow', 'hold end', 'hold piece'];

    public var direction:Int;
    public var numerator:Int;
    public var denominator:Int;
    public var section:Int;
    public var smcolor:SMNoteColor = GRAY;
    public var strumTime:Float;
    public var noteType:String;

    public var rootNote:SMNote;
    public var sustainPiece:SMNote;
    public var sustainEnd:SMNote;

    public var timeProcessed = false;

    public var wasGoodHit:Bool = false;
    public var dead:Bool = false;
    public var canBeHit:Bool = false;

    public var startY:Float = 0.0;

    public var currentSong:SMSong;

    public function new(currentSong:SMSong, direction:Int, numerator:Int, denominator:Int, section:Int, noteType:String, ?rootNote:SMNote = null, ?sustainPiece:SMNote = null, ?sustainEnd:SMNote = null)
    {
        super();

        this.currentSong = currentSong;
        this.direction = direction;
        this.numerator = numerator;
        this.denominator = denominator;
        this.section = section;
        this.noteType = noteType;
        this.rootNote = rootNote;
        this.sustainPiece = sustainPiece;
        this.sustainEnd = sustainEnd;
        #if debug
        if(numerator == denominator)
        {
            trace('big bad');
        }
        #end
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        var noteDiff:Float = Math.abs(strumTime - currentSong.elapsedTime);
        if(noteDiff < Conductor.safeZoneOffset)
            canBeHit = true;
        else 
            canBeHit = false;
        
        if(((y < 50 && !dead && noteType != 'M') || (y < 100 && !dead && noteType == '3')) && !currentSong.mustPressSong)
        {
            goodHit();
        }
    }

    // returns hit rating
    public function goodHit():String
    {
        trace('goodhit');
        if(noteType != '3' && noteType != '0')
        {
            #if debug
            trace('tick ' + getBeat());
            #end
            FlxG.sound.play(Paths.sound('OPENITG_tick', 'shared'));
        }
        if(noteType != '0')
        {
            visible = false;
            dead = true;
            wasGoodHit = true;
            this.kill();
        }
        return 'shit';
    }

    public function getBeat():Float
    {
        return 4.0 * (this.section + (this.numerator / this.denominator));
    }

    public function generateSprite(useSMTheme = true):Void
    {
        if(useSMTheme && noteType != 'M')
        {
            frames = Paths.getSparrowAtlas('SM_NOTE_assets', 'shared');
            for(i in 0...48)
            {
                animation.addByPrefix(colors[Math.floor(i / 6)] + ' ' + anim[i % 6], colors[Math.floor(i / 6)] + ' ' + anim[i % 6]);
            }

            if(noteType != '3' && noteType != '0')
            {
                if(Math.floor(getBeat() * 48) == Math.ceil(getBeat() * 48))
                    smcolor = GRAY;
                if(Math.floor(getBeat() * 16) == Math.ceil(getBeat() * 16))
                    smcolor = CYAN;
                if(Math.floor(getBeat() * 12) == Math.ceil(getBeat() * 12))
                    smcolor = PINK;
                if(Math.floor(getBeat() * 8) == Math.ceil(getBeat() * 8))
                    smcolor = ORANGE;
                if(Math.floor(getBeat() * 6) == Math.ceil(getBeat() * 6))
                    smcolor = PURPLE;
                if(Math.floor(getBeat() * 4) == Math.ceil(getBeat() * 4))
                    smcolor = GREEN;
                if(Math.floor(getBeat() * 3) == Math.ceil(getBeat() * 3))
                    smcolor = PURPLE;
                if(Math.floor(getBeat() * 2) == Math.ceil(getBeat() * 2))
                    smcolor = BLUE;
                if(Math.floor(getBeat()) == Math.ceil(getBeat()))
                    smcolor = RED;
            }
            else
            {
                smcolor = rootNote.smcolor;
            }


            var suffix:String = "";
            if(noteType == '3')
                suffix = "hold end";
            else if(noteType == '0')
                suffix = "hold piece";
            else if(noteType == '1' || noteType == '2')
            {
                switch(direction)
                {
                    case 0:
                        suffix += "left ";
                    case 1: 
                        suffix += "down ";
                    case 2:
                        suffix += "up ";
                    case 3: 
                        suffix += "right ";
                }
                suffix += "arrow";
            }

            var prefix:String = "gray";

            switch(smcolor)
            {
                default: 
                    prefix = "gray";
                case RED:
                    prefix = "red";
                case BLUE:
                    prefix = "blue";
                case PURPLE:
                    prefix = "purple";
                case GREEN:
                    prefix = "green";
                case ORANGE: 
                    prefix = "orange";
                case PINK: 
                    prefix = "pink";
                case CYAN: 
                    prefix = "cyan";
                case GRAY: 
                    prefix = "gray";
            }

            animation.play(prefix + ' ' + suffix);
        }
        else
        {
            frames = Paths.getSparrowAtlas('NOTE_assets', 'shared');

            animation.addByPrefix('bomb', 'bomb');

            animation.addByPrefix('greenScroll', 'green0');
            animation.addByPrefix('redScroll', 'red0');
            animation.addByPrefix('blueScroll', 'blue0');
            animation.addByPrefix('purpleScroll', 'purple0');

            animation.addByPrefix('purpleholdend', 'pruple end hold');
            animation.addByPrefix('greenholdend', 'green hold end');
            animation.addByPrefix('redholdend', 'red hold end');
            animation.addByPrefix('blueholdend', 'blue hold end');

            animation.addByPrefix('purplehold', 'purple hold piece');
            animation.addByPrefix('greenhold', 'green hold piece');
            animation.addByPrefix('redhold', 'red hold piece');
            animation.addByPrefix('bluehold', 'blue hold piece');

            if(noteType == 'M')
            {
                animation.play('bomb');
            }
            else 
            {
                switch(direction)
                {
                    case 0:
                        animation.play('purpleScroll');
                    case 1:
                        animation.play('blueScroll');
                    case 2:
                        animation.play('greenScroll');
                    case 3:
                        animation.play('redScroll');
                }
            }
        }
        updateHitbox();
        setGraphicSize(Std.int(width * 0.7));
        updateHitbox();
        antialiasing = true;

        x = 417 + 160 * direction * 0.7;

        if(noteType == '0' || noteType == '3')
        {
            x += 35;
        }
        if(noteType == '0')
        {
            flipY = true;
            startY += rootNote.height / 2;
        }
        if(noteType == '3')
        {
            startY += rootNote.height - height;
        }

        y = -2000;

    }
}