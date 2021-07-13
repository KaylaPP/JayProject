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

    public function new(direction:Int, numerator:Int, denominator:Int, section:Int, noteType:String)
    {
        super();

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

    public function addSustain(sustainEnd:SMNote)
    {
        this.sustainEnd = sustainEnd;
    }

    public function setStrumTime(strumTime:Float)
    {
        this.strumTime = strumTime;
    }
}