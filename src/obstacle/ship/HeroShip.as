package obstacle.ship
{
	import flash.display.Bitmap;
	import flash.display.Stage;
	
	/**
	 * Handles all the functionality for the hero's ship, including
	 * adding and removing the ship from the screen, and keeping track of the score
	 * 
	 * "Spend your paycheck on improving your ship men, money is no good to a corpse."
	 * -Markar the Mighty
	 * 
	 * @author William Drescher
	 * 
	 * Copyright (c) 2012 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 */
	public class HeroShip extends Ship
	{
		private var score:int;
		
		public function HeroShip(newImage:Bitmap, newHealth:int, newSpeed:uint, newStage:Stage) 
		{
			super(newImage, newHealth, newSpeed, newStage);
		}
		
		public function addToStage(newX:int, newY:int):void
		{
			image.x = newX;
			image.y = newY;
			stage.addChild(image);
		}
		
		public function addScore(extraScore:int):void 
		{
				score += extraScore;
		}
		
		public function getScore():int
		{
			return score;
		}
		
		public function setScore():int
		{
			return score;
		}
		
	}

}