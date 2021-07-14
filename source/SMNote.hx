import flixel.FlxSprite;

class SMNote extends FlxSprite
{
    public var direction:Int;
    public var numerator:Int;
    public var denominator:Int;
    public var section:Int;
    public var strumTime:Float;
    public var noteType:String;
    public var hasSustain:Bool = false;
    public var sustainEnd:SMNote;

    private var currentSong:SMSong;

    public function new(currentSong:SMSong, direction:Int, numerator:Int, denominator:Int, section:Int, noteType:String)
    {
        super();

        this.currentSong = currentSong;
        this.direction = direction;
        this.numerator = numerator;
        this.denominator = denominator;
        this.section = section;
        this.noteType = noteType;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    }

    public function addSustain(sustainEnd:SMNote):Void
    {
        this.sustainEnd = sustainEnd;
    }

    public function setScreenPosition(startX:Int, centerScroll:Bool, scrollSpeedMultiplier:Int, ?isEnemyNote:Bool = false):Void
    {
        //
    }

    public function setStrumTime(strumTime:Float):Void
    {
        this.strumTime = strumTime;
    }
}