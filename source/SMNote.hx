import flixel.FlxSprite;

typedef NoteLocation = 
{
    var numerator:Int;
    var denominator:Int;
    var section:Int;
}

typedef SMMetadata =
{
    var TITLE:String;
    var SUBTITLE:String;
    var ARTIST:String;
    var TITLETRANSLIT:String;
    var SUBTITLETRANSLIT:String;
    var ARTISTTRANSLIT:String;
    var GENRE:String;
    var CREDIT:String;
    var OFFSET:Float;
    var SAMPLESTART:Float;
    var SAMPLELENGTH:Float;
    var SELECTABLE:Bool;
    var BPMS:Array<Float>;
    var STOPS:Int; // change this data type
}

class SMNote extends FlxSprite
{
    public var direction:Int;
    public var location:NoteLocation;
    public var sustainEnd:NoteLocation;
    public var hasSustain:Bool = false;

    public function new(direction:Int, location:NoteLocation, sustainEnd:NoteLocation)
    {
        super();

        this.direction = direction;
        this.location = location;
        this.sustainEnd = sustainEnd;
        if(sustainEnd.denominator > 0)
            hasSustain = true;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}