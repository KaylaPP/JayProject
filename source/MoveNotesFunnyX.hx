package;

/*
<ActorFrame><children>

	<Layer
		Type="Quad"
		InitCommand="hidden,1"
		OnCommand="sleep,1000"
	/>
	
	<Layer
		Type="Quad"
		InitCommand="hidden,1"
		OnCommand="%function(self)
				fgcurcommand = 1;
				self:queuecommand('Update');
			end"
		
		UpdateCommand="%function(self)
			
			if GAMESTATE:IsCourseMode() then
			
				if GAMESTATE:GetSongBeat()>=0 and fgcurcommand == 1 then
					SCREENMAN:GetTopScreen():GetChild('Overlay'):hidden(1);
					SCREENMAN:GetTopScreen():GetChild('Underlay'):hidden(1);
					
					if GAMESTATE:IsHumanPlayer(PLAYER_1) then
						SCREENMAN:GetTopScreen():GetChild('LifeP1'):hidden(1);
						SCREENMAN:GetTopScreen():GetChild('ScoreP1'):hidden(1);
					end
					if GAMESTATE:IsHumanPlayer(PLAYER_2) then
						SCREENMAN:GetTopScreen():GetChild('LifeP2'):hidden(1);
						SCREENMAN:GetTopScreen():GetChild('ScoreP2'):hidden(1);
					end
					
					fgcurcommand = fgcurcommand + 1;
				end
				
				
				
				
				if GAMESTATE:GetSongBeat()>=8 and fgcurcommand == 2 then
					if GAMESTATE:IsHumanPlayer(PLAYER_1) then
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(50);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.258);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.258);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.173);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.518);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.862);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.258);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.258);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.173);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.518);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.862);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.258);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.258);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.173);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.518);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.862);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(100);

						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):linear(0.345);
						SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-50);
						
					end
					if GAMESTATE:IsHumanPlayer(PLAYER_2) then
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(50);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.258);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.258);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.173);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.518);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.862);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.258);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.258);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.173);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.518);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.862);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.69);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.258);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.258);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.173);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.518);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.862);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(100);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):linear(0.345);
						SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-50);
					end
					
					fgcurcommand = fgcurcommand + 1;
				end
			
			end
			
			self:queuecommand('Update2');
			
		end"
  

		Update2Command="%function(self)
		self:sleep(0.0166666666);
		self:queuecommand('Update');
		end"
		
	/>

	
	
</children></ActorFrame>
*/

class MoveNotesFunnyX
{
    public var x:Float;
    public var startx:Float;

    private var commands:Array<PrinterCommand> = [];
    private var i:Int = -1;

    private var goOn:Bool = false;
    private var hasEverStarted:Bool = false;
    private var isFirstTime = true;

    private var totalElapsed:Float = 0.0;
    private var stopSleepTime:Float = -1.0;
    private var goalX:Float;
    private var isOnLeftSide:Bool;
    private var currentVelocity:Float = 0.0;

    public function new(startx:Float)
    {
        this.startx = startx;
        x = startx;

        commands.push(new PrinterCommand(0.69, 50, 15.172, true));
        commands.push(new PrinterCommand(0.69, -100));
        commands.push(new PrinterCommand(0.69, 100));
        commands.push(new PrinterCommand(0.69, -100));
        commands.push(new PrinterCommand(0.258, 100));
        commands.push(new PrinterCommand(0.258, -100));
        commands.push(new PrinterCommand(0.173, 100));
        commands.push(new PrinterCommand(0.518, -100));
        commands.push(new PrinterCommand(0.862, 100));
        commands.push(new PrinterCommand(0.69, -100));
        commands.push(new PrinterCommand(0.69, 100));
        commands.push(new PrinterCommand(0.69, -100));
        commands.push(new PrinterCommand(0.69, 100));
        commands.push(new PrinterCommand(0.69, -100));
        commands.push(new PrinterCommand(0.258, 100));
        commands.push(new PrinterCommand(0.258, -100));
        commands.push(new PrinterCommand(0.173, 100));
        commands.push(new PrinterCommand(0.518, -100));
        commands.push(new PrinterCommand(0.862, 100));
        commands.push(new PrinterCommand(0.69, -100));
        commands.push(new PrinterCommand(0.69, 100));
        commands.push(new PrinterCommand(0.69, -100));
        commands.push(new PrinterCommand(0.69, 100));
        commands.push(new PrinterCommand(0.69, -100));
        commands.push(new PrinterCommand(0.258, 100));
        commands.push(new PrinterCommand(0.258, -100));
        commands.push(new PrinterCommand(0.173, 100));
        commands.push(new PrinterCommand(0.518, -100));
        commands.push(new PrinterCommand(0.862, 100));
        commands.push(new PrinterCommand(0.345, -50));
        
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
            if(!goalXReached())
                x += currentVelocity * elapsed;
            if(isFirstTime || goalXReached())
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
                    x = startx;
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
        currentVelocity = command.add / command.linear;
        goalX = x + command.add;
        if(command.doSleep)
            stopSleepTime = totalElapsed + command.sleep;
        isOnLeftSide = (goalX < x);
    }

    private function goalXReached():Bool
    {
        return ((isOnLeftSide && x <= goalX) || (!isOnLeftSide && x >= goalX));
    }
}