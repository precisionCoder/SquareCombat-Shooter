package game.engine.movement
{
	import flash.display.Bitmap;
	import game.engine.object.Ship;
	
	/**
	 * This class controls the placement of the ship image based on it's direction
	 * Since all images are placed based on the top left corner as the image is rotated it will change it's position
	 * The Ships have an absolute X and Y value that is the point at the middle of the image and this class
	 * normalizes their position on the screen based on their direction and x and y absolute coordinates.
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012-2013 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 * All artistic content of this game including images and sounds have all rights reserved
	 */
	public class DirectionNormalizer
	{
		
		public static function normalize(ship:Ship):void
		{
			var image:Bitmap = ship.getImage();
			var direction:String = ship.getDirection();
			var absoluteX:uint = ship.getAbsoluteX();
			var absoluteY:uint = ship.getAbsoluteY();
			
			switch (direction)
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
					break;
			}
		}
	
	}

}