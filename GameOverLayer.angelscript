
class GameOverLayer : UILayer
{

	GameOverLayer()
	{
		addSprite("sprites/game_over_icon.png",COLOR_WHITE,GetScreenSize()*V2_HALF,V2_HALF);
		addButton("restart","sprites/restart_game.png",vector2(0.25f,0.85f));
		addButton("exit","sprites/exit.png",vector2(0.75f,0.85f));
	
	}
	
	void update()
	{
		UILayer::update();
		
		if(isButtonPressed("restart"))
		{
			setButtonPressed("exit",false);
			g_stateManager.setState(Game(1,1));
		}
		if(isButtonPressed("exit"))
		{
			setButtonPressed("exit",false);
			Exit();
		}
	}
	
	string getName() const
	{
		return "GameOverLayer";
	}
	
	bool isAlwaysActive() const
	{
		return false;
	}
}