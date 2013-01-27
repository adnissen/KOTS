package
{

	import org.flixel.*;

	public class MenuState extends FlxState
	{
		[Embed(source = '../assets/sounds/Get Busy.mp3')] protected var song:Class;
		
		[Embed(source = '../assets/sprites/Background.png')] protected var backgroundSprite:Class;
		[Embed(source = '../assets/sprites/Clouds.png')] protected var cloudsSprite:Class;
		
		public var background:FlxSprite;
		
		public var clouds1:FlxSprite;
		public var clouds2:FlxSprite;
		
		public var flag:Flag;
		
		public var logo:Logo;
		override public function create():void
		{
			FlxG.bgColor = 0xff313210;
			
			FlxG.playMusic(song);
			
			//make the music play here, but since it's a stupid m4a I need to convert it first
			//at this point right now I don't have the tools to do that 
			//why doesn't it export as mp3????
			//jennie has failed me
			
			background = new FlxSprite(0, 0, backgroundSprite);
			this.add(background);
			
			clouds1 = new FlxSprite(0, 0, cloudsSprite);
			this.add(clouds1);
			
			clouds2 = new FlxSprite(-320, 0, cloudsSprite);
			this.add(clouds2);
			
			flag = new Flag();
			this.add(flag);
			
			logo = new Logo();
			this.add(logo);
			
			FlxG.fullscreen();
			
		}
		
		override public function update():void
		{
			super.update();	
			clouds1.x += .2;
			clouds2.x += .2;
			if (clouds1.x > 320)
				clouds1.x = -320;
			if (clouds2.x > 320)
				clouds2.x = -320;
			logo.update();
			flag.update();
			if (FlxG.keys.justPressed("B"))
					FlxG.switchState(new PlayState());
		}
		
	}
}

