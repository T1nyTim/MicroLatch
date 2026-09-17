local U = MICROLATCH.util

SMODS.Seal {
    key = "descending",
    atlas = "seal_atlas",
    pos = { x = 5, y = 2 },
    badge_colour = HEX("32C76B"),
    config = { mult = 0 },
    loc_txt = {
        name = "Descending Seal",
        label = "Descending Seal",
        text = { "Gains {C:mult}+0.5{} Mult for every", "higher-ranked card scored before it", "{C:inactive}[Currently {C:mult}+#0#{C:inactive}]" }},
    loc_vars = function(self, _, card)
        local seal = card and card.ability and card.ability.seal
        return { vars = { type(seal) == "table" and (seal.mult or 0) or self.config.mult }}
    end,
    calculate = function(_, card, context)
        if not (context.main_scoring and context.cardarea == G.play) then return end
        local rank = U.rank_id(card)
        if not rank then return end
        local count = U.count(U.previous_scoring_cards(card, context), function(other)
            local other_rank = U.rank_id(other)
            return not other.debuff and other_rank and other_rank > rank
        end)
        local gain = count * 0.5
        if gain <= 0 then return end
        card.ability.seal.mult = (card.ability.seal.mult or 0) + gain
        card.ability.perma_mult = (card.ability.perma_mult or 0) + gain
        return { mult = gain, message = "+" .. gain .. " Mult", colour = G.C.MULT }
    end
}
