SMODS.Seal {
    key = "silver",
    atlas = "seal_atlas",
    pos = { x = 8, y = 1 },
    badge_colour = HEX("C0C0C0"),
    text_colour = G.C.BLACK,
    loc_txt = { name = "Silver Seal", label = "Silver Seal", text = { "Earn {C:money}$4{} if this is", "the {C:attention}first{} card scored" }},
    calculate = function(_, card, context)
        if context.main_scoring and context.cardarea == G.play and MICROLATCH.util.is_first_scored(card, context) then return { dollars = 4 } end
    end
}
