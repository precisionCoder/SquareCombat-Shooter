package game.engine.screen
{
	import game.engine.object.Bullet;
	import game.engine.object.EnemyShip;
	import game.engine.object.HeroShip;
	import flash.media.Sound;
	import game.engine.assets.SoundManager;
	
	/**
	 * Performs operations on ships
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012-2013 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 * All artistic content of this game including images and sounds have all rights reserved
	 */
	public class ShipManager
	{
		//Handles collisions of the player's ship and enemy ships
		public function handleShipCollision(heroShip:HeroShip, enemyShipArray:Array, screenManager:ScreenManager):void
		{
			for each (var enemyShip:EnemyShip in enemyShipArray)
			{
				heroShip.takeDamage(1);
				enemyShip.takeDamage(10);
				if (enemyShip.getDead())
				{
					SoundManager.playCollision();
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
				SoundManager.playEnemyDeath();
				heroShip.addScore(1);
				screenManager.removeEnemyShipFromScreen(enemyShip.getEnemyShipId());
			}
			screenManager.removeBulletFromScreen(bullet);
		}
	
	}

}