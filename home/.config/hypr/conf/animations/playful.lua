
hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("easeOvershoot", { type = "bezier", points = { { 0.3, 1.5 }, { 0.5, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 9,
    bezier = "wind",
    style = "slide",
})
hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 9,
    bezier = "easeOvershoot",
    style = "slide",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 8,
    bezier = "wind",
    style = "slide",
})
hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 7,
    bezier = "easeOvershoot",
    style = "slide",
})
hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 8,
    bezier = "wind",
    style = "slide",
})
hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 9,
    bezier = "easeOvershoot",
    style = "slide",
})
hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 7,
    bezier = "wind",
    style = "slide",
})
hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 7,
    bezier = "wind",
})
hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 7,
    bezier = "wind",
})
hl.animation({
    leaf = "fadeSwitch",
    enabled = true,
    speed = 6,
    bezier = "wind",
})
hl.animation({
    leaf = "fadeShadow",
    enabled = true,
    speed = 6,
    bezier = "wind",
})
hl.animation({
    leaf = "fadeDim",
    enabled = true,
    speed = 6,
    bezier = "wind",
})
hl.animation({
    leaf = "fadeLayers",
    enabled = true,
    speed = 7,
    bezier = "wind",
})
hl.animation({
    leaf = "fadeLayersIn",
    enabled = true,
    speed = 7,
    bezier = "wind",
})
hl.animation({
    leaf = "fadeLayersOut",
    enabled = true,
    speed = 7,
    bezier = "wind",
})
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 3,
    bezier = "linear",
})
hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = 25,
    bezier = "linear",
    style = "loop",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 8,
    bezier = "easeOvershoot",
    style = "slidefade",
})
hl.animation({
    leaf = "workspacesIn",
    enabled = true,
    speed = 9,
    bezier = "easeOvershoot",
    style = "slidefade",
})
hl.animation({
    leaf = "workspacesOut",
    enabled = true,
    speed = 8,
    bezier = "wind",
    style = "slidefade",
})
hl.animation({
    leaf = "specialWorkspace",
    enabled = true,
    speed = 8,
    bezier = "wind",
    style = "slidefade",
})
hl.animation({
    leaf = "specialWorkspaceIn",
    enabled = true,
    speed = 9,
    bezier = "easeOvershoot",
    style = "slidefade",
})
hl.animation({
    leaf = "specialWorkspaceOut",
    enabled = true,
    speed = 8,
    bezier = "wind",
    style = "slidefade",
})
hl.config({
    animations = {
        enabled = true,
    },
})

