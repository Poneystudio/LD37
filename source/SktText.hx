package;

import flixel.text.FlxText;

/**
 * ...
 * @author SoKette
 */

class SktText extends FlxText 
{
	public function new(Text:String, Size:Int=8) 
	{	
		super(Text, Size);
		
		new FlxText();
		this.text = Text;
		this.size = Size;
		this.screenCenter();
		this.borderStyle = SHADOW;
		this.borderColor = 0xff222222;
		this.borderSize = Size / 4;
		this.shadowOffset.x = 0.75;
		this.shadowOffset.y = 0.75;
	}
	
}