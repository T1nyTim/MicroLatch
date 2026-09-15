SMODS.Seal {
    key = "platinum",
    atlas = "seal_atlas",
    pos = { x = 5, y = 1 },
    badge_colour = HEX("F2F3F4"),
    text_colour = G.C.BLACK,
    loc_txt = { name = "Platinum Seal", label = "Platinum Seal", text = { "Earn {C:money}$4{} if this is", "the {C:attention}last{} card scored" }},
    calculate = function(_, card, context)
        if context.main_scoring and context.cardarea == G.play and MICROLATCH.util.is_last_scored(card, context) then return { dollars = 4 } end
    end
}
