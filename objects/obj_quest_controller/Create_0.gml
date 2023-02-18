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
			inventory: {
				quantity: 3,
				rewarded: false,
			},
			reputation: noone,
			items: noone,
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
			inventory: {
				quantity: 3,
				rewarded: false,
			},
			reputation: noone,
			items: [
				{
					item: new Toad(),
					quantity: 1,
					rewarded: false
				},
				{
					item: new Shell(),
					quantity: 4,
					rewarded: false
				},
			]
		}
    },
};