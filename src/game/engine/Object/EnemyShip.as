package game.engine.Object
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * Enemy ship class provides all the functionality for enemy ships,
	 * it can add and remove itself from the screen as well as take damage
	 *
	 * "Blue as justice my ships ride forth as emissaries of my great empire"
	 * -Krasmak the Cruel
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
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
			if ((enemyShipImage.x - enemyShipImage.width / 2) < heroShip.getAbsoluteX())
			{
				enemyShip.getImage().x++;
			}
			if ((enemyShipImage.x + enemyShipImage.width / 2) > heroShip.getAbsoluteX())
			{
				enemyShip.getImage().x--;
			}
			if ((enemyShipImage.y + enemyShipImage.height / 2) < heroShip.getAbsoluteY())
			{
				enemyShip.getImage().y++;
			}
			if ((enemyShipImage.y - enemyShipImage.height / 2) > heroShip.getAbsoluteY())
			{
				enemyShip.getImage().y--;
			}
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