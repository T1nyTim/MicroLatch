local U = MICROLATCH.util

SMODS.Seal {
    key = "ascending",
    atlas = "seal_atlas",
    pos = { x = 1, y = 2 },
    badge_colour = HEX("FF4D4D"),
    config = { chips = 0 },
    loc_txt = {
        name = "Ascending Seal",
        label = "Ascending Seal",
        text = { "Gains {C:chips}+3{} Chips for every", "lower-ranked card scored before it", "{C:inactive}[Currently {C:chips}+#1#{C:inactive}]" }
    },
    loc_vars = function(self, _, card)
        local seal = card and card.ability and card.ability.seal
        return { vars = { type(seal) == "table" and (seal.chips or 0) or self.config.chips }}
    end,
    calculate = function(_, card, context)
        if not (context.main_scoring and context.cardarea == G.play) then return end
        local rank = U.rank_id(card)
        if not rank then return end
        local count = U.count(U.previous_scoring_cards(card, context), function(other)
            local other_rank = U.rank_id(other)
            return not other.debuff and other_rank and other_rank < rank
        end)
        local gain = count * 3
        if gain <= 0 then return end
        card.ability.seal.chips = (card.ability.seal.chips or 0) + gain
        card.ability.perma_bonus = (card.ability.perma_bonus or 0) + gain
        return { chips = gain, message = "+" .. gain .. " Chips", colour = G.C.CHIPS }
    end
}
