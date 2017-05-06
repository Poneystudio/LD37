package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;

/**
 * ...
 * @author SoKette
 */
class ExplainState extends FlxState 
{
	var _bg:FlxSprite;
	var _eplainText:FlxText;
	
	override public function create():Void
	{
		_bg = new FlxSprite(0, 0, AssetPaths.ld37_explain__png);
		
		_eplainText = new FlxText(10, 10, 200, "John really (REALLY) likes VR !\nHelp him play as long as possible ! \nDon't let his boredom, fatigue or\nhunger reach " + Reg.MAX_BEFORE_DEAD + " or he will DIE !\n\nPress Space to start...", 8);
		_eplainText.borderStyle = SHADOW;
		_eplainText.borderColor = 0xff000000;
		_eplainText.borderSize = 2;
		_eplainText.shadowOffset.x = 0.75;
		_eplainText.shadowOffset.y = 0.75;
		_eplainText.wordWrap = true;
		
		add(_bg);
		add(_eplainText);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void
	{
		control();
		
		super.update(elapsed);
	}
	
	private function control():Void
	{
		var _quit:Bool = FlxG.keys.anyJustPressed([ESCAPE]);
		var _play:Bool = FlxG.keys.anyJustPressed([SPACE]);
		
		if (_quit)
			FlxG.switchState(new MenuState());
		if (_play)
			FlxG.switchState(new PlayState());
	}
}