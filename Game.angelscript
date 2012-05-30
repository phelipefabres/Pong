
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
	
	
	
	void preLoop()
	{
		GameState::preLoop();
		
		SetAmbientLight(vector3(1,1,1));
		
		
		AddEntity("pin.ent",vector3(GetScreenSize()*vector2(0.15f,0.5f),0),MainPin);
		
			
		AddEntity("pin.ent",vector3(GetScreenSize()*vector2(0.9f,0.5f),0),Pin);
		if(playertwo == 1)
			Pin.SetFloat("speed",340.0f);


		AddEntity("ball.ent",vector3(GetScreenSize()*vector2(0.5f,0.5f),0),Ball);
		//LoadSoundEffect("soundfx/ping.mp3");
		LoadSoundEffect("soundfx/pong.wav");
		g_timeManager.resume();
	}
	
	void ballDirectionChange(float PinPosY, float PinSizeY)
	{
		SetSampleSpeed("soundfx/pong.wav",1.2f);
		PlaySample("soundfx/pong.wav");
		float newDir = (PinPosY - Ball.GetPositionXY().y)/PinSizeY;
		vector2 vec = Ball.GetVector2("direction")- vector2(0.0f,newDir);
		Ball.SetVector2("direction", vec*vector2(-1.0f,1.0f));
		Ball.AddToPositionXY(Ball.GetVector2("direction")*vector2(5.0f,1.0f));
	}
	
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
			//if(playertwo == 2)
			{
				for(int i=0; i<input.GetMaxTouchCount();i++)
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
			}

		/*	//moving the Pin with the finger pressed in the screen of the device
			if(input.GetTouchMove(0).y!=0)
			{
				MainPin.AddToPositionXY(vector2(0,input.GetTouchMove(0).y)*g_timeManager.getFactor());
				Ball.SetUInt("inGame",1);
			}
			
			//simulates the 'back' button in the phone, if it hits the menu popup is called*/
			if(input.GetKeyState(K_BACK)== KS_HIT)
			{
				showMenuPopup();
 			}
			
	}
	
	void collisionPinBallScene()
	{
			if(scaledCollide(Ball,MainPin)) 
				ballDirectionChange(MainPin.GetPositionXY().y,MainPin.GetSize().y);
			else if (scaledCollide(Ball,Pin))
				ballDirectionChange(Pin.GetPositionXY().y,Pin.GetSize().y);

		float minBallHeight = GetScreenSize().y-(Ball.GetSize().y/2);
		float maxBallHeight = Ball.GetSize().y/2;
		
		if(Ball.GetPositionXY().y > minBallHeight || Ball.GetPositionXY().y < maxBallHeight)
		{
			SetSampleSpeed("soundfx/pong.wav",0.6f);
			PlaySample("soundfx/pong.wav");
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
	
	void scoreManager(string name)
	{
		if(m_layerManager.getCurrentLayer().getName() != name)
			{
				if(name=="GameOverLayer")
					addLayer(GameOverLayer());
				else
					addLayer(WinLayer());

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
		
		
		//show de Layer of the gameover
		if(scorePin==3)
			scoreManager("GameOverLayer");//show de Layer of the wingame
		else if(scoreMainPin==3)
			scoreManager("WinLayer");
	
	}
}
