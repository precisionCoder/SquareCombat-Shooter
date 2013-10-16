package game.engine.object
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * Handles all the functionality for the hero's ship, including
	 * adding and removing the ship from the screen, and keeping track of the score
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012-2013 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 * All artistic content of this game including images and sounds have all rights reserved
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