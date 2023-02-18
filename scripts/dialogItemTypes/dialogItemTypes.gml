function DanielJournal () : DialogItem () constructor {
	name = "Journal";
	description = "Daniel's journal";
	object = obj_dialog_daniel_journal;
	dialog_current = 0; // Active script unlocked
	// Script 1
	dialog_script[0][0] = ["Daniel Lim","right","This is my journal, should I open it?",noone,noone,noone,noone];
	dialog_script[0][1] = ["Daniel Lim","right","Maybe I shouldn't",noone,noone,noone,noone];
	// Script 2 - Unlocked after talking to sarah
	dialog_script[1][0] = ["Daniel Lim","right","Ok I read it",noone,noone,noone,noone];
	dialog_script[1][1] = ["Daniel Lim","right","I should tell Sarah",[["unlockDialog",obj_npc_sarah,1]],noone,noone,noone];
	// Script 3 - Unlocked after completing sarahs quest
	dialog_script[2][0] = ["Daniel Lim","right","Theres nothing new in here",noone,noone,noone,noone];
	dialog_script[2][1] = ["Daniel Lim","right","All good",noone,noone,noone,noone];
}

function DanielComputer () : DialogItem () constructor {
	name = "Computer";
	description = "Daniel's computer";
	object = obj_dialog_daniel_computer;
	dialog_current = 0; // Active script unlocked
	// Script 1
	dialog_script[0][0] = ["Daniel Lim","right","This is my computer",noone,noone,noone,noone];
	// Script 2 - Unlocked after starting quest from luna
	dialog_script[1][0] = ["Daniel Lim","right","Ok I turned it on",[["unlockDialog",obj_npc_bob,3]],noone,noone,noone];
	// Script 3 - Unlocked after quest completed from luna
	dialog_script[2][0] = ["Daniel Lim","right","Should I use my computer?",noone,noone,noone,noone];
	dialog_script[2][1] = ["Daniel Lim","right","I should wait till after school",noone,noone,noone,noone];
}
