import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxSound;

class SMNote extends FlxSprite
{
    public var direction:Int;
    public var numerator:Float;
    public var denominator:Float;
    public var section:Float;
    public var strumTime:Float;
    public var noteType:String;
    public var hasSustain:Bool = false;
    public var sustainEnd:SMNote;

    public var startY:Float = 0.0;

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

        if(numerator == denominator)
            trace('big bad');

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

        setGraphicSize(Std.int(width * 0.6));
        updateHitbox();
        antialiasing = true;

        x = 300.0 + 160 * direction * 0.6;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        DebugState.doSong = true;
        
        y = startY + currentSong.pixelCoefficient * currentSong.velocityCoefficient * (getBeat() - currentSong.curStep);

        if(y < 0)
        {
            if(visible)
            {
                trace('tick ' + getBeat());
                FlxG.sound.play(Paths.sound('OPENITG_tick', 'shared'));
            }
            visible = false;
        }
    }

    public function addSustain(sustainEnd:SMNote):Void
    {
        this.sustainEnd = sustainEnd;
    }

    public function getBeat():Float
    {
        return 4.0 * (this.section + (this.numerator / this.denominator));
    }
}