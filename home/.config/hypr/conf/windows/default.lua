-- -----------------------------------------------------
-- General window layout and colors
-- name: "Default"
-- -----------------------------------------------------


hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 5,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(fabd2fff)", "rgba(fe8019ff)" }, angle = 45 },
            inactive_border = "rgba(3c3836ff)",
        },
        layout = "scrolling",
        resize_on_border = true,
    },
})

