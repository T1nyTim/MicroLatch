SMODS.Seal {
    key = "amber",
    atlas = "seal_atlas",
    pos = { x = 0, y = 0 },
    badge_colour = HEX("FFBF00"),
    loc_txt = { name = "Amber Seal", label = "Amber Seal", text = { "Gives {C:mult}+2{} Mult", "when scored" } },
    calculate = function(_, _, context) if context.main_scoring and context.cardarea == G.play then return { mult = 2 } end end
}
