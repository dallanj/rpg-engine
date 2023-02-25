function DanielJournal () : DialogItem () constructor {
	name = "Journal";
	description = "Daniel's journal";
	object = obj_dialog_daniel_journal;
	dialog_current = 0; // Active script unlocked
	// Script 1
	dialog_script[0][0] = {
		name: "Daniel Lim",
		position: "right",
		dialog: "This is my journal, should I open it?",
		before: noone,
		after: noone,
		choices: noone,
		sprite: noone,
	};
	dialog_script[0][1] = {
		name: "Daniel Lim",
		position: "right",
		dialog: "Maybe I shouldn't",
		before: noone,
		after: noone,
		choices: noone,
		sprite: noone,
	};
	//dialog_script[0][0] = ["Daniel Lim","right","This is my journal, should I open it?",[{action: Action.UpdateInventory, value:{item: SHELL(5),npc:object},rewarded: false}],noone,noone,noone];
	//dialog_script[0][1] = ["Daniel Lim","right","Maybe I shouldn't",[{action: Action.UnlockSlots, value: 2,rewarded: false}],noone,noone,noone];
	// Script 2 - Unlocked after talking to sarah
	dialog_script[1][0] = {
		name: "Daniel Lim",
		position: "right",
		dialog: "Ok I read it",
		before: noone,
		after: noone,
		choices: noone,
		sprite: noone,
	};
	dialog_script[1][1] = {
		name: "Daniel Lim",
		position: "right",
		dialog: "I should tell Sarah",
		before: [
			// Update quest requirement
			{action: Action.UnlockDialog, value: { dialog: 1, npc: obj_npc_sarah},rewarded: false},
		],
		after: noone,
		choices: noone,
		sprite: noone,
	};
	//dialog_script[1][0] = ["Daniel Lim","right","Ok I read it",noone,noone,noone,noone];
	//dialog_script[1][1] = ["Daniel Lim","right","I should tell Sarah",[{action: Action.UnlockDialog, value: { dialog: 1, npc: obj_npc_sarah},rewarded: false}],noone,noone,noone];
	// Script 3 - Unlocked after completing sarahs quest
	dialog_script[2][0] = {
		name: "Daniel Lim",
		position: "right",
		dialog: "Theres nothing new in here",
		before: noone,
		after: noone,
		choices: noone,
		sprite: noone,
	};
}

function DanielComputer () : DialogItem () constructor {
	name = "Computer";
	description = "Daniel's computer";
	object = obj_dialog_daniel_computer;
	dialog_current = 0; // Active script unlocked
	// Script 1
	dialog_script[0][0] = {
		name: "Daniel Lim",
		position: "right",
		dialog: "This is my computer",
		before: noone,
		after: noone,
		choices: noone,
		sprite: noone,
	};
	//dialog_script[0][0] = ["Daniel Lim","right","This is my computer",noone,noone,noone,noone];
	// Script 2 - Unlocked after starting quest from luna
	//dialog_script[1][0] = ["Daniel Lim","right","Ok I turned it on",[{action: Action.UnlockDialog, value: { dialog: 3, npc: obj_npc_bob},rewarded: false}],noone,noone,noone];
	dialog_script[1][0] = {
		name: "Daniel Lim",
		position: "right",
		dialog: "Ok I turned it on",
		before: [
			// Update quest requirement,
			{action: Action.UnlockDialog, value: { dialog: 3, npc: obj_npc_bob},rewarded: false}, // this should be in after scripts
		],
		after: noone,
		choices: noone,
		sprite: noone,
	};
	dialog_script[2][0] = {
		name: "Daniel Lim",
		position: "right",
		dialog: "Should I use my computer?",
		before: noone,
		after: noone,
		choices: noone,
		sprite: noone,
	};
	dialog_script[2][1] = {
		name: "Daniel Lim",
		position: "right",
		dialog: "I should wait till after school",
		before: noone,
		after: noone,
		choices: noone,
		sprite: noone,
	};
	// Script 3 - Unlocked after quest completed from luna
	//dialog_script[2][0] = ["Daniel Lim","right","Should I use my computer?",noone,noone,noone,noone];
	//dialog_script[2][1] = ["Daniel Lim","right","I should wait till after school",noone,noone,noone,noone];
}
