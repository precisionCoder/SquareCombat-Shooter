package game.engine.Screen
{
	import game.engine.Object.Bullet;
	import game.engine.Object.EnemyShip;
	import game.engine.Object.HeroShip;
	
	/**
	 * Contains a list of all of the objects that are currently on the screen
	 *
	 * @author William Drescher
	 */
	public class ScreenManager
	{
		private var enemyShipArray:Array;
		private var bulletArray:Array;
		private var heroShip:HeroShip;
		private var shipId:uint;
		private var bulletId:uint;
		
		public function ScreenManager()
		{
			enemyShipArray = new Array();
			bulletArray = new Array();
			shipId = 0;
			bulletId = 0;
		}
		
		//Enemy ship management
		public function getEnemyShipArray():Array
		{
			return enemyShipArray;
		}
		
		public function setEnemyShipArray(enemyShipArray:Array):void
		{
			this.enemyShipArray = enemyShipArray;
		}
		
		public function addEnemyShipToScreen(enemyShip:EnemyShip):void
		{
			enemyShip.setEnemyShipId(shipId);
			enemyShipArray.push(enemyShip);
			shipId++;
		}
		
		public function removeEnemyShipFromScreen(enemyShipId:uint):void
		{
			for (var i:int = 0; i < enemyShipArray.length; i++)
			{
				var enemyShip:EnemyShip = enemyShipArray[i];
				if (enemyShip.getEnemyShipId() == enemyShipId)
				{
					enemyShipArray.splice(i, 1);
				}
			}
		}
		
		public function moveEnemyShips():void
		{
			var collisionDetector:CollisionDetector = new CollisionDetector();
			var arrayIndex:uint = 0;
			for each (var enemy:EnemyShip in enemyShipArray)
			{
				enemy.move(heroShip, enemy);
				if (collisionDetector.checkForCollisions(heroShip, enemy))
				{
					heroShip.takeDamage(1);
					enemy.takeDamage(10);
					if (enemy.getDead())
					{
						heroShip.addScore(1);
						enemyShipArray.splice(arrayIndex, 1);
					}
				}
				arrayIndex++;
			}
		}
		
		public function removeAllEnemyShips():void
		{
			for each (var enemyShip:EnemyShip in enemyShipArray)
			{
				enemyShip.removeFromScreen();
			}
			enemyShipArray = new Array();
		}
		
		//Bullet management
		public function getBulletArray():Array
		{
			return bulletArray;
		}
		
		public function setBulletArray(bulletArray:Array):void
		{
			this.bulletArray = bulletArray;
		}
		
		public function addBulletToScreen(bullet:Bullet):void
		{
			bullet.setBulletId(bulletId);
			bulletArray.push(bullet);
			bullet.addToScreen(heroShip.getAbsoluteX(), heroShip.getAbsoluteY());
			bulletId++;
		}
		
		public function removeBulletFromScreen(bullet:Bullet):void
		{
			for (var i:int = 0; i < bulletArray.length; i++)
			{
				var arrayBullet:Bullet = bulletArray[i];
				if (bullet.getBulletId() == arrayBullet.getBulletId())
				{
					bulletArray.splice(i, 1);
				}
			}
		}
		
		public function moveBullets():void
		{
			for each (var bullet:Bullet in bulletArray)
			{
				bullet.move(heroShip, this);
			}
		}
		
		public function removeAllBullets():void
		{
			for each (var bullet:Bullet in bulletArray)
			{
				bullet.removeFromScreen();
			}
			bulletArray = new Array();
		}
		
		//Hero ship management
		public function getHeroShip():HeroShip
		{
			return heroShip;
		}
		
		public function setHeroShip(heroShip:HeroShip):void
		{
			this.heroShip = heroShip;
		}
	}

}