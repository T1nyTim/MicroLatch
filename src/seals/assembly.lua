local U = MICROLATCH.util

SMODS.Seal {
    key = "assembly",
    atlas = "seal_atlas",
    pos = { x = 2, y = 2 },
    badge_colour = HEX("2F7BFF"),
    loc_txt = { name = "Assembly Seal", label = "Assembly Seal", text = { "Gives {X:mult,C:white}X1.5{} Mult if every", "played card has a seal" }},
    calculate = function(_, _, context)
        if context.main_scoring and context.cardarea == G.play and U.all(context.full_hand, function(card) return card.seal ~= nil end) then
            return { xmult = 1.5 }
        end
    end
}
