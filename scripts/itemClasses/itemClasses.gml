function Item () constructor {
	name = "";
	price = 0;
	attackPower = 1;
	stackable = false;
	sprite = "";
	object = "";
	description = "";
	quantity = 1;
	
	//Effect = function () {}
}

function Potion () : Item () constructor {
	attackPower = -1;
	hpAdd = 0;
	staminaAdd = 0;
}