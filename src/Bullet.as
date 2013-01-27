package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Andrew Nissen
	 */
	public class Bullet extends FlxSprite
	{
		private var direction:int;
		[Embed(source='../assets/sprites/Bullet4x4.png')] protected var Sprite:Class;
		public function Bullet(_x:Number, _y:Number, _direction:int) 
		{
			x = _x;
			y = _y;
			loadGraphic(Sprite, true, false, 4, 4);
			addAnimation("flash", [0, 1, 2], 12, true);
			play("flash");
			speed = 5;
			direction = _direction;
			Registry.bulletGroup.add(this);
		}
		
		public function getDirection():int 
		{
			return direction;
		}
		
		override public function update():void 
		{
			//right
			if (direction == 1)
				x += speed;
			//left
			else if (direction == -1)
				x -= speed;
				
			if (x > FlxG.width + 100 || x < -100)
				this.kill();
			if (FlxG.collide(this, Registry.world))
				this.kill();
		}
		
	}

}