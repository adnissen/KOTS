package  
{
	/**
	 * ...
	 * @author Andrew Nissen
	 */
	import org.flixel.*;
	public class WinningFlag extends FlxSprite
	{
		[Embed(source = '../assets/sprites/BlueWins188x26.png')] protected var BlueWinSprite:Class;
		[Embed(source = '../assets/sprites/RedWins188x26.png')] protected var RedWinSprite:Class;
		public function WinningFlag() 
		{
			x = 64;
			y = 94;
			loadGraphic(BlueWinSprite, true, false, 188, 26);
			addAnimation("flash", [0, 1], 4, true);
			play("flash");
		}
		
		public function changeSprite():void
		{
			loadGraphic(RedWinSprite, true, false, 188, 26);
			addAnimation("flash", [0, 1], 4, true);
			play("flash");
		}
	}

}