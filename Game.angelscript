
class Game : GameState
{
	
	ETHEntity @Ball;
	ETHEntity @MainPin;
	ETHEntity @Pin;
	int scoreMainPin;
	int scorePin;
	Game(uint id)
	{
		
		//idx = id;
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
		
		AddEntity("MainPin.ent",vector3(GetScreenSize()*vector2(0.1f,0.5f),0),MainPin);
		AddEntity("pin.ent",vector3(GetScreenSize()*vector2(0.9f,0.5f),0),Pin);

		AddEntity("ball.ent",vector3(GetScreenSize()*vector2(0.5f,0.5f),0),Ball);

		
	}
	
	void ballDirectionChange(float PinPosY, float PinSizeY)
	{
		float newDir = (PinPosY - Ball.GetPositionXY().y)/PinSizeY;
		vector2 vec = Ball.GetVector2("direction")- vector2(0.0f,newDir);
		Ball.SetVector2("direction", vec*vector2(-1.0f,1.0f));
		Ball.AddToPositionXY(Ball.GetVector2("direction")*vector2(5.0f,1.0f));
	}
	
	void loop()
	{
		GameState::loop();
		
		if(scaledCollide(Ball,MainPin)) 
			ballDirectionChange(MainPin.GetPositionXY().y,MainPin.GetSize().y);
		else if (scaledCollide(Ball,Pin))
			ballDirectionChange(Pin.GetPositionXY().y,Pin.GetSize().y);

		float minBallHeight = GetScreenSize().y-(Ball.GetSize().y/2);
		float maxBallHeight = Ball.GetSize().y/2;
		
		if(Ball.GetPositionXY().y > minBallHeight || Ball.GetPositionXY().y < maxBallHeight)
		{
			Ball.SetVector2("direction", Ball.GetVector2("direction")*vector2(1.0f,-1.0f));
			Ball.AddToPositionXY(Ball.GetVector2("direction")*vector2(1.0f,5.0f));
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
		
		
		
		
		if(Ball.GetPositionXY().x > GetScreenSize().x)
		{
			scoreMainPin++;
			Ball.SetVector2("direction",vector2(-1,0));
			float speed =g_timeManager.unitsPerSecond(Ball.GetFloat("speed"));
			Ball.SetPositionXY(GetScreenSize()/2);

		}
		else if (Ball.GetPositionXY().x < 0)
		{
			scorePin++;
			Ball.SetVector2("direction",vector2(-1,0));
			float speed =g_timeManager.unitsPerSecond(Ball.GetFloat("speed"));
			Ball.SetPositionXY(GetScreenSize()/2);
		}
			
		DrawText(vector2(384,0), "Score","Verdana30_shadow.fnt", ARGB(250,255,255,255));
		DrawText(vector2(395,30), "" + scorePin,"Verdana30_shadow.fnt", ARGB(250,255,255,255));
		DrawText(vector2(357,30), "" + scoreMainPin,"Verdana30_shadow.fnt", ARGB(250,255,255,255));
		
		
		if(scorePin==3)
		{
			if(m_layerManager.getCurrentLayer().getName() != "GameOverLayer")
			{
				addLayer(GameOverLayer());
				m_layerManager.setCurrentLayer("GameOverLayer");
				DeleteEntity(Ball);
			}
		}
		else if(scoreMainPin==1)
		{
			if(m_layerManager.getCurrentLayer().getName() != "WinLayer")
			{
				addLayer(WinLayer());
				m_layerManager.setCurrentLayer("WinLayer");
				DeleteEntity(Ball);
			}
		}
		
	}
}
