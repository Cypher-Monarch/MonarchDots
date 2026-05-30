-- -----------------------------------------------------
-- General window decoration
-- name: "Default"
-- -----------------------------------------------------


hl.config({
    decoration = {
        rounding = 5,
        active_opacity = 0.8,
        inactive_opacity = 0.6,
        fullscreen_opacity = 1.0,
        blur = {
            enabled = true,
            size = 6,
            passes = 2,
            new_optimizations = true,
            ignore_opacity = true,
            xray = true,
            -- blurls = waybar
        },
        shadow = {
            enabled = true,
            range = 30,
            render_power = 3,
            color = 0x66000000,
        },
    },
})

