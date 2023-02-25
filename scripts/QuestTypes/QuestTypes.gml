function bookReader () : questClass () constructor {
	id = Quest.BookReader;
	name = "Book Reader";
    description = "Mom wants you to read a book";
    objective = "Read one of your books";
    reward = "100 gold";
	npc = obj_npc_sarah;
	starting_requirements = [
		{
			// Other quests needed to have started or completed
			action: QuestController.QuestStatus,
			value: {
				quest: Quest.ComputerStarter,
				started: true,
				completed: noone,
			},
			valid: false,
		},
		{
			// Minimum/maximum time to start the quest
			action: QuestController.CompareDates,
			value: {
				// Can begin quest after start date
				start_date: {
					day: 0,
					hours: 4,
					minutes: 30
				},
				// Can begin quest before end date
				end_date: noone,
			},
			valid: false,
		},
	];
	// Mid quest requirements. Specific npcs and their dialog scripts will be included
	requirements = [
		// Items to be given or received by an npc at a specific point in the game/dialog
		// Currency
		// Time
	];
	// Requirements to complete a quest
	completing_requirements = [];
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