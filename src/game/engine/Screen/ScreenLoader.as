package game.engine.Screen
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.Graphics;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	import flash.display.Bitmap;
	import game.engine.Main.ShooterGameManager;
	import game.engine.Object.HeroShip;
	
	/**
	 * A class that handles loading the various screens and bars that make up the ui
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 */
	public class ScreenLoader
	{
		//Start Screen images
		[Embed(source="../../images/StartScreenBackground.png")]
		private var startScreenBackgroundEmbedImage:Class;
		private var startScreenBackgroundImage:Bitmap = new startScreenBackgroundEmbedImage();
		
		[Embed(source="../../images/Title.png")]
		private var titleEmbedImage:Class;
		private var titleImage:Bitmap = new titleEmbedImage();
		
		[Embed(source="../../images/Instructions.png")]
		private var instructionsEmbedImage:Class;
		private var instructionsImage:Bitmap = new instructionsEmbedImage();
		
		[Embed(source="../../images/StartButton.png")]
		private var startButtonEmbedImage:Class;
		private var startButtonImage:Bitmap = new startButtonEmbedImage();
		
		//Game area screen images
		[Embed(source="../../images/TopBar.png")]
		private var topBarEmbedImage:Class;
		private var topBarImage:Bitmap = new topBarEmbedImage();
		
		[Embed(source="../../images/HealthBar.png")]
		private var healthBarEmbedImage:Class;
		private var healthBarImage:Bitmap = new healthBarEmbedImage();
		
		[Embed(source="../../images/ScoreBar.png")]
		private var scoreBarEmbedImage:Class;
		private var scoreBarImage:Bitmap = new scoreBarEmbedImage();
		
		[Embed(source="../../images/GameArea.png")]
		private var gameAreaEmbedImage:Class;
		private var gameAreaImage:Bitmap = new gameAreaEmbedImage();
		
		[Embed(source="../../images/GameFrame.png")]
		private var gameFrameEmbedImage:Class;
		private var gameFrameImage:Bitmap = new gameFrameEmbedImage();
		
		//Game over screen images
		[Embed(source="../../images/GameOverBackground.png")]
		private var gameOverBackgroundEmbedImage:Class;
		private var gameOverBackgroundImage:Bitmap = new gameOverBackgroundEmbedImage();
		
		[Embed(source="../../images/GameOverTitle.png")]
		private var gameOverTitleEmbedImage:Class;
		private var gameOverTitleImage:Bitmap = new gameOverTitleEmbedImage();
		
		[Embed(source="../../images/FinalScorePanel.png")]
		private var finalScoreEmbedImage:Class;
		private var finalScoreImage:Bitmap = new finalScoreEmbedImage();
		
		[Embed(source="../../images/ContinueButton.png")]
		private var continueButtonEmbedImage:Class;
		private var continueButtonImage:Bitmap = new continueButtonEmbedImage();
		
		private var stage:Stage;
		private var startButton:Sprite;
		private var continueButton:Sprite;
		
		private var gameManager:ShooterGameManager;
		
		public function ScreenLoader(stage:Stage)
		{
			this.stage = stage;
		}
		
		public function loadGameScreen():Sprite
		{
			var gameArea:Sprite = new Sprite();
			var gameAreaFrameSize:int = 26;
			gameArea.addChild(gameAreaImage);
			gameArea.x = gameAreaFrameSize;
			gameArea.y = (stage.stageHeight - gameArea.height - gameAreaFrameSize);
			return gameArea;
		}
		
		public function loadGameFrame():Sprite
		{
			var gameFrame:Sprite = new Sprite();
			gameFrame.x = 0;
			gameFrame.y = (stage.stageHeight - gameFrameImage.height);
			gameFrame.addChild(gameFrameImage);
			return gameFrame;
		}
		
		public function loadTopBar():Sprite
		{
			var topBar:Sprite = new Sprite();
			topBar.addChild(topBarImage);
			topBar.x = 0;
			topBar.y = 0;
			return topBar;
		}
		
		public function loadScreen():Sprite
		{
			var screenArea:Sprite = new Sprite();
			screenArea.graphics.beginFill(0x585858);
			screenArea.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			screenArea.graphics.endFill();
			screenArea.x = 0;
			screenArea.y = 0;
			return screenArea;
		}
		
		public function loadHealthBar():Sprite
		{
			var healthBar:Sprite = new Sprite();
			healthBar.addChild(healthBarImage);
			healthBar.x = (topBarImage.height - healthBar.height) / 2;
			healthBar.y = (topBarImage.height - healthBar.height) / 2;
			return healthBar;
		}
		
		public function loadScoreBar():Sprite
		{
			var scoreBar:Sprite = new Sprite();
			scoreBar.addChild(scoreBarImage);
			scoreBar.x = (topBarImage.width - scoreBar.width) - ((topBarImage.height - scoreBar.height) / 2);
			scoreBar.y = (topBarImage.height - scoreBar.height) / 2;
			return scoreBar;
		}
		
		public function loadScoreBarText():TextField
		{
			//Add end game message
			var score:TextField = new TextField();
			score.text = "0";
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 24;
			score.defaultTextFormat = myFormat;
			score.setTextFormat(myFormat);
			score.x = topBarImage.width - (scoreBarImage.width / 2);
			score.y = (topBarImage.height / 2) - 15;
			return score;
		}
		
		public function loadStartScreen(gameManager:ShooterGameManager):Sprite
		{
			this.gameManager = gameManager;
			//Create Screen
			var startScreen:Sprite = new Sprite();
			startScreen.addChild(startScreenBackgroundImage);
			var whitespace:int = 10;
			
			titleImage.x = (startScreen.width / 2) - (titleImage.width / 2);
			titleImage.y = whitespace;
			startScreen.addChild(titleImage);
			
			//Add instructions
			instructionsImage.x = (startScreen.width / 2) - (instructionsImage.width / 2);
			instructionsImage.y = titleImage.height + (whitespace * 2);
			startScreen.addChild(instructionsImage);
			
			//Add start button
			startButton = new Sprite();
			startButton.addEventListener(MouseEvent.CLICK, startButtonClicked);
			startButton.addEventListener(MouseEvent.MOUSE_OVER, startButtonRolledOver);
			startButton.addEventListener(MouseEvent.MOUSE_OUT, startButtonRolledOut);
			startButton.x = (startScreen.width / 2) - (startButtonImage.width / 2);
			startButton.y = instructionsImage.height + (whitespace * 2) + ((instructionsImage.height + (whitespace * 2)) / 3);
			startButtonImage.alpha = 100;
			startButton.addChild(startButtonImage);
			startScreen.addChild(startButton);
			
			return startScreen;
		}
		
		private function startButtonClicked(event:MouseEvent):void
		{
			gameManager.startGame(1000);
		}
		
		private function startButtonRolledOver(event:MouseEvent):void
		{
			startButtonImage.alpha = 1;
		}
		
		private function startButtonRolledOut(event:MouseEvent):void
		{
			startButtonImage.alpha = 1;
		}
		
		public function loadGameOverScreen(gameManager:ShooterGameManager, heroShip:HeroShip):Sprite
		{
			var spacing:int = (gameOverBackgroundImage.height - gameOverTitleImage.height - finalScoreImage.height) / 3;
			this.gameManager = gameManager;
			
			var gameOverScreen:Sprite = new Sprite();
			gameOverBackgroundImage.x = 0;
			gameOverBackgroundImage.y = 0;
			gameOverScreen.addChild(gameOverBackgroundImage);
			
			gameOverTitleImage.x = (gameOverBackgroundImage.width / 2) - (gameOverTitleImage.width / 2);
			gameOverTitleImage.y = spacing;
			gameOverScreen.addChild(gameOverTitleImage);
			
			finalScoreImage.x = (gameOverBackgroundImage.width / 2) - (finalScoreImage.width / 2);
			finalScoreImage.y = gameOverTitleImage.height + (spacing * 2);
			gameOverScreen.addChild(finalScoreImage);
			
			//Add end game message
			var finalScore:TextField = new TextField();
			finalScore.text = heroShip.getScore().toString();
			var myFormat:TextFormat = new TextFormat();
			//myFormat.color = 0xAA0000;
			myFormat.size = 45;
			//myFormat.font =
			finalScore.setTextFormat(myFormat);
			finalScore.x = (gameOverScreen.width / 2) - (finalScore.textWidth / 2);
			finalScore.y = finalScoreImage.y + (finalScoreImage.height / 2) - (finalScore.height / 2);
			gameOverScreen.addChild(finalScore);
			
			//Add start button
			continueButton = new Sprite();
			continueButton.addEventListener(MouseEvent.CLICK, restartButtonClicked);
			continueButton.addEventListener(MouseEvent.MOUSE_OVER, restartButtonRolledOver);
			continueButton.addEventListener(MouseEvent.MOUSE_OUT, restartButtonRolledOut);
			continueButton.x = (gameOverScreen.width / 2) - (continueButtonImage.width / 2);
			continueButton.y = gameOverScreen.height - 100;
			continueButtonImage.alpha = 1;
			continueButton.addChild(continueButtonImage);
			gameOverScreen.addChild(continueButton);
			
			return gameOverScreen;
		}
		
		private function restartButtonClicked(event:MouseEvent):void
		{
			gameManager.startGame(1000);
		}
		
		private function restartButtonRolledOver(event:MouseEvent):void
		{
			continueButtonImage.alpha = 1;
		}
		
		private function restartButtonRolledOut(event:MouseEvent):void
		{
			continueButtonImage.alpha = 1;
		}
	
	}

}