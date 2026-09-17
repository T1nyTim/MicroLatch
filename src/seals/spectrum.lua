SMODS.Seal {
    key = "spectrum",
    atlas = "seal_atlas",
    pos = { x = 8, y = 3 },
    badge_colour = HEX("7F5AF0"),
    loc_txt = { name = "Spectrum Seal", label = "Spectrum Seal", text = { "Gives {C:mult}+3{} Mult for each", "different suit played" }},
    calculate = function(_, _, context)
        if not (context.main_scoring and context.cardarea == G.play and context.full_hand) then return end
        local suits = {}
        for _, card in ipairs(context.full_hand) do if card.base and card.base.suit then suits[card.base.suit] = true end end
        local count = 0
        for _ in pairs(suits) do count = count + 1 end
        if count > 0 then return { mult = count * 3 } end
    end
}
