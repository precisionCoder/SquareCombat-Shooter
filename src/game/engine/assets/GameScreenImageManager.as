package game.engine.assets
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * Manages Game Screen images, including cloning images for enemy ships
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012-2013 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 * All artistic content of this game including images and sounds have all rights reserved
	 */
	public class GameScreenImageManager
	{
		//Game Screen Design Images
		[Embed(source="../../images/GameArea.png")]
		private static var gameAreaImage:Class;
		private static var gameAreaImageBitmap:BitmapData;
		
		[Embed(source="../../images/GameFrame.png")]
		private static var gameFrameImage:Class;
		private static var gameFrameImageBitmap:BitmapData;
		
		[Embed(source="../../images/HealthBar.png")]
		private static var healthBarImage:Class;
		private static var healthBarImageBitmap:BitmapData;
		
		[Embed(source="../../images/ScoreBar.png")]
		private static var scoreBarImage:Class;
		private static var scoreBarImageBitmap:BitmapData;
		
		[Embed(source="../../images/TopBar.png")]
		private static var topBarImage:Class;
		private static var topBarImageBitmap:BitmapData;
		
		//GameScreen Gameplay Images
		[Embed(source="../../images/BasicEnemy.png")]
		private static var basicEnemyImage:Class;
		private static var basicEnemyImageBitmap:BitmapData;
		
		[Embed(source="../../images/BasicHero.png")]
		private static var basicHeroImage:Class;
		private static var basicHeroImageBitmap:BitmapData;
		
		[Embed(source="../../images/Bullet.png")]
		private static var bulletImage:Class;
		private static var bulletImageBitmap:BitmapData;
		
		public static function init():void
		{
			gameAreaImageBitmap = (new gameAreaImage() as Bitmap).bitmapData;
			gameFrameImageBitmap = (new gameFrameImage() as Bitmap).bitmapData;
			healthBarImageBitmap = (new healthBarImage() as Bitmap).bitmapData;
			scoreBarImageBitmap = (new scoreBarImage as Bitmap).bitmapData;
			topBarImageBitmap = (new topBarImage() as Bitmap).bitmapData;
			basicEnemyImageBitmap = (new basicEnemyImage() as Bitmap).bitmapData;
			basicHeroImageBitmap = (new basicHeroImage() as Bitmap).bitmapData;
			bulletImageBitmap = (new bulletImage as Bitmap).bitmapData;
		}
		
		public static function getGameAreaImage():BitmapData
		{
			return gameAreaImageBitmap;
		}
		
		public static function getGameFrameImage():BitmapData
		{
			return gameFrameImageBitmap;
		}
		
		public static function getHealthBarImage():BitmapData
		{
			return healthBarImageBitmap;
		}
		
		public static function getScoreBarImage():BitmapData
		{
			return scoreBarImageBitmap;
		}
		
		public static function getTopBarImage():BitmapData
		{
			return topBarImageBitmap;
		}
		
		public static function getBasicEnemyImage():BitmapData
		{
			return basicEnemyImageBitmap;
		}
		
		public static function getBasicHeroImage():BitmapData
		{
			return basicHeroImageBitmap;
		}
		
		public static function getBulletImage():BitmapData
		{
			return bulletImageBitmap;
		}
	}
}