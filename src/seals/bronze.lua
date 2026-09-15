SMODS.Seal {
    key = "bronze",
    atlas = "seal_atlas",
    pos = { x = 3, y = 0 },
    badge_colour = HEX("CD7F32"),
    loc_txt = { name = "Bronze Seal", label = "Bronze Seal", text = { "Draw {C:attention}+1{} extra card after", "this card is discarded" }},
    calculate = function(_, card, context)
        if context.discard and context.other_card == card then
            MICROLATCH.util.queue_draws(1)
            return { message = "+1 draw", colour = G.C.BLUE }
        end
    end
}
