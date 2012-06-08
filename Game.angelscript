
class Game : GameState
{
	
	ETHEntity @Ball;
	ETHEntity @MainPin;
	ETHEntity @Pin;
	int scoreMainPin;
	int scorePin;
	int playertwo;
	Game(uint id, int player)
	{
		
		playertwo = player;
		scoreMainPin = 0;
		scorePin = 0;
		GameStateProperties props;
		props.menuButtonNormPos = vector2(1,0);
		props.menuButton = "sprites/menuButton2.png";
		props.backToMainMenuButton = "sprites/backMainMenu.png";
		props.resumeGameButton = "sprites/resumeButton.png";
		super(id, "scenes/main.esc", @props);
	}
	void loadSounds()
	{
		LoadSoundEffect("soundfx/pong.wav");
	}
	
	
	void preLoop()
	{
		GameState::preLoop();
		
		SetAmbientLight(vector3(1,1,1));
		
		
		AddEntity("pin.ent",vector3(GetScreenSize()*vector2(0.15f,0.5f),0),MainPin);
		
			
		AddEntity("pin.ent",vector3(GetScreenSize()*vector2(0.9f,0.5f),0),Pin);
		if(playertwo == 1)
			Pin.SetFloat("speed",340.0f);


		AddEntity("ball.ent",vector3(GetScreenSize()*vector2(0.5f,0.5f),0),Ball);
		loadSounds();
		g_timeManager.resume();
	}
	void onResume()
	{
	loadSounds();
	}
	
	//alters the direction of the ball when it colides whith something
	void ballDirectionChange(float PinPosY, float PinSizeY)
	{
		SetSampleSpeed("soundfx/pong.wav",1.2f);
		PlaySample("soundfx/pong.wav");
		float newDir = (PinPosY - Ball.GetPositionXY().y)/PinSizeY;
		vector2 vec = Ball.GetVector2("direction")- vector2(0.0f,newDir);
		Ball.SetVector2("direction", vec*vector2(-1.0f,1.0f));
		Ball.AddToPositionXY(Ball.GetVector2("direction")*vector2(10.0f,1.0f));
	}
	
	//verify witch side of the screen is touched by the users
	bool getTouchSide(vector2 pos)
	{
		if(pos.x < (GetScreenSize().x/2))
			return true;
			
		return false;
	}
	
	//Controlers of the Pin movimentation
	void pinControlMoves()
	{
		ETHInput @input = GetInputHandle();
	
		
			float speedPin = g_timeManager.unitsPerSecond(MainPin.GetFloat("speed"));
			
			if(input.KeyDown(K_UP))
			{
				MainPin.AddToPositionXY(vector2(0,-1)* speedPin);
				Ball.SetUInt("inGame",1);
			}
			
			if(input.KeyDown(K_DOWN))
			{
				MainPin.AddToPositionXY(vector2(0,1)* speedPin);
				Ball.SetUInt("inGame",1);
			}
			
				for(uint i=0; i<input.GetMaxTouchCount();i++)
				{
					if(input.GetTouchState(i)==KS_DOWN)
					{
						if(getTouchSide(input.GetTouchPos(i)))
							{
							MainPin.AddToPositionXY(vector2(0,input.GetTouchMove(i).y)*g_timeManager.getFactor());
							Ball.SetUInt("inGame",1);
							}
						else
							{
							Pin.AddToPositionXY(vector2(0,input.GetTouchMove(i).y)*g_timeManager.getFactor());
							Ball.SetUInt("inGame",1);
							}
					}

				}
			

		
			
			//simulates the 'back' button in the phone, if it hits the menu popup is called*/
			if(input.GetKeyState(K_BACK)== KS_HIT)
			{
				showMenuPopup();
 			}
			
	}
	
