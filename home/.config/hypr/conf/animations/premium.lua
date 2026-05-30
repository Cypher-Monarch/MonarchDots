
hl.curve("smoothOut", { type = "bezier", points = { { 0.2, 0.8 }, { 0.2, 1 } } })
hl.curve("smooth", { type = "bezier", points = { { 0.25, 0.1 }, { 0.25, 1 } } })
hl.curve("sharp", { type = "bezier", points = { { 0.4, 0 }, { 0.6, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })
hl.animation({
    leaf = "global",
    enabled = true,
    speed = 4,
    bezier = "smooth",
})
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 3,
    bezier = "smoothOut",
    style = "popin 92%",
})
hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 3,
    bezier = "smoothOut",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 2,
    bezier = "smoothOut",
})
hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 3,
    bezier = "smooth",
})
hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 4,
    bezier = "smooth",
    style = "slidefade 12%",
})
hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 4,
    bezier = "smoothOut",
})
hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 3,
    bezier = "smooth",
})
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 4,
    bezier = "sharp",
})
hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 4,
    bezier = "sharp",
})
hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 4,
    bezier = "sharp",
})
hl.animation({
    leaf = "fadeSwitch",
    enabled = true,
    speed = 3,
    bezier = "sharp",
})
hl.animation({
    leaf = "fadeShadow",
    enabled = true,
    speed = 3,
    bezier = "sharp",
})
hl.animation({
    leaf = "fadeDim",
    enabled = true,
    speed = 4,
    bezier = "sharp",
})
hl.animation({
    leaf = "fadeLayers",
    enabled = true,
    speed = 4,
    bezier = "sharp",
})
hl.animation({
    leaf = "fadeLayersIn",
    enabled = true,
    speed = 4,
    bezier = "sharp",
})
hl.animation({
    leaf = "fadeLayersOut",
    enabled = true,
    speed = 4,
    bezier = "sharp",
})
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 2,
    bezier = "linear",
})
hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = 20,
    bezier = "linear",
    style = "loop",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 5,
    bezier = "smooth",
    style = "slidefade 18%",
})
hl.animation({
    leaf = "workspacesIn",
    enabled = true,
    speed = 5,
    bezier = "smoothOut",
})
hl.animation({
    leaf = "workspacesOut",
    enabled = true,
    speed = 4,
    bezier = "smooth",
})
hl.animation({
    leaf = "specialWorkspace",
    enabled = true,
    speed = 5,
    bezier = "smooth",
})
hl.animation({
    leaf = "specialWorkspaceIn",
    enabled = true,
    speed = 5,
    bezier = "smoothOut",
})
hl.animation({
    leaf = "specialWorkspaceOut",
    enabled = true,
    speed = 4,
    bezier = "smooth",
})
hl.config({
    animations = {
        enabled = true,
        -- Global
        -- Windows 
        -- Layers
        -- Fade 
        -- Borders 
        -- Workspaces 
        -- Special workspaces
    },
})

