package  
{
	/**
	 * ...
	 * @author Andrew Nissen
	 */
	import flash.display.BitmapData;
	import flash.display.ColorCorrection;
	import flash.display.Sprite;

	import org.flixel.*;

	/**
	 * This is the world tilemap which handles creation from bitmap along with binding of
	 * the liquid tiles.
	 *  
	 * @author Arkeus
	 * 
	 */
	
	public class World extends FlxTilemap {
		private var _width:int;
		private var _height:int;
		private var mapWORLD:Class;
		private var blackTiles:FlxTilemap;
		[Embed(source = '../assets/Level.png')] protected var Level1:Class;
		public function World(levelNumber:int) 
		{
			super.update();
			mapWORLD = Level1;
			
			// Get a BitmapData representation of our color bitmap
			var pixels:BitmapData = new FlxSprite(0, 0, mapWORLD).pixels;
			// Call the Flixel bitmapToCSV with the new color map array set  to our tiles
			//var worldString:String = FlxTilemap.bitmapToCSV(pixels, false, 1, FlxTilemap.ImgAuto);
			var worldString:String = FlxTilemap.bitmapToCSV(pixels, false, 1);
			
			// Load the map like normal
			loadMap(worldString, FlxTilemap.ImgAuto, 8, 8, FlxTilemap.AUTO, 0);
			// Bind our liquid tiles to change player physics

			build();
		}
		private static const PLAYER_COLOR:uint = 0x3052FF;
		/**
		 * These are the colors for each tile. When reading in the map bitmap (map.png), if (for example) it sees
		 * a pixel with the color 0x1f1400 then it will put tile id "1" there, because that color is at index 1
		 * in this array. Because our tilesheet is 5x10, this array is also 5x10 (but it's actually a 1 dimensional
		 * array, it's just laid out as 5x10 to make it easier to compare this to the tile image as you are
		 * working on it). 
		 */		
		private static const TILES:Array = [
			0x000000
		];

		private function build():void {
			var pixels:BitmapData = new FlxSprite(0, 0, mapWORLD).pixels;
			for (var x:int = 0; x < pixels.width; x++) {
				for (var y:int = 0; y < pixels.height; y++) {
					var pixel:uint = pixels.getPixel(x, y);
					if (pixel == PLAYER_COLOR) {
						FlxG.state.add(new Player(x * 8, y * 8, 1, 1));
					}
				}
			}
		}
	}
}