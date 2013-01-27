package

{

	import org.flixel.*;
	import flash.system.Capabilities;
	[SWF(width="640", height="384", backgroundColor="#000000")]

	[Frame(factoryClass="Preloader")]

	public class Shootout extends FlxGame
	{
		public function Shootout()
		{
			
			var zoomLevel:int;
			
			for (var i:int = 0; i < 6; i++) 
			{
				if (((320 * i) <= Capabilities.screenResolutionX) && ((192 * i) <= Capabilities.screenResolutionY))
					zoomLevel = i;
			}
			
			super(320, 192, MenuState, zoomLevel, 60, 60);
			//forceDebugger = true;
		}

	}

}

