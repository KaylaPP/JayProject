package;

typedef SMMetadata =
{
    var TITLE:String;
    var SUBTITLE:String;
    var ARTIST:String;
    var GENRE:String;
    var CREDIT:String;
    var OFFSET:Float;
    var SAMPLESTART:Float;
    var SAMPLELENGTH:Float;
    var SELECTABLE:Bool;
    var BPMS:Array<Float>;
    var STOPS:Int; // change this data type
}

class SMSong
{
    public var sections:Array<SMSection>;
    public var metadata:SMMetadata;

    public function new()
    {
        
    }
}