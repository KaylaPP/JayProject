import flixel.FlxSprite;

typedef NoteLocation = 
{
    var numerator:Int;
    var denominator:Int;
    var section:Int;
}

class SMNote extends FlxSprite
{
    public var direction:Int;
    public var location:NoteLocation;
    public var sustainEnd:NoteLocation;
    public var noteType:Int;
    public var hasSustain:Bool = false;

    public function new(direction:Int, location:NoteLocation, ?sustainEnd:NoteLocation = {numerator:0, denominator:0, section:0}, ?noteType:Int = 0)
    {
        super();

        this.direction = direction;
        this.location = location;
        this.sustainEnd = sustainEnd;
        if(sustainEnd.denominator > 0)
            hasSustain = true;
        this.noteType = noteType;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}