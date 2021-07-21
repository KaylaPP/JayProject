package;

import haxe.Timer;
import FreeplayState.SongMetadata;
import sys.io.File;
import flixel.FlxG;
import flixel.util.FlxSort;

typedef SMBeat =
{
    var TIME:Float; // possibly not needed
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
    private var SMString:String;
    public var notes:Array<SMNote>;
    public var metadata:SMMetadata;
    public var songFileName:String;
    public var difficulty:String;

    public var prevCurStep:Float = 0.0;
    public var curStep:Float = 0.0;
    public var elapsedTime:Float = 0.0;
    public var velocityCoefficient:Float = 4.0;
    public var pixelCoefficient:Float = 120.0;
    public var useSMTheme:Bool;

    private var timer:Timer;
    public var songActive:Bool = false;
    public var songLoaded:Bool = false;

    public static var possibleDifficulties:Array<String>;
    public static var possibleNotes:String = "01234M";

    public var playstate:PlayState;

    public function new(songFileName:String)
    {
        this.songFileName = songFileName;

        notes = new Array<SMNote>();

        possibleDifficulties = new Array<String>();
        possibleDifficulties.push("Edit");      // Edit (can be any difficulty)
        possibleDifficulties.push("Challenge"); // Expert
        possibleDifficulties.push("Hard");      // Hard
        possibleDifficulties.push("Medium");    // Medium
        possibleDifficulties.push("Easy");      // Easy
        possibleDifficulties.push("Beginner");  // Novice
    }

    public function parseSM():Void
    {
        SMString = File.getContent("assets/data/" + songFileName + "/" + songFileName +  ".sm");
        SMString = strReplace(SMString, "\r\n", "\n");
        #if debug
        trace('strreplaced');
        #end

        var debugstr:String = "\n";

        debugstr += "TITLE\t" + getFeature(SMString, "TITLE") + '\n';
        debugstr += "ARTIST\t" + getFeature(SMString, "ARTIST") + '\n';
        debugstr += "OFFSET\t" + getFeature(SMString, "OFFSET") + '\n';
        debugstr += "BPMS\t" + getFeature(SMString, "BPMS") + '\n';
        debugstr += "STOPS\t" + getFeature(SMString, "STOPS") + '\n';
        #if debug
        trace(debugstr);
        #end

        metadata = 
        {
            TITLE:getFeature(SMString, "TITLE"), 
            ARTIST:getFeature(SMString, "ARTIST"), 
            OFFSET:truncateFloat(Std.parseFloat(getFeature(SMString, "OFFSET")), 3), 
            BPMS:getSMBeats(getFeature(SMString, "BPMS")), 
            STOPS:getSMBeats(getFeature(SMString, "STOPS"))
        };

        metadata.BPMS.sort((a, b) -> Std.int(a.BEAT - b.BEAT));
        metadata.STOPS.sort((a, b) -> Std.int(a.BEAT - b.BEAT));

        for(i in 0...metadata.BPMS.length - 1)
        {
            metadata.BPMS[i + 1].TIME = 60000.0 * (metadata.BPMS[i + 1].BEAT - metadata.BPMS[i].BEAT) / (metadata.BPMS[i].VAL) + metadata.BPMS[i].TIME;
        }
        // remove duplicates
        while(false)
        {
            var breakFromWhile:Bool = true;
            var breakFromFor:Bool = false;
            for(i in 0...metadata.BPMS.length)
            {
                for(j in 0...metadata.BPMS.length)
                {
                    if(i != j && metadata.BPMS[i].BEAT == metadata.BPMS[j].BEAT && metadata.BPMS[i].VAL == metadata.BPMS[j].VAL && metadata.BPMS[i].TIME == metadata.BPMS[j].TIME)
                    {
                        trace('i: ' + metadata.BPMS[i] + ', j: ' + metadata.BPMS[j]);
                        metadata.BPMS.remove(metadata.BPMS[i]);
                        breakFromWhile = false;
                        breakFromFor = true;
                    }
                    if(breakFromFor)
                        break;
                }
                if(breakFromFor)
                    break;
            }
            if(breakFromWhile)
                break;
        }
        trace(metadata.BPMS);

        while(true)
        {
            var breakFromWhile:Bool = true;
            var breakFromFor:Bool = false;
            for(i in 0...metadata.STOPS.length)
            {
                for(j in 0...metadata.STOPS.length)
                {
                    if(i != j && metadata.STOPS[i].BEAT == metadata.STOPS[j].BEAT && metadata.STOPS[i].VAL == metadata.STOPS[j].VAL && metadata.STOPS[i].TIME == metadata.STOPS[j].TIME)
                    {
                        metadata.STOPS.remove(metadata.STOPS[i]);
                        breakFromWhile = false;
                        breakFromFor = true;
                    }
                    if(breakFromFor)
                        break;
                }
                if(breakFromFor)
                    break;
            }
            if(breakFromWhile)
                break;
        }

        #if debug
        trace(metadata);
        #end

        elapsedTime = metadata.OFFSET * 1000.0;
        curStep = -8.0;
    }

    public function loadDifficulty(difficulty:String, ?constantScroll:Bool = false):Void
    {
        if(songLoaded)
            return;
        songLoaded = true;
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
            #if debug
            trace("\n"+NOTES);
            #end
        }
        else
        {
            NOTES = SMString.substr(0, SMString.indexOf(difficulty));
            NOTES = getFeature(SMString.substr(NOTES.lastIndexOf("#NOTES")), "NOTES");
            #if debug
            trace("\n"+NOTES);
            #end
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
        var tempstr:String = "";
        var section:Int = 0;
        var sustains:Array<SMNote> = [];
        for(i in 0...CHART.length)
        {
            if(CHART.charAt(i) != ',' && possibleNotes.indexOf(CHART.charAt(i)) != -1)
            {
                if(CHART.charAt(i) != '4')
                    tempstr += CHART.charAt(i);
                else
                    tempstr += '2';
            }
            else if(CHART.charAt(i) == ',' || i + 1 == CHART.length)
            {
                var denominator:Int = Math.floor(tempstr.length / 4);
                for(j in 0...tempstr.length)
                {
                    if(tempstr.charAt(j) != '0')
                    {
                        var jj:Float = j;
                        if(tempstr.charAt(j) != '0')
                        {
                            var newNote:SMNote = new SMNote(this, j % 4, Math.floor(jj / 4), denominator, section, tempstr.charAt(j));
                            if(newNote.noteType == '1' || newNote.noteType == '2')
                                newNote.rootNote = newNote;
                            if(newNote.noteType == '3')
                                newNote.sustainEnd = newNote;
                            notes.push(newNote);
                        }
                    }
                }
                tempstr = "";
                section += 1;
            }
        }

        // Link sustain notes
        notes.sort((a, b) -> Std.int(a.getBeat() - b.getBeat()));
        var ignoreNotes:Array<SMNote> = [];
        var endWhile:Bool = false;
        while(!endWhile)
        {
            for(i in 0...notes.length)
            {
                if(notes[i].noteType == '2' && ignoreNotes.indexOf(notes[i]) < 0)
                {
                    ignoreNotes.push(notes[i]);
                    for(j in i...notes.length)
                    {
                        if(notes[j].direction == notes[i].direction && notes[j].noteType == '3' && ignoreNotes.indexOf(notes[j]) < 0)
                        {
                            endWhile = false;
                            ignoreNotes.push(notes[j]);
                            notes[i].sustainEnd = notes[j];
                            notes[j].rootNote = notes[i];
                            var piece:SMNote = new SMNote(this, notes[i].direction, notes[i].numerator, notes[i].denominator, notes[i].section, '0', notes[i], null, notes[j]);
                            piece.sustainPiece = piece;
                            notes.push(piece);
                            notes[i].sustainPiece = piece;
                            notes[j].sustainPiece = piece;
                            notes.sort((a, b) -> Std.int(a.getBeat() - b.getBeat()));
                            break;
                        }
                        endWhile = true;
                    }
                    break;
                }
                endWhile = true;
            }
        }

        trace(notes.length);

        for(note in notes)
        {
            note.generateSprite();
            trace("w: " + note.width + "   step: " + note.getBeat() + "   type: " + note.noteType);
        }

        // create elapsed time for notes (very difficult)
        // 120 bpm -> 1/120 mpb -> 1/2 spb -> 500 mspb
        // bpm -> 1/bpm -> 60/bpm -> 60*1000/bpm = mspb

        // Place notes on the screen
        if(constantScroll)
        {
            // FNF style arrow placement
        }
        else
        {
            // SM style arrow placement
            for(i in 0...notes.length)
            {
                var note = notes[i];
                note.startY = pixelCoefficient * velocityCoefficient * note.getBeat();
                note.strumTime = metadata.OFFSET;
            }
        }
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
        trace(SMBeatsStr);
        var BEAT:Float = 0.0;
        var VAL:Float = 0.0;
        for(beat in SMBeatsStr)
        {
            trace(beat.substr(0, beat.indexOf('=')));
            BEAT = Std.parseFloat(beat.substr(0, beat.indexOf('=')));
            trace(beat.substr(beat.indexOf('=') + 1));
            VAL = Std.parseFloat(beat.substr(beat.indexOf('=') + 1));

            SMBeats.push({ TIME:0.0, BEAT:truncateFloat(BEAT, 3), VAL:truncateFloat(VAL, 3) });
        }
        trace(SMBeats);

        return SMBeats;
    }

    public function startSong():Void 
    {
        timer = new Timer(0);
        timer.run = function() 
        {
            if(songActive)
            {
                elapsedTime += 8.0; 
                prevCurStep = curStep;

                // calculate current beat
                if(metadata.BPMS.length == 1)
                {
                    curStep = metadata.BPMS[0].VAL * elapsedTime / 60000.0;
                }
                else
                {
                    var elapsedStart:Float = 0.0;
                    for(i in 0...metadata.BPMS.length)
                    {
                        if(elapsedTime > metadata.BPMS[i].TIME)
                        {
                            elapsedStart -= metadata.BPMS[i].TIME;
                            if(Math.abs(elapsedStart) > Math.abs(elapsedTime))
                            {
                                elapsedStart += metadata.BPMS[i].TIME;
                                break;
                            }
                        }
                    }
                    
                    var startBeat:SMBeat = metadata.BPMS[0];
                    for(v in metadata.BPMS)
                    {
                        if((v.TIME < elapsedTime || v.BEAT < curStep) && (v.BEAT > startBeat.BEAT || v.TIME > startBeat.TIME))
                        {
                            startBeat = v;
                        }
                    }

                    curStep = startBeat.BEAT + startBeat.VAL * (elapsedTime - startBeat.TIME) / 60000.0;
                }
            }
        }; 

        
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
        while(str.indexOf(pattern) >= 0)
        {
            str = str.substr(0, str.indexOf(pattern)) + newpattern + str.substr(str.indexOf(pattern) + pattern.length);
        }
        return str;
    }
}
