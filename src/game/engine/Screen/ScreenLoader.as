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
	 */
	public class ScreenLoader
	{
		[Embed(source="../../images/Start_Button.jpg")]
		private var startButtonEmbedImage:Class;
		private var startButtonImage:Bitmap = new startButtonEmbedImage();
		
		[Embed(source="../../images/Restart_Button.jpg")]
		private var restartButtonEmbedImage:Class;
		private var restartButtonImage:Bitmap = new restartButtonEmbedImage();
		
		private var stage:Stage;
		private var startButton:Sprite;
		private var restartButton:Sprite;
		
		private var gameManager:ShooterGameManager;
		
		
		public function ScreenLoader(stage:Stage)
		{
			this.stage = stage;
		}
		
		public function loadGameScreen():Sprite
		{
			var gameArea:Sprite = new Sprite();
			gameArea.graphics.beginFill(0xF0F0F0);
			gameArea.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight - 40);
			gameArea.graphics.endFill();
			gameArea.x = 0;
			gameArea.y = (stage.stageHeight - gameArea.height);
			return gameArea;
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
		
		public function loadHealthBar():TextField
		{
			var format:TextFormat = new TextFormat();
			format.size = 30;
			var healthBar:TextField = new TextField();
			healthBar.text = "Life: 0";
			healthBar.height = 40;
			healthBar.width = 150;
			healthBar.x = 0;
			healthBar.y = 0;
			healthBar.setTextFormat(format);
			healthBar.defaultTextFormat = format;
			return healthBar;
		}
		
		public function loadScoreBar():TextField
		{
			var format:TextFormat = new TextFormat();
			format.size = 30;
			var scoreBar:TextField = new TextField();
			scoreBar.text = "Score: 0";
			scoreBar.height = 40;
			scoreBar.width = 150;
			scoreBar.x = stage.stageWidth - 150;
			scoreBar.y = 0;
			scoreBar.setTextFormat(format);
			scoreBar.defaultTextFormat = format;
			return scoreBar;
		}
		
		public function loadStartScreen(gameManager:ShooterGameManager):Sprite
		{
			this.gameManager = gameManager;
			//Create Screen
			var startScreen:Sprite = new Sprite();
			startScreen.graphics.beginFill(0xF0F0F0);
			startScreen.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			startScreen.graphics.endFill();
			startScreen.x = 0;
			startScreen.y = 0;
			
			//Add welcome message
			var welcomeMessage:TextField = new TextField();
			welcomeMessage.text = "Welcome to Square Shooter!";
			var welcomeFormat:TextFormat = new TextFormat();
			welcomeFormat.color = 0xAA0000;
			welcomeFormat.size = 45;
			welcomeMessage.setTextFormat(welcomeFormat);
			welcomeFormat.italic = true;
			welcomeMessage.autoSize = TextFieldAutoSize.CENTER;
			welcomeMessage.x = (startScreen.width / 2) - (welcomeMessage.textWidth / 2);
			welcomeMessage.y = (startScreen.height / 3) - (welcomeMessage.textHeight / 2);
			startScreen.addChild(welcomeMessage);
			
			//Add instructions
			var instructionMessage:TextField = new TextField();
			instructionMessage.width = welcomeMessage.width;
			instructionMessage.multiline = true;
			instructionMessage.wordWrap = true;
			instructionMessage.text = "Use the arrow keys to move your ship, the space bar fires your weapon, and press the 'p' key to pause";
			var instructionFormat:TextFormat = new TextFormat();
			instructionFormat.size = 25;
			instructionMessage.setTextFormat(instructionFormat);
			instructionMessage.autoSize = TextFieldAutoSize.CENTER;
			instructionMessage.x = (startScreen.width / 2) - (welcomeMessage.textWidth / 2);
			instructionMessage.y = (startScreen.height / 2) - (welcomeMessage.textHeight / 2);
			startScreen.addChild(instructionMessage);
			
			//Add start button
			startButton = new Sprite();
			startButton.addEventListener(MouseEvent.CLICK, startButtonClicked);
			startButton.addEventListener(MouseEvent.MOUSE_OVER, startButtonRolledOver);
			startButton.addEventListener(MouseEvent.MOUSE_OUT, startButtonRolledOut);
			startButton.x = (startScreen.width / 2) - (startButtonImage.width / 2);
			startButton.y = startScreen.height - 100;
			startButtonImage.alpha = .75;
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
			startButtonImage.alpha = .75;
		}
		
		public function loadRestartScreen(gameManager:ShooterGameManager, heroShip:HeroShip):Sprite
		{
			this.gameManager = gameManager;
			//Create Screen
			var restartScreen:Sprite = new Sprite();
			restartScreen.graphics.beginFill(0xF0F0F0);
			restartScreen.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			restartScreen.graphics.endFill();
			restartScreen.x = 0;
			restartScreen.y = 0;
			
			//Add end game message
			var endGameMessage:TextField = new TextField();
			endGameMessage.text = "Great Job! Your final Score was: " + heroShip.getScore();
			var myFormat:TextFormat = new TextFormat();
			myFormat.color = 0xAA0000;
			myFormat.size = 45;
			endGameMessage.setTextFormat(myFormat);
			myFormat.italic = true;
			endGameMessage.autoSize = TextFieldAutoSize.CENTER;
			endGameMessage.x = (restartScreen.width / 2) - (endGameMessage.textWidth / 2);
			endGameMessage.y = (restartScreen.height / 3) - (endGameMessage.textHeight / 2);
			restartScreen.addChild(endGameMessage);
			
			//Add start button
			restartButton = new Sprite();
			restartButton.addEventListener(MouseEvent.CLICK, restartButtonClicked);
			restartButton.addEventListener(MouseEvent.MOUSE_OVER, restartButtonRolledOver);
			restartButton.addEventListener(MouseEvent.MOUSE_OUT, restartButtonRolledOut);
			restartButton.x = (restartScreen.width / 2) - (startButtonImage.width / 2);
			restartButton.y = restartScreen.height - 100;
			restartButtonImage.alpha = .75;
			restartButton.addChild(restartButtonImage);
			restartScreen.addChild(restartButton);
			
			return restartScreen;
		}
		
		private function restartButtonClicked(event:MouseEvent):void
		{
			gameManager.startGame(1000);
		}
		
		private function restartButtonRolledOver(event:MouseEvent):void
		{
			restartButtonImage.alpha = 1;
		}
		
		private function restartButtonRolledOut(event:MouseEvent):void
		{
			restartButtonImage.alpha = .75;
		}
		
		
	}

}