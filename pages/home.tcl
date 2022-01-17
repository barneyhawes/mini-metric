set espresso_contexts "off espresso_menu_profile espresso_menu_beans espresso_menu_grind espresso_menu_dose espresso_menu_ratio espresso_menu_yield espresso_menu_temperature"
set espresso_setting_contexts "off espresso_menu_grind espresso_menu_dose espresso_menu_ratio espresso_menu_yield espresso_menu_temperature"
add_background $espresso_contexts
add_page_title $espresso_contexts [translate "decent espresso"]

# variable size button with a symbol on
proc create_symbol_button2 {contexts x y size padding label symbol color action {symbolsize 128} {fontsize 24}} {
	set font_symbol [get_font "Mazzard SemiBold" $symbolsize]
	set font_label [get_font "Mazzard Regular" $fontsize]
	rounded_rectangle $contexts .can [rescale_x_skin $x] [rescale_y_skin $y] [rescale_x_skin [expr $x + $size]] [rescale_y_skin [expr $y + $size]] [rescale_x_skin [expr $size / 6]] $color
	set button_id [add_de1_text $contexts [expr $x + ($size / 2)] [expr $y + ($size / 2) - ($size / 18)] -text $symbol -font $font_symbol -fill $::color_text -anchor "center" -state "hidden"]
	add_de1_text $contexts [expr $x + ($size / 2)] [expr $y + $size - ($size / 24)] -text $label -font $font_label -fill $::color_text -anchor "s" -state "hidden"
	add_de1_button $contexts $action [expr $x - $padding] [expr $y - $padding] [expr $x + 180 + $padding] [expr $y + $size + $padding]
	return $button_id
}

create_symbol_button2 $espresso_contexts 2260 60 240 20 [translate "sleep"] $::symbol_power $::color_menu_background { say [translate "sleep"] $::settings(sound_button_in); start_sleep} 80 18

set ::water_button_id [create_symbol_button2 $espresso_contexts 600 600 360 30 [translate "hot water"] $::symbol_water $::color_menu_background {say [translate "hot water"] $::settings(sound_button_in); do_start_water} 110]
set ::espresso_action_button_id [create_symbol_button2 $espresso_contexts 1080 580 400 30 [translate "espresso"] $::symbol_espresso $::color_menu_background {say [translate {start}] $::settings(sound_button_in); do_start_espresso} 140]
set ::steam_button_id [create_symbol_button2 $espresso_contexts 1600 600 360 30 [translate "steam"] $::symbol_steam $::color_menu_background {say [translate "steam"] $::settings(sound_button_in); do_start_steam} 110]

set ::flush_button_id [create_symbol_button2 $espresso_contexts 800 1250 240 30 [translate "flush"] $::symbol_flush $::color_menu_background {say [translate "flush"] $::settings(sound_button_in); do_start_flush} 72 18]
create_symbol_button2 $espresso_contexts 1160 1250 240 20 [translate "settings"] $::symbol_settings $::color_menu_background { say [translate "settings"] $::settings(sound_button_in); show_settings; metric_load_current_profile }  72 18
set ::lastshot_button_id [create_symbol_button2 $espresso_contexts 1520 1250 240 30 [translate "analysis"] $::symbol_chart $::color_menu_background {say [translate "analysis"] $::settings(sound_button_in); do_show_last_shot } 72 18]

proc update_function_buttons {} {
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

#create_button "off" 2280 60 2480 180 [translate "debug"] $::font_button $::color_button $::color_button_text { say [translate "debug"] $::settings(sound_button_in); metric_jump_to "debug"}