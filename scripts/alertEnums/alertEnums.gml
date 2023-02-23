global.quests = [];

enum Action {
	UpdateCurrency,
	UpdateReputation,
	UpdateInventory,
	UnlockSlots,
	UnlockDialog,
	UnclaimedRewards,
	StartQuest,
	CompleteQuest,
}

enum QuestController {
	QuestStatus,
	//StartQuest,
	//CompleteQuest,
}

enum Item {
	Ghost,
	Shell,
	Toad,
}

enum Quest {
	BookReader,
	ComputerStarter,
}

// Macros for new items
#macro SHELL new shell
#macro GHOST new ghost()
#macro TOAD new toad()

#macro BOOK_READER new bookReader()
#macro COMPUTER_STARTER new computerStarter()

#macro ALERT new alertMessage()