SMODS.Seal {
    key = "copper",
    atlas = "seal_atlas",
    pos = { x = 4, y = 0 },
    badge_colour = HEX("B87333"),
    config = { used_this_round = false, scored_this_hand = false },
    loc_txt = { name = "Copper Seal", label = "Copper Seal", text = { "Returns to hand after scoring", "{C:attention}once per round{}" }},
    calculate = function(_, card, context)
        if context.main_scoring and context.cardarea == G.play then card.ability.seal.scored_this_hand = true end
        if context.stay_flipped
            and context.from_area == G.play
            and context.other_card == card
            and card.ability.seal.scored_this_hand
            and not card.ability.seal.used_this_round
        then
            card.ability.seal.used_this_round = true
            card.ability.seal.scored_this_hand = false
            return { modify = { to_area = G.hand }, message = "Returned!" }
        end
    end
    --Clean-up Effect managed by reset_copper_hand_state and reset_copper_round_state
}
