local U = MICROLATCH.util

SMODS.Seal {
    key = "livery",
    atlas = "seal_atlas",
    pos = { x = 2, y = 3 },
    badge_colour = HEX("7F3FBF"),
    loc_txt = { name = "Livery Seal", label = "Livery Seal", text = { "Gives {C:mult}+1{} Mult for each", "scoring card of the same suit" }},
    calculate = function(_, card, context)
        if context.main_scoring and context.cardarea == G.play and card.base and card.base.suit then
            return { mult = U.count(context.scoring_hand, function(other) return other:is_suit(card.base.suit) end) }
        end
    end
}
