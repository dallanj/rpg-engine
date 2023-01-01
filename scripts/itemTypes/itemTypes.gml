function Toad () : Item () constructor {
	id = 1;
	name = "Toad mushroom";
	description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
	price = 10;
	attackPower = 5;
	sprite = spr_item_toad;
	object = obj_item_toad;
	//Effect = function (opponent) {
	//	opponent.hp -= 10;
	//}
}

function Ghost () : Item () constructor {
	id = 2;
	name = "Ghost";
	description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
	price = 8;
	attackPower = 3;
	sprite = spr_item_ghost;
	object = obj_item_ghost;
}

function Shell () : Item () constructor {
	id = 3;
	name = "Red shell";
	description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
	price = 16;
	stackable = true;
	sprite = spr_item_shell;
	object = obj_item_shell;
}

//function Health_Potion () : Potion () constructor {
//	name = "Health Potion";
//	hpAdd = 25;
//}