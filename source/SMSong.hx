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
    public var difficulty:String;
    public static var possibleDifficulties:Array<String>;
    public static var possibleNotes:String = "01234M";

    public function new(songFileName:String)
    {
        this.songFileName = songFileName;

        possibleDifficulties = new Array<String>();
        possibleDifficulties.push("Edit");      // Edit (can be any difficulty)
        possibleDifficulties.push("Challenge"); // Expert
        possibleDifficulties.push("Hard");      // Hard
        possibleDifficulties.push("Medium");    // Medium
        possibleDifficulties.push("Easy");      // Easy
        possibleDifficulties.push("Beginner");  // Novice
    }

    public function parseSM(difficulty:String):Void
    {
        var SMString = File.getContent("assets/stepmania/" + songFileName + "/" + songFileName +  ".sm");
        SMString = strReplace(SMString, "\r\n", "\n");

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

        loadDifficulty(SMString, difficulty);

        trace(metadata);
    }

    private function loadDifficulty(SMString:String, difficulty:String):Void
    {
        var NOTES:String = "";
        if(possibleDifficulties.indexOf(difficulty) == -1 || SMString.indexOf(difficulty) == -1)
        {
            // load first available difficulty
            NOTES = getFeature(SMString, "NOTES");
            for(dif in possibleDifficulties)
            {
                if(NOTES.indexOf(dif) != -1)
                {
                    this.difficulty = dif;
                    break;
                }
            }
            trace("\n"+NOTES);
        }
        else
        {
            NOTES = SMString.substr(0, SMString.indexOf(difficulty));
            NOTES = getFeature(SMString.substr(NOTES.lastIndexOf("#NOTES")), "NOTES");
            trace("\n"+NOTES);
        }

        // skip over random attributes and go straight into the chart
        var colonCount:Int = 0;
        var CHART:String = "";
        for(i in 0...NOTES.length)
        {
            if(colonCount >= 5)
            {
                CHART = NOTES.substr(i);
                break;
            }
            if(NOTES.charAt(i) == ":")
            {
                colonCount += 1;
            }
        }

        // Turn chart into notes on a screen (very exciting)
        trace(CHART);
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

    public static function strReplace(str:String, pattern:String, newpattern:String):String
    {
        while(str.indexOf(pattern) != -1)
        {
            str = str.substr(0, str.indexOf(pattern)) + newpattern + str.substr(str.indexOf(pattern) + pattern.length);
        }
        return str;
    }
}