-- -----------------------------------------------------
-- Window rules
-- -----------------------------------------------------

-- Pavucontrol / Blueman (title-based)

hl.window_rule({
	match = {
		title = "^(pavucontrol)$",
	},
	float = true,
})

hl.window_rule({
	match = {
		title = "^(blueman-manager)$",
	},
	float = true,
})

-- -----------------------------------------------------
-- Browser Picture-in-Picture
-- -----------------------------------------------------
hl.window_rule({
	match = {
		title = "^(Picture-in-Picture)$",
	},
	float = true,
	pin = true,
	move = "69.5% 4%",
})

-- -----------------------------------------------------
-- Idle inhibit (fullscreen)
-- -----------------------------------------------------
hl.window_rule({
	match = {
		class = "([window])",
	},
	idle_inhibit = "fullscreen",
})

-- -----------------------------------------------------
-- Calcurse
-- -----------------------------------------------------
hl.window_rule({
	match = {
		title = "^(calcurse)$",
	},
	float = true,
	center = true,
	size = "800 600",
})

-- -----------------------------------------------------
-- NetworkManager GUI
-- -----------------------------------------------------
hl.window_rule({
	match = {
		class = "^(com.network.manager)$",
	},
	float = true,
	move = "1510 50",
	size = "400 650",
})

-- -----------------------------------------------------
-- NMTUI (kitty)
-- -----------------------------------------------------
hl.window_rule({
	match = {
		class = "kitty",
		title = "^(nmtui-float)$",
	},
	tile = false,
	float = true,
	center = true,
	size = "800 500",
})

-- -----------------------------------------------------
-- CypherGate
-- -----------------------------------------------------
hl.window_rule({
	match = {
		class = "^(cyphergate)$",
	},
	float = true,
	center = true,
	size = "850 600",
})

-- -----------------------------------------------------
-- GNOME Calendar
-- -----------------------------------------------------
hl.window_rule({
	match = {
		class = "^(org.gnome.Calendar)$",
	},
	float = true,
	move = "10 45",
	size = "360 600",
})

-- -----------------------------------------------------
-- Pavucontrol (class-based)
-- -----------------------------------------------------
hl.window_rule({
	match = {
		class = "(.*org.pulseaudio.pavucontrol.*)",
	},
	float = true,
	size = "700 600",
	center = true,
	pin = true,
})

-- -----------------------------------------------------
-- Waypaper
-- -----------------------------------------------------
hl.window_rule({
	match = {
		class = "(.*waypaper.*)",
	},
	float = true,
	size = "900 700",
	center = true,
	pin = true,
})

-- -----------------------------------------------------
-- Blueman Manager (class-based)
-- -----------------------------------------------------
hl.window_rule({
	match = {
		class = "(blueman-manager)",
	},
	float = true,
	size = "800 600",
	center = true,
})

-- -----------------------------------------------------
-- nwg-look
-- -----------------------------------------------------
hl.window_rule({
	match = {
		class = "(nwg-look)",
	},
	float = true,
	size = "700 600",
	move = "10% 20%",
	pin = true,
})

-- -----------------------------------------------------
-- nwg-displays
-- -----------------------------------------------------
hl.window_rule({
	match = {
		class = "(nwg-displays)",
	},
	float = true,
	size = "900 600",
	move = "10% 20%",
	pin = true,
})

-- -----------------------------------------------------
-- Mission Center
-- -----------------------------------------------------
hl.window_rule({
	match = {
		class = "(io.missioncenter.MissionCenter)",
	},
	float = true,
	pin = true,
	center = true,
	size = "900 600",
})

-- Preferences window
hl.window_rule({
	match = {
		class = "(missioncenter) match:title ^(Preferences)$",
	},
	float = true,
	pin = true,
	center = true,
})

-- -----------------------------------------------------
-- GNOME Calculator
-- -----------------------------------------------------
hl.window_rule({
	match = {
		class = "(org.gnome.Calculator)",
	},
	float = true,
	size = "320 616",
	center = true,
})

-- -----------------------------------------------------
-- Hyprland Share Picker
-- -----------------------------------------------------
hl.window_rule({
	match = {
		class = "(hyprland-share-picker)",
	},
	float = true,
	pin = true,
	center = true,
	size = "600 400",
})

-- -----------------------------------------------------
-- tty-clock
-- -----------------------------------------------------
hl.window_rule({
	match = {
		title = "(tty-clock)",
	},
	float = true,
	move = "720 45",
	size = "504 193",
})
