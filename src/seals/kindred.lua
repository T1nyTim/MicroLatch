local U = MICROLATCH.util

SMODS.Seal {
    key = "kindred",
    atlas = "seal_atlas",
    pos = { x = 1, y = 3 },
    badge_colour = HEX("21C7D9"),
    config = { mult = 0 },
    loc_txt = {
        name = "Kindred Seal",
        label = "Kindred Seal",
        text = { "Gains {C:mult}+1{} Mult when", "scoring in {C:attention}Five of a Kind{}", "{C:inactive}[Currently {C:mult}+#1#{C:inactive}]" }
    },
    loc_vars = function(self, _, card)
        local seal = card and card.ability and card.ability.seal
        return { vars = { type(seal) == "table" and (seal.mult or 0) or self.config.mult }}
    end,
    calculate = function(_, card, context)
        if context.main_scoring and context.cardarea == G.play and U.has_poker_hand(context, "Five of a Kind") then
            card.ability.seal.mult = (card.ability.seal.mult or 0) + 1
            card.ability.perma_mult = (card.ability.perma_mult or 0) + 1
            return { mult = 1, message = "+1 Mult", colour = G.C.MULT }
        end
    end
}
