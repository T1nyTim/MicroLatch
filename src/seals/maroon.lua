SMODS.Seal {
    key = "maroon",
    atlas = "seal_atlas",
    pos = { x = 3, y = 1 },
    badge_colour = HEX("800000"),
    loc_txt = { name = "Maroon Seal", label = "Maroon Seal", text = { "Gains {C:chips}+5{} Chips", "when discarded" }},
    calculate = function(_, card, context)
        if context.discard and context.other_card == card then
            card.ability.perma_bonus = (card.ability.perma_bonus or 0) + 5
            return { message = "+5 Chips", colour = G.C.CHIPS }
        end
    end
}
