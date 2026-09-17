SMODS.Seal {
    key = "ivory",
    atlas = "seal_atlas",
    pos = { x = 0, y = 1 },
    badge_colour = HEX("FFFFF0"),
    text_colour = G.C.BLACK,
    loc_txt = { name = "Ivory Seal", label = "Ivory Seal", text = { "This card {C:attention}cannot{}", "{C:attention}be debuffed{}" }},
    calculate = function(_, card, context) if context.debuff_card == card then return { prevent_debuff = true } end end
}
