// Alert testing
var item = SHELL(4);
storeAlert(Action.UpdateInventory,item);
//StoreAlert("currency", 50);
//StoreAlert("inventory", 5);
storeAlert(Action.UpdateCurrency, 1000);

var item = TOAD;
storeAlert(Action.UpdateInventory,item);

//StoreAlert("unlockDialog", obj_npc_bob);
//StoreAlert("startQuest", ["completeQuest","read_a_book",false]);
//storeAlert(Action.CompleteQuest, "read_a_book" ,false);
//storeAlert("unclaimedRewards", obj_npc_sarah.obj_data);
keyboard_clear(vk_shift);