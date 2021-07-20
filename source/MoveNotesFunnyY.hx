class MoveNotesFunnyY
{
    public var y:Float;
    public var starty:Float;

    private var commands:Array<PrinterCommand> = [];
    private var i:Int = -1;

    private var goOn:Bool = false;
    private var hasEverStarted:Bool = false;
    private var isFirstTime = true;

    private var totalElapsed:Float = 0.0;
    private var stopSleepTime:Float = -1.0;
    private var goalY:Float;
    private var isBelow:Bool;
    private var currentVelocity:Float = 0.0;

    public function new(starty:Float)
    {
        this.starty = starty;
        y = starty;

        commands.push(new PrinterCommand(0.259, 270, 37.586, true, true));
        commands.push(new PrinterCommand(0.345, starty, 0, false, true));
        commands.push(new PrinterCommand(0.344, 270, 0, false, true));
        commands.push(new PrinterCommand(0.345, starty, 0, false, true));
        commands.push(new PrinterCommand(0.345, 270, 0, false, true));
        commands.push(new PrinterCommand(0.431, starty, 0, false, true));
        commands.push(new PrinterCommand(0.345, 270, 0, false, true));
        commands.push(new PrinterCommand(0.345, starty, 0, false, true));
        commands.push(new PrinterCommand(0.258, 270, 0, false, true));
        commands.push(new PrinterCommand(0.259, starty, 0, false, true));
        commands.push(new PrinterCommand(0.086, 270, 0, false, true));
        commands.push(new PrinterCommand(0.086, starty, 0, false, true));
        commands.push(new PrinterCommand(0.518, 270, 0, false, true));
        commands.push(new PrinterCommand(0.086, starty, 0, false, true));
        commands.push(new PrinterCommand(0.086, 270, 0, false, true));
        commands.push(new PrinterCommand(0.517, starty, 0, false, true));
        commands.push(new PrinterCommand(0.087, 270, 0, false, true));
        commands.push(new PrinterCommand(0.086, starty, 0, false, true));
        commands.push(new PrinterCommand(0.345, 270, 0, false, true));
        commands.push(new PrinterCommand(0.344, starty, 0, false, true));
        commands.push(new PrinterCommand(0.259, 270, 0, false, true));
        commands.push(new PrinterCommand(0.345, starty, 0, false, true));
        commands.push(new PrinterCommand(0.345, 270, 0, false, true));
        commands.push(new PrinterCommand(0.431, starty, 0, false, true));
        commands.push(new PrinterCommand(0.258, 270, 0, false, true));
        commands.push(new PrinterCommand(0.431, starty, 0, false, true));
        commands.push(new PrinterCommand(0.259, 270, 0, false, true));
        commands.push(new PrinterCommand(0.431, starty, 0, false, true));
        commands.push(new PrinterCommand(0.259, 270, 0, false, true));
        commands.push(new PrinterCommand(0.258, starty, 0, false, true));
        commands.push(new PrinterCommand(0.087, 270, 0, false, true));
        commands.push(new PrinterCommand(0.086, starty, 0, false, true));
        commands.push(new PrinterCommand(0.517, 270, 0, false, true));
        commands.push(new PrinterCommand(0.086, starty, 0, false, true));
        commands.push(new PrinterCommand(0.086, 270, 0, false, true));
        commands.push(new PrinterCommand(0.518, starty, 0, false, true));
        commands.push(new PrinterCommand(0.258, 270, 0, false, true));
        commands.push(new PrinterCommand(0.259, starty, 0, false, true));
        commands.push(new PrinterCommand(0.345, 270, 0, false, true));
        commands.push(new PrinterCommand(0.258, starty, 0, false, true));
        commands.push(new PrinterCommand(0.431, 270, 0, false, true));
        commands.push(new PrinterCommand(0.259, starty, 0, false, true));
        commands.push(new PrinterCommand(0.431, 270, 0, false, true));
        commands.push(new PrinterCommand(0.259, starty, 0, false, true));
        commands.push(new PrinterCommand(0.431, 270, 0, false, true));
        commands.push(new PrinterCommand(0.344, starty, 0, false, true));
        commands.push(new PrinterCommand(0.345, 270, 0, false, true));
        commands.push(new PrinterCommand(0.259, starty, 0, false, true));
        commands.push(new PrinterCommand(0.259, 270, 0, false, true));
        commands.push(new PrinterCommand(0.086, starty, 0, false, true));
        commands.push(new PrinterCommand(0.086, 270, 0, false, true));
        commands.push(new PrinterCommand(0.517, starty, 0, false, true));
        commands.push(new PrinterCommand(0.086, 270, 0, false, true));
        commands.push(new PrinterCommand(0.087, starty, 0, false, true));
        commands.push(new PrinterCommand(0.517, 270, 0, false, true));
        commands.push(new PrinterCommand(0.086, starty, 0, false, true));
        commands.push(new PrinterCommand(0.086, 270, 0, false, true));
        commands.push(new PrinterCommand(0.259, starty, 0, false, true));
        commands.push(new PrinterCommand(0.431, 270, 0, false, true));
        commands.push(new PrinterCommand(0.172, starty, 0, false, true));
        commands.push(new PrinterCommand(0.518, 270, 0, false, true));
        commands.push(new PrinterCommand(0.258, starty, 0, false, true));
        commands.push(new PrinterCommand(0.431, 270, 0, false, true));
        commands.push(new PrinterCommand(0.259, starty, 0, false, true));
        commands.push(new PrinterCommand(0.431, 270, 0, false, true));
        commands.push(new PrinterCommand(0.259, starty, 0, false, true));
        commands.push(new PrinterCommand(0.344, 270, 0, false, true));
        commands.push(new PrinterCommand(0.259, starty, 0, false, true));
        commands.push(new PrinterCommand(0.259, 270, 0, false, true));
        commands.push(new PrinterCommand(0.258, starty, 0, false, true));
        commands.push(new PrinterCommand(0.345, 270, 0, false, true));
        commands.push(new PrinterCommand(0.258, starty, 0, false, true));
    }

    public function update(elapsed:Float)
    {
        if(hasEverStarted)
        {
            totalElapsed += elapsed;
            if(totalElapsed < stopSleepTime)
                goOn = false;
            else
                goOn = true;
        }
        if(goOn)
        {
            if(!goalYReached())
                y += currentVelocity * elapsed;
            if(isFirstTime || goalYReached())
            {
                isFirstTime = false;
                i++;
                #if debug
trace('new i value:');
#end
                #if debug
trace(i);
#end
                if(i < commands.length)
                {
                    runCommand(commands[i]);
                }
                else
                {
                    y = starty;
                    hasEverStarted = false;
                    goOn = false;
                }
            }
        }
    }

    public function getSilly():Void
    {
        goOn = true;
        hasEverStarted = true;
    }

    public function isSilly():Bool
    {
        return goOn;
    }

    private function runCommand(command:PrinterCommand):Void 
    {
        if(!command.addIsGoal)
        {
            goalY = y + command.add;
            currentVelocity = command.add / command.linear;
        }
        else
        {
            goalY = command.add;
            currentVelocity = (command.add - y) / command.linear;
        }
        if(command.doSleep)
            stopSleepTime = totalElapsed + command.sleep;
        isBelow = (y > goalY);
    }

    private function goalYReached():Bool
    {
        return ((isBelow && y <= goalY) || (!isBelow && y >= goalY));
    }
}