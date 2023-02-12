function DanielJournal () : DialogItem () constructor {
	name = "Journal";
	description = "Daniel's journal";
	//dialog_script[0] = ["Daniel Lim","right","This is my journal, should I open it?"];
	//dialog_script[1] = ["Daniel Lim","right","Maybe I shouldn't"];
	
	dialog_current = 0; // Active script unlocked
	// Script 1
	dialog_script[0][0] = ["Daniel Lim","right","This is my journal, should I open it?",noone,noone];
	dialog_script[0][1] = ["Daniel Lim","right","Maybe I shouldn't",noone,noone];
	// Script 2 - Unlocked after talking to sarah
	dialog_script[1][0] = ["Daniel Lim","right","Ok I read it",noone,noone];
	dialog_script[1][1] = ["Daniel Lim","right","I should tell Sarah",[[obj_npc_sarah,1]],noone];
	// Script 3 - Unlocked after completing sarahs quest
	//dialog_script[3][0] = ["Daniel Lim","right","Theres nothing new in here",noone,noone];
	//dialog_script[3][1] = ["Daniel Lim","right","All good",noone,noone];
}

function DanielComputer () : DialogItem () constructor {
	name = "Computer";
	description = "Daniel's computer";
	dialog_script[0] = ["Daniel Lim","right","Grandma said I can't use my computer till I get some of the ingredients"];
}
