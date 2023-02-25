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
	// General dialog scripts
	// General dialog scripts
	generic_dialog[Action.StartQuest][0] = {
		name: name,
		position: "left",
		before: noone,
		dialog: "Sorry but you cant start that quest yet",
		after: noone,
		choices: noone,
		sprite: spr_dialog_mother,
	};
	generic_dialog[Action.StartQuest][1] = {
		name: "Daniel Lim",
		position: "right",
		before: noone,
		dialog: "Okay I'll come back later",
		after: noone,
		choices: noone,
		sprite: spr_dialog_mother,
	};
	// General dialog scripts
	generic_dialog[Action.UnclaimedRewards][0] = {
		name: name,
		position: "left",
		before: noone,
		dialog: "You have unclaimed rewards, come back when you have XX inventory spaces.",
		after: noone,
		choices: noone,
		sprite: spr_dialog_mother,
		
	};
	generic_dialog[Action.UnclaimedRewards][1] = {
		name: "Daniel Lim",
		position: "right",
		before: noone,
		dialog: "Okay I'll come back later",
		after: noone,
		choices: noone,
		sprite: spr_dialog_mother,
	};
	
	// Script 1 - Start journal quest
	dialog_script[0][0] = {
		name: name,
		position: "left",
		dialog: "Hello I'm Sarah the NPC girl.",
		before: noone,
		after: noone,
		choices: noone,
		sprite: spr_dialog_mother,
	};
	dialog_script[0][1] = {
		name: name,
		position: "left",
		dialog: "Have you read your journal?",
		before: noone,
		after: noone,
		choices: noone,
		sprite: spr_dialog_mother,
	};
	dialog_script[0][2] = {
		name: "Daniel Lim",
		position: "right",
		dialog: "I have not but I can",
		before: noone,
		after: noone,
		choices: noone,
		sprite: spr_dialog_mother,
	};
	dialog_script[0][3] = {
		name: name,
		position: "left",
		before: [
			{action: Action.StartQuest, value: BOOK_READER, rewarded: false},
		],
		dialog: "Come back when you have read it.",
		after: [
			{action: Action.UnlockDialog, value: { dialog: 1, npc: obj_dialog_daniel_journal}, rewarded: false}
		],
		choices: noone,
		sprite: spr_dialog_mother,
	};
	
	// Complete quest - triggered by dialog item journal
	dialog_script[1][0] = {
		name: "Daniel Lim",
		position: "right",
		before: noone,
		dialog: "I read my book mom, do I get a reward?",
		after: noone,
		choices: noone,
		sprite: spr_dialog_mother,
	};
	dialog_script[1][1] = {
		name: name,
		position: "left",
		before: noone,
		dialog: "That's great, here is a reward for your obedience",
		after: [
			{action: Action.CompleteQuest, value: Quest.BookReader, rewarded: false},
			{action: Action.UpdateCurrency, value: 1000, rewarded: false},
			{action: Action.UnlockDialog, value: { dialog: 2, npc: obj_dialog_daniel_journal}, rewarded: false},
			{action: Action.UnlockDialog, value: { dialog: 2, npc: obj_npc_sarah}, rewarded: false},
		],
		choices: noone,
		sprite: spr_dialog_mother,
	};
	
	// After completing the quest
	dialog_script[1][0] = {
		name: "Daniel Lim",
		position: "right",
		before: noone,
		dialog: "Hey mom can I get an allowance?",
		after: noone,
		choices: noone,
		sprite: spr_dialog_mother,
	};
	dialog_script[1][1] = {
		name: name,
		position: "left",
		before: noone,
		dialog: "No but I'll take your computer away from you if you keep asking me",
		after: [
			{action: Action.UpdateReputation, value: -25, rewarded: false},
		],
		choices: noone,
		sprite: spr_dialog_mother,
	};
}

