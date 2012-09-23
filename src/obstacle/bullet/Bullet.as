package obstacle.bullet
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage
	import flash.events.Event;
	import game.engine.CollisionDetector;
	import obstacle.ship.HeroShip;
	
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
	public class Bullet
	{
		private var direction:String;
		private var speed:uint;
		private var bulletImage:Bitmap;
		private var stage:Stage;
		private var myDetector:CollisionDetector;
		private var damage:int;
		private var heroShip:HeroShip;
		
		public function Bullet(heroShip:HeroShip, newSpeed:uint, newDamage:uint, 
				newBulletImage:Bitmap, newStage:Stage, newDetector:CollisionDetector)
		{
			//Clone the image and use it to make a new bullet
			var bulletImageData:BitmapData = newBulletImage.bitmapData;
			var myClone:BitmapData = bulletImageData.clone();
			var myBulletClone:Bitmap = new Bitmap(myClone);
			
			//Assign variables
			this.heroShip = heroShip;
			bulletImage = myBulletClone;
			
			var newX:uint = heroShip.getAbsoluteX();
			var newY:uint = heroShip.getAbsoluteY();
			direction = heroShip.getDirection();
			speed = newSpeed;
			damage = newDamage;
			stage = newStage;
			myDetector = newDetector;
			
			//Give Bullet location based on direction
			switch (direction)
			{
				case "up":
					bulletImage.x = newX - (bulletImage.width/2);
					bulletImage.y = newY;
				break;
				case "upLeft":
					bulletImage.x = newX - (bulletImage.width / 2);
					bulletImage.y = newY - (bulletImage.height / 2);
				break;
				case "upRight":
					bulletImage.x = newX - (bulletImage.width / 2);
					bulletImage.y = newY - (bulletImage.height / 2);
				break;
				case "down":
					bulletImage.x = newX - (bulletImage.width / 2);
					bulletImage.y = newY;
				break; 
				case "downLeft":
					bulletImage.x = newX - (bulletImage.width / 2);
					bulletImage.y = newY - (bulletImage.height / 2);
				break;
				case "downRight":
					bulletImage.x = newX - (bulletImage.width / 2);
					bulletImage.y = newY - (bulletImage.height / 2);
				break;
				case "left":
					bulletImage.x = newX;
					bulletImage.y = newY  - (bulletImage.height/2);
				break; 
				case "right":
					bulletImage.x = newX;
					bulletImage.y = newY  - (bulletImage.height/2);
				break;				
			}
			
			//gameCollisionDetector.addToCollisionList(); kill enemy collision
					
			//Add listener
			stage.addEventListener(Event.ENTER_FRAME, bulletMovement);
			
			//Add Image
			stage.addChild(bulletImage);
		}
		
		private function bulletMovement(event:Event):void
		{
			//moves the bullet in the direction specified
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
			
			if (myDetector.checkForBulletCollisions(heroShip, bulletImage, damage))
			{
				stage.removeChild(bulletImage);
				stage.removeEventListener(Event.ENTER_FRAME, bulletMovement);
			}
		}
		
		public function getDamage():uint
		{
			return damage;
		}
		
		public function getImage():Bitmap
		{
			return bulletImage;
		}
		
	}
	
}