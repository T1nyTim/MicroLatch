local U = MICROLATCH.util

SMODS.Seal {
    key = "twin",
    atlas = "seal_atlas",
    pos = { x = 0, y = 4 },
    badge_colour = HEX("D4A017"),
    text_colour = G.C.BLACK,
    loc_txt = {
        name = "Twin Seal",
        label = "Twin Seal",
        text = { "Retriggers {C:attention}2{} additional", "times if an identical", "card has already scored" }
    },
    calculate = function(_, card, context)
        if not (context.repetition and context.cardarea == G.play) then return end
        for _, other in ipairs(U.previous_scoring_cards(card, context)) do
            if not other.debuff and U.same_playing_card_identity(card, other) then return { repetitions = 2, message = localize("k_again_ex") } end
        end
    end
}
