enum ITEM {
	GHOST,
	SHELL,
	TOAD,
}

global.items[ITEM.GHOST] = new Ghost();
global.items[ITEM.SHELL] = new Shell();
global.items[ITEM.TOAD] = new Toad();