#include "ETHFramework/IncludeModules.angelscript"
#include "Menu.angelscript"
#include "Game.angelscript"
#include "Pin.angelscript"
#include "Ball.angelscript"
#include "GameOverLayer.angelscript"


void main()
{
	g_scale.updateScaleFactor(DEFAULT_SCALE_HEIGHT);
	@g_gameStateFactory = SMyStateFactory();
	g_stateManager.setState(g_gameStateFactory.createMenuState());
	SetPersistentResources(true);
}

class MyChooser : ItemChooser
{
	bool performAction(const uint itemIdx)
	{
		g_stateManager.setState(g_gameStateFactory.createGameState(itemIdx));
		return true;
	}

	bool validateItem(const uint itemIdx)
	{
		return ((itemIdx > 15) ? false : true);
	}

	void itemDrawCallback(const uint index, const vector2 &in pos, const vector2 &in offset)
	{
	}
}

class SMyStateFactory : SGameStateFactory
{
	State@ createMenuState()
	{
		
		return Menu();
	}

	State@ createLevelSelectState()
	{
		/*PageProperties props;
		@(props.itemChooser) = MyChooser();
		return LevelSelector("empty", @props);*/
		return createGameState(Game(1));
	}

	State@ createGameState(const uint idx)
	{
		return Game(idx);
	}
}

void loop()
{
	g_stateManager.runCurrentLoopFunction();

	#if TESTING
		DrawText(V2_ZERO, "" + GetFPSRate(), "Verdana20_shadow.fnt", COLOR_WHITE);
	#endif
}

void preLoop()
{
	g_scale.updateScaleFactor(DEFAULT_SCALE_HEIGHT);
	g_stateManager.runCurrentPreLoopFunction();

	SetZBuffer(false);
	SetPositionRoundUp(false);
	SetFastGarbageCollector(false);
	SetNumIterations(8, 3);
}

// called when the program is paused and then resumed (all resources were cleared, need reload)
void onResume()
{
	g_stateManager.runCurrentOnResumeFunction();
}
