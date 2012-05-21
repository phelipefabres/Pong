void collidePinScreen(ETHEntity @pin)
{
	float MinHeight = GetScreenSize().y-(pin.GetSize().y/2);
	float MaxHeight = pin.GetSize().y/2;
	
	if(pin.GetPositionXY().y > MinHeight)
		pin.SetPositionXY(vector2(pin.GetPositionXY().x,MinHeight));
	else if(pin.GetPositionXY().y < 0+MaxHeight)
		pin.SetPositionXY(vector2(pin.GetPositionXY().x,0+MaxHeight));
}
void ETHConstructorCallback_pin(ETHEntity @ Pin)
{
	
	Pin.SetFloat("speed",120.0f);
	Pin.SetVector2("direction",vector2(1,1));
}

void ETHCallback_pin(ETHEntity @ pin)
{
	
	collidePinScreen(pin);
}


void ETHConstructorCallback_MainPin(ETHEntity @ pin)
{
	pin.SetFloat("speed",150.0f);
}

void ETHCallback_MainPin(ETHEntity @ pin)
{

	ETHInput @input = GetInputHandle();
	
		
	float speed = g_timeManager.unitsPerSecond(pin.GetFloat("speed"));
	
	if(input.KeyDown(K_UP))
	{
		pin.AddToPositionXY(vector2(0,-1)* speed);
	}
	
	if(input.KeyDown(K_DOWN))
	{
		pin.AddToPositionXY(vector2(0,1)* speed);
	}
	
	collidePinScreen(pin);
	
}
