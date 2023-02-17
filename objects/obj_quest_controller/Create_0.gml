/// @description
global.quests = {
    read_a_book: {
        name: "Read a Book",
        description: "Mom wants you to read a book",
        objective: "Read one of your books",
        reward: "100 gold",
        completed: false,
		started: false,
		npc: obj_npc_sarah,
		rewards: {
			currency: {
				quantity: 500,
				rewarded: false
			},
			reputation: noone,
			items: noone,
			//[[updateCurrency, 100],[updateInventory,[ITEM.TOAD,1]],[updateInventory,[ITEM.SHELL,6]]]
		}
    },
    turn_on_computer: {
        name: "Turn on Computer",
        description: "Luna wants you to turn on your computer",
        objective: "Turn on your computer",
        reward: "100 gold, 1 x Toad, 4 x Shell",
        completed: false,
		started: false,
		npc: obj_npc_bob,
		rewards: {
			currency: {
				quantity: 100,
				rewarded: false
			},
			reputation: noone,
			items: noone,
			items: [
				{
					item: ITEM.TOAD,
					quantity: 1,
					rewarded: false
				},
				{
					item: ITEM.SHELL,
					quantity: 4,
					rewarded: false
				},
			]
			//[[updateCurrency, 100],[updateInventory,[ITEM.TOAD,1]],[updateInventory,[ITEM.SHELL,6]]]
		}
    },
};