package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import openfl.Lib;

class MenuState extends FlxState
{
	var _titleBg:FlxSprite;
	var _titleTxt1:FlxText;
	var _titleTxt2:FlxText;
	
	var _credit1:FlxText;
	var _credit2:FlxText;
	
	
	override public function create():Void
	{
		#if html5
		FlxG.mouse.visible = false;
		#end
		
		_titleBg = new FlxSprite(0, 0, "assets/images/ld37_title_screen.png");
		add(_titleBg);
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		titleControl();
		
		super.update(elapsed);
	}
	
	private function titleControl():Void
	{
		//var _quit:Bool = FlxG.keys.anyJustPressed([ESCAPE]);
		//var _play:Bool = FlxG.keys.anyJustPressed([SPACE]);
		
		//if (_quit)
			//#if desktop
			//Lib.close();
			//#end
		if (FlxG.keys.anyJustPressed([SPACE]))
			FlxG.switchState(new ExplainState());
	}
}