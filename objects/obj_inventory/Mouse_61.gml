/// @description Change selected inventory slot
slot_pos += -1;

if (slot_pos < 0) {
	slot_pos = global.total_slots - 1;
}