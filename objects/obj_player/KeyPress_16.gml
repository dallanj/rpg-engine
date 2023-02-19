// Alert testing
var item = new Shell();
item.quantity = 10;

StoreAlert("items",item);
//StoreAlert("currency", 50);
//StoreAlert("inventory", 5);
StoreAlert("reputation", 40);

//StoreAlert("unlockDialog", obj_npc_bob);
//StoreAlert("startQuest", ["completeQuest","read_a_book",false]);
//StoreAlert("completeQuest", ["completeQuest","read_a_book",false]);
StoreAlert("unclaimedRewards", obj_npc_sarah);
keyboard_clear(vk_shift);