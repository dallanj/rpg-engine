function Sarah () : Npc () constructor {
	name = "Mother Lim";
	description = "A test dummy";
	sprite = spr_npc_sarah;
	object = obj_npc_sarah;
	dialog_sprite = spr_dialog_mother;
	sprites = frames.D;
	dialog_current = 0; // Active script unlocked
	
	// Dialog script structure
	// dialog_script[script_number][line_number] = [
	//	name_of_speaker => "Luna",
	//	direction_of_speaker => "left",
	//	dialog_string => "Hello World",
	//	scripts_to_run => [["inventory",amount,rewarded]],
	//	more scripts to run, // SHOULD BE REMOVED
	//	dialog_choices_and_scripts => see example below,
	//	sprite_artwork => spr_artwork
	//];
	
	// Dialog choice argument: [
	//[1,"Yes","Yes I will",[["startQuest","turn_on_computer",false]]],
	//[2,"No","No sorry",noone],
	//]
	
	// Example Scripts: [
	//["inventory",amount,rewarded],
	//["currency",60,false],
	//["reputation",1,false]
	//]
	
	//Items Script: [
	//"items",
	//[
	//	{
	//		item: new Ghost(),
	//		quantity: 1,
	//		rewarded: false,
	//	},
	//	{
	//		item: new Shell(),
	//		quantity: 8,
	//		rewarded: false
	//	},
	//],
	//obj_npc
	//]
	
	// Example Scripts: [
	//["startQuest",quest.name,started (boolean)],
	//["unlockDialog",obj_npc,script_index,unlocked (boolean)],
	//["completeQuest","read_a_book",false]
	//]
	
	// Script 1 - Start journal quest
	dialog_script[0][0] = [name,"left","Hello I'm Sarah the NPC girl.",[["inventory",1,false],["currency",60,false],["reputation",1,false]],noone,noone,spr_dialog_mother];
	dialog_script[0][1] = [name,"left","Have you read your journal?",[["items",[{item: new Ghost(),quantity: 1,rewarded: false},{item: new Toad(),quantity: 1,rewarded: false}],object]],noone,noone,spr_dialog_mother];
	dialog_script[0][2] = ["Daniel Lim","right","I have not",noone,noone,noone,spr_dialog_mother];
	dialog_script[0][3] = [name,"left","Come back when you have read it.",[["startQuest","read_a_book",false],["unlockDialog",obj_dialog_daniel_journal,1,false]],noone,noone,spr_dialog_mother];
	// Script 2 - Completing journal quest
	dialog_script[1][0] = ["Daniel Lim","right","I read my journal",noone,noone,noone,spr_dialog_mother];
	dialog_script[1][1] = [name,"left","Great!!!",[["completeQuest","read_a_book",false],["unlockDialog",obj_dialog_daniel_journal,2,false],["unlockDialog",obj_npc_sarah,2,false]],[[updateCurrency, 25]],noone,spr_dialog_mother];
	// Script 3 - Basic dialog after quest completion
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
	
	// Script 1 - Start the turn on computer quest
	dialog_script[0][0] = [name,"left","Can you turn on your computer for me?",noone,noone,noone,spr_dialog_luna];
	dialog_script[0][1] = ["Daniel Lim","right",noone,noone,noone,[[1,"Yes","Yes I will",[["startQuest","turn_on_computer",false],["unlockDialog",obj_dialog_daniel_computer,1,false],["unlockDialog",obj_npc_bob,2,false]]],[2,"Not right now","I will later",noone],[3,"Fuck off","NOPE!",[["items",[{item: new Shell(),quantity: 2,rewarded: false}],object],["unlockDialog",obj_npc_bob,1,false]]]],spr_dialog_luna];
	dialog_script[0][2] = [name,"left","Ok",noone,noone,noone,spr_dialog_luna];
	
	// Script 2 - If player choses the wrong answer, they cant start the quest
	dialog_script[1][0] = [name,"left","Go away",[["items",[{item: new Toad(),quantity: 1,rewarded: false},{item: new Shell(),quantity: 4,rewarded: false}],object]],noone,noone,spr_dialog_luna];
	
	// Script 3 - Mid quest dialog
	dialog_script[2][0] = [name,"left","Did you turn on computer yet?",noone,noone,noone,spr_dialog_luna];
	dialog_script[2][1] = ["Daniel Lim","right","No not yet",noone,noone,noone,spr_dialog_luna];
	
	// Script 4 - Complete computer quest
	dialog_script[3][0] = [name,"left","Thanks for using your computer!",[["completeQuest","turn_on_computer",false],["unlockDialog",obj_dialog_daniel_computer,2,false]],noone,noone,spr_dialog_luna];
	dialog_script[3][1] = ["Daniel Lim","right","No problem!",[["unlockDialog",obj_npc_bob,4,false]],noone,noone,spr_dialog_luna];
	
	// Script 5 - Regular dialog after quest complete
	dialog_script[4][0] = [name,"left","Hey Daniel",noone,noone,noone,spr_dialog_luna];
	dialog_script[4][1] = ["Daniel Lim","right","Hey Bob",noone,noone,noone,spr_dialog_luna];
	
	
}