function Bob () : Npc () constructor {
	name = "Luna Lim";
	description = "A test dummy but male";
	sprite = spr_npc_bob;
	object = obj_npc_bob;
	dialog_sprite = spr_dialog_luna;
	sprites = frames.S;
	dialog_current = 0; // Active script unlocked
	
	// General dialog scripts
	generic_dialog[Action.StartQuest][0] = {
		name: name,
		position: "left",
		before: noone,
		dialog: "Sorry but you cant start that quest yet",
		after: noone,
		choices: noone,
		sprite: spr_dialog_luna,
	};
	generic_dialog[Action.StartQuest][1] = {
		name: "Daniel Lim",
		position: "right",
		before: noone,
		dialog: "Okay I'll come back later",
		after: noone,
		choices: noone,
		sprite: spr_dialog_luna,
	};
	// General dialog scripts
	generic_dialog[Action.UnclaimedRewards][0] = {
		name: name,
		position: "left",
		before: noone,
		dialog: "You have unclaimed rewards, come back when you have XX inventory spaces.",
		after: noone,
		choices: noone,
		sprite: spr_dialog_luna,
	};
	generic_dialog[Action.UnclaimedRewards][1] = {
		name: "Daniel Lim",
		position: "right",
		before: noone,
		dialog: "Okay I'll come back later",
		after: noone,
		choices: noone,
		sprite: spr_dialog_luna,	
	};
	
	//Action.UnclaimedRewards
	
	// Script 1 - Start the turn on computer quest
	dialog_script[0][0] = {
		name: name,
		position: "left",
		before: noone,
		dialog: "Can you turn on your computer for me?",
		after: noone,
		choices: noone,
		sprite: spr_dialog_luna,
	};
	dialog_script[0][1] = {
		name: "Daniel Lim",
		position: "right",
		before: noone, // Scripts to run before dialog is shown - Check if quest can be started, change dialog if not
		dialog: noone,
		after: noone, // Scripts to run after dialog is shown,
		choices: [
			{
				// TODO: Each choice can trigger a different follow up script for the npc
				choice: 1,
				response: "Yes",
				before: noone,
				dialog: "Yes I will",
				after: [
					// NEXT LINE OF DIALOG [0][2]
					{action: Action.NextDialogLine, value: { dialog: 2, npc: object}, rewarded: false},
				],
			},
			{
				choice: 2,
				response: "Not right now",
				before: noone,
				dialog: "Maybe I will later",
				after: [
					// NEXT LINE OF DIALOG [0][3]
					{action: Action.NextDialogLine, value: { dialog: 3, npc: object}, rewarded: false},
				],
			},
			{
				choice: 3,
				response: "Never",
				before: noone,
				dialog: "I will never!",
				after: [
					// NEXT LINE OF DIALOG [0][4]
					{action: Action.NextDialogLine, value: { dialog: 4, npc: object}, rewarded: false},
				],
			},
		],
		sprite: spr_dialog_luna,
	};
	
	// Decision dialogs based on choice selection
	dialog_script[0][2] = {
		name: name,
		position: "left",
		before: [
			{action: Action.StartQuest, value: COMPUTER_STARTER, rewarded: false},
			{action: Action.UnlockDialog, value: { dialog: 1, npc: obj_dialog_daniel_computer}, rewarded: false},
			{action: Action.UnlockDialog, value: { dialog: 2, npc: object}, rewarded: false},
		],
		dialog: "Great, thanks!",
		after: [
			{action: Action.EndDialog, value: noone, rewarded: false}
		],
		choices: noone,
		sprite: spr_dialog_luna,
	};
	dialog_script[0][3] = {
		name: name,
		position: "left",
		before: noone,
		dialog: "No problem, come back later then",
		after: [
			{action: Action.EndDialog, value: noone, rewarded: false},
		],
		choices: noone,
		sprite: spr_dialog_luna,
	};
	dialog_script[0][4] = {
		name: name,
		position: "left",
		before: [
			{action: Action.UpdateReputation, value: -25, rewarded: false},
			{action: Action.UnlockDialog, value: { dialog: 1, npc: object}, rewarded: false},
		],
		dialog: "That was rude, you should be nice to your elders",
		after: [
			{action: Action.EndDialog, value: noone, rewarded: false},
		],
		choices: noone,
		sprite: spr_dialog_luna,
	};
	
	// Script 2 - If player choses the wrong answer, they cant start the quest
	dialog_script[1][0] = {
		name: name,
		position: "left",
		before: noone,
		dialog: "Get out of my face!!!",
		after: noone,
		choices: noone,
		sprite: spr_dialog_luna,
	};
	// Script 3 - Mid quest dialog
	dialog_script[2][0] = {
		name: name,
		position: "left",
		before: noone,
		dialog: "Did you turn on computer yet?",
		after: noone,
		choices: noone,
		sprite: spr_dialog_luna,
	};
	dialog_script[2][1] = {
		name: "Daniel Lim",
		position: "right",
		before: noone,
		dialog: "No not yet, I will turn it on now",
		after: noone,
		choices: noone,
		sprite: spr_dialog_luna,
	};
	
	// Script 4 - Complete computer quest
	dialog_script[3][0] = {
		name: name,
		position: "left",
		before: noone,
		dialog: "Thanks for using your computer!",
		after: [
			{action: Action.CompleteQuest, value: Quest.ComputerStarter, rewarded: false},
			{action: Action.UnlockDialog, value: { dialog: 2, npc: obj_dialog_daniel_computer}, rewarded: false},
		],
		choices: noone,
		sprite: spr_dialog_luna,
	};
	dialog_script[3][1] = {
		name: "Daniel Lim",
		position: "right",
		before: noone,
		dialog: "No problem!",
		after: [
			{action: Action.UnlockDialog, value: { dialog: 4, npc: object}, rewarded: false},
			{action: Action.UpdateCurrency, value: 1000, rewarded: false},
			{action: Action.UpdateReputation, value: 25, rewarded: false},
			{action: Action.UpdateInventory, value: { item: GHOST, npc: object}, rewarded: false},
			{action: Action.UpdateInventory, value: { item: TOAD, npc: object}, rewarded: false},
			{action: Action.UpdateInventory, value: { item: TOAD, npc: object}, rewarded: false},
			{action: Action.UpdateInventory, value: { item: SHELL(10), npc: object}, rewarded: false},
		],
		choices: noone,
		sprite: spr_dialog_luna,
	};
	
	// Script 5 - Regular dialog after quest complete
	dialog_script[4][0] = {
		name: name,
		position: "left",
		before: noone,
		dialog: "Hello Daniel, how are you doing?",
		after: noone,
		choices: noone,
		sprite: spr_dialog_luna,
	};
	dialog_script[4][1] = {
		name: "Daniel Lim",
		position: "right",
		before: noone,
		dialog: "I'm alright, thank you",
		after: noone,
		choices: noone,
		sprite: spr_dialog_luna,
	};
}
