local U = MICROLATCH.util

SMODS.Seal {
    key = "odd",
    atlas = "seal_atlas",
    pos = { x = 3, y = 3 },
    badge_colour = HEX("FF8C1A"),
    loc_txt = { name = "Odd Seal", label = "Odd Seal", text = { "Retriggers if every", "scoring rank is {C:attention}odd{}" }},
    calculate = function(_, _, context)
        if context.repetition and context.cardarea == G.play and U.all(context.scoring_hand, U.is_odd_rank) then
            return { repetitions = 1, message = localize("k_again_ex") }
        end
    end
}
