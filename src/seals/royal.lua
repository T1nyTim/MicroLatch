SMODS.Seal {
    key = "royal",
    atlas = "seal_atlas",
    pos = { x = 6, y = 3 },
    badge_colour = HEX("C62828"),
    loc_txt = { name = "Royal Seal", label = "Royal Seal", text = { "Gives {C:mult}+5{} Mult if scored", "with another face card" }},
    calculate = function(_, card, context)
        if not (context.main_scoring and context.cardarea == G.play and context.scoring_hand) then return end
        for _, other in ipairs(context.scoring_hand) do if other ~= card and other:is_face() then return { mult = 5 } end end
    end
}
