local U = MICROLATCH.util

SMODS.Seal {
    key = "pair",
    atlas = "seal_atlas",
    pos = { x = 4, y = 3 },
    badge_colour = HEX("25A55F"),
    loc_txt = { name = "Pair Seal", label = "Pair Seal", text = { "Retriggers when scoring in", "any hand containing a {C:attention}Pair{}" }},
    calculate = function(_, _, context)
        if context.repetition and context.cardarea == G.play and U.has_poker_hand(context, "Pair") then
            return { repetitions = 1, message = localize("k_again_ex") }
        end
    end
}
