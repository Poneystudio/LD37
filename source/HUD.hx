package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.ui.FlxBar;

/**
 * ...
 * @author SoKette
 */
class HUD extends FlxTypedGroup<FlxSprite>
{
	private var _scoreLabel:SktText;
	private var _scoreTxt:SktText;
	
	private var _boredLabel:SktText;
	private var _boredTxt:SktText;
	
	private var _hungryLabel:SktText;
	private var _hungryTxt:SktText;
	
	private var _tiredLabel:SktText;
	private var _tiredTxt:SktText;
	
	private var _moneyLabel:SktText;
	private var _moneyTxt:SktText;
	
	public function new() 
	{
		super();
		
		_scoreLabel = new SktText("score :", 8);
		_scoreLabel.y = 0;
		_scoreLabel.x -= 95;
		_scoreTxt = new SktText("0", 8);
		_scoreTxt.y = 0;
		_scoreTxt.x -= 70;
		
		_moneyLabel = new SktText("$", 8);
		_moneyLabel.y = 10;
		_moneyLabel.x = 5;
		_moneyTxt = new SktText("0", 8);
		_moneyTxt.y = 10;
		_moneyTxt.x = 15;
		_moneyLabel.color = _moneyTxt.color = 0xff85bb65;
		
		_boredLabel = new SktText("bored :", 8);
		_boredLabel.y = 0;
		_boredLabel.x = 180;
		_boredTxt = new SktText("0", 8);
		_boredTxt.y = 0;
		_boredTxt.x += 110;
		
		_hungryLabel = new SktText("hungry :", 8);
		_hungryLabel.y = 10;
		_hungryLabel.x = 180;
		_hungryTxt = new SktText("0", 8);
		_hungryTxt.y = 10;
		_hungryTxt.x += 110;
		
		_tiredLabel = new SktText("tired :", 8);
		_tiredLabel.y = 20;
		_tiredLabel.x = 180;
		_tiredTxt = new SktText("0", 8);
		_tiredTxt.y = 20;
		_tiredTxt.x += 110;
		
		add(_scoreLabel);
		add(_scoreTxt);
		add(_moneyLabel);
		add(_moneyTxt);
		add(_boredLabel);
		add(_boredTxt);
		add(_hungryLabel);
		add(_hungryTxt);
		add(_tiredLabel);
		add(_tiredTxt);
	}
	
	override public function update(elapsed:Float):Void
	{
		
		super.update(elapsed);
	}
	
	public function updateHUD():Void
	{
		_scoreTxt.text = Std.string(Reg.SCORE);
		_hungryTxt.text = Std.string(Reg.HUNGRY);
		_tiredTxt.text = Std.string(Reg.TIRED);
		_boredTxt.text = Std.string(Reg.BORED);
		_moneyTxt.text = Std.string(Reg.MONEY);
		
		// UPDATING HUNGER COLOR
		if (Reg.HUNGRY < 8)
		{
			_hungryLabel.color = 0xff00ff00;
			_hungryTxt.color = 0xff00ff00;
		}
		else if (Reg.HUNGRY >= 8 && Reg.HUNGRY < 15)
		{
			_hungryLabel.color = 0xffffa500;
			_hungryTxt.color = 0xffffa500;
		}
		else
		{
			_hungryLabel.color = 0xffff0000;
			_hungryTxt.color = 0xffff0000;
		}
		
		// UPDATING TIRED COLOR
		if (Reg.TIRED < 8)
		{
			_tiredLabel.color = 0xff00ff00;
			_tiredTxt.color = 0xff00ff00;
		}
		else if (Reg.TIRED >= 8 && Reg.TIRED < 15)
		{
			_tiredLabel.color = 0xffffa500;
			_tiredTxt.color = 0xffffa500;
		}
		else
		{
			_tiredLabel.color = 0xffff0000;
			_tiredTxt.color = 0xffff0000;
		}
		
		// UPDATING BORED COLOR
		if (Reg.BORED < 8)
		{
			_boredLabel.color = 0xff00ff00;
			_boredTxt.color = 0xff00ff00;
		}
		else if (Reg.BORED >= 8 && Reg.BORED < 15)
		{
			_boredLabel.color = 0xffffa500;
			_boredTxt.color = 0xffffa500;
		}
		else
		{
			_boredLabel.color = 0xffff0000;
			_boredTxt.color = 0xffff0000;
		}
	}
}