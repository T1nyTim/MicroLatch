local U = MICROLATCH.util

SMODS.Seal {
    key = "solitary",
    atlas = "seal_atlas",
    pos = { x = 7, y = 3 },
    badge_colour = HEX("666A73"),
    loc_txt = { name = "Solitary Seal", label = "Solitary Seal", text = { "Gives {X:mult,C:white}X2{} Mult if it is", "the only sealed card played" }},
    calculate = function(_, card, context)
        if context.main_scoring
            and context.cardarea == G.play
            and card.seal
            and U.count(context.full_hand, function(other) return other.seal ~= nil end) == 1
        then
            return { xmult = 2 }
        end
    end
}
