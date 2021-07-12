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

        //trace(SMString.substr(0, 512) + "\n\n\n\n");

        var debugstr:String = "\n";

        debugstr += "TITLE\t" + getFeature(SMString, "TITLE") + '\n';
        debugstr += "ARTIST\t" + getFeature(SMString, "ARTIST") + '\n';
        debugstr += "OFFSET\t" + getFeature(SMString, "OFFSET") + '\n';
        debugstr += "BPMS\t" + getFeature(SMString, "BPMS") + '\n';
        debugstr += "STOPS\t" + getFeature(SMString, "STOPS") + '\n';
        trace(debugstr);
        /*
        metadata = 
        {
            TITLE:getFeature(SMString, "TITLE"), 
            ARTIST:getFeature(SMString, "ARTIST"), 
            OFFSET:0.0, 
            BPMS:new Array<SMBeat>(), 
            STOPS:new Array<SMBeat>()
        };*/
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
            //trace("feature " + feature + " found!");
            //trace(startIndex);
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
                            if(feature == "#STOPS")
                                trace(tempstr);
                        }
                        else
                        {
                            return tempstr;
                        }
                    }
                }
                if(!letsGo && SMString.charAt(i) == ':')
                {
                    //trace("let's go!");
                    letsGo = true;
                }
            }
        }

        return "semicolon not found";
    }
}
