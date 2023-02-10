/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_white);
	draw_text(200,20,string_hash_to_newline("ai_speed: "+string(ai_speed)
        +"#npc_direction: "+string(npc_direction))
    );
// Inherit the parent event
event_inherited();

