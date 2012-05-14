
class Game : GameState
{
	
	ETHEntity @Ball;
	ETHEntity @Pin1;
	ETHEntity @Pin2;
	uint idx;
	Game(uint id)
	{
		
		idx = id;
		GameStateProperties props;
		super(id, "scenes/main.esc", @props);
	}
	
	
	
	void preLoop()
	{
		GameState::preLoop();
		
		g_scale.scaleEntities();
		
		/*SetAmbientLight(vector3(1,1,1));
		
		
		LoadSoundEffect("soundfx/tiro.mp3");
		LoadSoundEffect("soundfx/asteroide_explosao.mp3");
		LoadSoundEffect("soundfx/explosion_huge.mp3");
		
		
		LoadMusic("soundfx/trilha.mp3");
		LoopSample("soundfx/trilha.mp3",true);
		PlaySample("soundfx/trilha.mp3");*/
	
	}
	
	
	void loop()
	{
		GameState::loop();
		
		
		ETHInput @ input =  GetInputHandle();
	
		/*if(input.GetKeyState(K_ESC) == KS_HIT)
		{
			g_stateManager.setState(Menu());
		//	StopSample("soundfx/trilha.mp3");
		}*/
		
		/*if(SeekEntity("asteroid.ent") is null && SeekEntity("nave.ent") is null && SeekEntity("nave_chefe.ent") is null)
		{
			deadTime += g_timeManager.getLastFrameElapsedTime();
			StopSample("soundfx/trilha.mp3");
		
			if(deadTime >= 3000)
				g_stateManager.setState(Menu());
		}
		else if(SeekEntity("Destroyer") is null )
		{
			if(m_layerManager.getCurrentLayer().getName() != "GameOverLayer")
			{
				addLayer(GameOverLayer());
				m_layerManager.setCurrentLayer("GameOverLayer");
			}
		}
		
		if (cont < 10)
			time += g_timeManager.getLastFrameElapsedTime();
			
		ETHEntity @ crazyAsteroid;
		ETHEntity @ otherShip;
		ETHEntity @ boss;
		
		if(time >= 2000)
		{
			//AddEntity("asteroid.ent",vector3(randF(GetScreenSize().x),-30,0), crazyAsteroid);
			AddScaledEntity("asteroid.ent",vector3(randF(GetScreenSize().x),g_scale.scale(-30),0),g_scale.getScale(), crazyAsteroid); 
			//AddEntity("otherShip.ent",vector3(randF(GetScreenSize().x),-30,0),otherShip);
			AddScaledEntity("otherShip.ent",vector3(randF(GetScreenSize().x),g_scale.scale(-30),0),g_scale.getScale(),otherShip);
			crazyAsteroid.SetString("type", "randon");
			time =0;
			cont++;
		}
		
		if(cont2<5)
			timeBoss += g_timeManager.getLastFrameElapsedTime();
		
		
		
		if(timeBoss >= 3000)
		{
			//AddEntity("boss.ent",vector3(randF(GetScreenSize().x),-30,0),boss);
			AddScaledEntity("boss.ent",g_scale.scale(vector3(randF(GetScreenSize().x),-30,0)),g_scale.getScale(),boss);
			boss.SetUInt("shot",0);
			timeBoss=0;
			cont2++;
		}
		
		*/
		
		//DrawText(vector2(0,200), "Entidades = "+ GetNumEntities(),"Verdana14_shadow.fnt", ARGB(250,255,255,255));
		
		
		
	}
}
