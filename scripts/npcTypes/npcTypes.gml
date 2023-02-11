function Sarah () : Npc () constructor {
	name = "Sarah";
	description = "A test dummy";
	sprite = spr_npc_sarah;
	object = obj_npc_sarah;
	sprites = frames.D;
	dialog_script[0] = [name,"left","Hello I'm Sarah the NPC girl"];
	dialog_script[1] = ["Daniel Lim","right","GET OUT OF MY ROOM SARAH!"];
	dialog_script[2] = ["Daniel Lim","right","LIKE RIGHT NOW!!!"];
	dialog_script[3] = [name,"left","OK SORRY... I WILL"];
}

function Bob () : Npc () constructor {
	name = "Bob";
	description = "A test dummy but male";
	sprite = spr_npc_bob;
	object = obj_npc_bob;
	sprites = frames.S;
	dialog_script[0] = [name,"left","Hello I'm Bobby the NPC guy"];
	dialog_script[1] = ["Daniel Lim","right","I'm Daniel, what are you doing in my room?!"];
	dialog_script[2] = [name,"left","Well... you see I'm not sure. How do I leave your room?"];
	dialog_script[3] = ["Daniel Lim","right","I'm not sure either... well maybe through the door there"];
	dialog_script[4] = [name,"left","Okay thanks I guess. Bye"];
}
