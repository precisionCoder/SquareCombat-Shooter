package game.engine 
{
	import flash.display.Bitmap;
	import flash.display.Stage;
	import flash.geom.Point;
	import obstacle.ship.Ship;
	/**
	 * This class controls the placement of the ship image based on it's direction
	 * Since all images are placed based on the top left corner as the image is rotated it will change it's position
	 * The Ships have an absolute X and Y value that is the point at the middle of the image and this class
	 * normalizes their position on the screen based on their direction and x and y absolute coordinates.
	 * 
	 * "On my home planet they tried to Normalize me... That was the first planet I leveled once I put together my fleet. Hah!"
	 * Krasmak the Cruel
	 * 
	 * @author William Drescher
	 * 
	 * Copyright (c) 2012 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 */
	public class DirectionNormalizer 
	{
		public function DirectionNormalizer() {}
		
		public static function normalize(ship:Ship):void
		{
			var image:Bitmap = ship.getImage();
			var direction:String = ship.getDirection();
			var absoluteX:uint = ship.getAbsoluteX();
			var absoluteY:uint = ship.getAbsoluteY();
			
			switch(direction)
			{
				case "up":
					image.x = absoluteX - (image.width / 2);
					image.y = absoluteY - (image.height / 2);
					image.rotation = 0;
				break;
				case "down":
					image.x = absoluteX + (image.width / 2);
					image.y = absoluteY + (image.height / 2);
					image.rotation = 180;
				break;
				case "upLeft":
					image.x = absoluteX - (image.width / 2);
					image.y = absoluteY;
					image.rotation = -45;
				break;
				case "upRight":
					image.x = absoluteX;
					image.y = absoluteY - (image.width / 2);
					image.rotation = 45;
				break;
				case "left":
					image.x = absoluteX - (image.width / 2);
					image.y = absoluteY + (image.height / 2);
					image.rotation = -90;
				break
				case "right":
					image.x = absoluteX + (image.width / 2);
					image.y = absoluteY - (image.height / 2);
					image.rotation = 90;
				break;
				case "downLeft":
					image.x = absoluteX;
					image.y = absoluteY + (image.height / 2);
					image.rotation = -135;
				break;
				case "downRight":
					image.x = absoluteX + (image.width / 2);
					image.y = absoluteY;
					image.rotation = 135;
				break;			}
		}
			
	}

}