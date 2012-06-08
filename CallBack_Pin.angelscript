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
	pin.SetVector2("direction",vector2(1,1));
}

void ETHCallback_pin(ETHEntity @ pin)
{
	collidePinScreen(pin);
}

