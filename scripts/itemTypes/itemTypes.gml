function Toad () : Item () constructor {
	id = 1;
	name = "Toad mushroom";
	description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
	price = 10;
	sprite = spr_item_toad;
	inv_sprite = spr_item_toad_inv;
	object = obj_item_toad;
	//Effect = function (opponent) {
	//}
}

function Ghost () : Item () constructor {
	id = 2;
	name = "Ghost";
	description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
	price = 8;
	sprite = spr_item_ghost;
	inv_sprite = spr_item_ghost_inv;
	object = obj_item_ghost;
}

function Shell () : Item () constructor {
	id = 3;
	name = "Red shell";
	description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
	price = 16;
	stackable = true;
	sprite = spr_item_shell;
	inv_sprite = spr_item_shell_inv;
	object = obj_item_shell;
}

function Health_Potion () : Potion () constructor {
	//
}