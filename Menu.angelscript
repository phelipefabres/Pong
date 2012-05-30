
class Menu : MainMenu
{
	Menu()
	{
		MainMenuProperties props;
		props.showMusicSwitch = true;
		props.showSoundSwitch = true;
		props.titleSprite = "sprites/logo_inicio.png";
		props.playButton = "sprites/playerOne.png";
		props.buttonNormPos = vector2(0.5f,0.5f);
		props.titlePos = vector2(0.5f, 0.25f);
		super("empty",@props);
	}
	
	void preLoop()
	{
		MainMenu::preLoop();
		m_mainMenuLayer.addButton("playerTwo","sprites/playerTwo.png",vector2(0.5f,0.65f));

	}
	
	void loop()
	{
		MainMenu::loop();
		if(m_mainMenuLayer.isButtonPressed("playerTwo"))
		{
			m_mainMenuLayer.setButtonPressed("exit",false);
			g_stateManager.setState(Game(1,2));
		}
	}
}
