function DanielJournal () : DialogItem () constructor {
	name = "Journal";
	description = "Daniel's journal";
	dialog_script[0] = ["Daniel Lim","right","This is my journal, should I open it?"];
	dialog_script[1] = ["Daniel Lim","right","Maybe I shouldn't"];
}

function DanielComputer () : DialogItem () constructor {
	name = "Computer";
	description = "Daniel's computer";
	dialog_script[0] = ["Daniel Lim","right","Grandma said I can't use my computer till I get some of the ingredients"];
}