	//controu the moviments of the 2 pins in the scene and verify the collisions that happens in the scene
	void collisionPinBallScene()
	{
			if(scaledCollide(Ball,MainPin)) 
			{
				AddEntity("particle2.ent",Ball.GetPosition(),180);
				ballDirectionChange(MainPin.GetPositionXY().y,MainPin.GetSize().y);
			}
			else if (scaledCollide(Ball,Pin))
			{
				AddEntity("particle2.ent",Ball.GetPosition(),0);
				ballDirectionChange(Pin.GetPositionXY().y,Pin.GetSize().y);
			}

		float minBallHeight = GetScreenSize().y-(Ball.GetSize().y/2);
		float maxBallHeight = Ball.GetSize().y/2;
		
		if(Ball.GetPositionXY().y > minBallHeight || Ball.GetPositionXY().y < maxBallHeight)
		{
			SetSampleSpeed("soundfx/pong.wav",0.6f);
			PlaySample("soundfx/pong.wav");
			if(Ball.GetPositionXY().y > minBallHeight)
				AddEntity("particle.ent",Ball.GetPosition(),180);
			else
				AddEntity("particle.ent",Ball.GetPosition(),0);

			Ball.SetVector2("direction", Ball.GetVector2("direction")*vector2(1.0f,-1.0f));
			Ball.AddToPositionXY(Ball.GetVector2("direction")*vector2(1.0f,10.0f));
		}
		
		float aBs = abs(Ball.GetPositionXY().y - Pin.GetPositionXY().y);
		float speed = min(g_timeManager.unitsPerSecond(Pin.GetFloat("speed")),aBs);
		
		
		if(Ball.GetPositionXY().y < Pin.GetPositionXY().y)
		{
			Pin.AddToPositionXY(vector2(0,-1)* speed);
		}
		else if(Ball.GetPositionXY().y > Pin.GetPositionXY().y)
		{
			Pin.AddToPositionXY(vector2(0,1)* speed);
		}
		
		
		//when a player makes a score, the ball returns to the center of the screen and is released when the 
		//user taps the screen
		
		if(Ball.GetPositionXY().x > GetScreenSize().x && Ball.GetUInt("inGame")==1)
		{
			Ball.SetUInt("inGame",0);
			scoreMainPin++;
			Ball.SetVector2("direction",vector2(-1,0));
			float speed =g_timeManager.unitsPerSecond(Ball.GetFloat("speed"));
			Ball.SetPositionXY(GetScreenSize()/2);
			
		}
		else if (Ball.GetPositionXY().x < 0 && Ball.GetUInt("inGame")==1)
		{
			Ball.SetUInt("inGame",0);
			scorePin++;
			Ball.SetVector2("direction",vector2(-1,0));
			float speed =g_timeManager.unitsPerSecond(Ball.GetFloat("speed"));
			Ball.SetPositionXY(GetScreenSize()/2);
			
		}
	}
	
	//shows whith layer will be selected when the game finish
	void scoreManager(string name,int player)
	{
		if(m_layerManager.getCurrentLayer().getName() != name)
			{
				if(name=="GameOverLayer")
					addLayer(GameOverLayer());
				else
					addLayer(WinLayer(player));

				m_layerManager.setCurrentLayer(name);
				DeleteEntity(Ball);
				g_timeManager.pause();
			}
	}
	
	
	void loop()
	{
		GameState::loop();
			
			
		pinControlMoves();		
			
		
		collisionPinBallScene();
	
		//Drawing the score text in the scene		
		DrawText(vector2(384,0), "Score","Verdana30_shadow.fnt", ARGB(250,255,255,255));
		DrawText(vector2(395,30), "" + scorePin,"Verdana30_shadow.fnt", ARGB(250,255,255,255));
		DrawText(vector2(357,30), "" + scoreMainPin,"Verdana30_shadow.fnt", ARGB(250,255,255,255));
		
		
		//show de Layer for the gameover when it's a 2 player game
		if(playertwo==2)
		{
			if(scorePin==3)
				scoreManager("WinLayer",2);
			else if(scoreMainPin==3)
				scoreManager("WinLayer",1);
	    }
		else		//show de Layer for the gameover when it's a 2 player game

		{
			if(scorePin==3)
				scoreManager("GameOverLayer",1);
			else if(scoreMainPin==3)
				scoreManager("WinLayer",1);

		}
		
	}
}
