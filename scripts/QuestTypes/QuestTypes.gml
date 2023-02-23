function bookReader () : questClass () constructor {
	id = Quest.BookReader;
	name = "Book Reader";
    description = "Mom wants you to read a book";
    objective = "Read one of your books";
    reward = "100 gold";
	npc = obj_npc_sarah;
	starting_requirements = [
		{
			// quests needed to start
			action: QuestController.QuestStatus,
			value: {
				quest: Quest.ComputerStarter,
				started: noone,
				completed: true
			},
			valid: false,
		},
	];
	//requirements = [
		//{
		//	// item needed by an npc
		//	action:
		//	value: {
		//		item: GHOST,
		//		npc: npc,
		//	},
		//	dialog
		//},
		//{
		//	// currency needed by an npc
		//	currency
		//},
		//{
		//	// slots needed for quest
		//	slots
		//},
		//{
		//	// reputation given by npc
		//	reputation
		//},
		//{
		//	// quests needed
		//	quests
		//},
		//{
		//	// time and day of the week to continue
		//	time
		//},
	//];
	rewards = [
		{
			action: Action.UpdateCurrency,
			value: 200,
			rewarded: false
		},
		{
			action: Action.UnlockSlots,
			value: 3,
			rewarded: false,
		},
		{
			action: Action.UpdateInventory,
			value: {
				item: GHOST,
				npc: npc,
			},
			rewarded: false
		},
		{
			action: Action.UpdateInventory,
			value: {
				item: SHELL(25),
				npc: npc,
			},
			rewarded: false
		},
	];
	
	// Ideas: Run scripts on quest start, and quest completion, and when a checkpoint is reached
}

function computerStarter () : questClass () constructor {
	id = Quest.ComputerStarter;
	name = "Turn on Computer";
    description = "Luna wants you to turn on your computer";
    objective = "Start your computer";
	npc = obj_npc_bob;
	rewards = [
		{
			action: Action.UpdateReputation,
			value: 100,
			rewarded: false
		},
		{
			action: Action.UnlockSlots,
			value: 1,
			rewarded: false,
		},
		{
			action: Action.UpdateInventory,
			value: {
				item: TOAD,
				npc: npc,
			},
			rewarded: false
		},
		{
			action: Action.UpdateInventory,
			value: {
				item: GHOST,
				npc: npc,
			},
			rewarded: false
		},
		{
			action: Action.UpdateInventory,
			value: {
				item: SHELL(2),
				npc: npc,
			},
			rewarded: false
		},
	];
	
	// Ideas: Run scripts on quest start, and quest completion, and when a checkpoint is reached
}