SMODS.Seal {
    key = "lavender",
    atlas = "seal_atlas",
    pos = { x = 0, y = 1 },
    badge_colour = HEX("C0AADA"),
    loc_txt = { name = "Lavender Seal", label = "Lavender Seal", text = { "Gains {C:mult}+1{} Mult if held", "in hand at end of round" }},
    calculate = function(_, card, context)
        if context.playing_card_end_of_round and context.cardarea == G.hand then
            card.ability.perma_mult = (card.ability.perma_mult or 0) + 1
            return { message = "+1 Mult", colour = G.C.MULT }
        end
    end
}
