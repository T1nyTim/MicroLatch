SMODS.Seal {
    key = "white",
    atlas = "seal_atlas",
    pos = { x = 9, y = 1 },
    badge_colour = HEX("FFFFFF"),
    text_colour = G.C.BLACK,
    loc_txt = { name = "White Seal", label = "White Seal", text = { "Gives {C:chips}+20{} Chips", "when scored" }},
    calculate = function(_, _, context) if context.main_scoring and context.cardarea == G.play then return { chips = 20 } end end
}
