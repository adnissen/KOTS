package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Andrew Nissen
	 */
	public class Poof extends FlxSprite
	{
		[Embed(source = '../assets/sprites/Poof16x40.png')] protected var Sprite:Class;
		private var frameCount:int;
		public function Poof(_x:Number, _y:Number) 
		{
			x = _x;
			y = _y;
			loadGraphic(Sprite, true, false, 16, 40);
			
			addAnimation("poof", [0, 1, 2, 3, 4], 10, false);
			play("poof");
		}
		
		override public function update():void 
		{
			frameCount++;
			if (frameCount >= 35)
				this.kill();
		}
	}

}