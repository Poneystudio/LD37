package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;

/**
 * ...
 * @author SoKette
 */
class DeadState extends FlxState 
{
	var _bg:FlxSprite;
	var _deadTxt:SktText;
	var _finalScore:SktText;
	var _pressR:SktText;
	
	override public function create():Void
	{
		_bg = new FlxSprite(0, 0);
		_bg.makeGraphic(FlxG.width, FlxG.height, 0xff333643);
		_deadTxt = new SktText("You killed John. git gud.", 16);
		_deadTxt.y -= 40;
		_finalScore = new SktText("Final Score : " + Reg.SCORE, 8);
		_pressR = new SktText("Press [r] to replay", 8);
		_pressR.y += 20;
		
		add(_bg);
		add(_deadTxt);
		add(_finalScore);
		add(_pressR);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void
	{
		control();
		
		super.update(elapsed);
	}
	
	private function control():Void
	{
		if (FlxG.keys.anyJustPressed([R]))
		{
			FlxG.switchState(new PlayState());
		}
		if (FlxG.keys.anyJustPressed([ESCAPE]))
		{
			FlxG.switchState(new MenuState());
		}
	}
	
}