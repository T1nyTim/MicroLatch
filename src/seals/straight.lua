local U = MICROLATCH.util

SMODS.Seal {
    key = "straight",
    atlas = "seal_atlas",
    pos = { x = 9, y = 3 },
    badge_colour = HEX("7B2CBF"),
    loc_txt = {
        name = "Straight Seal",
        label = "Straight Seal",
        text = { "Gives {X:mult,C:white}X1.4{} Mult when", "scoring in a {C:attention}Straight{}" }
    },
    calculate = function(_, _, context)
        if context.main_scoring and context.cardarea == G.play and U.has_poker_hand(context, "Straight") then return { xmult = 1.4 } end
    end
}
