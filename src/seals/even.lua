local U = MICROLATCH.util

SMODS.Seal {
    key = "even",
    atlas = "seal_atlas",
    pos = { x = 6, y = 2 },
    badge_colour = HEX("E6B800"),
    text_colour = G.C.BLACK,
    loc_txt = { name = "Even Seal", label = "Even Seal", text = { "Retriggers if every", "scoring rank is {C:attention}even{}" }},
    calculate = function(_, _, context)
        if context.repetition and context.cardarea == G.play and U.all(context.scoring_hand, U.is_even_rank) then
            return { repetitions = 1, message = localize("k_again_ex") }
        end
    end
}
