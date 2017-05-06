package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.util.FlxTimer;

/**
 * ...
 * @author SoKette
 */
class Player extends FlxSprite 
{
	// controls
	var _use:Bool;
	var _exit:Bool;
	var _left:Bool;
	var _right:Bool;
	
	// variables
	var _speed:Float;
	var _sndWalk:FlxSound;
	var _sndPhone:FlxSound;
	var _sndSofa:FlxSound;
	var _sndDead:FlxSound;
	var _sndEat:FlxSound;
	var _timer:Float;
	var _pizzaTimer:Int;
	var _enjoyTimer:Int;
	var _restTimer:Int;
	
	// states
	public var usingSofa:Bool;
	public var usingPhone:Bool;
	public var usingPizza:Bool;
	public var pizzaType:Int;
	
	// public variables
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		// setting variables
		_timer = 0;
		_pizzaTimer = 0;
		_enjoyTimer = 0;
		_restTimer = 0;
		pizzaType = 2;
		
		usingSofa = false;
		usingPhone = false;
		usingPizza = false;
		
		// load stuff
		loadGraphic(AssetPaths.ld37_character__png, true, 16, 32);
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		animation.add("idle", [0], 12, false);
		animation.add("walk", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0], 16, false);
		animation.add("eat", [12, 13, 14, 15, 16, 17], 16, false);
		
		_sndWalk = FlxG.sound.load(AssetPaths.walk__ogg);
		_sndPhone = FlxG.sound.load(AssetPaths.phone__ogg);
		_sndSofa = FlxG.sound.load(AssetPaths.rest__ogg);
		_sndDead = FlxG.sound.load(AssetPaths.die__ogg);
		_sndEat = FlxG.sound.load(AssetPaths.eat__ogg);
		
		// offset taille des pieds
		width = 10;
		offset.x = 3;
		
		// drag,speed etc...
		drag.x = 1024;
		_speed = 32;
		
	}
	
	override public function update(elapsed:Float):Void
	{
		if (!Reg.ENDED)
		{
			playerControl();
			playSounds();
			increaseBars();
			resting();
			
			if (Reg.BORED == Reg.MAX_BEFORE_DEAD || 
				Reg.TIRED == Reg.MAX_BEFORE_DEAD || 
				Reg.HUNGRY == Reg.MAX_BEFORE_DEAD)
			{
				_sndWalk.stop();
				_sndPhone.stop();
				_sndSofa.stop();
				//_sndPizza.stop();
				_sndDead.play();
				Reg.ENDED = true;
				FlxG.camera.fade(FlxColor.BLACK, 3, false, goDeadState);
			}
		}
		
		super.update(elapsed);
	}
	
	// PRIVATE FUNCTIONS
	private function goDeadState():Void
	{
		FlxG.switchState(new DeadState());
	}
	
	private function playSounds():Void
	{
		if (usingPhone)
		{
			_sndPhone.play();
		}
		if (!usingPhone)
		{
			_sndPhone.stop();
		}
		if (usingSofa)
		{
			_sndSofa.play();
		}
		if (!usingSofa)
		{
			_sndSofa.stop();
		}
		if (usingPizza)
		{
			_sndEat.play();
			animation.play("eat");
			
			if (pizzaType == 0) // MARGHERITA
			{
				if (Reg.HUNGRY > 0)
				Reg.HUNGRY--;
				Reg.SCORE++;
				_pizzaTimer++;
				if (_pizzaTimer > 55)
				{
					_pizzaTimer = 0;
					usingPizza = false;
					Reg.BORED += 3;
				}
			}
			
			if (pizzaType == 1) // HAWAIIAN
			{
				if (Reg.HUNGRY > 0)
				Reg.HUNGRY--;
				Reg.SCORE++;
				_pizzaTimer++;
				if (_pizzaTimer > 60)
				{
					_pizzaTimer = 0;
					usingPizza = false;
				}
			}
		}
	}
	
	private function playerControl():Void
	{
		_left = FlxG.keys.anyPressed([LEFT, S]);
		_right = FlxG.keys.anyPressed([RIGHT, F]);
		_exit = FlxG.keys.anyJustPressed([ESCAPE]);
		_use = FlxG.keys.anyJustPressed([SPACE]);
		
		// MOVEMENTs
		if (!usingObject())
		{
			if (_left &&
				velocity.x > -_speed &&
				this.x > 10)
			{
				facing = FlxObject.LEFT;
				velocity.x -= _speed;
			}
			
			if (_right &&
				velocity.x < _speed &&
				this.x < 220)
			{
				facing = FlxObject.RIGHT;
				velocity.x += _speed;
			}
			
			if (velocity.x != 0)
			{
				animation.play("walk");
				_sndWalk.play();
				if (_enjoyTimer > 40)
				{
					enjoyVR();
					_enjoyTimer = 0;
				}
				else
				{
					_enjoyTimer++;
				}
			}
			else
				animation.play("idle");
		}
		
		// QUITTING THE CURRENT GAME
		if (_exit && !usingPhone)
			FlxG.switchState(new MenuState());
	}
	
	private function usingObject():Bool
	{
		if (usingSofa || usingPizza || usingPhone)
		{
			return true;
		}
		return false;
	}
	
	private function enjoyVR():Void
	{
		if (Reg.BORED > 0)
		{
			Reg.BORED--;
			Reg.SCORE++;
		}
	}
	
	private function resting():Void
	{
		if (usingSofa)
		{
			if (_restTimer > 30)
			{
				if (Reg.TIRED > 0)
				{
					Reg.TIRED--;
					Reg.SCORE++;
				}
				_restTimer = 0;
			}
			else
			{
				_restTimer++;
			}
			
		}
	}
	
	// PUBLIC FUNCTIONS
	public function pressingUse():Bool
	{
		return _use;
	}
	
	public function increaseBars():Void
	{
		if (_timer >= (3 / 60) * 1000)
		{
			Reg.SCORE++;
		}
		if (_timer >= (5 / 60) * 1000)
		{
			Reg.TIRED++;
			Reg.HUNGRY++;
			Reg.BORED++;
			#if DEBUG
			trace("BORED : " + Reg.BORED);
			#end
			_timer = 0;
		}
		else
			_timer++;
	}
}