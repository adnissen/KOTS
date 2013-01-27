package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Andrew Nissen
	 */
	
	public class Flag extends FlxSprite
	{
		[Embed(source = '../assets/sprites/Flag18x20.png')] protected var flagSprite:Class;
		public function Flag()
		{
			loadGraphic(flagSprite, true, false, 18, 20);
			x = 158;
			y = 100;
			addAnimation("wave", [0, 1], 8);
			play("wave");
		}
		
	}

}