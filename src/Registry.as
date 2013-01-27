package  
{
	import org.flixel.* ;
	/**
	 * ...
	 * @author Andrew Nissen
	 */
	public class Registry 
	{
		public static var world:World;
		
		public static var player1:Player;
		public static var player2:Player;
		public static var player3:Player;
		public static var player4:Player;
		
		public static var playersRemaining:int;
		
		public static var team1Time:Number;
		public static var team2Time:Number;
		public static var team1Win:Boolean;
		public static var team2Win:Boolean;
		
		public static var playerGroup:FlxGroup;
		public static var team1Group:FlxGroup;
		public static var team2Group:FlxGroup;
		public static var bulletGroup:FlxGroup;
		
		public static var inGame:Boolean;
		public function Registry() 
		{
			
		}
		
	}

}