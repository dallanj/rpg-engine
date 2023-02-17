function Sarah () : Npc () constructor {
	name = "Mother Lim";
	description = "A test dummy";
	sprite = spr_npc_sarah;
	object = obj_npc_sarah;
	dialog_sprite = spr_dialog_mother;
	sprites = frames.D;
	dialog_current = 0; // Active script unlocked
	// Script 1 - Unlock journal dialog 1
	dialog_script[0][0] = [name,"left","Hello I'm Sarah the NPC girl.",noone,noone,noone,spr_dialog_mother];
	dialog_script[0][1] = [name,"left","Have you read your journal?",noone,noone,noone,spr_dialog_mother];
	dialog_script[0][2] = ["Daniel Lim","right","I have not",noone,noone,noone,spr_dialog_mother];
	dialog_script[0][3] = [name,"left","Come back when you have read it.",[["startQuest","read_a_book"],["unlockDialog", obj_dialog_daniel_journal, 1]],noone,noone,spr_dialog_mother];
	// Script 2
	dialog_script[1][0] = ["Daniel Lim","right","I read my journal",noone,noone,noone,spr_dialog_mother];
	dialog_script[1][1] = [name,"left","Great!!!",[["completeQuest","read_a_book"],["unlockDialog", obj_dialog_daniel_journal, 2],["unlockDialog", obj_npc_sarah, 2]],[[updateCurrency, 25]],noone,spr_dialog_mother];
	// Script 3 - Unlocked after completing sarahs quest
	dialog_script[2][0] = [name,"left","Hi Daniel",noone,noone,noone,spr_dialog_mother];
	dialog_script[2][1] = ["Daniel Lim","right","Hi Sarah",noone,noone,noone,spr_dialog_mother];
}

function Bob () : Npc () constructor {
	name = "Luna Lim";
	description = "A test dummy but male";
	sprite = spr_npc_bob;
	object = obj_npc_bob;
	dialog_sprite = spr_dialog_luna;
	sprites = frames.S;
	dialog_current = 0; // Active script unlocked
	
	// Dialog for when completing a quest but inventory is full
	//dialog_script[0][0] = [name,"left","Can you turn on your computer for me?",noone,noone,noone,spr_dialog_luna];
	
	// Script to start quest of turning on computer
	dialog_script[0][0] = [name,"left","Can you turn on your computer for me?",noone,noone,noone,spr_dialog_luna];
	dialog_script[0][1] = ["Daniel Lim","right",noone,noone,noone,[[1,"Yes","Yes I will",[["startQuest","turn_on_computer"],["unlockDialog",obj_dialog_daniel_computer, 1],["unlockDialog",obj_npc_bob, 2]]],[2,"Not right now","I will later",noone],[3,"Fuck off","NOPE!",[["unlockDialog", obj_npc_bob, 1]]]],spr_dialog_luna];
	dialog_script[0][2] = [name,"left","Ok",noone,noone,noone,spr_dialog_luna];
	
	// After option 3 is selected - Option to start quest is gone
	dialog_script[1][0] = [name,"left","Go away",noone,noone,noone,spr_dialog_luna];
	
	// After option 1 is selected - Option to start quest is gone
	dialog_script[2][0] = [name,"left","Did you turn on computer yet?",noone,noone,noone,spr_dialog_luna];
	dialog_script[2][1] = ["Daniel Lim","right","No not yet",noone,noone,noone,spr_dialog_luna];
	
	// After computer turned on - Quest complete
	//dialog_script[3][0] = [name,"left","Thanks for using your computer!",[["completeQuest","turn_on_computer"]],[[updateCurrency, 100],[updateInventory,[ITEM.TOAD,1]],[updateInventory,[ITEM.SHELL,6]]],noone,spr_dialog_luna];
	dialog_script[3][0] = [name,"left","Thanks for using your computer!",[["completeQuest","turn_on_computer"],["unlockDialog", obj_dialog_daniel_computer, 2]],noone,noone,spr_dialog_luna];
	dialog_script[3][1] = ["Daniel Lim","right","No problem!",[["unlockDialog", obj_npc_bob, 4]],noone,noone,spr_dialog_luna];
	
	// Regular dialog after quest complete
	dialog_script[4][0] = [name,"left","Hey Daniel",noone,noone,noone,spr_dialog_luna];
	dialog_script[4][1] = ["Daniel Lim","right","Hey Bob",noone,noone,noone,spr_dialog_luna];
	
	
}
