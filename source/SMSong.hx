package;

import FreeplayState.SongMetadata;
import sys.io.File;

typedef SMBeat =
{
    var BEAT:Float;
    var VAL:Float; // can be used for stops or bpm changes
}

typedef SMMetadata = 
{
    var TITLE:String;
    var ARTIST:String;
    var OFFSET:Float;
    var BPMS:Array<SMBeat>;
    var STOPS:Array<SMBeat>;
}

class SMSong
{
    public var sections:Array<SMSection>;
    public var metadata:SMMetadata;
    public var songFileName:String;

    public function new(songFileName:String)
    {
        this.songFileName = songFileName;
    }

    public function parseSM():Void
    {
        var SMString = File.getContent("assets/stepmania/" + songFileName + "/" + songFileName +  ".sm");

        var debugstr:String = "\n";

        debugstr += "TITLE\t" + getFeature(SMString, "TITLE") + '\n';
        debugstr += "ARTIST\t" + getFeature(SMString, "ARTIST") + '\n';
        debugstr += "OFFSET\t" + getFeature(SMString, "OFFSET") + '\n';
        debugstr += "BPMS\t" + getFeature(SMString, "BPMS") + '\n';
        debugstr += "STOPS\t" + getFeature(SMString, "STOPS") + '\n';
        //trace(debugstr);

        metadata = 
        {
            TITLE:getFeature(SMString, "TITLE"), 
            ARTIST:getFeature(SMString, "ARTIST"), 
            OFFSET:truncateFloat(Std.parseFloat(getFeature(SMString, "OFFSET")), 3), 
            BPMS:getSMBeats(getFeature(SMString, "BPMS")), 
            STOPS:getSMBeats(getFeature(SMString, "STOPS"))
        };

        trace(metadata);
    }

    private function getFeature(SMString:String, feature:String):String
    {
        feature = "#" + feature;
        var tempstr:String = "";
        var startIndex:Int = SMString.indexOf(feature);

        if(startIndex < 0)
        {
            return "feature not found";
        }
        else
        {
            var letsGo:Bool = false;
            for(i in startIndex...SMString.length)
            {
                if(letsGo)
                {
                    if(SMString.charAt(i) != '\n')
                    {
                        if(SMString.charAt(i) != ';')
                        {
                            tempstr += SMString.charAt(i);
                        }
                        else
                        {
                            return tempstr;
                        }
                    }
                }
                if(!letsGo && SMString.charAt(i) == ':')
                {
                    letsGo = true;
                }
            }
        }

        return "semicolon not found";
    }

    private function getSMBeats(rawBeat:String):Array<SMBeat>
    {
        var SMBeatsStr:Array<String> = new Array<String>();
        var tempstr:String = "";
        for(i in 0...rawBeat.length)
        {
            if(rawBeat.charAt(i) != ',')
            {
                tempstr += rawBeat.charAt(i);
            }
            else // rawBeat.charAt(i) == ',' || rawBeat.charAt(i) == ';'
            {
                SMBeatsStr.push(tempstr);
                tempstr = "";
            }
        }
        if(tempstr != "")
        {
            SMBeatsStr.push(tempstr);
            tempstr = "";
        }

        var SMBeats:Array<SMBeat> = new Array<SMBeat>();
        var BEAT:Float = 0.0;
        var VAL:Float = 0.0;
        for(beat in SMBeatsStr)
        {
            var first:Bool = true;

            for(i in 0...beat.length)
            {
                if(beat.charAt(i) != '=')
                {
                    tempstr += beat.charAt(i);
                }
                else // beat.charAt(i) == '='
                {
                    first = false;

                    // turn str into float
                    BEAT = Std.parseFloat(tempstr);

                    tempstr = "";
                }
            }
            VAL = Std.parseFloat(tempstr);

            SMBeats.push({ BEAT:truncateFloat(BEAT, 3), VAL:truncateFloat(VAL, 3) });
        }

        return SMBeats;
    }

    public static function truncateFloat( number : Float, precision : Int): Float 
    {
        var num = number;
        num = num * Math.pow(10, precision);
        num = Math.floor( num ) / Math.pow(10, precision);
        return num;
    }
}