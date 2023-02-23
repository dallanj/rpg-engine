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
	//	scripts_to_run => [[Action.UnlockSlots,amount,rewarded]],
	//	more scripts to run, // SHOULD BE REMOVED
	//	dialog_choices_and_scripts => see example below,
	//	sprite_artwork => spr_artwork
	//];
	
	// Dialog choice argument: [
	//[1,"Yes","Yes I will",[[Action.StartQuest,"turn_on_computer",false]]],
	//[2,"No","No sorry",noone],
	//]
	
	// Example Scripts: [
	//[Action.UnlockSlots,amount,rewarded],
	//[Action.UpdateCurrency,60,false],
	//[Action.UpdateReputation,1,false]
	//]
	
	//Items Script: [
	//Action.UpdateInventory,
	//[
	//	{
	//		item: new Ghost(),
	//		rewarded: false,
	//	},
	//	{
	//		item: new Shell(),
	//		rewarded: false
	//	},
	//],
	//obj_npc
	//]
	
	// Example Scripts: [
	//[Action.StartQuest,quest.name,started (boolean)],
	//[Action.UnlockDialog,obj_npc,script_index,unlocked (boolean)],
	//[Action.CompleteQuest,"read_a_book",false]
	//]
	
	// Script 1 - Start journal quest
	dialog_script[0][0] = [name,"left","Hello I'm Sarah the NPC girl.",noone,noone,noone,spr_dialog_mother];
	dialog_script[0][1] = [name,"left","Have you read your journal?",noone,noone,noone,spr_dialog_mother];
	dialog_script[0][2] = ["Daniel Lim","right","I have not",noone,noone,noone,spr_dialog_mother];
	dialog_script[0][3] = [name,"left","Come back when you have read it.",[
		{action: Action.StartQuest, value: BOOK_READER, rewarded: false},
		{action: Action.UnlockDialog, value: { dialog: 1, npc: obj_dialog_daniel_journal}, rewarded: false}],noone,noone,spr_dialog_mother];
	// Script 2 - Completing journal quest
	dialog_script[1][0] = ["Daniel Lim","right","I read my journal",noone,noone,noone,spr_dialog_mother];
	dialog_script[1][1] = [name,"left","Great!!!",[
		{action: Action.CompleteQuest, value: Quest.BookReader, rewarded: false},
		{action: Action.UpdateCurrency, value: 1000, rewarded: false},
		{action: Action.UnlockDialog, value: { dialog: 2, npc: obj_dialog_daniel_journal}, rewarded: false},
		{action: Action.UnlockDialog, value: { dialog: 2, npc: obj_npc_sarah}, rewarded: false},],noone,noone,spr_dialog_mother];
	// Script 3 - Basic dialog after quest completion
	dialog_script[2][0] = [name,"left","Hi Daniel",[{action: Action.UpdateReputation, value: 1000, rewarded: false}],noone,noone,spr_dialog_mother];
	dialog_script[2][1] = ["Daniel Lim","right","Hi Sarah",[{action: Action.UnlockSlots, value: 3, rewarded: false}],noone,noone,spr_dialog_mother];
}

function Bob () : Npc () constructor {
	name = "Luna Lim";
	description = "A test dummy but male";
	sprite = spr_npc_bob;
	object = obj_npc_bob;
	dialog_sprite = spr_dialog_luna;
	sprites = frames.S;
	dialog_current = 0; // Active script unlocked
	
	//dialog_script[0][1] = ["Daniel Lim","right",noone,noone,noone,[[1,"Yes","Yes I will",[[Action.StartQuest,"turn_on_computer",false],[Action.UnlockDialog,obj_dialog_daniel_computer,1,false],[Action.UnlockDialog,obj_npc_bob,2,false]]],[2,"Not right now","I will later",noone],[3,"Fuck off","NOPE!",[[Action.UpdateInventory,[{action:item: SHELL(4),rewarded: false}],object],[Action.UnlockDialog,obj_npc_bob,1,false]]]],spr_dialog_luna];
	
	// Script 1 - Start the turn on computer quest
	dialog_script[0][0] = [name,"left","Can you turn on your computer for me?",noone,noone,noone,spr_dialog_luna];
	dialog_script[0][1] = ["Daniel Lim","right",noone,noone,noone,
	[
		[1,"Yes","Yes I will",[
			{action: Action.StartQuest, value: COMPUTER_STARTER, rewarded: false},
			{action: Action.UnlockDialog, value: { dialog: 1, npc: obj_dialog_daniel_computer}, rewarded: false},
			{action: Action.UnlockDialog, value: { dialog: 2, npc: object}, rewarded: false}
		]],
		[2,"Not right now","I will later",noone],
		[3,"Fuck off","NOPE!",[
			{action: Action.UnlockDialog, value: { dialog: 1, npc: object}, rewarded: false}
		]],
	],
	spr_dialog_luna
	];
	dialog_script[0][2] = [name,"left","Ok",noone,noone,noone,spr_dialog_luna];
	
	// Script 2 - If player choses the wrong answer, they cant start the quest
	dialog_script[1][0] = [name,"left","Go away",[{action: Action.UpdateInventory,value:{item: TOAD,npc:object},rewarded: false},{action: Action.UpdateInventory,value:{item: GHOST,npc:object},rewarded: false}],noone,noone,spr_dialog_luna];
	
	// Script 3 - Mid quest dialog
	dialog_script[2][0] = [name,"left","Did you turn on computer yet?",noone,noone,noone,spr_dialog_luna];
	dialog_script[2][1] = ["Daniel Lim","right","No not yet",noone,noone,noone,spr_dialog_luna];
	
	// Script 4 - Complete computer quest
	dialog_script[3][0] = [name,"left","Thanks for using your computer!",[{action: Action.CompleteQuest, value: Quest.ComputerStarter, rewarded: false},{action: Action.UnlockDialog, value: { dialog: 2, npc: obj_dialog_daniel_computer}, rewarded: false}],noone,noone,spr_dialog_luna];
	dialog_script[3][1] = ["Daniel Lim","right","No problem!",[{action: Action.UnlockDialog, value: { dialog: 4, npc: object}, rewarded: false}],noone,noone,spr_dialog_luna];
	
	// Script 5 - Regular dialog after quest complete
	dialog_script[4][0] = [name,"left","Hey Daniel",[{
			action: Action.UpdateInventory,
			value: {
				item: SHELL(7),
				npc: object,
			},
			rewarded: false
		},{
			action: Action.UpdateInventory,
			value: {
				item: SHELL(7),
				npc: object,
			},
			rewarded: false
		}],noone,noone,spr_dialog_luna];
	dialog_script[4][1] = ["Daniel Lim","right","Hey Bob",noone,noone,noone,spr_dialog_luna];
	
	
}
