package game.engine.Screen
{
	import game.engine.Object.Bullet;
	import game.engine.Object.EnemyShip;
	import game.engine.Object.HeroShip;
	import flash.media.Sound;
	
	/**
	 * Performs operations on ships
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 */
	public class ShipManager
	{
		//Add hero image
		[Embed(source="../../sounds/EnemyDeath.mp3")]
		private var enemyDeathEmbedSound:Class;
		private var enemyDeathSound:Sound = new enemyDeathEmbedSound();
		
		public function ShipManager()
		{
			//Empty
		}
		
		//Handles collisions of the player's ship and enemy ships
		public function handleShipCollision(heroShip:HeroShip, enemyShipArray:Array, screenManager:ScreenManager):void
		{
			for each (var enemyShip:EnemyShip in enemyShipArray)
			{
				heroShip.takeDamage(1);
				enemyShip.takeDamage(10);
				if (enemyShip.getDead())
				{
					heroShip.addScore(1);
					screenManager.removeEnemyShipFromScreen(enemyShip.getEnemyShipId());
				}
			}
		}
		
		//Handles collisions between a bullet and enemy ship, adds to player's score if the ship is destroyed
		public function handleBulletCollision(heroShip:HeroShip, bullet:Bullet, enemyShip:EnemyShip, screenManager:ScreenManager):void
		{
			enemyShip.takeDamage(bullet.getDamage());
			if (enemyShip.getDead())
			{
				enemyDeathSound.play();
				heroShip.addScore(1);
				screenManager.removeEnemyShipFromScreen(enemyShip.getEnemyShipId());
			}
			screenManager.removeBulletFromScreen(bullet);
		}
	
	}

}