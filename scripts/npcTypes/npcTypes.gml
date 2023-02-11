function Sarah () : Npc () constructor {
	name = "Mrs Test";
	description = "A test dummy";
	sprite = spr_npc_sarah;
	object = obj_npc_sarah;
	sprites = frames.D;
	dialog_script = "Hello I'm Sarah the NPC girl";
}

function Bob () : Npc () constructor {
	name = "Mr Bob";
	description = "A test dummy but male";
	sprite = spr_npc_bob;
	object = obj_npc_bob;
	sprites = frames.S;
	dialog_script = "Hello I'm Bobby the NPC guy";
}
