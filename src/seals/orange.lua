SMODS.Seal {
    key = "orange",
    atlas = "seal_atlas",
    pos = { x = 3, y = 1 },
    badge_colour = HEX("FFA500"),
    loc_txt = { name = "Orange Seal", label = "Orange Seal", text = { "Earn {C:money}$1{} when", "discarded" }},
    calculate = function(_, card, context) if context.discard and context.other_card == card then return { dollars = 1 } end end
}
