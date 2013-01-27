package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Andrew Nissen
	 */
	public class Logo extends FlxSprite 
	{
		[Embed(source = '../assets/sprites/Logo320x192.png')] protected var Sprite:Class;
		public function Logo() 
		{
			x = 0;
			y = 0;
			loadGraphic(Sprite, true, false, 320, 192);
			addAnimation("flash", [0, 1], 4);
			play("flash");
		}
		
	}

}