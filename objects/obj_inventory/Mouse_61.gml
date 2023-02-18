/// @description Change selected inventory slot
slot_pos += -1;

if (slot_pos < 0) {
	slot_pos = global.unlocked_slots - 1;
}