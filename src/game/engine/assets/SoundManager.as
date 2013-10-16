package game.engine.assets
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	/**
	 * Program for managing sounds
	 *
	 * @author William Drescher
	 *
	 * * Copyright (c) 2012-2013 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 * All artistic content of this game including images and sounds have all rights reserved
	 */
	public class SoundManager
	{
		[Embed(source="../../sounds/Collision.mp3")]
		private static var collisionEmbedSound:Class;
		private static var collisionSound:Sound = new collisionEmbedSound();
		
		[Embed(source="../../sounds/EnemyDeath.mp3")]
		private static var enemyDeathEmbedSound:Class;
		private static var enemyDeathSound:Sound = new enemyDeathEmbedSound();
		
		[Embed(source="../../sounds/GameOver.mp3")]
		private static var gameOverEmbedSound:Class;
		private static var gameOverSound:Sound = new gameOverEmbedSound();
		
		[Embed(source="../../sounds/GameStart.mp3")]
		private static var gameStartEmbedSound:Class;
		private static var gameStartSound:Sound = new gameStartEmbedSound();
		
		[Embed(source="../../sounds/Shoot.mp3")]
		private static var shootEmbedSound:Class;
		private static var shootSound:Sound = new shootEmbedSound();
		
		private static var currentSound:SoundChannel = new SoundChannel();
		
		public static function playCollision():void
		{
			currentSound.stop();
			currentSound = collisionSound.play();
		}
		
		public static function playEnemyDeath():void
		{
			currentSound.stop();
			currentSound = enemyDeathSound.play();
		}
		
		public static function playGameOver():void
		{
			currentSound.stop();
			currentSound = gameOverSound.play();
		}
		
		public static function playGameStart():void
		{
			currentSound.stop();
			currentSound = gameStartSound.play();
		}
		
		public static function playShoot():void
		{
			currentSound.stop();
			currentSound = shootSound.play();
		}
	
	}

}