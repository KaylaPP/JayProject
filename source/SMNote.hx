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
    public var hasSustain:Bool = false;
    public var isSustain:Bool = false;
    public var prevNote:SMNote;
    public var sustainEnd:SMNote;
    public var dead:Bool = false;

    public var startY:Float = 0.0;

    private var currentSong:SMSong;

    public function new(currentSong:SMSong, direction:Int, numerator:Int, denominator:Int, section:Int, noteType:String, useSMTheme:Bool = true, prevNote:SMNote = null, sustainEnd:SMNote = null)
    {
        super();

        this.currentSong = currentSong;
        this.direction = direction;
        this.numerator = numerator;
        this.denominator = denominator;
        this.section = section;
        this.noteType = noteType;
        if(numerator == denominator)
        {
            #if debug
            trace('big bad');
            #end
        }

        if(useSMTheme)
        {
            frames = Paths.getSparrowAtlas('SM_NOTE_assets', 'shared');
            for(i in 0...48)
            {
                animation.addByPrefix(colors[Math.floor(i / 6)] + ' ' + anim[i % 6], colors[Math.floor(i / 6)] + ' ' + anim[i % 6]);
            }

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

            var suffix:String = "";

            if(isSustain)
            {
                suffix += "hold ";
                if(sustainEnd == this)
                    suffix += "end";
                else
                    suffix += "piece";
            }
            else
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
        setGraphicSize(Std.int(width * 0.7));
        updateHitbox();
        antialiasing = true;

        x = 417 + 160 * direction * 0.7;

        y = -2000;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
        
        if(y < 50 && !dead)
        {
            if(visible)
            {
                #if debug
                trace('tick ' + getBeat());
                #end
                FlxG.sound.play(Paths.sound('OPENITG_tick', 'shared'));
            }
            visible = false;
            dead = true;
            this.kill();
        }
    }

    public function goodHit()
    {

    }

    public function addSustain(sustainEnd:SMNote):Void
    {
        this.sustainEnd = sustainEnd;
    }

    public function getBeat():Float
    {
        return 4.0 * (this.section + (this.numerator / this.denominator));
    }

    public function getColor():SMNoteColor
    {
        if(SMSong.truncateFloat(getBeat(), 3) == Math.floor(getBeat()))
            return RED;

        return GRAY;
    }
}