set_global_assignment -entity "PLL_40MHz" -library "lib_PLL_40MHz" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "PLL_40MHz" -library "lib_PLL_40MHz" -name IP_TOOL_VERSION "25.1"
set_global_assignment -entity "PLL_40MHz" -library "lib_PLL_40MHz" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_PLL_40MHz" -name SPD_FILE [file join $::quartus(sip_path) "PLL_40MHz.spd"]

set_global_assignment -library "lib_PLL_40MHz" -name MISC_FILE [file join $::quartus(sip_path) "PLL_40MHz_sim/PLL_40MHz.vho"]
