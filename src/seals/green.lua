SMODS.Seal {
    key = "green",
    atlas = "seal_atlas",
    pos = { x = 6, y = 0 },
    badge_colour = HEX("008000"),
    loc_txt = { name = "Green Seal", label = "Green Seal", text = { "Earn {C:money}$1{} if held in", "hand at end of round" }},
    calculate = function(_, _, context) if context.playing_card_end_of_round and context.cardarea == G.hand then return { dollars = 1 } end end
}
