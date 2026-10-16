hl.window_rule({
	name = "move-element",
	match = { class = "element" },
	workspace = "special:chat",
})

hl.window_rule({
	name = "move-signal",
	match = { class = "signal" },
	workspace = "special:chat",
})

hl.window_rule({
	name = "move-discord",
	match = { class = "discord" },
	workspace = "special:chat",
})

hl.window_rule({
	name = "move-thunderbird",
	match = { class = "thunderbird" },
	workspace = "special:mail",
})
hl.window_rule({
	name = "move-tux",
	match = { class = "tuxedo" },
	workspace = "special:tasks",
})
