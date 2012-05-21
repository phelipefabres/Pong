
void ETHConstructorCallback_ball(ETHEntity @ ball)
{
	ball.SetFloat("speed",240.0f);
	//ball.AddToPositionXY(vector2(-1,0)*ball.GetFloat("speed"));
	ball.SetVector2("direction",vector2(-1,0));
}

void ETHCallback_ball(ETHEntity @ ball)
{
	float speed =g_timeManager.unitsPerSecond(ball.GetFloat("speed"));
	
	ball.AddToPositionXY(ball.GetVector2("direction")*speed);


	
}
