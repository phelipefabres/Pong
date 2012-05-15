
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
		
		g_scale.scaleEntities();
		
		SetAmbientLight(vector3(1,1,1));
		
		
		
	}
	
	
	void loop()
	{
		GameState::loop();
		
		
				
		
	}
}
