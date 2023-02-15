function Sarah () : Npc () constructor {
	name = "Sarah";
	description = "A test dummy";
	sprite = spr_npc_sarah;
	object = obj_npc_sarah;
	sprites = frames.D;
	dialog_current = 0; // Active script unlocked
	// Script 1 - Unlock journal dialog 1
	dialog_script[0][0] = [name,"left","Hello I'm Sarah the NPC girl.",noone,noone,noone];
	dialog_script[0][1] = [name,"left","Have you read your journal?",noone,noone,noone];
	dialog_script[0][2] = ["Daniel Lim","right","I have not",noone,noone,noone];
	dialog_script[0][3] = [name,"left","Come back when you have read it.",[[obj_dialog_daniel_journal, 1]],noone,noone];
	// Script 2
	dialog_script[1][0] = ["Daniel Lim","right","I read my journal",noone,noone,noone];
	dialog_script[1][1] = [name,"left","Great!!!",[[obj_dialog_daniel_journal, 2],[obj_npc_sarah, 2]],[[updateCurrency, 25]],noone];
	// Script 3 - Unlocked after completing sarahs quest
	dialog_script[2][0] = [name,"left","Hi Daniel",noone,noone,noone];
	dialog_script[2][1] = ["Daniel Lim","right","Hi Sarah",noone,noone,noone];
}

function Bob () : Npc () constructor {
	name = "Bob";
	description = "A test dummy but male";
	sprite = spr_npc_bob;
	object = obj_npc_bob;
	sprites = frames.S;
	dialog_current = 0; // Active script unlocked
	
	// Script to start quest of turning on computer
	dialog_script[0][0] = [name,"left","Can you turn on your computer for me?",noone,noone,noone];
	dialog_script[0][1] = ["Daniel Lim","right",noone,noone,noone,[[1,"Yes","Yes I will",[[obj_dialog_daniel_computer, 1],[obj_npc_bob, 2]]],[2,"Not right now","I will later",noone],[3,"Fuck off","NOPE!",[[obj_npc_bob, 1]]]]];
	dialog_script[0][2] = [name,"left","Ok",noone,noone,noone];
	
	// After option 3 is selected - Option to start quest is gone
	dialog_script[1][0] = [name,"left","Go away",noone,noone,noone];
	
	// After option 1 is selected - Option to start quest is gone
	dialog_script[2][0] = [name,"left","Did you turn on computer yet?",noone,noone,noone];
	dialog_script[2][1] = ["Daniel Lim","right","No not yet",noone,noone,noone];
	
	// After computer turned on - Quest complete
	dialog_script[3][0] = [name,"left","Thanks for using your computer!",noone,[[updateCurrency, 100],[updateInventory,[ITEM.TOAD,1]],[updateInventory,[ITEM.SHELL,6]]],noone];
	dialog_script[3][1] = ["Daniel Lim","right","No problem!",[[obj_npc_bob, 4]],noone,noone];
	
	// Regular dialog after quest complete
	dialog_script[4][0] = [name,"left","Hey Daniel",noone,noone,noone];
	dialog_script[4][1] = ["Daniel Lim","right","Hey Bob",noone,noone,noone];
	
	
}
