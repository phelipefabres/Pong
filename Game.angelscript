
class Game : GameState
{
	
	//ETHEntity @Ball;
	//ETHEntity @Pin1;
	//ETHEntity @Pin2;
	//uint idx;
	Game(uint id)
	{
		
		//idx = id;
		GameStateProperties props;
		super(id, "scenes/main.esc", @props);
	}
	
	
	
	void preLoop()
	{
		GameState::preLoop();
		
		SetAmbientLight(vector3(1,1,1));
		
		AddEntity("MainPin.ent",vector3(GetScreenSize()*vector2(0.1f,0.5f),0),0.0f);
		AddEntity("pin.ent",vector3(GetScreenSize()*vector2(0.9f,0.5f),0),0.0f);

		AddEntity("ball.ent",vector3(GetScreenSize()*vector2(0.5f,0.5f),0),0.0f);

		
	}
	
	
	void loop()
	{
		GameState::loop();
		
		
				
		
	}
}
