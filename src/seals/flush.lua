local U = MICROLATCH.util

SMODS.Seal {
    key = "flush",
    atlas = "seal_atlas",
    pos = { x = 7, y = 2 },
    badge_colour = HEX("D7263D"),
    loc_txt = { name = "Flush Seal", label = "Flush Seal", text = { "Gives {X:mult,C:white}X1.4{} Mult when", "scoring in a {C:attention}Flush{}" }},
    calculate = function(_, _, context) if context.main_scoring and context.cardarea == G.play and U.has_poker_hand(context, "Flush") then
        return { xmult = 1.4 } end
    end
}
