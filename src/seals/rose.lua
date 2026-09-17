SMODS.Seal {
    key = "rose",
    atlas = "seal_atlas",
    pos = { x = 7, y = 1 },
    badge_colour = HEX("FF007F"),
    loc_txt = { name = "Rose Seal", label = "Rose Seal", text = { "Gives {X:mult,C:white}X1.2{} Mult", "when scored" }},
    calculate = function(_, _, context) if context.main_scoring and context.cardarea == G.play then return { xmult = 1.2 } end end
}
