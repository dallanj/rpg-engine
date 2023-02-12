function Sarah () : Npc () constructor {
	name = "Sarah";
	description = "A test dummy";
	sprite = spr_npc_sarah;
	object = obj_npc_sarah;
	sprites = frames.D;
	dialog_current = 0; // Active script unlocked
	// Script 1 - Unlock journal dialog 1
	dialog_script[0][0] = [name,"left","Hello I'm Sarah the NPC girl.",noone,noone];
	dialog_script[0][1] = [name,"left","Have you read your journal?",noone,noone];
	dialog_script[0][2] = ["Daniel Lim","right","I have not",noone,noone];
	dialog_script[0][3] = [name,"left","Come back when you have read it.",[[obj_dialog_daniel_journal, 1]],noone];
	// Script 2
	dialog_script[1][0] = ["Daniel Lim","right","I read my journal",noone,noone];
	dialog_script[1][1] = [name,"left","Great!!!",[[obj_dialog_daniel_journal, 2],[obj_npc_sarah, 2]],completeQuest];
	// Script 3 - Unlocked after completing sarahs quest
	dialog_script[2][0] = [name,"left","Hi Daniel",noone,noone];
	dialog_script[2][1] = ["Daniel Lim","right","Hi Sarah",noone,noone];
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
