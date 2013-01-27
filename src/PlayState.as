package
{

	import org.flixel.*;

	public class PlayState extends FlxState
	{
		[Embed(source = '../assets/capZone.png')] protected var capSprite:Class;
		[Embed(source = '../assets/sprites/Background.png')] protected var backgroundSprite:Class;
		[Embed(source = '../assets/sprites/Clouds.png')] protected var cloudsSprite:Class;
		
		public var txtTeam1Time:FlxText;
		public var txtTeam2Time:FlxText;
		
		public var winningTeam:WinningFlag;
		
		public var capZone:FlxSprite;
		
		public var background:FlxSprite;
		
		public var clouds1:FlxSprite;
		public var clouds2:FlxSprite;
		
		public var flag:Flag;
		
		public var logo:Logo;
		override public function create():void
		{
			//don't let the game start yet
			Registry.inGame = true;
			
			Registry.team1Win = false;
			Registry.team2Win = false;
			
			Registry.playersRemaining = 4;
			
			Registry.playerGroup = new FlxGroup();
			Registry.team1Group = new FlxGroup();
			Registry.team2Group = new FlxGroup();
			Registry.bulletGroup = new FlxGroup();
			
			Registry.team1Time = 10.00;
			Registry.team2Time = 10.00;
			
			FlxG.bgColor = 0xFFFDE997;
			
			background = new FlxSprite(0, 0, backgroundSprite);
			this.add(background);
			
			clouds1 = new FlxSprite(0, 0, cloudsSprite);
			this.add(clouds1);
			
			clouds2 = new FlxSprite(-320, 0, cloudsSprite);
			this.add(clouds2);
			
			flag = new Flag();
			this.add(flag);
			
			Registry.world = new World(1);
			Registry.world.visible = false;
			this.add(Registry.world);
			
			capZone = new FlxSprite(144, 112, capSprite);
			capZone.visible = false;
			this.add(capZone);
			
			Registry.player1 = new Player(90, 120, 1, 1);
			this.add(Registry.player1);
			
			Registry.player2 = new Player(50, 100, 1, 2);
			this.add(Registry.player2);
			
			Registry.player3 = new Player(220, 120, 2, 3);
			this.add(Registry.player3);
			
			Registry.player4 = new Player(250, 100, 2, 4);
			this.add(Registry.player4);
			
			txtTeam1Time = new FlxText(-40, 96, FlxG.width, "10.00");
			txtTeam1Time.alignment = "center";
			txtTeam1Time.color = 0xFFFF4CB6;
			this.add(txtTeam1Time);
			
			txtTeam2Time = new FlxText(40, 96, FlxG.width, "10.00");
			txtTeam2Time.alignment = "center";
			txtTeam2Time.color = 0xFF2361FF;
			this.add(txtTeam2Time);
			
			winningTeam = new WinningFlag();
			winningTeam.visible = false;
			this.add(winningTeam);
			
			logo = new Logo();
			
			FlxG.fullscreen();
		}
		
		
		override public function update():void 
		{
			if (Registry.inGame == true)
			{
				flag.update();
				clouds1.x += .2;
				clouds2.x += .2;
				if (clouds1.x > 320)
					clouds1.x = -320;
				if (clouds2.x > 320)
					clouds2.x = -320;
					
				//figure out how to do sfx here, it'll ad some major polish
				if (FlxG.overlap(Registry.team1Group, capZone))
				{
					if (Registry.team1Time > .02)
						Registry.team1Time -= .02;
					else if (Registry.team1Time <= .02)
					{
						Registry.team1Win = true;
						winningTeam.changeSprite();
						winningTeam.visible = true;
						winningTeam.play("flash");
						flag.kill();
						this.add(logo);
						Registry.inGame = false;
						Registry.team1Time = 0.00;
					}
					txtTeam1Time.text = Registry.team1Time.toPrecision(3);
				}
				if (FlxG.overlap(Registry.team2Group, capZone))
				{
					if (Registry.team2Time > .02)
						Registry.team2Time -= .02;
					else if (Registry.team2Time <= .02)
					{
						Registry.team2Win = true;
						winningTeam.visible = true;
						winningTeam.play("flash");
						flag.kill();
						this.add(logo);
						Registry.inGame = false;
						Registry.team2Time = 0.00;
					}
					txtTeam2Time.text = Registry.team2Time.toPrecision(3);
				}
				FlxG.collide(Registry.playerGroup, Registry.world);
				super.update();
			}
			else
			{
				//there needs to be a victory jingle here
				//maybe even a different one for each time if we're feeling adventurous
				FlxG.collide(Registry.playerGroup, Registry.world);
				logo.update();
				winningTeam.update();
				if (FlxG.keys.justPressed("B"))
					FlxG.switchState(new PlayState());
				super.update();
			}
		}
	}
}

