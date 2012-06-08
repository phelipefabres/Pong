
class WinLayer : UILayer
{
	int player;
	WinLayer(int player)
	{	
		this.player=player;
		if(player==1)
			addSprite("sprites/you_win_icon.png",COLOR_WHITE,GetScreenSize()*V2_HALF,V2_HALF);
		else
			addSprite("sprites/you_win_icon2.png",COLOR_WHITE,GetScreenSize()*V2_HALF,V2_HALF);
			
			addButton("restart","sprites/restart_game.png",vector2(0.25f,0.85f));
			addButton("exit","sprites/exit.png",vector2(0.75f,0.85f));
	}
	
	void update()
	{
		UILayer::update();
		
		if(isButtonPressed("restart"))
		{
			setButtonPressed("exit",false);
			if(player==1)
				g_stateManager.setState(Game(1,player));
			else
				g_stateManager.setState(Game(1,player));
		}
		if(isButtonPressed("exit"))
		{
			setButtonPressed("exit",false);
			Exit();
		}
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