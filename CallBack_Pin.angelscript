void collidePinScreen(ETHEntity @pin)
{
	float MinHeight = GetScreenSize().y-(pin.GetSize().y/2);
	float MaxHeight = pin.GetSize().y/2;
	
	if(pin.GetPositionXY().y > MinHeight)
		pin.SetPositionXY(vector2(pin.GetPositionXY().x,MinHeight));
	else if(pin.GetPositionXY().y < 0+MaxHeight)
		pin.SetPositionXY(vector2(pin.GetPositionXY().x,0+MaxHeight));
}
void ETHConstructorCallback_pin(ETHEntity @ pin)
{
	
//	pin.SetFloat("speed",340.0f);
	pin.SetVector2("direction",vector2(1,1));
	//pin.SetInt("player",0);
}

void ETHCallback_pin(ETHEntity @ pin)
{
	
	collidePinScreen(pin);
}

/*
void ETHConstructorCallback_MainPin(ETHEntity @ pin)
{
	pin.SetFloat("speed",1.0f);
}

void ETHCallback_MainPin(ETHEntity @ pin)
{

	
	
	collidePinScreen(pin);
	
}
*/