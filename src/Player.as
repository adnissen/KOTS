package  
{
	/**
	 * ...
	 * @author Andrew Nissen
	 */
	import org.flixel.*;
	public class Player extends FlxSprite 
	{
		private var team:int;
		private var player:int;
		[Embed(source = '../assets/sprites/Orange17x16.png')] protected var Sprite1:Class;
		[Embed(source = '../assets/sprites/Red17x16.png')] protected var Sprite2:Class;
		[Embed(source = '../assets/sprites/Blue17x16.png')] protected var Sprite4:Class;
		[Embed(source = '../assets/sprites/Teal17x16.png')] protected var Sprite3:Class;
		
		[Embed(source = '../assets/sounds/shoot.mp3')] protected var sndShoot:Class;
		[Embed(source = '../assets/sounds/jump.mp3')] protected var sndJump:Class;
		[Embed(source = '../assets/sounds/hit.mp3')] protected var sndHit:Class;
		
		private var letGo:Boolean = false;
		private var ammo:int = 1000000;
		public var isKnockBack:Boolean;
		public var frameCounter:int;
		public var shootCooldown:int;
		public function Player(_x:Number, _y:Number,_team:int, _player:int) 
		{
			team = _team;
			player = _player;
			x = _x;
			y = _y;
			if (player == 1)
				loadGraphic(Sprite1, true, false, 17, 16);
			else if (player == 2)
				loadGraphic(Sprite2, true, false, 17, 16);
			else if (player == 3)
				loadGraphic(Sprite3, true, false, 17, 16);
			else if (player == 4)
				loadGraphic(Sprite4, true, false, 17, 16);
			width = 8;
			offset.x = 4;
			addAnimation("idleLeft", [11, 10], 4);
			addAnimation("idleRight", [0, 1], 4);
			addAnimation("runRight", [2, 3, 4, 5], 8, true);
			addAnimation("runLeft", [6,7,8,9], 8, true);
			addAnimation("jumpRight", [5], 1, true);
			addAnimation("jumpLeft", [6], 1, true);
			addAnimation("shotRight", [12, 13, 14], 6);
			addAnimation("shotLeft", [15, 16, 17], 6);
			maxVelocity.x = 200;
			maxVelocity.y = 200;
			acceleration.y = 250;
			drag.x = maxVelocity.x * 20;
			
			if (team == 1)
			{	
				this.facing = FlxObject.RIGHT;
				Registry.team1Group.add(this);
			}
			else if (team == 2)
			{
				this.facing = FlxObject.LEFT
				Registry.team2Group.add(this);
			}
				
			Registry.playerGroup.add(this);
		}
		
		override public function update():void 
		{
			frameCounter++;
			super.update();
			//we only want to update if the game has actually started
			if (Registry.inGame == true)
			{
				/* Player Controle: 
				 * Player 1: 
				 * Left/Right - Left/Right
				 * Z - Jump
				 * X - Shoot
				 * 
				 * Player 2:
				 * Q/W - Left/Right
				 * E - Jump
				 * R - Shoot
				 * 
				 * Player 3:
				 * A/S - Left/Right
				 * D - Jump
				 * F - Shoot
				 * 
				 * Player 4:
				 * U/I - Left/Right
				 * O - Jump
				 * P - Shoot
				 */
				
				 
				 /*
				  * There are a lot of weird hacks in here, so I'm going to document it a bit
				  * first off for the jump, it requires another if so that it doesn't play
				  * a billion times while they aren't touching the ground.
				  * It also requires the this.isTouching() because we don't want them
				  * pressing the key in the air and hearing the sound play
				  * 
				  * there might need to be more sounds here, I'm not sure, ask playtesters
				  * I'm thinking one for when they hit the ground
				  * 
				  * Speaking of that, I could also add the poof to when they hit the ground, 
				  * but I'm not sure if it'll be confusing with 4 people jumping and shooting
				  * --that is a lot of poofing. 
				  * Maybe it's a good thing though I'm not sure. 
				  */
				 
				  
				//so this is SO BAD but it works because my computers don't suck
				//if I ever release this it really needs to be set to FlxG.elapsed
				//otherwise the dude playing it on the win98 computer will get mad
				shootCooldown--;
				
				//you have no idea how long it took to make this work
				if (isKnockBack == false)
					acceleration.x = 0;
				if (frameCounter % 30 == 0)
				{
					this.maxVelocity.x = 200;
					isKnockBack = false;
				}
					
				if (player == 1)
				{
					if (isKnockBack == false)
					{
						if (FlxG.keys.LEFT)
						{
							acceleration.x = -maxVelocity.x * 100;
							this.facing = FlxObject.LEFT;
							play("runLeft");
						}
						if (FlxG.keys.RIGHT)
						{
							acceleration.x = maxVelocity.x * 100;
							this.facing = FlxObject.RIGHT;
							play("runRight");
						}
						if (velocity.x == 0 && this.isTouching(FlxObject.DOWN))
						{
							if (this.facing == FlxObject.RIGHT)
								play("idleRight");
							if (this.facing == FlxObject.LEFT)
								play("idleLeft");
						}
						if (this.isTouching(FlxObject.FLOOR))
						{
							letGo = false;
						}
					}
					else if (this.facing == FlxObject.RIGHT)
						play("shotRight");
					else
						play("shotLeft");
					if (!this.isTouching(FlxObject.ANY))
					{	
						if (this.facing == FlxObject.RIGHT)
							play("jumpRight");
						else if (this.facing == FlxObject.LEFT)
							play("jumpLeft");
					}
					if (FlxG.keys.justPressed("Z") && this.isTouching(FlxObject.FLOOR))
						FlxG.play(sndJump, .5, false, true);
					if (FlxG.keys.Z && this.isTouching(FlxObject.DOWN))
					{
						velocity.y = -maxVelocity.y / 1.2;
					}
					if (FlxG.keys.justReleased("Z") && letGo == false)
					{
						letGo = true;
						if (velocity.y >= 0)
							velocity.y = velocity.y;
						else
							velocity.y = 0;
					}
					if (FlxG.keys.justPressed("X"))
					{
						if (shootCooldown <= 0)
						{
							FlxG.play(sndShoot, .5, false, true);
							shootCooldown = 45;
							if (this.facing == FlxObject.RIGHT)
							{
								FlxG.state.add(new Poof(this.x + 6, this.y - 32));
								FlxG.state.add(new Bullet(this.x + 8, this.y + 8, 1));
							}
							else
							{
								FlxG.state.add(new Poof(this.x - 14, this.y - 32));
								FlxG.state.add(new Bullet(this.x - 8, this.y + 8, -1));
							}
						}
					}
				}
				else if (player == 2)
				{
					if (isKnockBack == false)
					{
						if (FlxG.keys.Q)
						{
							acceleration.x = -maxVelocity.x * 100;
							this.facing = FlxObject.LEFT;
							play("runLeft");
						}
						if (FlxG.keys.W)
						{
							acceleration.x = maxVelocity.x * 100;
							this.facing = FlxObject.RIGHT;
							play("runRight");
						}
						if (velocity.x == 0 && this.isTouching(FlxObject.DOWN))
						{
							if (this.facing == FlxObject.RIGHT)
								play("idleRight");
							if (this.facing == FlxObject.LEFT)
								play("idleLeft");
						}
						if (this.isTouching(FlxObject.FLOOR))
						{
							letGo = false;
						}
						if (!this.isTouching(FlxObject.ANY))
						{
							if (this.facing == FlxObject.RIGHT)
								play("jumpRight");
							else if (this.facing == FlxObject.LEFT)
								play("jumpLeft");
						}
					}
					else if (this.facing == FlxObject.RIGHT)
						play("shotRight");
					else
						play("shotLeft");
					if (FlxG.keys.justPressed("E") && this.isTouching(FlxObject.FLOOR))
						FlxG.play(sndJump, .5, false, true);
					if (FlxG.keys.E && this.isTouching(FlxObject.DOWN))
					{
						velocity.y = -maxVelocity.y / 1.2;
					}
					if (FlxG.keys.justReleased("E") && letGo == false)
					{
						letGo = true;
						if (velocity.y >= 0)
							velocity.y = velocity.y;
						else
							velocity.y = 0;
					}
					if (FlxG.keys.justPressed("R"))
					{
						if (shootCooldown <= 0)
						{
							FlxG.play(sndShoot, .5, false, true);
							shootCooldown = 45;
							if (this.facing == FlxObject.RIGHT)
							{
								FlxG.state.add(new Poof(this.x + 6, this.y - 32));
								FlxG.state.add(new Bullet(this.x + 8, this.y + 8, 1));
							}
							else
							{
								FlxG.state.add(new Poof(this.x - 14, this.y - 32));
								FlxG.state.add(new Bullet(this.x - 8, this.y + 8, -1));
							}
						}
					}
				}
				else if (player == 3)
				{
					if (isKnockBack == false)
					{
						if (FlxG.keys.A)
						{
							acceleration.x = -maxVelocity.x * 100;
							this.facing = FlxObject.LEFT;
							play("runLeft");
						}
						if (FlxG.keys.S)
						{
							acceleration.x = maxVelocity.x * 100;
							this.facing = FlxObject.RIGHT;
							play("runRight");
						}
						if (velocity.x == 0 && this.isTouching(FlxObject.DOWN))
						{
							if (this.facing == FlxObject.RIGHT)
								play("idleRight");
							if (this.facing == FlxObject.LEFT)
								play("idleLeft");
						}
						if (this.isTouching(FlxObject.FLOOR))
						{
							letGo = false;
						}
						if (!this.isTouching(FlxObject.ANY))
						{
							if (this.facing == FlxObject.RIGHT)
								play("jumpRight");
							else if (this.facing == FlxObject.LEFT)
								play("jumpLeft");
						}
					}
					else if (this.facing == FlxObject.RIGHT)
						play("shotRight");
					else
						play("shotLeft");
					if (FlxG.keys.justPressed("D") && this.isTouching(FlxObject.FLOOR))
						FlxG.play(sndJump, .5, false, true);
					if (FlxG.keys.D && this.isTouching(FlxObject.DOWN))
					{
						velocity.y = -maxVelocity.y / 1.2;
					}
					
					if (FlxG.keys.justReleased("D") && letGo == false)
					{
						letGo = true;
						if (velocity.y >= 0)
							velocity.y = velocity.y;
						else
							velocity.y = 0;
					}
					if (FlxG.keys.justPressed("F"))
					{
						if (shootCooldown <= 0)
						{
							FlxG.play(sndShoot, .5, false, true);
							shootCooldown = 45;
							if (this.facing == FlxObject.RIGHT)
							{
								FlxG.state.add(new Poof(this.x + 6, this.y - 32));
								FlxG.state.add(new Bullet(this.x + 8, this.y + 8, 1));
							}
							else
							{
								FlxG.state.add(new Poof(this.x - 14, this.y - 32));
								FlxG.state.add(new Bullet(this.x - 8, this.y + 8, -1));
							}
						}
					}
				}
				else if (player == 4)
				{
					if (isKnockBack == false)
					{
						if (FlxG.keys.U)
						{
							acceleration.x = -maxVelocity.x * 100;
							this.facing = FlxObject.LEFT;
							play("runLeft");
						}
						if (FlxG.keys.I)
						{
							acceleration.x = maxVelocity.x * 100;
							this.facing = FlxObject.RIGHT;
							play("runRight");
						}
						if (velocity.x == 0 && this.isTouching(FlxObject.DOWN))
						{
							if (this.facing == FlxObject.RIGHT)
								play("idleRight");
							if (this.facing == FlxObject.LEFT)
								play("idleLeft");
						}
						if (this.isTouching(FlxObject.FLOOR))
						{
							letGo = false;
						}
						if (!this.isTouching(FlxObject.ANY))
						{
							if (this.facing == FlxObject.RIGHT)
								play("jumpRight");
							else if (this.facing == FlxObject.LEFT)
								play("jumpLeft");
						}
					}
					else if (this.facing == FlxObject.RIGHT)
						play("shotRight");
					else
						play("shotLeft");
					if (FlxG.keys.justPressed("O") && this.isTouching(FlxObject.FLOOR))
						FlxG.play(sndJump, .5, false, true);
					if (FlxG.keys.O && this.isTouching(FlxObject.DOWN))
					{
						velocity.y = -maxVelocity.y / 1.2;
					}
					if (FlxG.keys.justReleased("O") && letGo == false)
					{
						letGo = true;
						if (velocity.y >= 0)
							velocity.y = velocity.y;
						else
							velocity.y = 0;
					}
					if (FlxG.keys.justPressed("P"))
					{
						if (shootCooldown <= 0)
						{
							FlxG.play(sndShoot, .5, false, true);
							shootCooldown = 45;
							if (this.facing == FlxObject.RIGHT)
							{
								FlxG.state.add(new Poof(this.x + 6, this.y - 32));
								FlxG.state.add(new Bullet(this.x + 8, this.y + 8, 1));
							}
							else
							{
								FlxG.state.add(new Poof(this.x - 14, this.y - 32));
								FlxG.state.add(new Bullet(this.x - 8, this.y + 8, -1));
							}
						}
					}
				}
				
				//death and bullets stuffs
				FlxG.collide(this, Registry.bulletGroup, bulletCollide)
			}
		}
		private function bulletCollide(p:Player, b:Bullet):void
		{
			//so we set all this player stuff before killing the bullet because
			//there is some slight chance it fires twice -- which would be AWESOME
			
			//it also took me a long time to figure this all out as well
			p.maxVelocity.x = 500;
			p.acceleration.x = p.maxVelocity.x * 100 * b.getDirection();
			p.isKnockBack = true;
			p.frameCounter = 0;
			b.kill();
			
			//god I hope this doesn't play several times like in NICE SHOOT because that was terrible and peeps hated it
			FlxG.play(sndHit, .5, false, true);
		}
	}

}