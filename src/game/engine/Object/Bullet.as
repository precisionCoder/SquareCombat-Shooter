package game.engine.Object
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import game.engine.Screen.CollisionDetector;
	import game.engine.Screen.ScreenManager;
	
	/**
	 * The bullet class handles everything to do with the bullet object.
	 * That includes placement, movement, and the damage that the bullet does
	 *
	 * "Bullets are like friends, the most painful thing with both is when they stab you in the back"
	 * -Markar the Mighty
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 */
	public class Bullet extends GameObject
	{
		private var direction:String;
		private var speed:uint;
		private var damage:int;
		private var bulletId:uint;
		private var screenManager:ScreenManager;
		
		public function Bullet(speed:uint, damage:uint, bulletImage:Bitmap, parent:Sprite, direction:String)
		{
			this.screenManager = screenManager;
			super(bulletImage, parent);
			this.speed = speed;
			this.damage = damage;
			this.direction = direction;
		}
		
		override public function addToScreen(x:int, y:int):void
		{
			//Give Bullet location based on direction
			var bulletImage:Bitmap = getImage();
			switch (direction)
			{
				case "up":
					bulletImage.x = x - (bulletImage.width / 2);
					bulletImage.y = y;
					break;
				case "upLeft":
					bulletImage.x = x - (bulletImage.width / 2);
					bulletImage.y = y - (bulletImage.height / 2);
					break;
				case "upRight":
					bulletImage.x = x - (bulletImage.width / 2);
					bulletImage.y = y - (bulletImage.height / 2);
					break;
				case "down":
					bulletImage.x = x - (bulletImage.width / 2);
					bulletImage.y = y;
					break;
				case "downLeft":
					bulletImage.x = x - (bulletImage.width / 2);
					bulletImage.y = y - (bulletImage.height / 2);
					break;
				case "downRight":
					bulletImage.x = x - (bulletImage.width / 2);
					bulletImage.y = y - (bulletImage.height / 2);
					break;
				case "left":
					bulletImage.x = x;
					bulletImage.y = y - (bulletImage.height / 2);
					break;
				case "right":
					bulletImage.x = x;
					bulletImage.y = y - (bulletImage.height / 2);
					break;
			}
			
			//Add Image
			getParent().addChild(bulletImage);
		}
		
		public function move(heroShip:HeroShip, screenManager:ScreenManager):void
		{
			//moves the bullet in the direction specified
			var bulletImage:Bitmap = getImage();
			switch (direction)
			{
				case "up":
					bulletImage.y -= speed * 2;
					break;
				case "upLeft":
					bulletImage.x -= speed * 2;
					bulletImage.y -= speed * 2;
					break;
				case "upRight":
					bulletImage.x += speed * 2;
					bulletImage.y -= speed * 2;
					break;
				case "down":
					bulletImage.y += speed * 2;
					break;
				case "downLeft":
					bulletImage.x -= speed * 2;
					bulletImage.y += speed * 2;
					break;
				case "downRight":
					bulletImage.x += speed * 2;
					bulletImage.y += speed * 2;
					break;
				case "left":
					bulletImage.x -= speed * 2;
					break;
				case "right":
					bulletImage.x += speed * 2;
					break;
			}
			
			var collisionDetector:CollisionDetector = new CollisionDetector();
			if (collisionDetector.checkForBulletCollisions(heroShip, this, screenManager) || collisionDetector.checkIfObjectIsOutOfBounds(this.getImage().x, this.getImage().y, this.getImage(), this.getParent()))
			{
				screenManager.removeBulletFromScreen(this);
				removeFromScreen();
			}
		}
		
		public function getDamage():uint
		{
			return damage;
		}
		
		//Gets the bullet id which is a unique identifier number
		public function getBulletId():uint
		{
			return bulletId;
		}
		
		//Sets the bullet id which is a unique identifier number
		public function setBulletId(bulletId:uint):void
		{
			this.bulletId = bulletId;
		}
	}

}