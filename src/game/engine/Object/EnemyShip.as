package game.engine.object
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * Enemy ship class provides all the functionality for enemy ships,
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012-2013 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 * All artistic content of this game including images and sounds have all rights reserved
	 */
	public class EnemyShip extends Ship
	{
		private var enemyShipId:uint;
		
		public function EnemyShip(image:Bitmap, health:uint, speed:uint, gameArea:Sprite)
		{
			super(image, health, speed, gameArea);
		}
		
		public function move(heroShip:HeroShip, enemyShip:EnemyShip):void
		{
			var enemyShipImage:Bitmap = enemyShip.getImage();
			
			var enemyShipAbsoluteX:Number = enemyShipImage.x + enemyShipImage.width / 2
			var enemyShipAbsoluteY:Number = enemyShipImage.y + enemyShipImage.width / 2
			var xDistance:Number = heroShip.getAbsoluteX() - enemyShipAbsoluteX;
			var yDistance:Number = heroShip.getAbsoluteY() - enemyShipAbsoluteY;
			var distance:Number = Math.sqrt(Math.pow(xDistance, 2) + Math.pow(yDistance, 2));
			
			enemyShip.getImage().x += (xDistance / distance) * this.getSpeed();
			enemyShip.getImage().y += (yDistance / distance) * this.getSpeed();
		}
		
		//The ship takes damage and if it's health drops to 0 or below it is removed from the screen
		override public function takeDamage(newDamage:int):void
		{
			health -= newDamage;
			if (health <= 0)
			{
				setDead(true);
				removeFromScreen();
			}
		}
		
		//Gets the ship id which is a unique identifier number
		public function getEnemyShipId():uint
		{
			return enemyShipId;
		}
		
		//Sets the ship id which is a unique identifier number
		public function setEnemyShipId(enemyShipId:uint):void
		{
			this.enemyShipId = enemyShipId;
		}
	}

}