package game.engine.Screen
{
	import game.engine.Object.Bullet;
	import game.engine.Object.EnemyShip;
	import game.engine.Object.HeroShip;
	/**
	 * Performs operations on ships
	 *
	 * @author William Drescher
	 */
	public class ShipManager
	{
		
		public function ShipManager()
		{
		
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
				heroShip.addScore(1);
				screenManager.removeEnemyShipFromScreen(enemyShip.getEnemyShipId());
			}
			screenManager.removeBulletFromScreen(bullet);
		}
	
	}

}