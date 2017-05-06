package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author SoKette
 */
class Delivery extends FlxSprite 
{
	public var done:Bool;
	public var waiting:Bool;
	
	public var hasPizza:Bool;
	
	var FUCKING_STOP:Bool;
	var timer:Int;
	
	public function new() 
	{
		super(197, 80);
		
		loadGraphic(AssetPaths.ld37_delivery__png, true, 16, 32);
		animation.add("give_pizza", [0]);
		animation.add("bye", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28], 16, false);
		animation.add("gone", [28], 16, false);
		
		waiting = false;
		done = false;
		FUCKING_STOP = false;
		hasPizza = true;
		
		timer = 0;
	}
	
	override public function update(elapsed:Float):Void
	{
		if (waiting)
		{
			animation.play("give_pizza");
		}
		
		if (done && !FUCKING_STOP)
		{
			animation.play("bye");
			FUCKING_STOP = true;
		}
		
		super.update(elapsed);
	}
	
	public function resetBoi():Void
	{
		waiting = false;
		done = false;
		FUCKING_STOP = false;
		hasPizza = true;
	}
}