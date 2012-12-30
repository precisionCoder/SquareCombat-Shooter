package game.engine.Object
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
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
		
		public function HeroShip(image:Bitmap, health:int, speed:uint, gameArea:Sprite)
		{
			super(image, health, speed, gameArea);
			score = 0;
		}
		
		public function addScore(extraScore:int):void
		{
			score += extraScore;
		}
		
		public function getScore():int
		{
			return score;
		}
		
		public function setScore(score:int):void
		{
			this.score = score;
		}
	}

}