set espresso_contexts "off"
add_background $espresso_contexts
add_page_title $espresso_contexts [translate "decent espresso"]

create_symbol_button2 $espresso_contexts 2260 60 240 20 [translate "sleep"] $::symbol_power $::color_menu_background { say [translate "sleep"] $::settings(sound_button_in); start_sleep} 80 18

set ::water_button_id [create_symbol_button2 $espresso_contexts 600 500 360 30 [translate "hot water"] $::symbol_water $::color_menu_background {say [translate "hot water"] $::settings(sound_button_in); do_start_water} 110]
set ::espresso_action_button_id [create_symbol_button2 $espresso_contexts 1080 480 400 30 [translate "espresso"] $::symbol_espresso $::color_menu_background {say [translate {start}] $::settings(sound_button_in); do_start_espresso} 140]
set ::steam_button_id [create_symbol_button2 $espresso_contexts 1600 500 360 30 [translate "steam"] $::symbol_steam $::color_menu_background {say [translate "steam"] $::settings(sound_button_in); do_start_steam} 110]

set ::flush_button_id [create_symbol_button2 $espresso_contexts 800 1150 240 30 [translate "flush"] $::symbol_flush $::color_menu_background {say [translate "flush"] $::settings(sound_button_in); do_start_flush} 72 18]
create_symbol_button2 $espresso_contexts 1160 1150 240 20 [translate "settings"] $::symbol_settings $::color_menu_background { say [translate "settings"] $::settings(sound_button_in); show_android_navigation false; show_settings}  72 18
set ::lastshot_button_id [create_symbol_button2 $espresso_contexts 1520 1150 240 30 [translate "analysis"] $::symbol_chart $::color_menu_background {say [translate "analysis"] $::settings(sound_button_in); do_show_last_shot } 72 18]

proc update_function_buttons {} {
	show_android_navigation true 

	if { [can_start_water] } {
		.can itemconfigure $::water_button_id -fill $::color_text
		.can itemconfigure [expr $::water_button_id + 1] -fill $::color_text
	} else {
		.can itemconfigure $::water_button_id -fill $::color_grey_text
		.can itemconfigure [expr $::water_button_id + 1] -fill $::color_grey_text
	}

	if { [can_start_steam] } {
		.can itemconfigure $::steam_button_id -fill $::color_text
		.can itemconfigure [expr $::steam_button_id + 1] -fill $::color_text
	} else {
		.can itemconfigure $::steam_button_id -fill $::color_grey_text
		.can itemconfigure [expr $::steam_button_id + 1] -fill $::color_grey_text
	}	

	if { [can_start_espresso] } {
		.can itemconfigure $::espresso_action_button_id -fill $::color_text
		.can itemconfigure [expr $::espresso_action_button_id + 1] -fill $::color_text
	} else {
		.can itemconfigure $::espresso_action_button_id -fill $::color_grey_text
		.can itemconfigure [expr $::espresso_action_button_id + 1] -fill $::color_grey_text
	}

	if { [can_start_flush] } {
		.can itemconfigure $::flush_button_id -fill $::color_text
		.can itemconfigure [expr $::flush_button_id + 1] -fill $::color_text
	} else {
		.can itemconfigure $::flush_button_id -fill $::color_grey_text
		.can itemconfigure [expr $::flush_button_id + 1] -fill $::color_grey_text
	}

	if { [can_show_last_shot] } {
		.can itemconfigure $::lastshot_button_id -fill $::color_text
		.can itemconfigure [expr $::lastshot_button_id + 1] -fill $::color_text
	} else {
		.can itemconfigure $::lastshot_button_id -fill $::color_grey_text
		.can itemconfigure [expr $::lastshot_button_id + 1] -fill $::color_grey_text
	}
}
add_de1_variable $espresso_contexts -100 -100 -textvariable {[update_function_buttons]}
