package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author SoKette
 */
class Door extends FlxSprite 
{
	public var opened:Bool;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		opened = false;
		
		loadGraphic(AssetPaths.ld37_door__png, true, 53, 58);
		animation.add("closed", [0]);
		animation.add("open", [1]);
	}
	
}