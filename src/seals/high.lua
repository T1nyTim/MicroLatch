SMODS.Seal {
    key = "high",
    atlas = "seal_atlas",
    pos = { x = 8, y = 2 },
    badge_colour = HEX("4169E1"),
    loc_txt = { name = "High Seal", label = "High Seal", text = { "Gives {X:mult,C:white}X2{} Mult", "when it is the", "only scoring card" }},
    calculate = function(_, card, context)
        if context.main_scoring
            and context.cardarea == G.play
            and context.scoring_hand
            and #context.scoring_hand == 1
            and context.scoring_hand[1] == card
        then
            return { xmult = 2 }
        end
    end
}
