
class WinLayer : UILayer
{

	WinLayer()
	{
		addSprite("sprites/you_win_icon.png",COLOR_WHITE,GetScreenSize()*V2_HALF,V2_HALF);
		addButton("restart","sprites/restart_game.png",vector2(0.5f,0.85f));
		//addButton("selectLevel","sprites/game_over_levelSelect.png",vector2(0.75f,0.85f));
	
	}
	
	void update()
	{
		UILayer::update();
		
		if(isButtonPressed("restart"))
		{
			//StopSample("soundfx/trilha.mp3");
			g_stateManager.setState(Game(1));
		}
		/*if(isButtonPressed("selectLevel"))
		{
			//StopSample("soundfx/trilha.mp3");
			g_stateManager.setState(g_gameStateFactory.createLevelSelectState());
		}*/
	}
	
	string getName() const
	{
		return "WinLayer";
	}
	
	bool isAlwaysActive() const
	{
		return false;
	}
}