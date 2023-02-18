enum DIALOGITEM {
	DANIELJOURNAL,
	DANIELCOMPUTER,
}

global.dialogItems[DIALOGITEM.DANIELJOURNAL] = new DanielJournal();
global.dialogItems[DIALOGITEM.DANIELCOMPUTER] = new DanielComputer();
